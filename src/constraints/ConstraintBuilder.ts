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

  constraint: Node[] = []
  variables: Map<string, StateVariableDeclaration[]> = new Map()
  currentContractVariables: StateVariableDeclaration[] = []
  contractVars: Map<string, TypeName>
  muVariables: string[] = []
  freeVariables: string[] = []

  constructor(contractVars: Map<string, TypeName>) {
    super()
    this.contractVars = contractVars
  }

  defaultResult() {
    return new (objectAllocator.getNodeConstructor())('DummyNode')
  }

  visitStandardDefinition(context: StandardDefinitionContext) {
    this.currentContractVariables = []
    this.variables.set(context.Identifier().text, this.currentContractVariables)
    // context.constraint().forEach(it => this.visit(it))
    context.constraintPart().forEach(it => this.visit(it.getChild(0)))
    return null 
  }

  generateNewVariable(name: string, type: TypeName) {
    const node = createBaseASTNode('StateVariableDeclaration') as StateVariableDeclaration
    node.variables = [createVariableDeclaration(name, type, true)]
    this.currentContractVariables.push(node)
    return name
  }

  aggregateResult(current: Node, next: Node) {
    return next
  }

  visitConstraint(context: ConstraintContext): Node {
    this.constraint.push(this.visit(context.expression())!)
    return this.defaultResult()
  }


  visitConstraintVariableDeclaration(context: ConstraintVariableDeclarationContext): Node {
    const node = this.visit(context.expression())
    if (!node) return this.defaultResult()
    this.constraint.push(node)
    if (node.type == 'SumExpression') {
      node.name = context.identifier().text
      if (node.constraint.type == 'MuIndexedAccess') {
        let object = node.constraint.object
        while (object.type == 'MuIndexedAccess') object = object.object
        let type = this.contractVars.get(object.name)!
        let newType = createBaseASTNode('Mapping') as Mapping
        let newTypeRoot = newType
        while (type.type != 'ElementaryTypeName') {
          if (type.type == 'Mapping') {
            if (type.valueType.type == 'ElementaryTypeName') {
              newType.keyType = type.valueType
              newType.valueType = createElementaryTypeName('uint256')
            }
            else {
              newType.keyType = type.keyType
              newType.valueType = createBaseASTNode('Mapping') as Mapping
              newType = newType.valueType
            }
            type = type.valueType
          }
          else if (type.type == 'ArrayTypeName') {
            newType.keyType = type.baseTypeName as ElementaryTypeName
            newType.valueType = createElementaryTypeName('uint256')
            type = type.baseTypeName
          }
          else {
            break
          }
        }
        this.generateNewVariable(context.identifier().text, newTypeRoot)
      }
      else {
        this.generateNewVariable(context.identifier().text, createElementaryTypeName('uint256'))
      }
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
    node.mu = this.visit(context.identifier()) as MuIdentifier
    node.constraint = this.visit(context.expression()) as CMPExpression
    if (node.constraint.type == 'CMPExpression') {
      node.name = this.generateNewVariable(generateNewVarName('cmp'), createElementaryTypeName('uint256'))
    }
    else {
      node.name = this.generateNewVariable(generateNewVarName('arr'), createArray(createElementaryTypeName('uint256')))
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
    node.constraint = this.visit(context.expression(1)) as CMPExpression
    this.muVariables = []
    this.freeVariables = []
    return node
  }
}