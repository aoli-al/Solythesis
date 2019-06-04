import {
  ASTNode, Expression, ExpressionStatement, Identifier, IndexAccess, Statement, TypeName,
  VariableDeclarationStatement, visit, Visitor, BinaryOperation,
} from "solidity-parser-antlr"
import { updateOps } from "../constraints/AssertionVarDecorator"
import { QuantityExp } from "../constraints/nodes/Node"
import { Rewriter } from "../constraints/Rewriter"
import { generateNewVarName } from "../constraints/StateVariableGenerator"
import {
  createBinaryOperation, createElementaryTypeName, createExpressionStmt, createIdentifier,
  createVariableDeclaration, createVariableDeclarationStmt, equal, getIndexAccessBase,
} from "../constraints/utilities"
import { ContractVisitor } from "../visitors/ContractVisitor"
import { IndexAccessCollector } from "./IndexAccessCollector"

export function optimizeStorageAccess(constraintsPair: Array<[QuantityExp, Map<string, Expression>]>,
                                      statements: Statement[], contractVars: Map<string, TypeName>,
                                      stateVarCache: Map<string, string>): Statement[][] {
  const collector = new IndexAccessCollector()
  constraintsPair.map((it) => {
    if (it[0].type === "ForAllExpression") {
      visit(new Rewriter(stateVarCache, it[1]).visit(it[0].constraint), collector)
    } else {
      visit(new Rewriter(stateVarCache, it[1]).visit(it[0].constraint), collector)
      visit(new Rewriter(stateVarCache, it[1]).visit(it[0].body), collector)
    }
  })
  const tmpVars: Array<[string, IndexAccess, VariableDeclarationStatement, ExpressionStatement]> =
    collector.nodes.map((it) => {
      const baseVar = getIndexAccessBase(it) as Identifier
      let type = contractVars.get(baseVar.name)!
      while (type.type === "Mapping") { type = type.valueType }
      const name = generateNewVarName("opt")
      const decl = createVariableDeclaration(name, type, false)
      const update = createExpressionStmt(createBinaryOperation(it, createIdentifier(name), "="))
      return [name, it, createVariableDeclarationStmt([decl], it), update]
    })
  const rewriter = new IndexAccessRewriter(tmpVars.map((tuple) => [tuple[0], tuple[1]]) as Array<[string, IndexAccess]>)
  const stmts = rewriter.visit(statements)
  const usedVarsDecl = tmpVars.filter((it) => rewriter.used.has(it[0])).map((it) => it[2])
  const updatedVarUpdate = tmpVars.filter((it) => rewriter.updated.has(it[0])).map((it) => it[3])
  return [usedVarsDecl, stmts, updatedVarUpdate]
}

class IndexAccessRewriter extends ContractVisitor implements Visitor {
  public nodes: Array<[string, IndexAccess]>
  public updated: Set<string> = new Set()
  public used: Set<string> = new Set()
  constructor(nodes: Array<[string, IndexAccess]>) {
    super()
    this.nodes = nodes
  }

  public IndexAccess = (node: IndexAccess) => {
    const tuple = this.nodes.filter((it) => equal(node, it[1]))
    if (tuple.length === 0) {
      node.base = this.visit(node.base)
      node.index = this.visit(node.index)
      return node
    }
    this.used.add(tuple[0][0])
    return createIdentifier(tuple[0][0])
  }

  public BinaryOperation = (node: BinaryOperation) => {
    node.left = this.visit(node.left)
    node.right = this.visit(node.right)

    if (updateOps.includes(node.operator) && node.left.type === "Identifier") {
      this.updated.add(node.left.name)
    }
    return node
  }
}
