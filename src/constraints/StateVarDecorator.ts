import * as _ from "lodash"
import {
  BinOp, Block, ContractDefinition, Expression, ExpressionStatement, ForStatement, FunctionDefinition,
  Identifier, ReturnStatement, Statement, StateVariableDeclaration, TypeName, Visitor, ArrayTypeName,
} from "solidity-parser-antlr"
import { optimizeStorageAccess } from "../optimizer/StorageAccessOptimizer"
import { ContractVisitor } from "../visitors/ContractVisitor"
import { CMPExpression, ForAllExpression, Iden, Node, QuantityExp, SumExpression } from "./nodes/Node"
import { PendingStatements } from "./PendingStatements"
import { Rewriter } from "./Rewriter"
import { generateNewVarName } from "./StateVariableGenerator"
import {
  createBaseASTNode, createBinaryOperation, createBlock, createElementaryTypeName,
  createExpressionStmt, createFunctionCall, createIdentifier, createIfStatment, createIndexAccess,
  createMemberAccess, createNumberLiteral, createVariableDeclaration, createVariableDeclarationStmt,
  getChildren, getMonitoredStateVariables, getMonitoredVariables, getMuIndices, getUpdatedVariable,
  createArray,
} from "./utilities"

const updateOps = ["=", "-=", "+=", "*=", "/="]

export class StateVarDecorator extends ContractVisitor implements Visitor  {
  public constraints: Node[]
  public variables: Map<string, StateVariableDeclaration[]>
  public functionConstraints: Map<string, Map<string, Set<Node>>> = new Map()
  public canAddAssertions = false
  public contractVars: Map<string, TypeName>
  public functionDecorators: PendingStatements = new PendingStatements()
  public enableMappingOptimization: boolean
  public enableForAllOptimization: boolean
  public forAllCacheMap: Map<ForAllExpression, [string[], string]> = new Map()
  private contractName: string = ""
  private functionName: string = ""
  constructor(constraints: Node[], variables: Map<string, StateVariableDeclaration[]>,
              contractVars: Map<string, TypeName>, optimize: boolean, forAllMemoryCache: boolean = true) {
    super()
    this.constraints = constraints
    this.variables = variables
    this.contractVars = contractVars
    this.enableMappingOptimization = optimize
    this.enableForAllOptimization = forAllMemoryCache
  }
  public ContractDefinition = (node: ContractDefinition) => {
    this.contractName = node.name
    this.functionConstraints.set(node.name, new Map())
    node.subNodes = this.visit(node.subNodes)
    if (this.variables.has(node.name)) {
      node.subNodes = [...this.variables.get(node.name)!, ...node.subNodes]
    }
    return node
  }
  public FunctionDefinition = (node: FunctionDefinition) => {
    this.functionName = node.name ? node.name : "constructor"
    this.functionConstraints.get(this.contractName)!.set(this.functionName, new Set())
    this.functionDecorators = new PendingStatements()
    this.forAllCacheMap = new Map()
    this.canAddAssertions = node.visibility === "public"
    node.body = this.visit(node.body)
    if (node.body) {
      node.body.statements.unshift(...this.functionDecorators.pre)
      node.body.statements.push(...this.functionDecorators.post)
    }
    return node
  }
  public ReturnStatement = (node: ReturnStatement) => {
    const block = createBaseASTNode("Block") as Block
    block.statements = []
    block.statements.push(...this.functionDecorators.post)
    block.statements.push(node)
    return block
  }
  public ExpressionStatement = (statement: ExpressionStatement) => {
    if (statement.expression.type !== "BinaryOperation") { return statement }
    const binOp = statement.expression
    if (!updateOps.includes(binOp.operator)) { return statement }
    const variable = getUpdatedVariable(binOp.left)!
    this.constraints.filter((it) => getMonitoredStateVariables(it).has(variable)).forEach((it) => {
      this.functionConstraints.get(this.contractName)!.get(this.functionName)!.add(it)
    })
    if (binOp.left.type !== "IndexAccess") { return statement }
    let indices = [binOp.left.index]

    let base = binOp.left.base
    while (base.type === "IndexAccess") {
      indices.push(base.index)
      base = base.base
    }
    indices = indices.reverse()
    if (base.type !== "Identifier") { return statement }
    const constraintPair: Array<[QuantityExp, Map<string, Expression>]> = []
    const generate = (constraint: Node, identifier: Identifier) => {
      getChildren(constraint).map((it) => generate(it, identifier)).forEach((it) => pendingStatements.merge(it))
      if (constraint.type === "ForAllExpression" || constraint.type === "SumExpression") {
        const muIndices: Map<string, Expression> = new Map()
        getMuIndices(constraint, identifier.name)
          .map((it, id) => muIndices.set(it, indices[id]))
        const pendingStmts = constraint.type === "ForAllExpression"
          ? this.generateForAll(constraint, identifier, muIndices)
          : this.generateSum(constraint, identifier, muIndices)
        if (!pendingStmts.isEmpty()) {
          constraintPair.push([constraint, muIndices])
        }
        return pendingStmts
      }
      return new PendingStatements()
    }
    const pendingStatements = new PendingStatements()
    this.constraints.forEach((it) => pendingStatements.merge(generate(it, base as Identifier)))
    if (pendingStatements.isEmpty()) { return statement }
    if (!this.enableMappingOptimization || constraintPair.filter((it) => it[0].type === "SumExpression").length === 0) {
      return [...this.visit(pendingStatements.pre), statement, ...this.visit(pendingStatements.post)]
    } else {
      const result = optimizeStorageAccess(constraintPair,
        [...pendingStatements.pre, statement, ...pendingStatements.post], this.contractVars, this.stateVarCache)
      return createBlock([...result[0], ...this.visit(result[1]), ...result[2]])
    }
  }

