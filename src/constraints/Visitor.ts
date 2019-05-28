import { Node, SumExpression, ForAllExpression, SExpression, MuExpression, PrimaryExpression, SIndexedAccess, MuIdentifier, SIdentifier, CMPExpression, MuIndexedAccess } from "./nodes/Node";
import * as _ from "lodash";
import { Visitor } from "solidity-parser-antlr"

export abstract class ConstraintVisitor {
  SumExpression?: (node: SumExpression) => void 
  ForAllExpression?: (node: ForAllExpression) => void
  SExpression?: (node: SExpression) => void
  MuExpression?: (node: MuExpression) => void
  PrimaryExpression?: (node: PrimaryExpression) => void
  SIndexedAccess?: (node: SIndexedAccess) => void
  MuIndexedAccess?: (node: MuIndexedAccess) => void
  MuIdentifier?: (node: MuIdentifier) => void
  SIdentifier?: (node: SIdentifier) => void
  CMPExpression?: (node: CMPExpression) => void
  visit(node: Node) {
    if (Array.isArray(node)) {
      node.forEach(it => this.visit(it))
    }
    else if (_.has(node, 'type')) {
      if (node.type in this) this[node.type as keyof ConstraintVisitor]!(node as any)
      else {
        for (const prop in node) {
          if (node.hasOwnProperty(prop)) {
            this.visit((<any>node)[prop])
          }
        }
      }
    }
  }
}

export abstract class ConstractVisitor  {
  visit(node: any) {
    if (Array.isArray(node)) {
      for (var i = 0; i < node.length; i++) {
        node[i] = this.visit(node[i])
      }
      return node
    }
    if (!_.has(node, 'type')) return node
    if (node.type in this) {
      node = (this as any)[node.type](node)
      return node
    }

    for (const prop in node) {
      if (node.hasOwnProperty(prop)) {
        node[prop] = this.visit(node[prop])
      }
    }
    return node
  }
}