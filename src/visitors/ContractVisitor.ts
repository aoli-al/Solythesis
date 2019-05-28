import * as _ from "lodash"

export abstract class ContractVisitor  {
  public visit(node: any) {
    if (Array.isArray(node)) {
      for (let i = 0; i < node.length; i++) {
        node[i] = this.visit(node[i])
      }
      return node
    }
    if (!_.has(node, "type")) { return node }
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