  public generateForAll(node: ForAllExpression, identifier: Identifier,
                        indices: Map<string, Expression>): PendingStatements {
    if (!getMonitoredVariables(node, node.mu[0].name).has(identifier.name)) { return new PendingStatements() }
    const gen = (operator: BinOp) => {
      const variable = createIdentifier(node.name[0])
      const left = new Rewriter(indices)
        .visit((node.constraint as CMPExpression).right) as Expression
      const condition = createBinaryOperation(left, variable, operator)
      const trueBody = createExpressionStmt(createBinaryOperation(variable, left as Expression, "="))
      return createIfStatment(condition, trueBody)
    }
    switch (node.constraint.type) {
      case "CMPExpression": {
        switch (node.constraint.op) {
          case "<":
          case "<=": {
            return new PendingStatements([gen("<")])
          }
          case ">":
          case ">=": {
            return new PendingStatements([gen(">")])
          }
        }
        break
      }
      case "MuExpression": {
        const block = createBaseASTNode("Block") as Block
        block.statements = []
        if (this.enableForAllOptimization) {
          const arrays = this.generateOrCreateForAllCache(node)
          const index = createIdentifier(arrays[1])
          arrays[0].forEach((it, idx) => {
            const assignment = createBinaryOperation(
              createIndexAccess(createIdentifier(it), index), indices.get(node.mu[idx].name)!, "=")
            block.statements.push(createExpressionStmt(assignment))
          })
          block.statements.push(createExpressionStmt(createBinaryOperation(index, createNumberLiteral("1"), "+=")))
        } else {
          node.name.forEach((name, index) => {
            const functionCall = createFunctionCall(
              createMemberAccess(createIdentifier(name), "push"), [indices.get(node.mu[index].name)!], [])
            block.statements.push(createExpressionStmt(functionCall))
            this.functionDecorators.pre.push(createExpressionStmt(
              createBinaryOperation(createMemberAccess(createIdentifier(name), "length"),
                createNumberLiteral("0"), "=")))
          })
        }
        return new PendingStatements([block])
      }
    }
    return new PendingStatements()
  }


  public generateOrCreateForAllCache(node: ForAllExpression): [string[], string] {
    if (!this.forAllCacheMap.has(node)) {
      const index = generateNewVarName("index")
      const varDecl = createVariableDeclaration(index, createElementaryTypeName("uint256"), false)
      this.functionDecorators.pre.push(createVariableDeclarationStmt([varDecl], createNumberLiteral("0")))
      const names: string[] = []
      node.name.forEach((it, idx) => {
        const arr = generateNewVarName(node.mu[idx].name)
        names.push(arr)
        const type = (this.contractVars.get(it)! as ArrayTypeName).baseTypeName
        const arrayType = createArray(type, createNumberLiteral("20"))
        const decl = createVariableDeclaration(arr, arrayType, false, "memory")
        this.functionDecorators.pre.push(createVariableDeclarationStmt([decl]))
      })
      this.forAllCacheMap.set(node, [names, index])
    }
    return this.forAllCacheMap.get(node)!
  }

  public generateSum(node: SumExpression, identifier: Identifier,
                     muIndices: Map<string, Expression>): PendingStatements {
    if (node.mu.filter((it) => getMonitoredVariables(node, it.name)
      .has(identifier.name)).length === 0) { return new PendingStatements() }
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
        return createIndexAccessRecursive(createIdentifier(name), node.free.map((it) => muIndices.get(it.name)!))
      }
    }
    const gen = (operator: BinOp) => {
      const typeName = this.contractVars.get(node.name)!
      if (typeName.type === "ElementaryTypeName") {

      }
      const base = cacheOrGenerate(node.name)
      const v = (node.constraint.type === "MuIndexedAccess")
        ? createIndexAccess(base, new Rewriter(this.stateVarCache, muIndices).visit(node.constraint) as Expression)
        : base
      const right = new Rewriter(this.stateVarCache, muIndices).visit(node.body) as Expression
      const safeOperation = createExpressionStmt(createFunctionCall(
        createIdentifier("assert"),
        [createBinaryOperation(v, right, ">=")],
      ))
      const statement = createExpressionStmt(createBinaryOperation(v, right, operator))
      const statements: Statement[] = operator === "-=" ? [safeOperation, statement] : [statement, safeOperation]
      const block = createBlock(statements)
      if (node.constraint.type === "MuExpression") {
        const condition = new Rewriter(this.stateVarCache, muIndices).visit(node.constraint) as Expression
        return createIfStatment(condition, block)
      } else {
        return block
      }
    }
    return new PendingStatements([gen("-=")], [gen("+=")])
  }
}
