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
  createUnaryOperation,
  createIndexAccessRecursive,
  loadMemoryValue,
  loadMemoryAddress,
  storeMemoryValue,
  allocateMemory,
} from "./utilities"
import { SubstutionAnalyzer } from "../analyzer/SubstitutionAnalyzer"

export const updateOps = ["=", "-=", "+=", "*=", "/="]
const memoryStart = generateNewVarName("memoryStart")
const entry = generateNewVarName("entry")
const one = createNumberLiteral("1")
const zero = createNumberLiteral("0")

export class AssertionDectorator extends ContractVisitor implements Visitor  {
  public constraints: Node[]
  public variables: Map<string, StateVariableDeclaration[]>
  public checkConstraints: Set<Node> = new Set()
  public stateVarCache: Map<string, string> = new Map()
  public stateVarCacheReverse: Map<string, string> = new Map()
  public totalMemorySize: number
  public allocatedMemorySize: number = 0
  public canAddAssertions = false
  public contractVars: Map<string, TypeName>
  public functionDecorators: PendingStatements = new PendingStatements()
  public enableMappingOptimization: boolean
  public canOptimize: boolean = false
  public pendingReturns: Block[] = []
  public forAllCacheMap: Map<ForAllExpression, [Map<string, string>, Expression]> = new Map()
  private contractName: string = ""
  private forallOptimization: boolean
  private depthRequired: boolean = false
  private baselineImplementation: boolean = false
  private functionConstraints: Map<string, Map<string, Set<Node>>>
  constructor(constraints: Node[], functionConstraints: Map<string, Map<string, Set<Node>>>,
              variables: Map<string, StateVariableDeclaration[]>,
              contractVars: Map<string, TypeName>, optimize: boolean,
              forallOptimization: boolean = true, baselineImplementation: boolean = false,
              totalMemorySize: number = 0) {
    super()
    this.constraints = constraints
    this.variables = variables
    this.contractVars = contractVars
    this.enableMappingOptimization = optimize
    this.functionConstraints = functionConstraints
    this.forallOptimization = forallOptimization
    this.baselineImplementation = baselineImplementation
    this.totalMemorySize = totalMemorySize
  }
  public ContractDefinition = (node: ContractDefinition) => {
    this.contractName = node.name
    node.subNodes = this.visit(node.subNodes)
    if (this.variables.has(node.name)) {
      node.subNodes = [...this.variables.get(node.name)!, ...node.subNodes]
      const varDecl = createVariableDeclaration(memoryStart, createElementaryTypeName("uint256"), true)
      node.subNodes.unshift(createStateVariableDeclaration([varDecl]))
    }
    return node
  }
  public FunctionDefinition = (node: FunctionDefinition) => {
    this.stateVarCache = new Map()
    this.stateVarCacheReverse = new Map()
    this.functionDecorators = new PendingStatements()
    this.forAllCacheMap = new Map()
    this.canAddAssertions = node.visibility === "public" &&
      (!node.stateMutability || !["pure", "view", "constant"].includes(node.stateMutability))
    this.pendingReturns = []
    const name = (() => {
      if (node.isConstructor || !node.name) { return "<Constructor>" }
      if (node.name.length === 0) { return  "<Fallback>" }
      return node.name
    })()
    this.depthRequired = (getCallers(this.contractName, name).length > 0 ||
      getSubFunctions(this.contractName, name).length > 0) &&
      (!node.stateMutability || !["pure", "view", "constant"].includes(node.stateMutability))
    this.checkConstraints = [...getSubFunctions(this.contractName, name), [this.contractName, name]].map((it) => {
      if (!this.functionConstraints.has(it[0]) ||
        !this.functionConstraints.get(it[0])!.has(it[1])) { return new Set() as Set<Node>  }
      return this.functionConstraints.get(it[0])!.get(it[1])!
    }).reduce((left, right) => new Set([...left, ...right]), new Set())
    this.canOptimize = canOptimize(this.contractName, name) && this.canAddAssertions
    node.body = this.visit(node.body)
    if (node.body) {
      if (this.canAddAssertions && this.checkConstraints.size !== 0) {
        node.body.statements.push(...this.generateAssertions())
        node.body.statements.unshift(...this.functionDecorators.pre)
        const tmp = generateNewVarName("tmp")
        const entryVar = createIdentifier(entry)
        const tmpDecl =
          createVariableDeclarationStmt([createVariableDeclaration(tmp, createElementaryTypeName("uint256"), false)])
        const entryDecl =
          createVariableDeclarationStmt([createVariableDeclaration(entry, createElementaryTypeName("uint256"), false)],
          zero)
        const ifStmt = createIfStatment(createBinaryOperation(createIdentifier(memoryStart), zero, "=="),
          createBlock([
            createExpressionStmt(createBinaryOperation(entryVar, one, "=")),
            allocateMemory(tmp, memoryStart, this.totalMemorySize)]))
        node.body.statements.unshift(ifStmt)
        node.body.statements.unshift(tmpDecl)
        node.body.statements.unshift(entryDecl)
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
          if (!this.baselineImplementation) {
            const pendingStmts = constraint.type === "ForAllExpression"
              ? this.generateForall(constraint, muBinding)
              : this.generateSum(constraint, muBinding)
            if (!pendingStmts.isEmpty()) {
              constraintPair.push([constraint, muBinding])
            }
            ps.merge(pendingStmts)
          }
          const universeUpdate = this.generateUniverseUpdate(constraint, muBinding)
          ps.post.push(...universeUpdate)
        })
      }
      return ps
    }
    const pendingStatements = new PendingStatements()
    this.constraints.forEach((it) => pendingStatements.merge(generate(it)))
    if (pendingStatements.isEmpty()) { return statement }
    if (this.baselineImplementation || !this.enableMappingOptimization ||
      constraintPair.filter((it) => it[0].type === "SumExpression").length === 0) {
      return [...this.visit(pendingStatements.pre), statement, ...this.visit(pendingStatements.post)]
    } else {
      const result = optimizeStorageAccess(constraintPair,
        [...pendingStatements.pre, statement, ...pendingStatements.post], this.contractVars, this.stateVarCache)
      return createBlock([...result[0], ...this.visit(result[1]), ...result[2]])
    }
  }
  private generateUniverseUpdate(node: QuantityExp, mu: Map<string, Expression>) {
    const muBindings = new Map(mu)
    if (node.type === "SumExpression") {
      this.findBoundedFreeVars(node, muBindings, node.mu)
    }
    const stmts: Statement[] = []
    muBindings.forEach((binding, name) => {
      if (node.unboundedMu.has(name)) {
        const index = createIndexAccess(createIdentifier(node.universe.get(name)![0]), binding)
        const condition = createUnaryOperation(index, "!")
        const ifstmt = createIfStatment(condition,
          createBlock([
            createExpressionStmt(
              createFunctionCall(createMemberAccess(createIdentifier(node.universe.get(name)![1]), "push"), [binding])),
            createExpressionStmt(createBinaryOperation(index, createNumberLiteral("true"), "="))]))
        stmts.push(ifstmt)
      }
    })
    return stmts
  }
  private generateAssertions(): Statement[] {
    const generate = (node: Node): Array<(ForStatement | ExpressionStatement | Block)> => {
      switch (node.type) {
        case "ForAllExpression": {
          return [this.generateAssertionsForAll(node)]
        }
        case "SumExpression": {
          if (node.unboundedMu.size > 0) {
            return [this.generateSumUpdate(node)]
          } else {
            return []
          }
        }
        default: {
          const exp = new Rewriter(this.stateVarCache).visit(node) as Expression
          const functionCall = createFunctionCall(createIdentifier("assert"), [exp], [])
          return [createExpressionStmt(functionCall)]
        }
      }
    }
    const array = [...this.checkConstraints].sort((a, b) => a.precedence - b.precedence)

    const assertions = array
      .map((it) => generate(it)).reduce((pre, cur) => [...pre, ...cur], [])

    if (this.depthRequired) {
      const ifStatment = createIfStatment(
        createBinaryOperation(createIdentifier(entry),
          createNumberLiteral("1"), "=="), createBlock(assertions.concat(
            [createExpressionStmt(createBinaryOperation(createIdentifier(memoryStart), zero, "="))])))
      return [ifStatment]
    } else {
      return assertions
    }
  }
  private generateSumUpdate(node: SumExpression) {
    const [mm, lb, ff] = this.generateUnboundedFreeVars(node, new Map(), node.mu)
    const [muMap, lastBlock, firstFor] = this.generateUnboundedFreeVars(node, new Map())
    const updateVar = createIndexAccessRecursive(createIdentifier(node.name),
      node.mu.map((it) => muMap.get(it.name)!))
    const recursiveIf = (mu: Identifier[]): Statement => {
      // if (mu.length === 0) {
      const lhs = createIndexAccessRecursive(createIdentifier(node.name),
        node.mu.map((it) => mm.get(it.name)!))
      return createExpressionStmt(createBinaryOperation(lhs, createNumberLiteral("0"), "="))
      // } else {
      //   const currentMu = mu[0]!
      //   return createIfStatment(createBinaryOperation(indexMapping!.get(currentMu.name)!,
      //     createNumberLiteral("0"), "=="), recursiveIf(mu.slice(1)))
      // }
    }
    const right = new Rewriter(this.stateVarCache, muMap).visit(node.expression) as Expression
    lb.statements.push(recursiveIf(node.free))
    lastBlock.statements.push(
      createExpressionStmt(
        createBinaryOperation(updateVar, right, "+=")))
    lastBlock.statements.push(
      createExpressionStmt(
        createFunctionCall(createIdentifier("assert"),
        [createBinaryOperation(updateVar, right, ">=")])))
    return createBlock([ff ? ff : lb, firstFor ? firstFor : lastBlock])
  }
  private generateAssertionsForAll(node: ForAllExpression) {
    const forallCache = this.generateOrCreateForAllCache(node)
    const muRaw: Map<string, Expression> = new Map()
    const indexIdentifier = createIdentifier(generateNewVarName("index"))
    const tmpStatements: Statement[] = []
    if (!this.baselineImplementation) {
      forallCache[0].forEach((localArray, muName) => {
        if (this.canOptimize || !this.forallOptimization) {
          muRaw.set(muName, createIndexAccess(createIdentifier(localArray), indexIdentifier))
        } else {
          const tmpVar = generateNewVarName("tmp")
          const varDecl = createVariableDeclaration(tmpVar, node.muWithTypes.get(muName)!, false)
          tmpStatements.push(createVariableDeclarationStmt([varDecl]))
          tmpStatements.push(loadArrayValue(localArray, indexIdentifier.name, tmpVar))
          muRaw.set(muName, createIdentifier(tmpVar))
        }
      })
    }
    const [muMap, lastBlock, firstFor] = this.generateUnboundedFreeVars(node, muRaw)
    let body = createBaseASTNode("Block") as Block
    if (firstFor) {
      body.statements = [firstFor]
    } else {
      body = lastBlock
    }
    const statements = lastBlock.statements
    statements.unshift(...tmpStatements)
    const exp = new Rewriter(this.stateVarCache, muMap).visit(node.condition) as Expression
    const functionCall = createFunctionCall(createIdentifier("assert"), [exp], [])
    statements.push(createExpressionStmt(functionCall))
    if (forallCache[0].size > 0 && !this.baselineImplementation) {
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
      }
      //   // const setToZero: Statement[] = [createExpressionStmt(
      //   //   createBinaryOperation(createIdentifier(node.index), createNumberLiteral("0"), "="))]
      //   // setToZero.unshift(forLoop)
      //   return forLoop
      // }
      return forLoop
    }
    return firstFor ? firstFor : lastBlock
  }

  private generateForall(node: ForAllExpression, muBindings: Map<string, Expression>): PendingStatements {
    const block = createBaseASTNode("Block") as Block
    node.mu.filter((it) => !muBindings.has(it.name) && !node.positionMuVarMap.has(it.name))
      .forEach((it) => node.unboundedMu.add(it.name))
    block.statements = []
    const forallCache = this.generateOrCreateForAllCache(node)
    const index = forallCache[1]
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
          block.statements.push(storeArrayValue(localArray, tmpVar))
        }
      }
    })
    if (this.forallOptimization && node.mu.length !== node.unboundedMu.size && index.type === "Identifier") {
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

  private generateOrCreateForAllCache(node: ForAllExpression): [Map<string, string>, Expression] {
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
          // const initAssembly = createGlobalArray(arr, node.muStateVars.get(it.name)!)
          const loadAssembly = loadMemoryAddress(memoryStart, node.muStateVars.get(it.name)!, arr)
          // const loadAssembly = loadGlobalArray(arr, node.muStateVars.get(it.name)!)
          this.functionDecorators.pre.push(loadAssembly)
          // if (!this.canAddAssertions) {
          //   this.functionDecorators.pre.push(loadAssembly)
          // } else if (this.depthRequired) {
          //   const ifStmt = createIfStatment(
          //     createBinaryOperation(createIdentifier(depthTracker),
          //       createNumberLiteral("1"), "<="),
          //     initAssembly, loadAssembly)
          //   this.functionDecorators.pre.push(ifStmt)
          // } else if (this.canAddAssertions) {
          //   this.functionDecorators.pre.push(initAssembly)
          // }
        }
      })
      const index = globalArray ? names.values().next().value as string : generateNewVarName("index")
      const indexVar = createIdentifier(index)
      if (!globalArray && this.forallOptimization) {
        const varDecl = createVariableDeclaration(index, createElementaryTypeName("uint256"), false)
        this.functionDecorators.pre.push(createVariableDeclarationStmt([varDecl], createNumberLiteral("0")))
      }
      this.forAllCacheMap.set(node, [names, globalArray ? createMemberAccess(indexVar, "length") : indexVar])
    }
    return this.forAllCacheMap.get(node)!
  }
  private generateSum(node: SumExpression,
                      muMapping: Map<string, Expression>): PendingStatements {
    const gen = (operator: BinOp) => {
      const [muMappingWithUnbounded, lastBlock, firstFor] = this.generateUnboundedFreeVars(node, muMapping)
      const cacheOrGenerate = (name: string) => {
        const typeName = this.contractVars.get(name)!
        if (typeName.type === "ElementaryTypeName") {
          return createIdentifier(this.findOrCreateStateVarCache(name))
        } else {
          return createIndexAccessRecursive(createIdentifier(name),
            node.mu.map((it) => muMappingWithUnbounded.get(it.name)!))
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
  private findBoundedFreeVars(node: QuantityExp,
                              muMapping: Map<string, Expression>, diffVar: Iden[]): [boolean, Iden[]] {
    while (diffVar.length > 0) {
      let change = false
      diffVar = diffVar.filter((it) => {
        if (node.positionMuDependencyMap.has(it.name) &&
          [...node.positionMuDependencyMap.get(it.name)!].every((dep) => muMapping.has(dep))) {
          change = true
          muMapping.set(it.name,
            new Rewriter(this.stateVarCache, muMapping).visit(node.positionMuVarMap.get(it.name)!) as Expression)
          return false
        }
        return true
      })
      if (!change) {
        return [true, diffVar]
      }
    }
    return [false, diffVar]
  }
  private generateUnboundedFreeVars(node: QuantityExp, muMapping: Map<string, Expression>, initialDiffVar?: Iden[]):
    [Map<string, Expression>, Block, ForStatement?, Map<string, Identifier>?] {

    const indexMapping: Map<string, Identifier> = new Map()
    let diffVar = initialDiffVar ? initialDiffVar :
      ((node.type === "ForAllExpression" ? node.mu : [...node.free, ...node.mu])
        .filter((it) => !muMapping.has(it.name)))
    let firstFor: ForStatement | undefined
    let lastBlock: Block = createBlock([])
    const createLoop = (identifier: Iden) => {
      const indexIdentifier = createIdentifier(generateNewVarName("index"))
      indexMapping.set(identifier.name, indexIdentifier)
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
        firstFor = forLoop
      }
      lastBlock.statements.push(forLoop)
      lastBlock = forLoop.body as Block
      node.unboundedMu.add(identifier.name)
      muMapping.set(identifier.name, createIndexAccess(storeIdentifier, indexIdentifier))
    }

    diffVar = diffVar.filter((it) => {
      if (!node.positionMuVarMap.has(it.name) || initialDiffVar) {
        createLoop(it)
        return false
      }
      return true
    })
    diffVar = diffVar.sort((a, b) => a.name < b.name ? -1 : 1)

    let result = false
    for ([result, diffVar] = this.findBoundedFreeVars(node, muMapping, diffVar); result;) {
      createLoop(diffVar.pop()!)
    }

    node.positionMuVarAssertions.map((it) => {
      const exp = new Rewriter(this.stateVarCache, muMapping).visit(it) as Expression
      lastBlock.statements.push(createExpressionStmt(
        createFunctionCall(createIdentifier("assert"), [exp])))
    })
    return [muMapping, lastBlock, firstFor, indexMapping]
  }

}
