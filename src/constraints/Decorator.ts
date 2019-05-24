import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, FunctionDefinition, ContractDefinition, Statement, ASTNode, Block, ReturnStatement, BaseASTNode, ForStatement, BinOp } from "solidity-parser-antlr";
import { Node, ForAllExpression, SumExpression, CMPExpression, Iden, QuantityExp } from "./nodes/Node";
import { Printer } from "../printer/Printer";
import { createBaseASTNode, getMonitoredStateVariables, getUpdatedVariable, createFunctionCall, createIdentifier, createExpressionStmt, createBinaryOperation, createVariableDeclarationStmt, createVariableDeclaration, createElementaryTypeName, createNumberLiteral, createMemberAccess, createIndexAccess, getMonitoredVariables, createIfStatment, getChildren, getMuIndices, createBlock, checkSafeAdd, checkSafeSub, equal } from "./utilities";
import * as _ from "lodash";
import { isMainThread } from "worker_threads";
import { prependListener } from "cluster";
import { Rewriter } from "./Rewriter";
import { generateNewVarName } from "./StateVariableGenerator";
import { ConstractVisitor } from "./visitor";
import { optimize } from "../optimizer/StorageAccessOptimizer";

const updateOps = ['=', '-=', '+=', '*=', '/=']

export class PendingStatements {
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
    return this.pre.length == 0 && this.post.length == 0
  }
}


export class Decorator extends ConstractVisitor implements Visitor  {
  constraints: Node[]
  variables: Map<string, StateVariableDeclaration[]>
  checkConstraints: Set<Node> = new Set()
  canAddAssertions = false
  constructor(constraints: Node[], variables: Map<string, StateVariableDeclaration[]>) {
    super()
    this.constraints = constraints
    this.variables = variables
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
  ContractDefinition = (node: ContractDefinition) => {
    node.subNodes = this.visit(node.subNodes)
    if (this.variables.has(node.name)) {
      node.subNodes = [...this.variables.get(node.name)!, ...node.subNodes]
    }
    return node
  }
  FunctionDefinition = (node: FunctionDefinition) => {
    this.checkConstraints = new Set()
    this.canAddAssertions = node.visibility == 'public'
    node.body = this.visit(node.body)
    if (this.canAddAssertions) {
      const block = createBaseASTNode('Block') as Block
      block.statements = [...this.checkConstraints].map(it => this.generateAssertions(it)).reduce((pre, cur) => [...pre, ...cur], [])
      if (node.body) {
        node.body.statements.push(block)
      }
    }
    return node
  }
  ExpressionStatement = (statement: ExpressionStatement) => {
    if (statement.expression.type != 'BinaryOperation') return statement
    const binOp = statement.expression
    if (!updateOps.includes(binOp.operator)) return statement
    const variable = getUpdatedVariable(binOp.left)!
    this.constraints.filter(it => getMonitoredStateVariables(it).has(variable)).forEach(it => {
      this.checkConstraints.add(it)
    })
    if (binOp.left.type != 'IndexAccess') return statement
    let indices = [binOp.left.index]

    var base = binOp.left.base
    while (base.type == 'IndexAccess') {
      indices.push(base.index)
      base = base.base
    }
    indices = indices.reverse()
    if (base.type != 'Identifier') return statement
    const constraintPair: [QuantityExp, Map<string, Expression>][] = []
    const generate = (constraint: Node, identifier: Identifier) => {
      getChildren(constraint).map(it => generate(it, identifier)).forEach(it => pendingStatements.merge(it))
      if (constraint.type == 'ForAllExpression' || constraint.type == 'SumExpression') {
        const muIndices: Map<string, Expression> = new Map()
        getMuIndices(constraint, identifier.name)
          .map((it, id) => muIndices.set(it, indices[id]))
        const pendingStatements = constraint.type == 'ForAllExpression'
          ? this.generateForAll(constraint, identifier, muIndices)
          : this.generateSum(constraint, identifier, muIndices)
        if (!pendingStatements.isEmpty()) {
          constraintPair.push([constraint, muIndices])
        }
        return pendingStatements
      }
      return new PendingStatements()
    }
    const pendingStatements = new PendingStatements()
    this.constraints.forEach(it => pendingStatements.merge(generate(it, base as Identifier)))
    if (pendingStatements.isEmpty()) return statement
    const updated = binOp.left
    const result = optimize(constraintPair, [...pendingStatements.pre, statement,...pendingStatements.post])
    return createBlock([...result[0], ...this.visit(result[1]), ...result[2]])
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

  generateForAll(node: ForAllExpression, identifier: Identifier, indices: Map<string, Expression>): PendingStatements {
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

  generateSum(node: SumExpression, identifier: Identifier, muIndices: Map<string, Expression>): PendingStatements {
    if (node.mu.filter(it => getMonitoredVariables(node, it.name).has(identifier.name)).length == 0) return new PendingStatements()
    const createIndexAccessRecursive = (object: Expression, expressions: Expression[]): Expression => {
      if (expressions.length == 0) return object
      const indexAccess = createIndexAccess(object, expressions[0])
      return createIndexAccessRecursive(indexAccess, expressions.slice(1))
    }
    const gen = (operator: BinOp) => {
      const base = createIndexAccessRecursive(createIdentifier(node.name), node.free.map(it => muIndices.get(it.name)!))
      const v = (node.constraint.type == 'MuIndexedAccess')
        ? createIndexAccess(base, new Rewriter(muIndices).visit(node.constraint) as Expression)
        : base
      const right = new Rewriter(muIndices).visit(node.body) as Expression
      const safeOperation = createExpressionStmt(createFunctionCall(
        createIdentifier('assert'),
        [createBinaryOperation(v, right, '>=')]
      ))
      const statement = createExpressionStmt(createBinaryOperation(v, right, operator))
      let statements: Statement[] = operator == '-=' ? [safeOperation, statement] : [statement, safeOperation]
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