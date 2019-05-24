import {AbstractParseTreeVisitor} from 'antlr4ts/tree/AbstractParseTreeVisitor'
import {SolidityVisitor} from '../antlr/SolidityVisitor'
import {Node, SyntaxKind, PrimaryExpression, Identifier, ForAllExpression, SumExpression, BinOp, MuIndexedAccess, SIndexedAccess, SExp, MuExp, MuIdentifier, ArithmeticOp, ComparisonOp, MuExpTypes, MuExpression, SExpTypes, SExpression, CMPExpression, Exp, ComparisonOpList, Iden, SIdentifier, QuantityExp} from './nodes/Node'
import { objectAllocator, createBaseASTNode, createIdentifier, createElementaryTypeName, createMapping, createArray, createVariableDeclaration, createNumberLiteral } from './utilities';
import { ConstraintContext, ExpressionContext, SolidityParser, NumberLiteralContext, IdentifierContext, ForAllExpressionContext, SumExpressionContext, PrimaryExpressionContext, StateVariableDeclarationContext, StandardDefinitionContext, ConstraintVariableDeclarationContext } from '../antlr/SolidityParser';
import { TerminalNode } from 'antlr4ts/tree/TerminalNode';
import { StateVariableDeclaration, TypeName, Mapping, ElementaryTypeName } from 'solidity-parser-antlr';
import { RuleNode } from 'antlr4ts/tree/RuleNode';
import assert from 'assert';
import { ConstraintVisitor } from './visitor';

var counter = 0
export function generateNewVarName(base: string) {
  return base + '_' + (counter++).toString()
}

export class GenStateVariables extends ConstraintVisitor {
  currentTypeName?: TypeName
  contractVars: Map<string, TypeName>
  stateVariables: StateVariableDeclaration[] = []
  muWithTypes: Map<string, ElementaryTypeName> = new Map()
  constructor(contractVars: Map<string, TypeName>) {
    super()
    this.contractVars = contractVars
  }
  analysis(constraint: QuantityExp) {
    this.muWithTypes = new Map()
    this.stateVariables = []
    this.visit(constraint)
    this.stateVariables.forEach(it => {
      this.contractVars.set(it.variables[0].name, it.variables[0].typeName)
    })
    return this.stateVariables
  }

  MuIndexedAccess = (node: MuIndexedAccess) => {
    this.visit(node.object)
    if (!this.currentTypeName || this.currentTypeName.type != 'Mapping') return
    if (this.muWithTypes.has(node.index.name)) {
      assert((this.muWithTypes.get(node.index.name) as ElementaryTypeName).name == this.currentTypeName.keyType.name)
    }
    else {
      this.muWithTypes.set(node.index.name, this.currentTypeName.keyType)
    }
    this.currentTypeName = this.currentTypeName.valueType 
  }

  SIdentifier = (node: SIdentifier) => {
    this.currentTypeName = this.contractVars.get(node.name) 
  }

  createStateVariable(name: string, typeStack: TypeName[]) {
    const node = createBaseASTNode('StateVariableDeclaration') as StateVariableDeclaration
    if (typeStack.length == 1) {
      node.variables = [createVariableDeclaration(name, typeStack[0], true)]
    }
    else {
      const createMappingRecursive = (stack: TypeName[]): TypeName => {
        if (stack.length == 1) {
          return stack[0]
        }
        return createMapping(stack[0] as ElementaryTypeName, createMappingRecursive(stack.slice(1)))
      }
      node.variables = [createVariableDeclaration(name, createMappingRecursive(typeStack), true)]
    }
    this.stateVariables.push(node)
  }

  SumExpression = (node: SumExpression) => {
    const typeStack: ElementaryTypeName[] = []
    this.visit(node.body)
    this.visit(node.constraint)
    node.free = node.free.filter(it => this.muWithTypes.has(it.name))
    node.free.forEach(it => {
      typeStack.push(this.muWithTypes.get(it.name)!)
    })
    if (node.constraint.type == 'MuIndexedAccess') {
      typeStack.push(this.currentTypeName! as ElementaryTypeName)
    }
    typeStack.push(createElementaryTypeName('uint256'))
    this.createStateVariable(node.name, typeStack)
  }

  ForAllExpression = (node: ForAllExpression) => {
    if (node.constraint.type == 'CMPExpression') {
    }
    else {
    }
    if (node.constraint.type == 'CMPExpression') {
      node.name = [generateNewVarName('cmp')]
      this.createStateVariable(node.name[0], [createElementaryTypeName('uint256')])
    }
    else {
      this.visit(node.constraint)
      node.mu = node.mu.filter(it => this.muWithTypes.has(it.name))
      node.name = []
      node.mu.forEach(it => {
        const type = this.muWithTypes.get(it.name)!
        const name = generateNewVarName(it.name + '_arr')
        this.createStateVariable(name, [createArray(type)])
        node.name.push(name)
      })
    }
  }
}
