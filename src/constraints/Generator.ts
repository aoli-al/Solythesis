import { Node, SyntaxKind, ForAllExpression, SumExpression, SExpression, SIndexedAccess, SIdentifier, MuIdentifier, CMPExpression, MuExpression, BinaryExpression, IndexedAccess, Iden, Exp, PrimaryExpression} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode, Block, IndexAccess, ExpressionStatement, BinOp, VariableDeclaration, VariableDeclarationStatement, ElementaryTypeName, Statement, BooleanLiteral, NumberLiteral, FunctionCall, ExpressionList, ForStatement } from "solidity-parser-antlr";
import { getSVariables, createBaseASTNode, getMonitoredVariables, getChildren, createBinaryOperation, createIdentifier, createVariableDeclaration, createElementaryTypeName, createVariableDeclarationStmt, createIndexAccess, createExpressionStmt, createNumberLiteral, createMemberAccess, createIfStatment, createFunctionCall } from "./utilities";
import { Visitor} from "./Visitor";
import { generateNewVarName } from "./ConstraintBuilder";

export function generateUpdates(constraint: Node, identifier: Identifier, index: Expression, value: Expression): Statement[] {
  var nodes = getChildren(constraint).map((child) => generateUpdates(child, identifier, index, value)).reduce((pre, cur) => [...pre, ...cur], [])
  switch (constraint.type) {
    case 'ForAllExpression': return [...nodes, ...generateForAll(constraint, identifier, index, value)]
    case 'SumExpression': return [...nodes, ...generateSum(constraint, identifier, index, value)]
  }
  return []
}

export function generateAssertions(node: Node) {
  switch (node.type) {
    case 'SExpression': {
      const exp = new Rewriter().visit(node) as Expression
      const functionCall = createFunctionCall(createIdentifier('assert'), [exp], [])
      return createExpressionStmt(functionCall)
    }
    case 'ForAllExpression': {
      return generateAssertionsForAll(node)
    }
  }
}

function generateAssertionsForAll(node: ForAllExpression) {
  if (node.constraint.type == 'CMPExpression') {
    const binrayExp = createBinaryOperation(new Rewriter(node.mu.name).visit(node.constraint.left) as Expression, createIdentifier(node.name), node.constraint.op)
    const functionCall = createFunctionCall(createIdentifier('assert'), [binrayExp], [])
    return createExpressionStmt(functionCall)
  }
  else {
    const forLoop = createBaseASTNode('ForStatement') as ForStatement
    const arrayVar = createIdentifier(node.name)
    const indexVarName = generateNewVarName('index')
    const indexIdentifier = createIdentifier(generateNewVarName('index'))
    forLoop.initExpression = createVariableDeclarationStmt(
      [createVariableDeclaration(indexVarName, createElementaryTypeName('uint256'), false)],
      createNumberLiteral('0'))
    forLoop.conditionExpression = createBinaryOperation(indexIdentifier, createMemberAccess(arrayVar, 'length'), '<')
    forLoop.expression = createBinaryOperation(indexIdentifier, createNumberLiteral('1'), '+=')
    forLoop.body = createBaseASTNode('Block') as Block
    const exp = new Rewriter(node.mu.name, createIndexAccess(arrayVar, indexIdentifier)).visit(node.constraint) as Expression
    const functionCall = createFunctionCall(createIdentifier('assert'), [exp], [])
    forLoop.body.statements = [createExpressionStmt(functionCall)]
    return forLoop
  }
}

function generateTmpUpdate(identifier: Identifier, index: Expression, value: Expression, before?: Statement, after?: Statement) {
  const block = createBaseASTNode('Block') as Block
  const left = createIndexAccess(identifier, index)
  const tmpVarName = generateNewVarName('tmp')
  const tmp = createVariableDeclarationStmt(
    [createVariableDeclaration(tmpVarName, createElementaryTypeName('uint256'), false)],
    left)
  block.statements = [tmp]
  if (before) block.statements.push(before)
  block.statements.push(createExpressionStmt(createBinaryOperation(left, value, '=')))
  if (after) block.statements.push(after)
  block.statements.push(createExpressionStmt(createBinaryOperation(left, createIdentifier(tmpVarName), '=')))
  return block
}

function generateForAll(node: ForAllExpression, identifier: Identifier, index: Expression, value: Expression) {
  if (!getMonitoredVariables(node, node.mu.name).has(identifier.name)) return []
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
          return [gen('<')]
        }
        case '>':
        case '>=': {
          return [gen('>')]
        }
      }
      break
    }
    case 'MuExpression': {
      const block = createBaseASTNode('Block') as Block
      const functionCall = createFunctionCall(createMemberAccess(createIdentifier(node.name), 'push'), [index], [])
      block.statements = [createExpressionStmt(functionCall)]
      return [block]
    }
  }
  return []
}

function generateSum(node: SumExpression, identifier: Identifier, index: Expression, value: Expression): Statement[] {
  if (!getMonitoredVariables(node, node.mu.name).has(identifier.name)) return []
  const v = createIdentifier(node.name)
  const gen = (operator: BinOp): Statement => {
    const right = new Rewriter(node.mu.name, index).visit(node.body) as Expression
    const binaryExp = createBinaryOperation(v, right, operator)
    const statement = createExpressionStmt(binaryExp)
    switch (node.constraint.type) {
      case 'MuExpression': 
      case 'MuIndexedAccess': {
        const condition = new Rewriter(node.mu.name, index).visit(node.constraint) as Expression
        return createIfStatment(condition, statement)
      }
      case 'SExpression': 
      case 'SIndexedAccess': 
      case 'SIdentifier': 
      case 'PrimaryExpression': {
        break
      }
      case 'CMPExpression': {
        const i = new Rewriter(node.mu.name, index).visit(node.constraint.right) as Expression
        binaryExp.left = createIndexAccess(v, i)
      }
    }
    return statement
  }
  return [generateTmpUpdate(identifier, index, value, gen('-='), gen('+='))]
}

export class Rewriter extends Visitor<ASTNode> {
  [key: string]: any
  mu?: string
  expression?: Expression
  constructor(mu?: string, expression?: Expression) {
    super()
    this.mu = mu
    this.expression = expression
  }

  default() {
    return createBaseASTNode('SourceUnit')
  }

  SumExpression = (node: SumExpression) => {
    return createIdentifier(node.name)
  }

  BinaryExpression(node: BinaryExpression) {

    const left = this.visit(node.left) as Expression
    const right = this.visit(node.right) as Expression

    return createBinaryOperation(left, right, node.op)
  }

  SExpression = this.BinaryExpression
  MuExpression = this.BinaryExpression

  CMPExpression = (node: CMPExpression) => {
    const left = this.visit(node.left) as Expression
    const right = createIdentifier(node.name)
    return createBinaryOperation(left, right, node.op)
  }

  IndexedAccess(node: IndexedAccess) {
    return createIndexAccess(this.visit(node.object) as Expression, this.visit(node.index) as Expression)
  }

  SIndexedAccess = this.IndexedAccess
  MuIndexedAccess = this.IndexedAccess

  SIdentifier = (node: SIdentifier) => {
    return createIdentifier(node.name)
  }

  MuIdentifier = (node: MuIdentifier) => {
    if (this.expression) {
      return this.expression
    }
    return this.default()
  }

  PrimaryExpression = (node: PrimaryExpression) => {
    switch(node.typeName) {
      case 'boolean': {
        const bool = createBaseASTNode('BooleanLiteral') as BooleanLiteral
        bool.value = node.value == 'true'
        return bool
      }
      case 'number': {
        return createNumberLiteral(node.value)
      }
    }
  }

}