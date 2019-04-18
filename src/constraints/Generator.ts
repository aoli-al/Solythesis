import { Node, SyntaxKind, ForAllExpression, SumExpression, SExpression, SIndexedAccess, SIdentifier, MuIdentifier, CMPExpression, MuExpression, BinaryExpression, IndexedAccess, Iden, Exp, PrimaryExpression} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode, IfStatement, BaseASTNode, Block, IndexAccess, ExpressionStatement, BinOp, VariableDeclaration, VariableDeclarationStatement, ElementaryTypeName, Statement, BooleanLiteral, NumberLiteral } from "solidity-parser-antlr";
import { getSVariables, createBaseASTNode, createBinaryOperationStmt, getMonitoredVariables, getChildren } from "./utilities";
import { Visitor} from "./Visitor";

export function generate(constraint: Node, identifier: Identifier, index: Expression, value: Expression): ASTNode[] {
  var nodes = getChildren(constraint).map((child) => generate(child, identifier, index, value)).reduce((pre, cur) => [...pre, ...cur], [])
  switch (constraint.type) {
    case 'ForAllExpression': return [...nodes, ...generateForAll(constraint, identifier, index, value)]
    case 'SumExpression': return [...nodes, ...generateSum(constraint, identifier, index, value)]
  }
  return []
}


function generateTmpUpdate(identifier: Identifier, index: Expression, value: Expression, before?: Statement, after?: Statement, ) {
  const block = createBaseASTNode('Block') as Block
  const left = createBaseASTNode('IndexAccess') as IndexAccess
  left.base = identifier
  left.index = index
  const tmp = createBaseASTNode('VariableDeclarationStatement') as VariableDeclarationStatement
  const declare = createBaseASTNode('VariableDeclaration') as VariableDeclaration
  const tmpVar = createBaseASTNode('Identifier') as Identifier
  tmpVar.name = 'tmp'
  declare.name = tmpVar
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
    }
  }
  return []
}

function generateSum(node: SumExpression, identifier: Identifier, index: Expression, value: Expression): ASTNode[] {
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

  SumExpression = (node: SumExpression) => {
    const identifier = createBaseASTNode('Identifier') as Identifier
    identifier.name = node.name
    return identifier
  }

  BinaryExpression(node: BinaryExpression) {
    const bexp = createBaseASTNode('BinaryOperation') as BinaryOperation
    bexp.left = this.visit(node.left) as Expression
    bexp.right = this.visit(node.right) as Expression
    bexp.operator = node.op
    return bexp
  }

  SExpression = this.BinaryExpression
  CMPExpression = this.BinaryExpression
  MuExpression = this.BinaryExpression

  IndexedAccess(node: IndexedAccess) {
    const indexedAccess = createBaseASTNode('IndexAccess') as IndexAccess
    indexedAccess.base = this.visit(node.object) as Expression
    indexedAccess.index = this.visit(node.index) as Expression
    return indexedAccess
  }

  SIndexedAccess = this.IndexedAccess
  MuIndexedAccess = this.IndexedAccess

  SIdentifier = (node: SIdentifier) => {
    const identifier = createBaseASTNode('Identifier') as Identifier
    identifier.name = node.name
    return identifier
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