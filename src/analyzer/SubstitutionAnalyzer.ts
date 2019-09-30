import assert from "assert"
import { Node, IndexedAccess, Identifier, Sum, Forall, BinaryExpression } from "src/constraints/nodes/Node"
import { Expression, ExpressionStatement, Identifier as Iden, TypeName } from "solidity-parser-antlr"
import { ConstraintVisitor } from "src/visitors/ConstraintVisitor"
import { equal, createExpressionStmt, createFunctionCall, createIdentifier, createBinaryOperation,
  getMonitoredVariables, getUpdatedVariable } from "src/constraints/utilities"
import { basename } from "path"

export class SubstutionAnalyzer extends ConstraintVisitor {
  public map: Array<Map<string, Expression>> = []
  public constraint: Node
  public currentExpression: Expression
  public assertions: ExpressionStatement[] = []
  public stateVarName: string = ""
  constructor(constraint: Node, expression: Expression) {
    super()
    this.currentExpression = expression
    this.constraint = constraint
  }

  public run(): [boolean, Array<Map<string, Expression>>] {
    if (!getMonitoredVariables(this.constraint)
      .has(getUpdatedVariable(this.currentExpression))) {
      return [false, this.map]
    }
    if (this.currentExpression.type !== "IndexAccess") {
      return [true, this.map]
    }
    let base: Expression = this.currentExpression
    while (base.type === "IndexAccess") {
      base = base.base
    }
    assert(base.type === "Identifier", "Must be identifier here.")
    this.stateVarName = (base as Iden).name
    this.visit(this.constraint)
    return [true, this.map]
  }

  public IndexedAccess = (node: IndexedAccess) => {
    let base = node.object
    while (base.type === "IndexedAccess") {
      base = base.object
    }
    if ((base as Identifier).name !== this.stateVarName) {
      return
    }
    const map: Map<string, Expression> = new Map()
    let ebase: Expression = this.currentExpression
    let cbase: Node = node
    while (cbase.type === "IndexedAccess" && ebase.type === "IndexAccess") {
      this.update(cbase.index, ebase.index, map)
      cbase = cbase.object
      ebase = ebase.base
    }
    this.map.push(map)
  }

  public Sum = (node: Sum) => {
    this.visit(node.expression)
    this.visit(node.condition)
  }

  public Forall = (node: Forall) => {
    this.visit(node.condition)
  }

  public BinaryExpression = (node: BinaryExpression) => {
    this.visit(node.left)
    this.visit(node.right)
  }

  private update(node: Identifier, expression: Expression, map: Map<string, Expression>) {
    assert(node.isMu, "muse be mu here")
    if (map.has(node.name) && !equal(map.get(node.name)!, expression)) {
      this.assertions.push(createExpressionStmt(
        createFunctionCall(createIdentifier("assert"),
        [createBinaryOperation(map.get(node.name)!, expression, "==")])))
    }
    map.set(node.name, expression)
  }
}
