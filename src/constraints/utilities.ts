import {Node, SyntaxKind, PrimaryExpression} from './nodes/Node'
import { Type, TypeFlags } from './types/Type';

function Node(this: Node, kind: SyntaxKind) {
  this.children = []
  this.kind = kind
  this.parent = undefined
} 

export let objectAllocator = {
  getNodeConstructor: () => <any>Node,
}