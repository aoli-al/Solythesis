import * as _ from "lodash"
import {
  BinOp, Block, ContractDefinition, Expression, ExpressionStatement, ForStatement, FunctionDefinition,
  Identifier, ReturnStatement, Statement, StateVariableDeclaration, TypeName, Visitor, ArrayTypeName, FunctionCall,
} from "solidity-parser-antlr"
import { optimizeStorageAccess } from "../optimizer/StorageAccessOptimizer"
import { ContractVisitor } from "../visitors/ContractVisitor"
import {  Node} from "./nodes/Node"
import { PendingStatements } from "./PendingStatements"
import { Rewriter } from "./Rewriter"
import { generateNewVarName } from "./StateVariableGenerator"
import {
  createBaseASTNode, createBinaryOperation, createBlock, createElementaryTypeName,
  createExpressionStmt, createFunctionCall, createIdentifier, createIfStatment, createIndexAccess,
  createMemberAccess, createNumberLiteral, createVariableDeclaration, createVariableDeclarationStmt,
  getChildren, getMonitoredStateVariables, getMonitoredVariables, getMuIndices, getUpdatedVariable,
  createArray, canOptimize, createStateVariableDeclaration,
} from "./utilities"

const updateOps = ["=", "-=", "+=", "*=", "/="]
const depthTracker = generateNewVarName("depth")

export class ConstraintsCollector extends ContractVisitor implements Visitor  {
  public constraints: Node[]
  public functionConstraints: Map<string, Map<string, Set<Node>>> = new Map()
  public checkConstraints: Set<Node> = new Set()
  private contractName: string = ""
  constructor(constraints: Node[]) {
    super()
    this.constraints = constraints
  }
  public ContractDefinition = (node: ContractDefinition) => {
    this.contractName = node.name
    this.functionConstraints.set(node.name, new Map())
    node.subNodes = this.visit(node.subNodes)
    return node
  }
  public FunctionDefinition = (node: FunctionDefinition) => {
    this.checkConstraints = new Set()
    const name = (() => {
      if (node.isConstructor || !node.name) { return "<Constructor>" }
      if (node.name.length === 0) { return  "<Fallback>" }
      return node.name
    })()
    node.body = this.visit(node.body)
    this.functionConstraints.get(this.contractName)!.set(name, this.checkConstraints)
    return node
  }
  public FunctionCall = (node: FunctionCall) => {
    if (node.expression.type !== "MemberAccess" || node.expression.expression.type !== "Identifier") { return node }
    const updateVar = node.expression.expression.name
    this.updateConstraints(updateVar)
    return node
  }
  public ExpressionStatement = (statement: ExpressionStatement) => {
    if (statement.expression.type !== "BinaryOperation") { return statement }
    const binOp = statement.expression
    if (!updateOps.includes(binOp.operator)) { return statement }
    this.updateConstraints(getUpdatedVariable(binOp.left)!)
    return statement
  }
  private updateConstraints(v: string) {
    const stack = [v]
    while (stack.length !== 0) {
      const variable = stack.pop()!
      this.constraints.filter((it) => getMonitoredStateVariables(it).has(variable)).forEach((it) => {
        if (!this.checkConstraints.has(it)) {
          this.checkConstraints.add(it)
          if (it.type === "SumExpression") {
            stack.push(it.name)
          }
        }
      })
    }
  }
}
