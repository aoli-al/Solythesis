import {AbstractParseTreeVisitor} from 'antlr4ts/tree/AbstractParseTreeVisitor'
import {SolidityVisitor} from '../antlr/SolidityVisitor'
import {Node, SyntaxKind, IndexedAccess, Expression, BinaryExpression, PrimaryExpression, Identifier, ForAllExpression, SumExpression} from './nodes/Node'
import { objectAllocator } from './utilities';
import { ConstraintContext, ExpressionContext, SolidityParser, NumberLiteralContext, IdentifierContext, ForAllExpressionContext, SumExpressionContext } from '../antlr/SolidityParser';
import { TypeFlags } from './types/Type';
import { TerminalNode } from 'antlr4ts/tree/TerminalNode';

export class ConstraintBuilder extends AbstractParseTreeVisitor<Node> implements SolidityVisitor<Node> {

  constraint: Node[] = []
  defaultResult() {
    return new (objectAllocator.getNodeConstructor())(SyntaxKind.DummyNode)
  }

  aggregateResult(current: Node, next: Node) {
    return next
  }

  visitConstraint(context: ConstraintContext): Node {
    this.constraint.push(this.visit(context.expression()))
    return this.defaultResult()
  }

  createNode(kind: SyntaxKind): Node {
    return new (objectAllocator.getNodeConstructor())(kind)
  }

  visitExpression(context: ExpressionContext): Node {
    switch (context.childCount) {
      case 1: { return this.visit(context.getChild(0)) }
      case 4: {
        if (context.getChild(1).text == "[") {
          const node = this.createNode(SyntaxKind.IndexedAccess) as IndexedAccess
          node.object = this.visit(context.expression(0)) 
          node.index = this.visit(context.expression(1)) 
          return node
        }
      }
      case 3: {
          const node = this.createNode(SyntaxKind.BinaryExpression) as BinaryExpression
          node.left = this.visit(context.expression(0))
          node.right = this.visit(context.expression(1))
          return node
      }
    }
    return new (objectAllocator.getNodeConstructor())(SyntaxKind.DummyNode)
  }

  visitTerminal(context: TerminalNode): Node {
    const node = this.createNode(SyntaxKind.PrimaryExpression) as PrimaryExpression
    node.value = context.text
    switch (context.symbol.type) {
      case SolidityParser.HexLiteral: {
        node.type = { flags: TypeFlags.Int }
        return node
      }
      case SolidityParser.BooleanLiteral: {
        node.type = { flags: TypeFlags.Bool }
        return node
      }
    }
    return new (objectAllocator.getNodeConstructor())(SyntaxKind.DummyNode)
  }

  visitNumberLiteral(context: NumberLiteralContext): Node {
    const node = this.createNode(SyntaxKind.PrimaryExpression) as PrimaryExpression
    node.type = { flags: TypeFlags.Int }
    node.value = context.text
    return node
  }

  visitIdentifier(context: IdentifierContext): Node {
    const node = this.createNode(SyntaxKind.Identifier) as Identifier
    node.name = context.text
    node.type = { flags: TypeFlags.Any }
    return node
  }

  visitForAllExpression(context: ForAllExpressionContext): Node {
    const node = this.createNode(SyntaxKind.ForAllExpression) as ForAllExpression
    node.mu = this.visit(context.identifier())
    node.constraint = this.visit(context.expression())
    return node
  }

  visitSumExpression(context: SumExpressionContext): Node {
    const node = this.createNode(SyntaxKind.SumExpression) as SumExpression
    node.mu = this.visit(context.identifier())
    node.body = this.visit(context.expression(0))
    node.constraint = this.visit(context.expression(1))
    return node
  }
}