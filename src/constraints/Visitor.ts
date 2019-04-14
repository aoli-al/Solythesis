import { Node, SumExpression, ForAllExpression, SExpression, MuExpression, PrimaryExpression, SIndexedAccess, MuIdentifier, SIdentifier, CMPExpression, MuIndexedAccess } from "./nodes/Node";

export abstract class Visitor<T> {
  [key: string]: any
  SumExpression?: (node: SumExpression) => T
  ForAllExpression?: (node: ForAllExpression) => T
  SExpression?: (node: SExpression) => T
  MuExpression?: (node: MuExpression) => T
  PrimaryExpression?: (node: PrimaryExpression) => T
  SIndexedAccess?: (node: SIndexedAccess) => T
  MuIndexedAccess?: (node: MuIndexedAccess) => T
  MuIdentifier?: (node: MuIdentifier) => T
  SIdentifier?: (node: SIdentifier) => T
  CMPExpression?: (node: CMPExpression) => T
  abstract default(): T
  visit(node: Node): T {
    if (node.type in this) this[node.type](node) as T
    return this.default()
  }
}

// export function visit(node: Node, visitor: Visitor) {
//   let cont = true
//   if (visitor[node.type]) {
//     cont = visitor[node.type]!(node)
//   }

//   if (cont == false) return

//   for (const prop in node) {
//     if (node.hasOwnProperty(prop)) {
//       visit(node[prop] as Node, visitor)
//     }
//   }
// }