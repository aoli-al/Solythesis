import {Node, SyntaxKind, PrimaryExpression, SumExpression, SExpTypes, MuExpTypes, MuExp} from './nodes/Node'
import { BaseASTNode, ASTNodeTypeString, ASTNode } from 'solidity-parser-antlr';

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