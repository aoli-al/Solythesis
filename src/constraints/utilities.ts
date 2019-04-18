import {Node, SyntaxKind, PrimaryExpression, SumExpression, SExpTypes, MuExpTypes, MuExp} from './nodes/Node'
import { BaseASTNode, ASTNodeTypeString, ASTNode, Expression, BinOp, BinaryOperation, ExpressionStatement, Identifier, ElementaryTypeName, TypeName, Mapping } from 'solidity-parser-antlr';

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

export function createMapping(keyType: ElementaryTypeName, valueType: TypeName) {
  const node = createBaseASTNode('Mapping') as Mapping
  node.keyType = keyType
  node.valueType = valueType
  return node
}

export function createBinaryOperationStmt(left: Expression, right: Expression, op: BinOp): ExpressionStatement {
  const node = createBaseASTNode('BinaryOperation') as BinaryOperation
  node.left = left
  node.right = right
  node.operator = op
  const stmt = createBaseASTNode('ExpressionStatement') as ExpressionStatement
  stmt.expression = node
  return stmt
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