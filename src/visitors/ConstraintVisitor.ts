import * as _ from "lodash"
import {
  CMPExpression, ForAllExpression, MuExpression, MuIdentifier, MuIndexedAccess, Node, PrimaryExpression,
  SExpression, SIdentifier, SIndexedAccess, SumExpression, MemberAccess,
} from "../constraints/nodes/Node"

export abstract class ConstraintVisitor {
  public SumExpression?: (node: SumExpression) => void
  public ForAllExpression?: (node: ForAllExpression) => void
  public SExpression?: (node: SExpression) => void
  public MuExpression?: (node: MuExpression) => void
  public PrimaryExpression?: (node: PrimaryExpression) => void
  public SIndexedAccess?: (node: SIndexedAccess) => void
  public MuIndexedAccess?: (node: MuIndexedAccess) => void
  public MuIdentifier?: (node: MuIdentifier) => void
  public SIdentifier?: (node: SIdentifier) => void
  public CMPExpression?: (node: CMPExpression) => void
  public MemberAccess?: (node: MemberAccess) => void
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
