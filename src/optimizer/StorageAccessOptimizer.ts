import { Visitor, Block, IndexAccess, Expression, Statement, ASTNode, visit, VariableDeclarationStatement, ExpressionStatement } from "solidity-parser-antlr";
import { SumExpression, QuantityExp } from "../constraints/nodes/Node";
import { Rewriter } from "../constraints/Rewriter";
import { equal, createIdentifier, createVariableDeclarationStmt, createVariableDeclaration, createElementaryTypeName, createExpressionStmt, createBinaryOperation } from "../constraints/utilities";
import { generateNewVarName } from "../constraints/StateVariableGenerator";
import { isMainThread } from "worker_threads";
import { ConstractVisitor as ContractVisitor } from "../constraints/visitor";
import { PendingStatements } from "../constraints/Decorator";
import { TupleExpressionContext } from "../antlr/SolidityParser";


export function optimize(constraintsPair: [QuantityExp, Map<string, Expression>][],
  statements: Statement[]): Statement[][] {
  const collector = new IndexAccessCollector()
  constraintsPair.map(it => {
    if (it[0].type == 'ForAllExpression') {
      visit(new Rewriter(it[1]).visit(it[0].constraint), collector)
    }
    else {
      visit(new Rewriter(it[1]).visit(it[0].constraint), collector)
      visit(new Rewriter(it[1]).visit(it[0].body), collector)
    }
  })
  const tmpVars: [string, Expression, VariableDeclarationStatement, ExpressionStatement][] = collector.nodes.map(it => {
    const name = generateNewVarName('opt')
    const decl = createVariableDeclaration(name, createElementaryTypeName('uint256'), false)
    const update = createExpressionStmt(createBinaryOperation(it, createIdentifier(name), '='))
    return [name, it, createVariableDeclarationStmt([decl], it), update]
  })
  const rewriter = new IndexAccessRewriter(tmpVars.map(tuple => [tuple[0], tuple[1]]) as [string, Expression][])
  return [tmpVars.map(it => it[2]), rewriter.visit(statements), tmpVars.map(it => it[3])]
}

class IndexAccessRewriter extends ContractVisitor implements Visitor {
  nodes: [string, Expression][]
  constructor(nodes: [string, Expression][]) {
    super()
    this.nodes = nodes
  }

  IndexAccess = (node: IndexAccess) => {
    const tuple = this.nodes.filter(it => equal(node, it[1]))
    if (tuple.length == 0) {
      node.base = this.visit(node.base)
      node.index = this.visit(node.index)
      return node
    }
    return createIdentifier(tuple[0][0])
  }
}

class IndexAccessCollector implements Visitor {
  nodes: Expression[] = []

  IndexAccess = (node: IndexAccess) => {
    if (this.nodes.filter(it => equal(node, it)).length > 0) return
    this.nodes.push(node)
    return false
  }
}