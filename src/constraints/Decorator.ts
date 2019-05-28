import * as _ from "lodash"
import {
  BinOp, Block, ContractDefinition, Expression, ExpressionStatement, ForStatement, FunctionDefinition,
  Identifier, ReturnStatement, Statement, StateVariableDeclaration, TypeName, Visitor,
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
} from "./utilities"

const updateOps = ["=", "-=", "+=", "*=", "/="]

export class Decorator extends ContractVisitor implements Visitor  {
  public constraints: Node[]
  public variables: Map<string, StateVariableDeclaration[]>
  public checkConstraints: Set<Node> = new Set()
  public stateVarCache: Map<string, string> = new Map()
  public stateVarCacheReverse: Map<string, string> = new Map()
  public canAddAssertions = false
  public contractVars: Map<string, TypeName>
  public functionDecorators: PendingStatements = new PendingStatements()
  public optimize: boolean
  constructor(constraints: Node[], variables: Map<string, StateVariableDeclaration[]>,
              contractVars: Map<string, TypeName>, optimize: boolean) {
    super()
    this.constraints = constraints
    this.variables = variables
    this.contractVars = contractVars
    this.optimize = optimize
  }
  public ContractDefinition = (node: ContractDefinition) => {
    node.subNodes = this.visit(node.subNodes)
    if (this.variables.has(node.name)) {
      node.subNodes = [...this.variables.get(node.name)!, ...node.subNodes]
    }
    return node
  }
  public FunctionDefinition = (node: FunctionDefinition) => {
    this.checkConstraints = new Set()
    this.stateVarCache = new Map()
    this.stateVarCacheReverse = new Map()
    this.functionDecorators = new PendingStatements()
    this.canAddAssertions = node.visibility === "public"
    node.body = this.visit(node.body)
    if (node.body) {
      node.body.statements.unshift(...this.functionDecorators.pre)
      if (this.canAddAssertions) {
        node.body.statements.push(
          ...[...this.checkConstraints]
            .map((it) => this.generateAssertions(it)).reduce((pre, cur) => [...pre, ...cur], []))
      }
      node.body.statements.push(...this.functionDecorators.post)
    }
    return node
  }
  public ReturnStatement = (node: ReturnStatement) => {
    const block = createBaseASTNode("Block") as Block
    block.statements = []
    if (this.canAddAssertions) {
      block.statements.push(
        ...[...this.checkConstraints]
          .map((it) => this.generateAssertions(it)).reduce((pre, cur) => [...pre, ...cur], []))
    }
    block.statements.push(...this.functionDecorators.post)
    block.statements.push(node)
    return block
  }
  public ExpressionStatement = (statement: ExpressionStatement) => {
    if (statement.expression.type !== "BinaryOperation") { return statement }
    const binOp = statement.expression
    if (!updateOps.includes(binOp.operator)) { return statement }
    const variable = getUpdatedVariable(binOp.left)!
    const realVarOptional = this.stateVarCacheReverse.get(variable)
    const realVar = realVarOptional ? realVarOptional : variable
    this.constraints.filter((it) => getMonitoredStateVariables(it).has(realVar)).forEach((it) => {
      this.checkConstraints.add(it)
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
    if (this.optimize) {
      const result = optimizeStorageAccess(constraintPair,
        [...pendingStatements.pre, statement, ...pendingStatements.post], this.contractVars, this.stateVarCache)
      return createBlock([...result[0], ...this.visit(result[1]), ...result[2]])
    } else {
      return [...this.visit(pendingStatements.pre), statement, ...this.visit(pendingStatements.post)]
    }
  }
  public generateAssertions(node: Node): Statement[] {
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
  public generateAssertionsForAll(node: ForAllExpression) {
    if (node.constraint.type === "CMPExpression") {
      const binrayExp = createBinaryOperation(
        new Rewriter(this.stateVarCache).visit(node.constraint.left) as Expression,
        createIdentifier(node.name[0]), node.constraint.op)
      const functionCall = createFunctionCall(createIdentifier("assert"), [binrayExp], [])
      return createExpressionStmt(functionCall)
    } else {
      const forLoop = createBaseASTNode("ForStatement") as ForStatement
      const indexIdentifier = createIdentifier(generateNewVarName("index"))
      forLoop.initExpression = createVariableDeclarationStmt(
        [createVariableDeclaration(indexIdentifier.name, createElementaryTypeName("uint256"), false)],
        createNumberLiteral("0"))
      const arrayVar = createIdentifier(node.name[0])
      forLoop.conditionExpression = createBinaryOperation(
        indexIdentifier, createMemberAccess(arrayVar, "length"), "<")
      forLoop.loopExpression = createExpressionStmt(
        createBinaryOperation(indexIdentifier, createNumberLiteral("1"), "+="))
      forLoop.body = createBaseASTNode("Block") as Block
      const map: Map<string, Expression> = new Map()
      node.name.forEach((value, idx) => {
        map.set(node.mu[idx].name, createIndexAccess(createIdentifier(value), indexIdentifier))
      })
      const exp = new Rewriter(this.stateVarCache, map).visit(node.constraint) as Expression
      const functionCall = createFunctionCall(createIdentifier("assert"), [exp], [])
      forLoop.body.statements = [createExpressionStmt(functionCall)]
      return forLoop
    }
  }

  public generateForAll(node: ForAllExpression, identifier: Identifier,
                        indices: Map<string, Expression>): PendingStatements {
    if (!getMonitoredVariables(node, node.mu[0].name).has(identifier.name)) { return new PendingStatements() }
    const gen = (operator: BinOp) => {
      const variable = createIdentifier(node.name[0])
      const left = new Rewriter(this.stateVarCache, indices)
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
        node.name.forEach((name, index) => {
          const functionCall = createFunctionCall(
            createMemberAccess(createIdentifier(name), "push"), [indices.get(node.mu[index].name)!], [])
          block.statements.push(createExpressionStmt(functionCall))
          this.functionDecorators.pre.push(createExpressionStmt(
            createBinaryOperation(createMemberAccess(createIdentifier(name), "length"), createNumberLiteral("0"), "=")))
        })
        return new PendingStatements([block])
      }
    }
    return new PendingStatements()
  }

  public generateOrCreateStateVarCache(name: string): string {
    if (!this.optimize) { return name }
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
