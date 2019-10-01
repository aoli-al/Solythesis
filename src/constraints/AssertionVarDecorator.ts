import * as _ from "lodash"
import {
  BinOp, Block, ContractDefinition, Expression, ExpressionStatement, ForStatement, FunctionDefinition,
  Identifier, ReturnStatement, Statement, StateVariableDeclaration, TypeName, Visitor,
} from "solidity-parser-antlr"
import { optimizeStorageAccess } from "../optimizer/StorageAccessOptimizer"
import { ContractVisitor } from "../visitors/ContractVisitor"
import { Forall, Node, QuantityExp, Sum, Identifier as Iden} from "./nodes/Node"
import { PendingStatements } from "./PendingStatements"
import { Rewriter } from "./Rewriter"
import { generateNewVarName } from "./StateVariableGenerator"
import {
  createBaseASTNode, createBinaryOperation, createBlock, createElementaryTypeName,
  createExpressionStmt, createFunctionCall, createIdentifier, createIfStatment, createIndexAccess,
  createMemberAccess, createNumberLiteral, createVariableDeclaration, createVariableDeclarationStmt,
  getChildren, getMonitoredStateVariables, getMonitoredVariables, getMuIndices, getUpdatedVariable,
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
import { SubstutionAnalyzer } from "src/analyzer/SubstitutionAnalyzer"

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
  public forAllCacheMap: Map<Forall, [string[], Identifier]> = new Map()
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
      if (constraint.type === "ForAllExpression" || constraint.type === "SumExpression") {
        const [result, muBindings] = (new SubstutionAnalyzer(constraint, binOp)).run()
        if (!result) { return new PendingStatements() }

        const ps = new PendingStatements()
        muBindings.forEach((muBinding) => {
          const pendingStmts = constraint.type === "ForAllExpression"
            ? this.generateForall(constraint, muBinding)
            : this.generateSum(constraint, muBinding)
          if (!pendingStmts.isEmpty()) {
            constraintPair.push([constraint, muBinding])
          }
          ps.merge(pendingStatements)
        })
      }
      return new PendingStatements()
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
    const generate = (node: Node) => {
      switch (node.type) {
        case "SExpression": {
          const exp = new Rewriter(this.stateVarCache).visit(node) as Expression
          const functionCall = createFunctionCall(createIdentifier("assert"), [exp], [])
          return [createExpressionStmt(functionCall)]
        }
        case "ForAllExpression": {
          return [this.generateAssertionsForAll(node)]
        }
      }
      return []
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
  private generateAssertionsForAll(node: Forall) {
    if (node.constraint.type === "CMPExpression") {
      const binrayExp = createBinaryOperation(
        new Rewriter(this.stateVarCache).visit(node.constraint.left) as Expression,
        createIdentifier(node.name[0]), node.constraint.op)
      const functionCall = createFunctionCall(createIdentifier("assert"), [binrayExp], [])
      return createExpressionStmt(functionCall)
    } else {
      const indexIdentifier = createIdentifier(generateNewVarName("index"))
      const initExpression = createVariableDeclarationStmt(
        [createVariableDeclaration(indexIdentifier.name, createElementaryTypeName("uint256"), false)],
        createNumberLiteral("0"))
      const length = this.forallOptimization ? this.generateOrCreateForAllCache(node)[1]
        : createMemberAccess(createIdentifier(this.generateOrCreateForAllCache(node)[0][0]), "length")
      const conditionExpression = createBinaryOperation(indexIdentifier, length, "<")
      const loopExpression = createExpressionStmt(
        createBinaryOperation(indexIdentifier, createNumberLiteral("1"), "+="))
      const body = createBaseASTNode("Block") as Block
      const statements: Statement[] = []
      const map: Map<string, Expression> = new Map()
      this.generateOrCreateForAllCache(node)[0].forEach((value, index) => {
        if (this.canOptimize || !this.forallOptimization) {
          map.set(node.mu[index].name, createIndexAccess(createIdentifier(value), indexIdentifier))
        } else {
          const tmpVar = generateNewVarName("tmp")
          const varDecl = createVariableDeclaration(tmpVar, node.muWithTypes.get(node.mu[index].name)!, false)
          statements.push(createVariableDeclarationStmt([varDecl]))
          statements.push(loadArrayValue(value, indexIdentifier.name, tmpVar))
          map.set(node.mu[index].name, createIdentifier(tmpVar))
        }
      })
      const exp = new Rewriter(this.stateVarCache, map).visit(node.constraint) as Expression
      const functionCall = createFunctionCall(createIdentifier("assert"), [exp], [])
      body.statements = [...statements, createExpressionStmt(functionCall)]
      const forLoop = createForloop(body, initExpression, conditionExpression, loopExpression)
      if (!this.forallOptimization) {
        const expressions: Statement[] = []
        this.generateOrCreateForAllCache(node)[0].forEach((value) => {
          expressions.push(createExpressionStmt(
            createBinaryOperation(
              createMemberAccess(createIdentifier(value), "length"), createNumberLiteral("0"), "=")))
        })
        expressions.unshift(forLoop)
        return createBlock(expressions)
      } else if (!this.canOptimize) {
        const expressions: Statement[] = [createExpressionStmt(
          createBinaryOperation(createIdentifier(node.index), createNumberLiteral("0"), "="))]
        expressions.unshift(forLoop)
        return createBlock(expressions)
      }
      return forLoop
    }
  }

  private generateForall(node: Forall, muBindings: Map<string, Expression>): PendingStatements {
    const block = createBaseASTNode("Block") as Block
    node.mu.filter((it) => !muBindings.has(it.name)).forEach((it) => node.unboundedMu.add(it.name))
    block.statements = []
    const arrays = this.generateOrCreateForAllCache(node)
    const index = arrays[1] as Identifier
    arrays[0].forEach((it, idx) => {
      if (!node.unboundedMu.has(node.mu[idx].name)) {
        const value = muBindings.get(node.mu[idx].name)!
        if (!this.forallOptimization) {
          const push = createFunctionCall(createMemberAccess(createIdentifier(it), "push"), [value])
          block.statements.push(createExpressionStmt(push))
        } else {
          if (this.canOptimize) {
            const assignment = createBinaryOperation(
              createIndexAccess(createIdentifier(it), index), muBindings.get(node.mu[idx].name)!, "=")
            block.statements.push(createExpressionStmt(assignment))
          } else {
            const tmpVar = generateNewVarName("tmp")
            const varDecl = createVariableDeclaration(tmpVar, node.muWithTypes.get(node.mu[idx].name)!, false)
            block.statements.push(createVariableDeclarationStmt([varDecl], muBindings.get(node.mu[idx].name)!))
            block.statements.push(storeArrayValue(it, index.name, tmpVar))
          }
        }
      }
    })
    if (this.forallOptimization) {
      block.statements.push(createExpressionStmt(createBinaryOperation(index, createNumberLiteral("1"), "+=")))
    }
    return new PendingStatements([block])
  }

  private generateOrCreateStateVarCache(name: string): string {
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

  private generateOrCreateForAllCache(node: Forall): [string[], Identifier] {
    const globalArray = !this.canOptimize
    if (!this.forAllCacheMap.has(node)) {
      const names: string[] = []
      node.name.forEach((it, idx) => {
        const arr = generateNewVarName(node.mu[idx].name)
        if (this.forallOptimization) {
          names.push(arr)
        } else {
          names.push(node.mu[idx].name)
          return
        }
        const type = node.muWithTypes.get(node.mu[idx].name)!
        // const arrayType = createArray(type, createNumberLiteral("20"))
        const arrayType = createArray(type, globalArray ? undefined : createNumberLiteral("20"))
        const decl = createVariableDeclaration(arr, arrayType, false, "memory")
        this.functionDecorators.pre.push(createVariableDeclarationStmt([decl]))
        if (globalArray) {
          const initAssembly = createGlobalArray(arr, it)
          const loadAssembly = loadGlobalArray(arr, it)
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

  private generateSum(node: Sum,
                      muMapping: Map<string, Expression>): PendingStatements {
    const diffVar = [...node.free, ...node.mu].filter((it) => !muMapping.has(it.name))
    diffVar.forEach((it) => node.unboundedMu.add(it.name))
    const [result, firstFor, lastFor] = this.loopUnboundedArrays(node, diffVar)
    const muMappingWithUnbounded = new Map([...Array.from(muMapping), ...result])
    const createIndexAccessRecursive = (object: Expression, expressions: Expression[]): Expression => {
      if (expressions.length === 0) { return object }
      const indexAccess = createIndexAccess(object, expressions[0])
      return createIndexAccessRecursive(indexAccess, expressions.slice(1))
    }
    const cacheOrGenerate = (name: string) => {
      const typeName = this.contractVars.get(name)!
      if (typeName.type === "ElementaryTypeName") {
        return createIdentifier(this.generateOrCreateStateVarCache(name))
      } else {
        return createIndexAccessRecursive(createIdentifier(name),
          node.free.map((it) => muMappingWithUnbounded.get(it.name)!))
      }
    }
    const gen = (operator: BinOp) => {
      const base = cacheOrGenerate(node.name)
      const right = new Rewriter(this.stateVarCache, muMappingWithUnbounded).visit(node.expression) as Expression
      const safeOperation = createExpressionStmt(createFunctionCall(
        createIdentifier("assert"),
        [createBinaryOperation(base, right, ">=")],
      ))
      const statement = createExpressionStmt(createBinaryOperation(base, right, operator))
      const statements: Statement[] = operator === "-=" ? [safeOperation, statement] : [statement, safeOperation]
      const block = createBlock(statements)
      let muUpdate: Statement = block
      if (node.constraint.type === "MuExpression") {
        const condition = new Rewriter(this.stateVarCache, muIndices).visit(node.constraint) as Expression
        muUpdate = createIfStatment(condition, block)
      }
      if (node.muDescriptor) {
        return createIfStatment(new Rewriter(this.stateVarCache, muIndices)
          .visit(node.muDescriptor) as Expression, muUpdate)
      }
      return muUpdate
    }

    return new PendingStatements([gen("-=")], [gen("+=")])
  }
  private loopUnboundedArrays(node: QuantityExp, identifiers: Iden[]):
    [Array<[string, Expression]>, ForStatement?, ForStatement?] {
    let lastFor: ForStatement | undefined
    let firstFor: ForStatement | undefined
    const createLoop = (identifier: Iden): [string, Expression] => {
      const indexIdentifier = createIdentifier(generateNewVarName("index"))
      const storeIdentifier = createIdentifier(node.universe.get(identifier.name)![1])
      const initExpression = createVariableDeclarationStmt(
        [createVariableDeclaration(indexIdentifier.name, createElementaryTypeName("uint256"), false)],
        createNumberLiteral("0"))
      const length = createMemberAccess(storeIdentifier, "length")
      const conditionExpression = createBinaryOperation(indexIdentifier, length, "<")
      const loopExpression = createExpressionStmt(
        createBinaryOperation(indexIdentifier, createNumberLiteral("1"), "+="))
      const body = createBaseASTNode("Block") as Block
      const forLoop = createForloop(body, initExpression, conditionExpression, loopExpression)
      if (lastFor) {
        (lastFor.body as Block).statements.push(forLoop)
      } else {
        firstFor = forLoop
      }
      lastFor = forLoop
      return [identifier.name,
              createIndexAccess(storeIdentifier, indexIdentifier)]
    }
    const result = identifiers.map((it) => createLoop(it))
    return [result, firstFor, lastFor]
  }

}
