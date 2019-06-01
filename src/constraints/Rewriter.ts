import {
  ASTNode, BinaryOperation, BinOp, Block, BooleanLiteral, ElementaryTypeName, Expression, ExpressionList,
  ExpressionStatement, ForStatement, FunctionCall, Identifier, IndexAccess, NumberLiteral, Statement,
  VariableDeclaration, VariableDeclarationStatement,
} from "solidity-parser-antlr"
import { ConstraintVisitor } from "../visitors/ConstraintVisitor"
import {
  BinaryExpression, CMPExpression, Exp, ForAllExpression, Iden, IndexedAccess, MuExpression, MuIdentifier,
  Node, PrimaryExpression, SExpression, SIdentifier, SIndexedAccess, SumExpression, SyntaxKind,
} from "./nodes/Node"
import {
  createBaseASTNode, createBinaryOperation, createElementaryTypeName, createExpressionStmt, createFunctionCall,
  createIdentifier, createIfStatment, createIndexAccess, createMemberAccess, createNumberLiteral,
  createVariableDeclaration, createVariableDeclarationStmt, getChildren, getMonitoredVariables, getSVariables,
} from "./utilities"

export class Rewriter extends ConstraintVisitor {
  public expression: Map<string, Expression>
  public stack: ASTNode[] = []

  public SExpression = this.BinaryExpression
  public MuExpression = this.BinaryExpression

  public SIndexedAccess = this.IndexedAccess
  public MuIndexedAccess = this.IndexedAccess
  constructor(expression: Map<string, Expression> = new Map()) {
    super()
    this.expression = expression
  }

  public visit(node: Node): ASTNode {
    super.visit(node)
    return this.stack.pop()!
  }

  public BinaryExpression(node: BinaryExpression) {
    const left = this.visit(node.left) as Expression
    const right = this.visit(node.right) as Expression
    this.stack.push(createBinaryOperation(left, right, node.op))
  }

  public IndexedAccess(node: IndexedAccess) {
    this.stack.push(createIndexAccess(this.visit(node.object) as Expression, this.visit(node.index) as Expression))
  }

  public SIdentifier = (node: SIdentifier) => {
    if (this.cache.has(node.name)) {
      this.stack.push(createIdentifier(this.cache.get(node.name)!))
    } else {
      this.stack.push(createIdentifier(node.name))
    }
  }

  public MuIdentifier = (node: MuIdentifier) => {
    this.stack.push(this.expression.get(node.name)!)
  }

  public PrimaryExpression = (node: PrimaryExpression) => {
    switch (node.typeName) {
      case "boolean": {
        const bool = createBaseASTNode("BooleanLiteral") as BooleanLiteral
        bool.value = node.value === "true"
        this.stack.push(bool)
      }
      case "number": {
        this.stack.push(createNumberLiteral(node.value))
      }
    }
  }

}
