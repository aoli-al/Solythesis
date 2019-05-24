import { Visitor, Block, IndexAccess, Expression, Statement, ASTNode, visit } from "solidity-parser-antlr";
import { SumExpression } from "../constraints/nodes/Node";
import { Rewriter } from "../constraints/Rewriter";
import { equal, createIdentifier, createVariableDeclarationStmt, createVariableDeclaration, createElementaryTypeName } from "../constraints/utilities";
import { generateNewVarName } from "../constraints/StateVariableGenerator";
import { isMainThread } from "worker_threads";


export function optimize(sum: SumExpression, mu: Map<string, Expression>, statements: Statement[]) {
  const constraint = new Rewriter(mu).visit(sum.constraint)
  const body = new Rewriter(mu).visit(sum.body)
  const collector = new IndexAccessCollector()
  visit(constraint, collector)
  visit(body, collector)
  collector.nodes.map(it => {
    const name = generateNewVarName('opt')
    const decl = createVariableDeclaration(name, createElementaryTypeName('uint256'), false)
    return [name , createVariableDeclarationStmt([decl], it)]
  })
}

class IndexAccessRewriter implements Visitor {
  nodes: [string, Expression][]
  constructor(nodes: [string, Expression][]) {
    this.nodes = nodes
  }

  IndexAccess = (node: IndexAccess) => {
    const nodes = this.nodes.filter(it => equal(node, it[1]))
    if (nodes.length == 0) return true
    
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