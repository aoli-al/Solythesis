import { Node, SyntaxKind, ForAllExpression, SumExpression, SExpression, SIndexedAccess, SIdentifier, MuIdentifier, CMPExpression, MuExpression, BinaryExpression, IndexedAccess, Iden, Exp, PrimaryExpression} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode, Block, IndexAccess, ExpressionStatement, BinOp, VariableDeclaration, VariableDeclarationStatement, ElementaryTypeName, Statement, BooleanLiteral, NumberLiteral, FunctionCall, ExpressionList, ForStatement } from "solidity-parser-antlr";
import { getSVariables, createBaseASTNode, getMonitoredVariables, getChildren, createBinaryOperation, createIdentifier, createVariableDeclaration, createElementaryTypeName, createVariableDeclarationStmt, createIndexAccess, createExpressionStmt, createNumberLiteral, createMemberAccess, createIfStatment, createFunctionCall } from "./utilities";
import { ConstraintVisitor} from "./visitor";


export class Rewriter extends ConstraintVisitor {
  expression: Map<string, Expression>
  stack: ASTNode[] = [] 
  cache: Map<string, string>
  constructor(cache: Map<string, string>, expression: Map<string, Expression> = new Map()) {
    super()
    this.expression = expression
    this.cache = cache
  }

  visit(node: Node): ASTNode {
    super.visit(node)
    return this.stack.pop()!
  }

  BinaryExpression(node: BinaryExpression) {
    const left = this.visit(node.left) as Expression
    const right = this.visit(node.right) as Expression
    this.stack.push(createBinaryOperation(left, right, node.op))
  }

  SExpression = this.BinaryExpression
  MuExpression = this.BinaryExpression

  IndexedAccess(node: IndexedAccess) {
    this.stack.push(createIndexAccess(this.visit(node.object) as Expression, this.visit(node.index) as Expression))
  }

  SIndexedAccess = this.IndexedAccess
  MuIndexedAccess = this.IndexedAccess

  SIdentifier = (node: SIdentifier) => {
    if (this.cache.has(node.name)) {
      this.stack.push(createIdentifier(this.cache.get(node.name)!))
    }
    else {
      this.stack.push(createIdentifier(node.name))
    }
  }

  MuIdentifier = (node: MuIdentifier) => {
    this.stack.push(this.expression.get(node.name)!)
  }

  PrimaryExpression = (node: PrimaryExpression) => {
    switch(node.typeName) {
      case 'boolean': {
        const bool = createBaseASTNode('BooleanLiteral') as BooleanLiteral
        bool.value = node.value == 'true'
        this.stack.push(bool)
      }
      case 'number': {
        this.stack.push(createNumberLiteral(node.value))
      }
    }
  }

}