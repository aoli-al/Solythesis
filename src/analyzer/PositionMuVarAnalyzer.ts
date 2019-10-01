import { ConstraintVisitor } from "../visitors/ConstraintVisitor"
import { QuantityExp, BinaryExpression, Identifier } from "../constraints/nodes/Node"
import { createNode } from "../constraints/utilities"

export class PositionMuVarAnalyzer extends ConstraintVisitor {
  private muSet: Set<string> = new Set()
  private node: QuantityExp
  constructor(node: QuantityExp) {
    super()
    this.node = node
  }

  public run() {
    this.visit(this.node)
  }

  public BinaryExpression = (node: BinaryExpression) => {
    if (node.op === "==" && node.right.type === "Identifier" && node.right.isMu) {
      const name = node.right.name
      if (this.node.positionMuVarMap.has(name)) {
        const exp = createNode("BinaryExpression") as BinaryExpression
        exp.op = "=="
        exp.left = node.left
        exp.right = this.node.positionMuVarMap.get(name)!
        this.node.positionMuVarAssertions.push(exp)
      } else {
        this.node.positionMuVarMap.set(name, node.left)
      }
      this.muSet = new Set()
      this.visit(node.left)
      if (this.node.positionMuDependencyMap.has(name)) {
        this.muSet.forEach((it) =>
          this.node.positionMuDependencyMap.get(name)!.add(it))
      } else {
        this.node.positionMuDependencyMap.set(name, this.muSet)
      }
      this.muSet = new Set()
    }
  }

  public Identifier = (node: Identifier) => {
    if (node.isMu) {
      this.muSet.add(node.name)
    }
  }
}
