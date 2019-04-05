import { Node, SyntaxKind, ForAllExpression, SumExpression} from "./nodes/Node";
import { BinaryOperation, Identifier, Expression, ASTNode } from "solidity-parser-antlr";

export function generate(constraint: Node, identifier: Identifier, index: ASTNode, value: ASTNode) {
  switch (constraint.kind) {
    case 'SumExpression': {
    }
  }
}

function generateForAll(constraint: ForAllExpression, identifier: Identifier, index: ASTNode, value: ASTNode) {

}


function generateSum(constraint: SumExpression, assignment: BinaryOperation) {
  var freeVar = undefined
  switch(assignment.left.type) {
    case 'IndexAccess': {
      freeVar = assignment.left.base 
      break
    }
    case 'Identifier': {
      freeVar = assignment.left
      break
    }
  }
  if (!freeVar) return
}