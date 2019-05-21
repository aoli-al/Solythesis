import {AbstractParseTreeVisitor} from 'antlr4ts/tree/AbstractParseTreeVisitor'
import {SolidityVisitor} from '../antlr/SolidityVisitor'
import {Node, SyntaxKind, PrimaryExpression, Identifier, ForAllExpression, SumExpression, BinOp, MuIndexedAccess, SIndexedAccess, SExp, MuExp, MuIdentifier, ArithmeticOp, ComparisonOp, MuExpTypes, MuExpression, SExpTypes, SExpression, CMPExpression, Exp, ComparisonOpList, Iden, SIdentifier, QuantityExpression, QuantityExp} from './nodes/Node'
import { objectAllocator, createBaseASTNode, createIdentifier, createElementaryTypeName, createMapping, createArray, createVariableDeclaration } from './utilities';
import { ConstraintContext, ExpressionContext, SolidityParser, NumberLiteralContext, IdentifierContext, ForAllExpressionContext, SumExpressionContext, PrimaryExpressionContext, StateVariableDeclarationContext, StandardDefinitionContext, ConstraintVariableDeclarationContext } from '../antlr/SolidityParser';
import { TerminalNode } from 'antlr4ts/tree/TerminalNode';
import { StateVariableDeclaration, TypeName, Mapping, ElementaryTypeName } from 'solidity-parser-antlr';
import { RuleNode } from 'antlr4ts/tree/RuleNode';
import assert from 'assert';
import { Visitor } from './visitor';

var counter = 0
export function generateNewVarName(base: string) {
  return base + '_' + (counter++).toString()
}

export class GenStateVariables extends Visitor {
  currentTypeName?: TypeName
  contractVars: Map<string, TypeName>
  stateVariables: StateVariableDeclaration[] = []
  constraint?: QuantityExp
  freeVarWithTypes: Map<string, ElementaryTypeName> = new Map()
  default() {}

  constructor(contractVars: Map<string, TypeName>) {
    super()
    this.contractVars = contractVars
  }
  analysis(constraint: QuantityExp) {
    this.freeVarWithTypes = new Map()
    this.constraint = constraint
    this.stateVariables = []
    this.visit(constraint)
    return this.stateVariables
  }

  MuIndexedAccess = (node: MuIndexedAccess) => {
    this.visit(node.object)
    if (!this.currentTypeName || this.currentTypeName.type != 'Mapping' || !this.constraint) return
    if (this.constraint.free.map(it => it.name).includes(node.index.name)) {
      if (this.freeVarWithTypes.has(node.index.name)) {
        assert((this.freeVarWithTypes.get(node.index.name) as ElementaryTypeName).name == this.currentTypeName.keyType.name)
      }
      else {
        this.freeVarWithTypes.set(node.index.name, this.currentTypeName.keyType)
      }
    }
    this.currentTypeName = this.currentTypeName.valueType 
  }

  SIdentifier = (node: SIdentifier) => {
    this.currentTypeName = this.contractVars.get(node.name) 
  }

  createStateVariable(name: string, typeStack: ElementaryTypeName[]) {
    const node = createBaseASTNode('StateVariableDeclaration') as StateVariableDeclaration
    if (typeStack.length == 1) {
      node.variables = [createVariableDeclaration(name, typeStack[0], true)]
    }
    else {
      const createMappingRecursive = (stack: ElementaryTypeName[]): TypeName => {
        if (stack.length == 1) {
          return stack[0]
        }
        return createMapping(stack[0], createMappingRecursive(stack.slice(1)))
      }
      node.variables = [createVariableDeclaration(name, createMappingRecursive(typeStack), true)]
    }
    this.stateVariables.push(node)
  }

  SumExpression = (node: SumExpression) => {
    const typeStack: ElementaryTypeName[] = []
    this.visit(node.body)
    this.visit(node.constraint)
    node.free = node.free.filter(it => this.freeVarWithTypes.has(it.name))
    node.free.forEach(it => {
      typeStack.push(this.freeVarWithTypes.get(it.name)!)
    })
    if (node.constraint.type == 'MuIndexedAccess') {
      typeStack.push(this.currentTypeName! as ElementaryTypeName)
    }
    typeStack.push(createElementaryTypeName('uint256'))
    this.createStateVariable(node.name, typeStack)
  }
}
