import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, FunctionDefinition, ContractDefinition, Statement, ASTNode, Block, ReturnStatement, BaseASTNode, ForStatement, BinOp } from "solidity-parser-antlr";
import { Node, ForAllExpression, SumExpression, CMPExpression, Iden } from "./nodes/Node";
import { Printer } from "../printer/Printer";
import { createBaseASTNode, getMonitoredStateVariables, getUpdatedVariable, createFunctionCall, createIdentifier, createExpressionStmt, createBinaryOperation, createVariableDeclarationStmt, createVariableDeclaration, createElementaryTypeName, createNumberLiteral, createMemberAccess, createIndexAccess, getMonitoredVariables, createIfStatment, getChildren, getMuIndices, createBlock } from "./utilities";
import * as _ from "lodash";
import { isMainThread } from "worker_threads";
import { prependListener } from "cluster";
import { Rewriter } from "./Rewriter";
import { generateNewVarName } from "./StateVariableGenerator";

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
  constraints: Node[]
  variables: Map<string, StateVariableDeclaration[]>
  pendingStatements: PendingStatements = new PendingStatements()
  hasPendingBlocks() {
    return this.pendingStatements.pre.length > 0 || this.pendingStatements.post.length > 0
  }
  checkConstraints: Set<Node> = new Set()
  canAddAssertions = false
  constructor(constraints: Node[], variables: Map<string, StateVariableDeclaration[]>) {
    this.constraints = constraints
    this.variables = variables
  }
  buildStatements(statement: Statement) {
    const block = createBaseASTNode('Block') as Block
    block.statements = [...this.pendingStatements.pre, statement, ...this.pendingStatements.post]
    this.pendingStatements = new PendingStatements()
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
      result = (this as any)[node.type](node)
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
    this.pendingStatements.merge(this.checkUpdates(node))
    return false
  }
  checkUpdates(statement: ExpressionStatement) {
    if (statement.expression.type != 'BinaryOperation') return
    const binOp = statement.expression
    if (!updateOps.includes(binOp.operator)) return
    if (binOp.left.type != 'IndexAccess') return
    let indices = [binOp.left.index]

    var base = binOp.left.base
    while (base.type == 'IndexAccess') {
      indices.push(base.index)
      base = base.base
    }
    indices = indices.reverse()
    if (base.type != 'Identifier') return
    const generate = (constraint: Node, identifier: Identifier) => {
      const pendingStatements = new PendingStatements()
      getChildren(constraint).map(it => generate(it, identifier)).forEach(it => pendingStatements.merge(it))
      if (constraint.type == 'ForAllExpression' || constraint.type == 'SumExpression') {
        const muIndices: Map<string, Expression> = new Map()
        getMuIndices(constraint, identifier.name)
          .map((it, id) => muIndices.set(it, indices[id]))
        switch (constraint.type) {
          case 'ForAllExpression': {
            pendingStatements.merge(this.generateForAll(constraint, identifier, muIndices, binOp))
            break
          }
          case 'SumExpression': {
            pendingStatements.merge(this.generateSum(constraint, identifier, muIndices, binOp))
            break
          }
        }
      }
      return pendingStatements
    }
    const pendingStatements = new PendingStatements()
    this.constraints.forEach(it => pendingStatements.merge(generate(it, base as Identifier)))
    const variable = getUpdatedVariable(binOp.left)!
    this.constraints.filter(it => getMonitoredStateVariables(it).has(variable)).forEach(it => {
      this.checkConstraints.add(it)
    })
    return pendingStatements
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
      const binrayExp = createBinaryOperation(new Rewriter().visit(node.constraint.left) as Expression,
        createIdentifier(node.name[0]), node.constraint.op)
      const functionCall = createFunctionCall(createIdentifier('assert'), [binrayExp], [])
      return createExpressionStmt(functionCall)
    }
    else {
      const forLoop = createBaseASTNode('ForStatement') as ForStatement
      for (let i = 0; i < node.name.length; i++) {
        const indexIdentifier = createIdentifier(generateNewVarName('index'))
        forLoop.initExpression = createVariableDeclarationStmt(
          [createVariableDeclaration(indexIdentifier.name, createElementaryTypeName('uint256'), false)],
          createNumberLiteral('0'))
        const arrayVar = createIdentifier(node.name[0])
        forLoop.conditionExpression = createBinaryOperation(indexIdentifier, createMemberAccess(arrayVar, 'length'), '<')
        forLoop.loopExpression = createExpressionStmt(createBinaryOperation(indexIdentifier, createNumberLiteral('1'), '+='))
        forLoop.body = createBaseASTNode('Block') as Block
        const map: Map<string, Expression> = new Map()
        node.name.forEach((value, idx) => {
          map.set(node.mu[idx].name, createIndexAccess(createIdentifier(value), indexIdentifier))
        })
        const exp = new Rewriter(map).visit(node.constraint) as Expression
        const functionCall = createFunctionCall(createIdentifier('assert'), [exp], [])
        forLoop.body.statements = [createExpressionStmt(functionCall)]
      }
      return forLoop
    }
  }

  generateForAll(node: ForAllExpression, identifier: Identifier, indices: Map<string, Expression>, binOp: BinaryOperation): PendingStatements {
    if (!getMonitoredVariables(node, node.mu[0].name).has(identifier.name)) return new PendingStatements()
    const gen = (operator: BinOp) => {
      const variable = createIdentifier(node.name[0])
      const left = new Rewriter(indices).visit((node.constraint as CMPExpression).right) as Expression
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
        block.statements = []
        node.name.forEach((name, index) => {
          const functionCall = createFunctionCall(createMemberAccess(createIdentifier(name), 'push'), [indices.get(node.mu[index].name)!], [])
          block.statements.push(createExpressionStmt(functionCall))
        })
        return new PendingStatements([block])
      }
    }
    return new PendingStatements()
  }

  generateSum(node: SumExpression, identifier: Identifier, muIndices: Map<string, Expression>, binOp: BinaryOperation): PendingStatements {
    if (node.mu.filter(it => getMonitoredVariables(node, it.name).has(identifier.name)).length == 0) return new PendingStatements()
    const createIndexAccessRecursive = (object: Expression, expressions: Expression[]): Expression => {
      if (expressions.length == 0) return object
      const indexAccess = createIndexAccess(object, expressions[0])
      return createIndexAccessRecursive(indexAccess, expressions.slice(1))
    }
    const v = createIndexAccessRecursive(createIdentifier(node.name), node.free.map(it => muIndices.get(it.name)!))
    const gen = (operator: BinOp) => {
      const right = new Rewriter(muIndices).visit(node.body) as Expression
      const statement = (() => {
        if (node.constraint.type == 'MuIndexedAccess') {
          const i = new Rewriter(muIndices).visit(node.constraint) as Expression
          return createExpressionStmt(createBinaryOperation(createIndexAccess(v, i), right, operator))
        }
        else {
          return createExpressionStmt(createBinaryOperation(v, right, operator))
        }
      })()
      const pendingStatements = this.checkUpdates(statement)
      const statements: Statement[] = []
      if (pendingStatements) statements.push(...pendingStatements.pre, statement, ...pendingStatements.post)
      else statements.push(statement)
      const block = createBlock(statements)
      if (node.constraint.type == 'MuExpression') {
        const condition = new Rewriter(muIndices).visit(node.constraint) as Expression
        return createIfStatment(condition, block)
      }
      else {
        return block
      }
    }
    return new PendingStatements([gen('-=')], [gen('+=')])
  }
}