import * as _ from "lodash"
import {
  BinOp, Block, ContractDefinition, Expression, ExpressionStatement, ForStatement, FunctionDefinition,
  Identifier, ReturnStatement, Statement, StateVariableDeclaration, TypeName, Visitor,
} from "solidity-parser-antlr"
import { optimizeStorageAccess } from "../optimizer/StorageAccessOptimizer"
import { ContractVisitor } from "../visitors/ContractVisitor"
import { ForAllExpression, Node, QuantityExp, SumExpression, Identifier as Iden} from "./nodes/Node"
import { PendingStatements } from "./PendingStatements"
import { Rewriter } from "./Rewriter"
import { generateNewVarName } from "./StateVariableGenerator"
import {
  createBaseASTNode, createBinaryOperation, createBlock, createElementaryTypeName,
  createExpressionStmt, createFunctionCall, createIdentifier, createIfStatment, createIndexAccess,
  createMemberAccess, createNumberLiteral, createVariableDeclaration, createVariableDeclarationStmt,
  createArray,
  canOptimize,
  createStateVariableDeclaration,
  getSubFunctions,
  createGlobalArray,
  loadGlobalArray,
  storeArrayValue,
  loadArrayValue,
  getCallers,
  createForloop,
} from "./utilities"
import { SubstutionAnalyzer } from "../analyzer/SubstitutionAnalyzer"

export const updateOps = ["=", "-=", "+=", "*=", "/="]
const depthTracker = generateNewVarName("depth")

