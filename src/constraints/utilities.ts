import {Node, SyntaxKind, PrimaryExpression, SumExpression, SExpTypes, MuExpTypes, MuExp} from './nodes/Node'
import { BaseASTNode, ASTNodeTypeString, ASTNode, Expression, BinOp, BinaryOperation, ExpressionStatement, Identifier, ElementaryTypeName, TypeName, Mapping, ArrayTypeName, VariableDeclaration, VariableDeclarationStatement, IndexAccess, NumberLiteral, MemberAccess, Statement, IfStatement, FunctionCall } from 'solidity-parser-antlr';

function Node(this: Node, kind: SyntaxKind) {
  this.children = []
  this.type = kind
  this.parent = undefined
} 

function BaseASTNode(this: BaseASTNode, type: ASTNodeTypeString) {
  this.type = type
}

export let objectAllocator = {
  getNodeConstructor: () => <any>Node,
  getBaseASTNodeConstructor: () => <any>BaseASTNode,
}

export function createNode(kind: SyntaxKind): Node {
  return new (objectAllocator.getNodeConstructor())(kind)
}

export function createBaseASTNode(type: ASTNodeTypeString) {
  return new (objectAllocator.getBaseASTNodeConstructor())(type)
}

export function createIdentifier(name: string) {
  const node = createBaseASTNode('Identifier') as Identifier
  node.name = name
  return node
}

export function createElementaryTypeName(name: string) {
  const node = createBaseASTNode('ElementaryTypeName') as ElementaryTypeName
  node.name = name
  return node
}

export function createNumberLiteral(value: string) {
  const node = createBaseASTNode('NumberLiteral') as NumberLiteral
  node.number = value
  return node
}

export function createVariableDeclaration(name: string, type: TypeName, stateVar: boolean) {
  const node = createBaseASTNode('VariableDeclaration') as VariableDeclaration
  node.name = name
  node.isStateVar = stateVar
  node.typeName = type
  if (type.type == 'Mapping' || type.type == 'ArrayTypeName') {
    node.isIndexed = true
  }
  else {
    node.isIndexed = false
  }
  return node
}

export function createVariableDeclarationStmt(variables: VariableDeclaration[], initValue?: Expression) {
  const node = createBaseASTNode('VariableDeclarationStatement') as VariableDeclarationStatement
  node.variables = variables
  if (initValue) {
    node.initialValue = initValue
    variables.forEach(it => it.expression = initValue)
  }
  return node
}

export function createMemberAccess(expression: Expression, memberName: string) {
  const node = createBaseASTNode('MemberAccess') as MemberAccess
  node.expression = expression
  node.memberName = memberName
  return node
}

export function createIfStatment(condition: Expression, trueBody: Statement, falseBody?: Statement) {
  const node = createBaseASTNode('IfStatement') as IfStatement
  node.condition = condition
  node.trueBody = trueBody
  node.falseBody = falseBody
  return node
}

export function createSafeBinaryOperation(left: Expression, right: Expression, op: '+='|'-=') {
  const opMap = {
    '+=': ['+', '>='],
    '-=': ['-', '<=']
  }
 createBinaryOperation(createBinaryOperation(left, right, opMap[op][0] as BinOp), left, '>=')
}

export function createFunctionCall(expression: Expression, args: Expression[], names: string[]) {
  const node = createBaseASTNode('FunctionCall') as FunctionCall
  node.expression = expression
  node.arguments = args
  node.names = names
  return node
}

export function createIndexAccess(base: Expression, index: Expression) {
  const node = createBaseASTNode('IndexAccess') as IndexAccess
  node.base = base
  node.index = index
  return node
}

export function createMapping(keyType: ElementaryTypeName, valueType: TypeName) {
  const node = createBaseASTNode('Mapping') as Mapping
  node.keyType = keyType
  node.valueType = valueType
  return node
}

export function createArray(baseTypeName: TypeName) {
  const node = createBaseASTNode('ArrayTypeName') as ArrayTypeName
  node.baseTypeName = baseTypeName
  return node
}

export function createBinaryOperation(left: Expression, right: Expression, op: BinOp) {
  const node = createBaseASTNode('BinaryOperation') as BinaryOperation
  node.left = left
  node.right = right
  node.operator = op
  return node
}

export function createExpressionStmt(expression: Expression) {
  const node = createBaseASTNode('ExpressionStatement') as ExpressionStatement
  node.expression = expression
  return node
}

export function getChildren(node: Node): Node[] {
  switch (node.type) {
    case 'MuExpression': 
    case 'SExpression':
    case 'CMPExpression': {
      return [node.left, node.right]
    }
    case 'ForAllExpression': {
      return [node.mu, node.constraint]
    }
    case 'SumExpression': {
      return [node.mu, node.body, node.constraint]
    }
    case 'SIndexedAccess': 
    case 'MuIndexedAccess': {
      return [node.object, node.index]
    }
  }
  return []
}


export function getSVariables(node: Node): Set<string> {
  switch (node.type) {
    case 'MuIdentifier': {
      return new Set()
    }
    case 'SIdentifier': {
      return new Set([node.name])
    }
  }
  return getChildren(node)
    .map(getSVariables)
    .reduce((accumulator, set) => new Set([...accumulator, ...set]), new Set())
}

export function getMonitoredVariables(node: Node, mu: string): Set<string> {
  switch (node.type) {
    case 'MuIndexedAccess': {
      if (node.index.name == mu) {
        return new Set([node.object.name])
      }
    }
  }
  return getChildren(node)
    .map((name) => getMonitoredVariables(name, mu))
    .reduce((accumulator, set) => new Set([...accumulator, ...set]), new Set())
}

export function getMonitoredStateVariables(node: Node): Set<string> {
  switch (node.type) {
    case 'SIdentifier': {
      return new Set([node.name])
    }
  }
  return getChildren(node)
    .map((name) => getMonitoredStateVariables(name))
    .reduce((accumulator, set) => new Set([...accumulator, ...set]), new Set())
}

export function getUpdatedVariable(node: Expression): string | undefined {
  switch (node.type) {
    case 'Identifier': return node.name
    case 'IndexAccess': return getUpdatedVariable(node.base)
  }
  return undefined
}
