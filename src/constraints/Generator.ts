import { Node, SyntaxKind, ForAllExpression, SumExpression, SExpression, SIndexedAccess, SIdentifier, MuIdentifier, CMPExpression, MuExpression, BinaryExpression, IndexedAccess, Iden, Exp, PrimaryExpression} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode, IfStatement, BaseASTNode, Block, IndexAccess, ExpressionStatement, BinOp, VariableDeclaration, VariableDeclarationStatement, ElementaryTypeName, Statement, BooleanLiteral, NumberLiteral, MemberAccess, FunctionCall, FunctionCallArguments, ExpressionList } from "solidity-parser-antlr";
import { getSVariables, createBaseASTNode, createBinaryOperationStmt, getMonitoredVariables, getChildren, createBinaryOperation, createIdentifier } from "./utilities";
import { Visitor} from "./Visitor";

export function generateUpdates(constraint: Node, identifier: Identifier, index: Expression, value: Expression): Statement[] {
  var nodes = getChildren(constraint).map((child) => generateUpdates(child, identifier, index, value)).reduce((pre, cur) => [...pre, ...cur], [])
  switch (constraint.type) {
    case 'ForAllExpression': return [...nodes, ...generateForAll(constraint, identifier, index, value)]
    case 'SumExpression': return [...nodes, ...generateSum(constraint, identifier, index, value)]
  }
  return []
}

export function generateAssertions(constraint: Node) {

}


function generateTmpUpdate(identifier: Identifier, index: Expression, value: Expression, before?: Statement, after?: Statement) {
  const block = createBaseASTNode('Block') as Block
  const left = createBaseASTNode('IndexAccess') as IndexAccess
  left.base = identifier
  left.index = index
  const tmp = createBaseASTNode('VariableDeclarationStatement') as VariableDeclarationStatement
  const declare = createBaseASTNode('VariableDeclaration') as VariableDeclaration
  const tmpVar = createBaseASTNode('Identifier') as Identifier
  tmpVar.name = 'tmp'
  declare.name = tmpVar.name
  declare.typeName = createBaseASTNode('ElementaryTypeName') as ElementaryTypeName
  declare.typeName.name = 'uint256'
  tmp.variables = [declare]
  tmp.initialValue = left
  block.statements = [tmp]
  if (before) block.statements.push(before)
  block.statements.push(createBinaryOperationStmt(left, value, '='))
  if (after) block.statements.push(after)
  block.statements.push(createBinaryOperationStmt(left, tmpVar, '='))
  return block
}


function generateForAll(node: ForAllExpression, identifier: Identifier, index: Expression, value: Expression) {
  if (!getMonitoredVariables(node, node.mu.name).has(identifier.name)) return []
  const gen = (operator: BinOp) => {
    const variable = createBaseASTNode('Identifier') as Identifier
    variable.name = node.constraint.name
    const ifStatement = createBaseASTNode('IfStatement') as IfStatement
    const cmp = createBaseASTNode('BinaryOperation') as BinaryOperation
    cmp.left = new Rewriter(node.mu.name, index).visit(node.constraint.right) as Expression
    cmp.operator = operator
    cmp.right = variable
    ifStatement.condition = cmp
    ifStatement.trueBody = createBinaryOperationStmt(variable, cmp.left as Expression, '=')
    return generateTmpUpdate(identifier, index, value, undefined, ifStatement)
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
      const memberAccess = createBaseASTNode('MemberAccess') as MemberAccess
      memberAccess.expression = createIdentifier(node.name)
      memberAccess.memberName = 'push'
      const functionCall = createBaseASTNode('FunctionCall') as FunctionCall
      functionCall.expression = memberAccess
      const args = createBaseASTNode('FunctionCallArguments') as FunctionCallArguments
      args.arguments = [index]
      args.names = []
      const stmt = createBaseASTNode('ExpressionStatement') as ExpressionStatement
      stmt.expression = functionCall
      block.statements = [stmt]
      return [block]
    }
  }
  return []
}

function generateSum(node: SumExpression, identifier: Identifier, index: Expression, value: Expression): Statement[] {
  if (!getMonitoredVariables(node, node.mu.name).has(identifier.name)) return []
  const v = createBaseASTNode('Identifier') as Identifier
  v.name = node.name
  const gen = (operator: BinOp): Statement => {
    const update = createBaseASTNode('BinaryOperation') as BinaryOperation
    update.left = v
    update.right = new Rewriter(node.mu.name, index).visit(node.body) as Expression
    update.operator = operator
    const statement = createBaseASTNode('ExpressionStatement') as ExpressionStatement
    statement.expression = update

    switch (node.constraint.type) {
      case 'MuExpression': 
      case 'MuIndexedAccess': {
        const ifStatement = createBaseASTNode('IfStatement') as IfStatement
        ifStatement.condition = new Rewriter(node.mu.name, index).visit(node.constraint) as Expression
        ifStatement.trueBody = statement
        return ifStatement
      }
      case 'SExpression': 
      case 'SIndexedAccess': 
      case 'SIdentifier': 
      case 'PrimaryExpression': {
        break
      }
      case 'CMPExpression': {
        const indexed = createBaseASTNode('IndexAccess') as IndexAccess
        indexed.base = v
        indexed.index = new Rewriter(node.mu.name, index).visit(node.constraint.right) as Expression
        update.left = index
      }
    }
    return statement
  }
  return [generateTmpUpdate(identifier, index, value, gen('-='), gen('+='))]
}

export class Rewriter extends Visitor<ASTNode> {
  [key: string]: any
  mu: string
  expression: Expression
  constructor(mu: string, expression: Expression) {
    super()
    this.mu = mu
    this.expression = expression
  }

  default() {
    return createBaseASTNode('SourceUnit')
  }

  // ForAllExpression = (node: ForAllExpression) => {
  //   // const forLoop 
  // }

  SumExpression = (node: SumExpression) => {
    const identifier = createBaseASTNode('Identifier') as Identifier
    identifier.name = node.name
    return identifier
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
    const indexedAccess = createBaseASTNode('IndexAccess') as IndexAccess
    indexedAccess.base = this.visit(node.object) as Expression
    indexedAccess.index = this.visit(node.index) as Expression
    return indexedAccess
  }

  SIndexedAccess = this.IndexedAccess
  MuIndexedAccess = this.IndexedAccess

  SIdentifier = (node: SIdentifier) => {
    return createIdentifier(node.name)
  }

  MuIdentifier = (node: MuIdentifier) => {
    return this.expression
  }

  PrimaryExpression = (node: PrimaryExpression) => {
    switch(node.typeName) {
      case 'boolean': {
        const bool = createBaseASTNode('BooleanLiteral') as BooleanLiteral
        bool.value = node.value == 'true'
        return bool
      }
      case 'number': {
        const number = createBaseASTNode('NumberLiteral') as NumberLiteral
        number.number = node.value
        return number
      }
    }
  }

}