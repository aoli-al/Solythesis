import * as _ from "lodash"
import {
  Forall, Node, PrimaryExpression,
  Sum, MemberAccess, BinaryExpression, IndexedAccess, Identifier,
} from "../constraints/nodes/Node"

export abstract class ConstraintVisitor {
  public Sum?: (node: Sum) => void
  public Forall?: (node: Forall) => void
  public MemberAccess?: (node: MemberAccess) => void
  public BinaryExpression?: (node: BinaryExpression) => void
  public IndexedAccess?: (node: IndexedAccess) => void
  public Identifier?: (node: Identifier) => void
  public PrimaryExpression?: (node: PrimaryExpression) => void
  public visit(node: Node) {
    if (Array.isArray(node)) {
      node.forEach((it) => this.visit(it))
    } else if (_.has(node, "type")) {
      if (node.type in this) { this[node.type as keyof ConstraintVisitor]!(node as any) } else {
        for (const prop in node) {
          if (node.hasOwnProperty(prop)) {
            this.visit((node as any)[prop])
          }
        }
      }
    }
  }
}
