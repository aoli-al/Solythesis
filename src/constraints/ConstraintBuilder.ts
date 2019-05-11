import {AbstractParseTreeVisitor} from 'antlr4ts/tree/AbstractParseTreeVisitor'
import {SolidityVisitor} from '../antlr/SolidityVisitor'
import {Node, SyntaxKind, PrimaryExpression, Identifier, ForAllExpression, SumExpression, BinOp, MuIndexedAccess, SIndexedAccess, SExp, MuExp, MuIdentifier, ArithmeticOp, ComparisonOp, MuExpTypes, MuExpression, SExpTypes, SExpression, CMPExpression, Exp, ComparisonOpList, Iden, SIdentifier} from './nodes/Node'
import { objectAllocator, createBaseASTNode, createIdentifier, createElementaryTypeName, createMapping, createArray, createVariableDeclaration } from './utilities';
import { ConstraintContext, ExpressionContext, SolidityParser, NumberLiteralContext, IdentifierContext, ForAllExpressionContext, SumExpressionContext, PrimaryExpressionContext, StateVariableDeclarationContext, StandardDefinitionContext } from '../antlr/SolidityParser';
import { TerminalNode } from 'antlr4ts/tree/TerminalNode';
import { StateVariableDeclaration, TypeName } from 'solidity-parser-antlr';
import { RuleNode } from 'antlr4ts/tree/RuleNode';

var counter = 0
export function generateNewVarName(base: string) {
  return base + '_' + (counter++).toString()
}

export class ConstraintBuilder extends AbstractParseTreeVisitor<Node|null> implements SolidityVisitor<Node|null> {

  constraint: Node[] = []
  variables: Map<string, StateVariableDeclaration[]> = new Map()
  currentContractVariables: StateVariableDeclaration[] = []
  muVariables: string[] = ['#']
  defaultResult() {
    return new (objectAllocator.getNodeConstructor())('DummyNode')
  }

  visitStandardDefinition(context: StandardDefinitionContext) {
    this.currentContractVariables = []
    this.variables.set(context.Identifier().text, this.currentContractVariables)
    context.constraint().forEach(it => this.visit(it))
    return null 
  }

  generateNewVariable(base: string, type: TypeName) {
    const node = createBaseASTNode('StateVariableDeclaration') as StateVariableDeclaration
    node.variables = [createVariableDeclaration(generateNewVarName(base), type, true)]
    this.currentContractVariables.push(node)
    return node.variables[0].name
  }

  aggregateResult(current: Node, next: Node) {
    return next
  }

  visitConstraint(context: ConstraintContext): Node {
    this.constraint.push(this.visit(context.expression())!)
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
          let node = undefined
          if (this.muVariables[this.muVariables.length-1] == context.expression(1).text) {
            node = this.createNode('MuIndexedAccess') as MuIndexedAccess
            node.index = this.visit(context.expression(1)) as MuIdentifier
          }
          else {
            node = this.createNode('SIndexedAccess') as SIndexedAccess
            node.index = this.visit(context.expression(1)) as SExp
          }
          node.object = this.visit(context.expression(0)) as SIdentifier
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
    if (context.text == this.muVariables[this.muVariables.length-1]) {
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
    this.muVariables.push(context.identifier().text)
    node.mu = this.visit(context.identifier()) as MuIdentifier
    node.constraint = this.visit(context.expression()) as CMPExpression
    if (node.constraint.type == 'CMPExpression') {
      node.name = this.generateNewVariable('cmp', createElementaryTypeName('uint256'))
    }
    else {
      node.name = this.generateNewVariable('arr', createArray(createElementaryTypeName('uint256')))
    }
    this.muVariables.pop()
    return node
  }

  visitSumExpression(context: SumExpressionContext): Node {
    const node = this.createNode('SumExpression') as SumExpression
    this.muVariables.push(context.identifier().text)
    node.mu = this.visit(context.identifier()) as MuIdentifier
    node.body = this.visit(context.expression(0)) as MuExp
    node.constraint = this.visit(context.expression(1)) as CMPExpression
    node.name =  (() => {
      switch (node.constraint.type) {
        case 'CMPExpression':
          return this.generateNewVariable('sum',
            createMapping(createElementaryTypeName('uin256'), createElementaryTypeName('uint256')))
        default:
          return this.generateNewVariable('sum', createElementaryTypeName('uint256'))
      }
    })()
    this.muVariables.pop()
    return node
  }
}