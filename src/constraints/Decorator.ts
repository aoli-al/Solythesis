import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, FunctionDefinition, ContractDefinition, Statement, ASTNode, Block, ReturnStatement, BaseASTNode, ForStatement, BinOp } from "solidity-parser-antlr";
import { Node, ForAllExpression, SumExpression } from "./nodes/Node";
import { Printer } from "../printer/printer";
import { createBaseASTNode, getMonitoredStateVariables, getUpdatedVariable, createFunctionCall, createIdentifier, createExpressionStmt, createBinaryOperation, createVariableDeclarationStmt, createVariableDeclaration, createElementaryTypeName, createNumberLiteral, createMemberAccess, createIndexAccess, getMonitoredVariables, createIfStatment, getChildren } from "./utilities";
import * as _ from "lodash";
import { isMainThread } from "worker_threads";
import { prependListener } from "cluster";
import { Rewriter } from "./Generator";

const updateOps = ['=', '-=', '+=', '*=', '/=']

class PendingStatements {
  pre: Statement[]
  post: Statement[]

  constructor(pre: Statement[] = [], post: Statement[] = []) {
    this.pre = pre
    this.post = post
  }

  merge(stmts?: PendingStatements) {
    if (stmts) {
      this.pre.push(...stmts.pre)
      this.post.push(...stmts.post)
    }
  }

  isEmpty() {
    return this.pre.length > 0 || this.post.length > 0
  }
}


export class Decorator implements Visitor {
  [key: string]: any
  constraints: Node[]
  variables: Map<string, StateVariableDeclaration[]>
  pendingBlocks: PendingStatements = new PendingStatements()
  hasPendingBlocks() {
    return this.pendingBlocks.pre.length > 0 || this.pendingBlocks.post.length > 0
  }
  checkConstraints: Set<Node> = new Set()
  canAddAssertions = false
  constructor(constraints: Node[], variables: Map<string, StateVariableDeclaration[]>) {
    this.constraints = constraints
    this.variables = variables
  }
  buildStatements(statement: Statement) {
    const block = createBaseASTNode('Block') as Block
    block.statements = [...this.pendingBlocks.pre, statement, ...this.pendingBlocks.post]
    this.pendingBlocks = new PendingStatements()
    return block
  }
  addAssertions(node: ReturnStatement) {
    if (this.canAddAssertions) {
      const block = createBaseASTNode('Block') as Block
      block.statements = [...this.checkConstraints].map(it => this.generateAssertions(it)).reduce((pre, cur) => [...pre, ...cur], [])
      block.statements.push(node)
      return block
    }
    else {
      return node
    }
  }
  visit(node: any) {
    if (Array.isArray(node)) {
      for (var i = 0; i < node.length; i++) {
        this.visit(node[i])
        if (this.hasPendingBlocks()) {
          node[i] = this.buildStatements(node[i])
        }
        if ((node[i] as ASTNode).type == 'ReturnStatement') {
          node[i] = this.addAssertions(node[i])
        }
      }
      return
    }
    if (!_.has(node, 'type')) return
    var result = true
    if (node.type in this) {
      result = this[node.type](node)
    }
    if (result == false) {
      return
    }

    for (const prop in node) {
      if (node.hasOwnProperty(prop)) {
        this.visit(node[prop])
        if (this.hasPendingBlocks()) {
          node[prop] = this.buildStatements(node[prop])
        }
        if (_.has(node[prop], 'type') && node[prop].type == 'ReturnStatement') {
          node[prop] = this.addAssertions(node[prop])
        }
      }
    }
  }
  ContractDefinition = (node: ContractDefinition) => {
    if (this.variables.has(node.name)) {
      node.subNodes = [...this.variables.get(node.name)!, ...node.subNodes]
    }
  }
  FunctionDefinition = (node: FunctionDefinition) => {
    this.checkConstraints = new Set()
    this.canAddAssertions = node.visibility == 'public'
    this.visit(node.body)
    if (this.canAddAssertions) {
      const block = createBaseASTNode('Block') as Block
      block.statements = [...this.checkConstraints].map(it => this.generateAssertions(it)).reduce((pre, cur) => [...pre, ...cur], [])
      if (node.body) {
        node.body.statements.push(block)
      }
    }
    return false
  }
  ExpressionStatement = (node: ExpressionStatement) => {
    this.generateUpdates(node)
    return false
  }
  generateUpdates(statement: ExpressionStatement) {
    if (statement.expression.type != 'BinaryOperation') return
    const binOp = statement.expression
    if (!updateOps.includes(binOp.operator)) return
    if (binOp.left.type != 'IndexAccess') return
    const base = binOp.left.base
    const index = binOp.left.index
    if (base.type != 'Identifier') return
    const generate = (constraint: Node) => {
      const pendingStatements = new PendingStatements()
      getChildren(constraint).map(it => generate(it)).forEach(it => pendingStatements.merge(it))
      switch (constraint.type) {
        case 'ForAllExpression': {
          pendingStatements.merge(this.generateForAll(constraint, base, index, binOp))
          break
        }
        case 'SumExpression': {
          pendingStatements.merge(this.generateSum(constraint, base, index, binOp))
          break
        }
      }
      return pendingStatements
    }
    this.constraints.forEach(it => this.pendingBlocks.merge(generate(it)))
    const variable = getUpdatedVariable(binOp.left)
    if (variable) {
      this.constraints.filter(it => getMonitoredStateVariables(it).has(variable)).forEach(it => this.checkConstraints.add(it))
    }
  }
  generateAssertions(node: Node): Statement[] {
    switch (node.type) {
      case 'SExpression': {
        const exp = new Rewriter().visit(node) as Expression
        const functionCall = createFunctionCall(createIdentifier('assert'), [exp], [])
        return [createExpressionStmt(functionCall)]
      }
      case 'ForAllExpression': {
        return [this.generateAssertionsForAll(node)]
      }
    }
    return []
  }