export class AssertionDectorator extends ContractVisitor implements Visitor  {
  public constraints: Node[]
  public variables: Map<string, StateVariableDeclaration[]>
  public checkConstraints: Set<Node> = new Set()
  public stateVarCache: Map<string, string> = new Map()
  public stateVarCacheReverse: Map<string, string> = new Map()
  public canAddAssertions = false
  public contractVars: Map<string, TypeName>
  public functionDecorators: PendingStatements = new PendingStatements()
  public enableMappingOptimization: boolean
  public canOptimize: boolean = false
  public pendingReturns: Block[] = []
  public forAllCacheMap: Map<ForAllExpression, [Map<string, string>, Identifier]> = new Map()
  private contractName: string = ""
  private forallOptimization: boolean
  private depthRequired: boolean = false
  private virtualRun: boolean = false
  private functionConstraints: Map<string, Map<string, Set<Node>>>
  constructor(constraints: Node[], functionConstraints: Map<string, Map<string, Set<Node>>>,
              variables: Map<string, StateVariableDeclaration[]>,
              contractVars: Map<string, TypeName>, optimize: boolean,
              forallOptimization: boolean = true) {
    super()
    this.constraints = constraints
    this.variables = variables
    this.contractVars = contractVars
    this.enableMappingOptimization = optimize
    this.functionConstraints = functionConstraints
    this.forallOptimization = forallOptimization
  }
  public ContractDefinition = (node: ContractDefinition) => {
    this.contractName = node.name
    node.subNodes = this.visit(node.subNodes)
    if (this.variables.has(node.name)) {
      node.subNodes = [...this.variables.get(node.name)!, ...node.subNodes]
      const varDecl = createVariableDeclaration(depthTracker, createElementaryTypeName("uint256"), true)
      node.subNodes.unshift(createStateVariableDeclaration([varDecl]))
    }
    return node
  }
  public FunctionDefinition = (node: FunctionDefinition) => {
    this.stateVarCache = new Map()
    this.stateVarCacheReverse = new Map()
    this.functionDecorators = new PendingStatements()
    this.forAllCacheMap = new Map()
    this.canAddAssertions = node.visibility === "public"
    this.pendingReturns = []
    const name = (() => {
      if (node.isConstructor || !node.name) { return "<Constructor>" }
      if (node.name.length === 0) { return  "<Fallback>" }
      return node.name
    })()
    this.depthRequired = getCallers(this.contractName, name).length > 0 ||
      getSubFunctions(this.contractName, name).length > 0
    this.checkConstraints = [...getSubFunctions(this.contractName, name), [this.contractName, name]].map((it) => {
      if (!this.functionConstraints.has(it[0]) ||
        !this.functionConstraints.get(it[0])!.has(it[1])) { return new Set() as Set<Node>  }
      return this.functionConstraints.get(it[0])!.get(it[1])!
    }).reduce((left, right) => new Set([...left, ...right]), new Set())
    this.canOptimize = canOptimize(this.contractName, name)
    node.body = this.visit(node.body)
    if (node.body) {
      if (this.canAddAssertions && this.checkConstraints.size !== 0) {
        node.body.statements.push(...this.generateAssertions())
        node.body.statements.unshift(...this.functionDecorators.pre)
        if (this.depthRequired) {
          const depth = createIdentifier(depthTracker)
          const one = createNumberLiteral("1")
          const increaseOne = createBinaryOperation(depth, one, "+=")
          node.body.statements.unshift(createExpressionStmt(increaseOne))
        }
      } else {
        node.body.statements.unshift(...this.functionDecorators.pre)
      }
      node.body.statements.push(...this.functionDecorators.post)
    }
    return node
  }
  public ReturnStatement = (node: ReturnStatement) => {
    const block = createBaseASTNode("Block") as Block
    block.statements = []
    if (this.canAddAssertions && this.checkConstraints.size !== 0) {
      block.statements.push(...this.generateAssertions())
    } else {
      this.pendingReturns.push(block)
    }
    block.statements.push(...this.functionDecorators.post)
    block.statements.push(node)
    return block
  }
  public ExpressionStatement = (statement: ExpressionStatement) => {
    if (statement.expression.type !== "BinaryOperation") { return statement }
    const binOp = statement.expression
    if (!updateOps.includes(binOp.operator)) { return statement }

    const constraintPair: Array<[QuantityExp, Map<string, Expression>]> = []
    const generate = (constraint: Node) => {
      const ps = new PendingStatements()
      if (constraint.type === "ForAllExpression" || constraint.type === "SumExpression") {
        const [result, muBindings] = (new SubstutionAnalyzer(constraint, binOp.left)).run()
        if (!result) { return ps }

        muBindings.forEach((muBinding) => {
          const pendingStmts = constraint.type === "ForAllExpression"
            ? this.generateForall(constraint, muBinding)
            : this.generateSum(constraint, muBinding)
          if (!pendingStmts.isEmpty()) {
            constraintPair.push([constraint, muBinding])
          }
          ps.merge(pendingStmts)
        })
      }
      return ps
    }
    const pendingStatements = new PendingStatements()
    this.constraints.forEach((it) => pendingStatements.merge(generate(it)))
    if (pendingStatements.isEmpty()) { return statement }
    if (!this.enableMappingOptimization ||
      constraintPair.filter((it) => it[0].type === "SumExpression").length === 0) {
      return [...this.visit(pendingStatements.pre), statement, ...this.visit(pendingStatements.post)]
    } else {
      const result = optimizeStorageAccess(constraintPair,
        [...pendingStatements.pre, statement, ...pendingStatements.post], this.contractVars, this.stateVarCache)
      return createBlock([...result[0], ...this.visit(result[1]), ...result[2]])
    }
  }
  private generateAssertions(): Statement[] {
    const depth = createIdentifier(depthTracker)
    const decreaseOne = createExpressionStmt(createBinaryOperation(depth, createNumberLiteral("1"), "-="))
    const generate = (node: Node): Array<(ForStatement | ExpressionStatement | Block)> => {
      switch (node.type) {
        case "ForAllExpression": {
          return [this.generateAssertionsForAll(node)]
        }
        case "SumExpression": {
          return []
        }
        default: {
          const exp = new Rewriter(this.stateVarCache).visit(node) as Expression
          const functionCall = createFunctionCall(createIdentifier("assert"), [exp], [])
          return [createExpressionStmt(functionCall)]
        }
      }
    }

    const assertions = [...this.checkConstraints]
      .map((it) => generate(it)).reduce((pre, cur) => [...pre, ...cur], [])

    if (this.depthRequired) {
      const ifStatment = createIfStatment(
        createBinaryOperation(depth, createNumberLiteral("0"), "=="), createBlock(assertions))
      return [decreaseOne, ifStatment]
    } else {
      return assertions
    }
  }
  private generateAssertionsForAll(node: ForAllExpression) {
    const forallCache = this.generateOrCreateForAllCache(node)

    const muRaw: Map<string, Expression> = new Map()
    const [muMap, lastBlock, firstFor] = this.generateUnboundedFreeVars(node, muRaw)
    const body = createBaseASTNode("Block") as Block
    if (firstFor) {
      body.statements = [firstFor]
    }
    const statements = lastBlock.statements
    const exp = new Rewriter(this.stateVarCache, muMap).visit(node.condition) as Expression
    const functionCall = createFunctionCall(createIdentifier("assert"), [exp], [])
    statements.push(createExpressionStmt(functionCall))
    if (forallCache[0].size > 0) {
      const indexIdentifier = createIdentifier(generateNewVarName("index"))
      forallCache[0].forEach((localArray, muName) => {
        if (this.canOptimize || !this.forallOptimization) {
          muRaw.set(muName, createIndexAccess(createIdentifier(localArray), indexIdentifier))
        } else {
          const tmpVar = generateNewVarName("tmp")
          const varDecl = createVariableDeclaration(tmpVar, node.muWithTypes.get(muName)!, false)
          statements.unshift(createVariableDeclarationStmt([varDecl]))
          statements.unshift(loadArrayValue(localArray, indexIdentifier.name, tmpVar))
          muRaw.set(muName, createIdentifier(tmpVar))
        }
      })
      const initExpression = createVariableDeclarationStmt(
        [createVariableDeclaration(indexIdentifier.name, createElementaryTypeName("uint256"), false)],
        createNumberLiteral("0"))
      const length = this.forallOptimization ? forallCache[1]
        : createMemberAccess(createIdentifier([...forallCache[0].keys()][0]), "length")
      const conditionExpression = createBinaryOperation(indexIdentifier, length, "<")
      const loopExpression = createExpressionStmt(
        createBinaryOperation(indexIdentifier, createNumberLiteral("1"), "+="))
      const forLoop = createForloop(body, initExpression, conditionExpression, loopExpression)
      if (!this.forallOptimization) {
        const setToZero: Statement[] = []
        forallCache[0].forEach((value) => {
          setToZero.push(createExpressionStmt(
            createBinaryOperation(
              createMemberAccess(createIdentifier(value), "length"), createNumberLiteral("0"), "=")))
        })
        setToZero.unshift(forLoop)
        return createBlock(setToZero)
      } else if (!this.canOptimize) {
        const setToZero: Statement[] = [createExpressionStmt(
          createBinaryOperation(createIdentifier(node.index), createNumberLiteral("0"), "="))]
        setToZero.unshift(forLoop)
        return createBlock(setToZero)
      }
    }
    return firstFor ? firstFor : lastBlock
  }

