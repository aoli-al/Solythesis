import { Node, BinaryExpression, SyntaxKind, ForAllExpression } from "./nodes/Node";
import { BinaryOperation } from "solidity-parser-antlr";

export function generate(constraint: Node, assignment: BinaryOperation) {
  switch (constraint.kind) {
    case SyntaxKind.ForAllExpression: 
  }
}

function generateForAll(constraint: ForAllExpression, assignment: BinaryOperation) {
}