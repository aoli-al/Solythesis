import {AbstractParseTreeVisitor} from "antlr4ts/tree/AbstractParseTreeVisitor"
import { TerminalNode } from "antlr4ts/tree/TerminalNode"
import {
  ConstraintContext, ConstraintVariableDeclarationContext, ExpressionContext, ForAllExpressionContext,
  IdentifierContext, NumberLiteralContext, PrimaryExpressionContext, SolidityParser, StandardDefinitionContext,
  StateVariableDeclarationContext, SumExpressionContext,
} from "../antlr/SolidityParser"
import { SolidityVisitor } from "../antlr/SolidityVisitor"
import {
  BinOp, ComparisonOp, ComparisonOpList, Forall,
  Identifier, Node, PrimaryExpression,
  Sum, SyntaxKind, Expresssion as Expression, IndexedAccess, MemberAccess, BinaryExpression,
} from "./nodes/Node"
import { objectAllocator, createElementaryTypeName } from "./utilities"

let counter = 0
export function generateNewVarName(base: string) {
  return base + "_" + (counter++).toString()
}

export class ConstraintBuilder extends AbstractParseTreeVisitor<Node|null> implements SolidityVisitor<Node|null> {

  public constraint: Map<string, Node[]> = new Map()
  public currentContract: string = ""
  public arrayCount = 0

  constructor() {
    super()
  }

  public defaultResult() {
    return new (objectAllocator.getNodeConstructor())("DummyNode")
  }

  public visitStandardDefinition(context: StandardDefinitionContext): Node {
    this.currentContract = context.Identifier().text
    this.constraint.set(this.currentContract, [])
    context.constraintPart().forEach((it) => this.visit(it))
    return this.defaultResult()
  }

  public visitConstraint(context: ConstraintContext): Node {
    this.constraint.get(this.currentContract)!.push(this.visit(context.expression())!)
    return this.defaultResult()
  }

  public visitConstraintVariableDeclaration(context: ConstraintVariableDeclarationContext): Node {
    const node = this.visit(context.expression())
    if (!node) { return this.defaultResult() }
    this.constraint.get(this.currentContract)!.push(node)
    if (node.type === "SumExpression") {
      node.name = context.identifier().text
      node.cacheName = generateNewVarName(node.name + "_tmp")
    }
    return this.defaultResult()
  }

  public createNode(kind: SyntaxKind): Node {
    return new (objectAllocator.getNodeConstructor())(kind)
  }

  public visitExpression(context: ExpressionContext) {
    switch (context.childCount) {
      case 1: { return this.visit(context.getChild(0)) }
      case 4: {
        if (context.getChild(1).text === "[") {
          const node = this.createNode("IndexedAccess") as IndexedAccess
          node.index = this.visit(context.expression(1)) as Identifier
          node.object = this.visit(context.expression(0)) as Expression
          return node
        }
      }
      case 3: {
        const left = this.visit(context.expression(0))!
        const right = this.visit(context.getChild(2))!
        if ("." === context.getChild(1).text) {
          const n = this.createNode("MemberAccess") as MemberAccess
          n.expression = left as Expression
          n.memberName = (right as Identifier).name
          return n

        }
        const node = this.createNode("BinaryExpression") as BinaryExpression
        node.left = left as Expression
        node.right = right as Expression
        node.op = context.getChild(1).text as BinOp
      }
    }
    return null
  }

  public visitTerminal(context: TerminalNode): Node {
    const node = this.createNode("PrimaryExpression") as PrimaryExpression
    node.value = context.text
    return node
  }

  public visitNumberLiteral(context: NumberLiteralContext): Node {
    const node = this.createNode("PrimaryExpression") as PrimaryExpression
    node.value = context.text
    node.typeName = createElementaryTypeName("uin256")
    return node
  }

  public visitPrimaryExpression(context: PrimaryExpressionContext) {
    if (context.BooleanLiteral()) {
      const node = this.createNode("PrimaryExpression") as PrimaryExpression
      node.value = context.text
      node.typeName = createElementaryTypeName("boolean")
      return node
    }
    return this.visit(context.getChild(0))
  }

  public visitIdentifier(context: IdentifierContext): Node {
    const node = this.createNode("Identifier") as Identifier
    node.name = context.text
    return node
  }

  public visitForAllExpression(context: ForAllExpressionContext): Node {
    const node = this.createNode("ForAllExpression") as Forall
    node.mu = context.identifierList().identifier().map((it) => this.visit(it) as Identifier)
    node.condition = this.visit(context.expression()) as Expression
    return node
  }

  public visitSumExpression(context: SumExpressionContext): Node {
    const node = this.createNode("SumExpression") as Sum
    node.mu = context.identifierList(0).identifier().map((it) => this.visit(it) as Identifier)
    node.free = context.identifierList(1).identifier().map((it) => this.visit(it) as Identifier)
    node.expression = this.visit(context.expression(0)) as Expression
    node.condition = this.visit(context.expression(1)) as Expression
    return node
  }
}
