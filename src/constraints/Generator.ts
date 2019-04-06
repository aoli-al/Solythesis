import { Node, SyntaxKind, ForAllExpression, SumExpression} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode, IfStatement, BaseASTNode, Block } from "solidity-parser-antlr";
import { getSVariables, createBaseASTNode } from "./utilities";

export function generate(constraint: Node, identifier: Identifier, index: ASTNode, value: ASTNode): BaseASTNode {
}


function generateSum(constraint: SumExpression, assignment: BinaryOperation) {
  var freeVar = undefined
  switch(assignment.left.type) {
    case 'IndexAccess': {
      freeVar = assignment.left.base as Identifier
      break
    }
    case 'Identifier': {
      freeVar = assignment.left
      break
    }
  }
  if (!freeVar) return
  const name = freeVar.name
  if (!getSVariables(constraint).has(name)) return
  const block = createBaseASTNode('Block') as Block
  const ifStatement = createBaseASTNode('IfStatement') as IfStatement
}


function rewrite(node: Node, identifier?: Identifier, index?: ASTNode, value?: ASTNode) {

}