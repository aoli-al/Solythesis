import { Node, SyntaxKind, ForAllExpression, SumExpression, SExpression, SIndexedAccess, SIdentifier, MuIdentifier, CMPExpression, MuExpression, BinaryExpression, IndexedAccess} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode, IfStatement, BaseASTNode, Block, IndexAccess, ExpressionStatement, BinOp, VariableDeclaration } from "solidity-parser-antlr";
import { getSVariables, createBaseASTNode } from "./utilities";
import { Visitor} from "./Visitor";

// export function generate(constraint: Node, identifier: Identifier, index: ASTNode, value: ASTNode): BaseASTNode {
// }


function generateSum(node: SumExpression, identifier: Identifier, index: Expression, value: Expression) {
  if (!getSVariables(node).has(identifier.name)) return
  const v = createBaseASTNode('Identifier') as Identifier
  v.name = node.name
  const block = createBaseASTNode('Block') as Block
  const gen = (operator: BinOp) => {
    const update = createBaseASTNode('BinaryOperation') as BinaryOperation
    update.left = v
    update.right = new Rewriter(node.mu.name, index).visit(node.body)
    update.operator = operator
    const statement = createBaseASTNode('ExpressionStatement') as ExpressionStatement
    statement.expression = update

    switch (node.constraint.type) {
      case 'MuExpression': 
      case 'MuIndexedAccess': {
        const ifStatement = createBaseASTNode('IfStatement') as IfStatement
        ifStatement.condition = new Rewriter(node.mu.name, index).visit(node.constraint) as Expression
        ifStatement.trueBody.statements.push(statement)
        block.statements.push(ifStatement)
        break;
      }
      case 'SExpression': 
      case 'SIndexedAccess': 
      case 'SIdentifier': 
      case 'PrimaryExpression': {
        block.statements.push(statement)
        break
      }
      case 'CMPExpression': {
        const indexed = createBaseASTNode('IndexAccess') as IndexAccess
        indexed.base = v
        indexed.index = new Rewriter(node.mu.name, index).visit(node.constraint.right)
        update.left = index
        block.statements.push(statement)
      }
    }
  }
  {
    const tmp = createBaseASTNode('VariableDeclaration') as VariableDeclaration
  }
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

  SumExpression = (node: SumExpression) => {
    const identifier = createBaseASTNode('Identifier') as Identifier
    identifier.name = node.name
    return identifier
  }

  BinaryExpression(node: BinaryExpression) {
    const bexp = createBaseASTNode('BinaryOperation') as BinaryOperation
    bexp.left = this.visit(node.left)
    bexp.right = this.visit(node.right)
    bexp.operator = node.op
    return bexp
  }

  SExpression = this.BinaryExpression
  CMPExpression = this.BinaryExpression
  MuExpression = this.BinaryExpression

  IndexedAccess(node: IndexedAccess) {
    const indexedAccess = createBaseASTNode('IndexAccess') as IndexAccess
    indexedAccess.base = this.visit(node.object)
    indexedAccess.index = this.visit(node.index)
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

}