  private generateForall(node: ForAllExpression, muBindings: Map<string, Expression>): PendingStatements {
    const block = createBaseASTNode("Block") as Block
    node.mu.filter((it) => !muBindings.has(it.name) && !node.positionMuVarMap.has(it.name))
    .forEach((it) => node.unboundedMu.add(it.name))
    block.statements = []
    const forallCache = this.generateOrCreateForAllCache(node)
    const index = forallCache[1] as Identifier
    forallCache[0].forEach((localArray, muName) => {
      const value = muBindings.get(muName)!
      if (!this.forallOptimization) {
        const push = createFunctionCall(createMemberAccess(createIdentifier(localArray), "push"), [value])
        block.statements.push(createExpressionStmt(push))
      } else {
        if (this.canOptimize) {
          const assignment = createBinaryOperation(
            createIndexAccess(createIdentifier(localArray), index), value, "=")
          block.statements.push(createExpressionStmt(assignment))
        } else {
          const tmpVar = generateNewVarName("tmp")
          const varDecl = createVariableDeclaration(tmpVar, node.muWithTypes.get(muName)!, false)
          block.statements.push(createVariableDeclarationStmt([varDecl], muBindings.get(muName)!))
          block.statements.push(storeArrayValue(localArray, index.name, tmpVar))
        }
      }
    })
    if (this.forallOptimization) {
      block.statements.push(createExpressionStmt(createBinaryOperation(index, createNumberLiteral("1"), "+=")))
    }
    return new PendingStatements([block])
  }

