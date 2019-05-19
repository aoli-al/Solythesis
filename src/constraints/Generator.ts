import { Node, SyntaxKind, ForAllExpression, SumExpression, SExpression, SIndexedAccess, SIdentifier, MuIdentifier, CMPExpression, MuExpression, BinaryExpression, IndexedAccess, Iden, Exp, PrimaryExpression} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode, Block, IndexAccess, ExpressionStatement, BinOp, VariableDeclaration, VariableDeclarationStatement, ElementaryTypeName, Statement, BooleanLiteral, NumberLiteral, FunctionCall, ExpressionList, ForStatement } from "solidity-parser-antlr";
import { getSVariables, createBaseASTNode, getMonitoredVariables, getChildren, createBinaryOperation, createIdentifier, createVariableDeclaration, createElementaryTypeName, createVariableDeclarationStmt, createIndexAccess, createExpressionStmt, createNumberLiteral, createMemberAccess, createIfStatment, createFunctionCall } from "./utilities";
import { Visitor} from "./visitor";


export class Rewriter extends Visitor<ASTNode> {
  [key: string]: any
  mu: string[]
  expression: Expression[]
  constructor(mu: string[] = [], expression: Expression[] = []) {
    super()
    this.mu = mu
    this.expression = expression
  }

  default() {
    return createBaseASTNode('SourceUnit')
  }

  BinaryExpression(node: BinaryExpression) {

    const left = this.visit(node.left) as Expression
    const right = this.visit(node.right) as Expression

    return createBinaryOperation(left, right, node.op)
  }

  SExpression = this.BinaryExpression
  MuExpression = this.BinaryExpression

  IndexedAccess(node: IndexedAccess) {
    return createIndexAccess(this.visit(node.object) as Expression, this.visit(node.index) as Expression)
  }

  SIndexedAccess = this.IndexedAccess
  MuIndexedAccess = this.IndexedAccess

  SIdentifier = (node: SIdentifier) => {
    return createIdentifier(node.name)
  }

  MuIdentifier = (node: MuIdentifier) => {
    const index = this.mu.findIndex(it => it == node.name)  
    if (index >= 0) return this.expression[index]
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