  generateAssertionsForAll(node: ForAllExpression) {
    if (node.constraint.type == 'CMPExpression') {
      const binrayExp = createBinaryOperation(new Rewriter(node.mu.name).visit(node.constraint.left) as Expression, createIdentifier(node.name), node.constraint.op)
      const functionCall = createFunctionCall(createIdentifier('assert'), [binrayExp], [])
      return createExpressionStmt(functionCall)
    }
    else {
      const forLoop = createBaseASTNode('ForStatement') as ForStatement
      const arrayVar = createIdentifier(node.name)
      const indexVarName = this.generateNewVarName('index')
      const indexIdentifier = createIdentifier(this.generateNewVarName('index'))
      forLoop.initExpression = createVariableDeclarationStmt(
        [createVariableDeclaration(indexVarName, createElementaryTypeName('uint256'), false)],
        createNumberLiteral('0'))
      forLoop.conditionExpression = createBinaryOperation(indexIdentifier, createMemberAccess(arrayVar, 'length'), '<')
      forLoop.loopExpression = createExpressionStmt(createBinaryOperation(indexIdentifier, createNumberLiteral('1'), '+='))
      forLoop.body = createBaseASTNode('Block') as Block
      const exp = new Rewriter(node.mu.name, createIndexAccess(arrayVar, indexIdentifier)).visit(node.constraint) as Expression
      const functionCall = createFunctionCall(createIdentifier('assert'), [exp], [])
      forLoop.body.statements = [createExpressionStmt(functionCall)]
      return forLoop
    }
  }

  generateForAll(node: ForAllExpression, identifier: Identifier, index: Expression, binOp: BinaryOperation): PendingStatements {
    if (!getMonitoredVariables(node, node.mu.name).has(identifier.name)) return new PendingStatements()
    const gen = (operator: BinOp) => {
      const variable = createIdentifier(node.constraint.name)
      const left = new Rewriter(node.mu.name, index).visit(node.constraint.right) as Expression
      const condition = createBinaryOperation(left, variable, operator)
      const trueBody = createExpressionStmt(createBinaryOperation(variable, left as Expression, '='))
      return createIfStatment(condition, trueBody)
    }
    switch (node.constraint.type) {
      case 'CMPExpression': {
        switch (node.constraint.op) {
          case '<':
          case '<=': {
            return new PendingStatements([gen('<')])
          }
          case '>':
          case '>=': {
            return new PendingStatements([gen('>')])
          }
        }
        break
      }
      case 'MuExpression': {
        const block = createBaseASTNode('Block') as Block
        const functionCall = createFunctionCall(createMemberAccess(createIdentifier(node.name), 'push'), [index], [])
        block.statements = [createExpressionStmt(functionCall)]
        return new PendingStatements([block])
      }
    }
    return new PendingStatements()
  }

  generateSum(node: SumExpression, identifier: Identifier, index: Expression, binOp: BinaryOperation): PendingStatements {
    if (!getMonitoredVariables(node, node.mu.name).has(identifier.name)) return new PendingStatements()
    const v = createIdentifier(node.name)
    const gen = (operator: BinOp) => {
      const right = new Rewriter(node.mu.name, index).visit(node.body) as Expression
      const binaryExp = createBinaryOperation(v, right, operator)
      switch (node.constraint.type) {
        case 'MuExpression':
        case 'MuIndexedAccess': {
          const condition = new Rewriter(node.mu.name, index).visit(node.constraint) as Expression
          const statement = createExpressionStmt(createBinaryOperation(v, right, operator))
          return createIfStatment(condition, statement)
        }
        case 'SExpression':
        case 'SIndexedAccess':
        case 'SIdentifier':
        case 'PrimaryExpression': {
          return createExpressionStmt(createBinaryOperation(v, right, operator))
        }
        case 'CMPExpression':
        default: {
          const i = new Rewriter(node.mu.name, index).visit(node.constraint.right) as Expression
          return createExpressionStmt(createBinaryOperation(v, createIndexAccess(v, i), operator))
        }
      }
    }
    return new PendingStatements([gen('-=')], [gen('+=')])
  }
}