  private findOrCreateStateVarCache(name: string): string {
    if (!this.canOptimize) { return name }
    if (this.stateVarCache.has(name)) {
      return this.stateVarCache.get(name)!
    } else {
      const newVar = generateNewVarName("tmp_" + name)
      const typeName = this.contractVars.get(name)!
      const stateVar = createIdentifier(name)
      const varDecl = createVariableDeclaration(newVar, typeName, false)
      this.functionDecorators.pre.push(createVariableDeclarationStmt([varDecl], stateVar))
      this.functionDecorators.post.push(createExpressionStmt(
        createBinaryOperation(stateVar, createIdentifier(newVar), "="),
      ))
      this.stateVarCache.set(name, newVar)
      this.stateVarCacheReverse.set(newVar, name)
      return newVar
    }
  }

  private generateOrCreateForAllCache(node: ForAllExpression): [Map<string, string>, Identifier] {
    const globalArray = !this.canOptimize
    if (!this.forAllCacheMap.has(node)) {
      const names: Map<string, string> = new Map()
      node.mu.forEach((it) => {
        const arr = generateNewVarName(it.name)
        if (node.unboundedMu.has(it.name)) {
          return
        }
        if (this.forallOptimization) {
          names.set(it.name, arr)
        } else {
          names.set(it.name, it.name)
          return
        }
        const type = node.muWithTypes.get(it.name)!
        // const arrayType = createArray(type, createNumberLiteral("20"))
        const arrayType = createArray(type, globalArray ? undefined : createNumberLiteral("20"))
        const decl = createVariableDeclaration(arr, arrayType, false, "memory")
        this.functionDecorators.pre.push(createVariableDeclarationStmt([decl]))
        if (globalArray) {
          const initAssembly = createGlobalArray(arr, node.muStateVars.get(it.name)!)
          const loadAssembly = loadGlobalArray(arr, node.muStateVars.get(it.name)!)
          if (!this.canAddAssertions) {
            this.functionDecorators.pre.push(loadAssembly)
          } else if (this.depthRequired) {
            const ifStmt = createIfStatment(
              createBinaryOperation(createIdentifier(depthTracker), createNumberLiteral("1"), "<="),
              initAssembly, loadAssembly)
            this.functionDecorators.pre.push(ifStmt)
          } else if (this.canAddAssertions) {
            this.functionDecorators.pre.push(initAssembly)
          }
        }
      })
      const index = globalArray ? node.index : generateNewVarName("index")
      if (!globalArray && this.forallOptimization) {
        const varDecl = createVariableDeclaration(index, createElementaryTypeName("uint256"), false)
        this.functionDecorators.pre.push(createVariableDeclarationStmt([varDecl], createNumberLiteral("0")))
      }
      this.forAllCacheMap.set(node, [names, createIdentifier(index)])
    }
    return this.forAllCacheMap.get(node)!
  }

