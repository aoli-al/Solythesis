import {
  ASTNode, Expression, ExpressionStatement, Identifier, IndexAccess, Statement, TypeName,
  VariableDeclarationStatement, visit, Visitor,
} from "solidity-parser-antlr"
import { QuantityExp } from "../constraints/nodes/Node"
import { Rewriter } from "../constraints/Rewriter"
import { generateNewVarName } from "../constraints/StateVariableGenerator"
import {
  createBinaryOperation, createElementaryTypeName, createExpressionStmt, createIdentifier,
  createVariableDeclaration, createVariableDeclarationStmt, equal, getIndexAccessBase,
} from "../constraints/utilities"
import { ContractVisitor } from "../visitors/ContractVisitor"
import { IndexAccessCollector } from "./IndexAccessCollector"

export function optimize(constraintsPair: Array<[QuantityExp, Map<string, Expression>]>,
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
  return [tmpVars.map((it) => it[2]), rewriter.visit(statements), tmpVars.map((it) => it[3])]
}

class IndexAccessRewriter extends ContractVisitor implements Visitor {
  public nodes: Array<[string, IndexAccess]>
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
    return createIdentifier(tuple[0][0])
  }
}
