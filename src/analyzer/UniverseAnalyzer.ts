import { ContractVisitor } from "src/visitors/ContractVisitor"
import { Visitor, ExpressionStatement, BinaryOperation } from "solidity-parser-antlr"
import { Node } from "src/constraints/nodes/Node"
import { updateOps } from "src/constraints/AssertionVarDecorator"

export class UniverseAnalyzer extends ContractVisitor implements Visitor {
  private constraints: Node[]

  constructor(constraints: Node[]) {
    super()
    this.constraints = constraints
  }

  // public ExpressionStatement = (statement: ExpressionStatement) {
  //   if (statement.expression.type !== "BinaryOperation") {
  //   }
  // }
  public BinaryOperation = (exp: BinaryOperation) => {
    if (!updateOps.includes(exp.operator)) { return exp }
  }
}