  private generateSum(node: SumExpression,
                      muMapping: Map<string, Expression>): PendingStatements {
    const diffVar = [...node.free, ...node.mu].filter((it) => !muMapping.has(it.name))
    diffVar.forEach((it) => node.unboundedMu.add(it.name))
    const createIndexAccessRecursive = (object: Expression, expressions: Expression[]): Expression => {
      if (expressions.length === 0) { return object }
      const indexAccess = createIndexAccess(object, expressions[0])
      return createIndexAccessRecursive(indexAccess, expressions.slice(1))
    }
    const gen = (operator: BinOp) => {
      const [muMappingWithUnbounded, lastBlock, firstFor] = this.generateUnboundedFreeVars(node, muMapping)
      const cacheOrGenerate = (name: string) => {
        const typeName = this.contractVars.get(name)!
        if (typeName.type === "ElementaryTypeName") {
          return createIdentifier(this.findOrCreateStateVarCache(name))
        } else {
          return createIndexAccessRecursive(createIdentifier(name),
            node.free.map((it) => muMappingWithUnbounded.get(it.name)!))
        }
      }
      const base = cacheOrGenerate(node.name)
      const right = new Rewriter(this.stateVarCache, muMappingWithUnbounded).visit(node.expression) as Expression
      const safeOperation = createExpressionStmt(createFunctionCall(
        createIdentifier("assert"),
        [createBinaryOperation(base, right, ">=")],
      ))
      const statement = createExpressionStmt(createBinaryOperation(base, right, operator))
      const statements: Statement[] = operator === "-=" ? [safeOperation, statement] : [statement, safeOperation]
      const block = createBlock(statements)
      const condition = new Rewriter(this.stateVarCache, muMappingWithUnbounded).visit(node.condition) as Expression
      const muUpdate = createIfStatment(condition, block)
      lastBlock.statements.push(muUpdate)
      return firstFor ? firstFor : lastBlock
    }

    return new PendingStatements([gen("-=")], [gen("+=")])
  }
  private generateUnboundedFreeVars(node: QuantityExp, muMapping: Map<string, Expression>):
    [Map<string, Expression>, Block, ForStatement?] {

    let diffVar = (node.type === "ForAllExpression" ? node.mu : [...node.free, ...node.mu])
      .filter((it) => !muMapping.has(it.name))
    let firstFor: ForStatement | undefined
    let lastBlock: Block = createBlock([])
    const createLoop = (identifier: Iden) => {
      const indexIdentifier = createIdentifier(generateNewVarName("index"))
      const storeIdentifier = createIdentifier(node.universe.get(identifier.name)![1])
      const initExpression = createVariableDeclarationStmt(
        [createVariableDeclaration(indexIdentifier.name, createElementaryTypeName("uint256"), false)],
        createNumberLiteral("0"))
      const length = createMemberAccess(storeIdentifier, "length")
      const conditionExpression = createBinaryOperation(indexIdentifier, length, "<")
      const loopExpression = createExpressionStmt(
        createBinaryOperation(indexIdentifier, createNumberLiteral("1"), "+="))
      const body = createBlock([])
      const forLoop = createForloop(body, initExpression, conditionExpression, loopExpression)
      if (!firstFor) {
        lastBlock.statements.push(forLoop)
      } else {
        firstFor = forLoop
      }
      lastBlock = forLoop.body as Block
      node.unboundedMu.add(identifier.name)
      muMapping.set(identifier.name, createIndexAccess(storeIdentifier, indexIdentifier))
    }

    diffVar = diffVar.filter((it) => {
      if (!node.positionMuVarMap.has(it.name)) {
        createLoop(it)
        return false
      }
      return true
    })
    diffVar = diffVar.sort((a, b) => a.name < b.name ? -1 : 1)

    while (diffVar.length > 0) {
      let change = false
      diffVar = diffVar.filter((it) => {
        if ([...node.positionMuDependencyMap.get(it.name)!].every((dep) => muMapping.has(dep))) {
          change = true
          muMapping.set(it.name,
            new Rewriter(this.stateVarCache, muMapping).visit(node.positionMuVarMap.get(it.name)!) as Expression)
          return false
        }
        return true
      })
      if (!change) {
        createLoop(diffVar.pop()!)
      }
    }

    node.positionMuVarAssertions.map((it) => {
      const exp = new Rewriter(this.stateVarCache, muMapping).visit(it) as Expression
      lastBlock.statements.push(createExpressionStmt(
        createFunctionCall(createIdentifier("assert"), [exp])))
    })
    return [muMapping, lastBlock, firstFor]
  }

}
