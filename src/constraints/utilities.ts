import {Node, SyntaxKind, PrimaryExpression, SumExpression, SExpTypes, MuExpTypes} from './nodes/Node'

function Node(this: Node, kind: SyntaxKind) {
  this.children = []
  this.kind = kind
  this.parent = undefined
} 

export let objectAllocator = {
  getNodeConstructor: () => <any>Node,
}