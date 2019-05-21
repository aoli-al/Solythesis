import {AbstractParseTreeVisitor} from 'antlr4ts/tree/AbstractParseTreeVisitor'
import {SolidityVisitor} from '../antlr/SolidityVisitor'
import {Node, SyntaxKind, PrimaryExpression, Identifier, ForAllExpression, SumExpression, BinOp, MuIndexedAccess, SIndexedAccess, SExp, MuExp, MuIdentifier, ArithmeticOp, ComparisonOp, MuExpTypes, MuExpression, SExpTypes, SExpression, CMPExpression, Exp, ComparisonOpList, Iden, SIdentifier} from './nodes/Node'
import { objectAllocator, createBaseASTNode, createIdentifier, createElementaryTypeName, createMapping, createArray, createVariableDeclaration } from './utilities';
import { ConstraintContext, ExpressionContext, SolidityParser, NumberLiteralContext, IdentifierContext, ForAllExpressionContext, SumExpressionContext, PrimaryExpressionContext, StateVariableDeclarationContext, StandardDefinitionContext, ConstraintVariableDeclarationContext } from '../antlr/SolidityParser';
import { TerminalNode } from 'antlr4ts/tree/TerminalNode';
import { StateVariableDeclaration, TypeName, Mapping, ElementaryTypeName } from 'solidity-parser-antlr';
import { RuleNode } from 'antlr4ts/tree/RuleNode';
import assert from 'assert';

var counter = 0
export function generateNewVarName(base: string) {
  return base + '_' + (counter++).toString()
}

export class ConstraintBuilder extends AbstractParseTreeVisitor<Node|null> implements SolidityVisitor<Node|null> {

  constraint: Map<string, Node[]> = new Map() 
  currentContract: string = ""
  muVariables: string[] = []

  constructor() {
    super()
  }

  defaultResult() {
    return new (objectAllocator.getNodeConstructor())('DummyNode')
  }

  visitStandardDefinition(context: StandardDefinitionContext): Node {
    this.currentContract = context.Identifier().text
    this.constraint.set(this.currentContract, [])
    context.constraintPart().forEach(it => this.visit(it))
    return this.defaultResult()
  }

  visitConstraint(context: ConstraintContext): Node {
    this.constraint.get(this.currentContract)!.push(this.visit(context.expression())!)
    return this.defaultResult()
  }

  visitConstraintVariableDeclaration(context: ConstraintVariableDeclarationContext): Node {
    const node = this.visit(context.expression())
    if (!node) return this.defaultResult()
    this.constraint.get(this.currentContract)!.push(node)
    if (node.type == 'SumExpression') {
      node.name = context.identifier().text
    }
    return this.defaultResult()
  }

  createNode(kind: SyntaxKind): Node {
    return new (objectAllocator.getNodeConstructor())(kind)
  }

  visitExpression(context: ExpressionContext) {
    switch (context.childCount) {
      case 1: { return this.visit(context.getChild(0)) }
      case 4: {
        if (context.getChild(1).text == "[") {
          let index = this.visit(context.expression(1))!
          const node = (() => {
            if (index.type == 'MuIdentifier') {
              const n = this.createNode('MuIndexedAccess') as MuIndexedAccess
              n.index = index
              return n
            }
            else {
              const n = this.createNode('SIndexedAccess') as SIndexedAccess
              n.index = index as SExp
              return n
            }
          })()
          node.object = this.visit(context.expression(0))! as MuIndexedAccess | SIdentifier 
          return node
        }
      }
      case 3: {
          const left = this.visit(context.expression(0))!
          const right = this.visit(context.expression(1))! 
          const op = context.getChild(1).text as BinOp
          if (MuExpTypes.includes(left.type) && MuExpTypes.includes(right.type)) {
            const node = this.createNode('MuExpression') as MuExpression
            node.left = left as MuExp
            node.right = right as MuExp
            node.op = op
            return node
          }
          if (SExpTypes.includes(left.type) && SExpTypes.includes(right.type)) {
            const node = this.createNode('SExpression') as SExpression
            node.left = left as SExp
            node.right = right as SExp
            node.op = op
            return node
          }
          if (ComparisonOpList.includes(op)) {
            const node = this.createNode('CMPExpression') as CMPExpression
            node.left = left as SExp
            node.right = right as MuExp
            node.op = op as ComparisonOp
            return node
          }
      }
    }
    return null
  }

  visitTerminal(context: TerminalNode): Node {
    const node = this.createNode('PrimaryExpression') as PrimaryExpression
    node.value = context.text
    return node
  }

  visitNumberLiteral(context: NumberLiteralContext): Node {
    const node = this.createNode('PrimaryExpression') as PrimaryExpression
    node.value = context.text
    node.typeName = 'number'
    return node
  }

  visitPrimaryExpression(context: PrimaryExpressionContext) {
    if (context.BooleanLiteral()) {
      const node = this.createNode('PrimaryExpression') as PrimaryExpression
      node.value = context.text
      node.typeName = 'boolean'
      return node
    }
    return this.visit(context.getChild(0))
  }


  visitIdentifier(context: IdentifierContext): Node {
    var node = undefined
    if (this.muVariables.includes(context.text)) {
      node = this.createNode('MuIdentifier') as Iden
    }
    else {
      node = this.createNode('SIdentifier') as Iden
    }
    node.name = context.text
    return node
  }

  visitForAllExpression(context: ForAllExpressionContext): Node {
    const node = this.createNode('ForAllExpression') as ForAllExpression
    this.muVariables = [context.identifier().text]
    node.mu = [this.visit(context.identifier()) as MuIdentifier]
    node.constraint = this.visit(context.expression()) as CMPExpression
    if (node.constraint.type == 'CMPExpression') {
      node.name = generateNewVarName('cmp')
    }
    else {
      node.name = generateNewVarName('arr')
    }
    this.muVariables = []
    return node
  }

  visitSumExpression(context: SumExpressionContext): Node {
    const node = this.createNode('SumExpression') as SumExpression
    this.muVariables = context.identifierList()
      .map(it => it.identifier().map(it => it.text))
      .reduce((left, right) => [...left, ...right], [])
    node.free = context.identifierList(0).identifier().map(it => this.visit(it) as MuIdentifier)
    node.mu = context.identifierList(1).identifier().map(it => this.visit(it) as MuIdentifier)
    node.body = this.visit(context.expression(0)) as MuExp
    node.constraint = this.visit(context.expression(1)) as MuExpression
    this.muVariables = []
    return node
  }
}