import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess } from "solidity-parser-antlr";


export class Decorator implements Visitor {
  constructor() {
  }
  Expression = (node: Expression) => {
    console.log(node)
  }
  BinaryOperation = (node: BinaryOperation) => {
    if (node.operator == '=' && node.left.type == 'IndexAccess') {
      const indexAccess = node.left 
      const base = node.left.base
    }
    return false
  }
  ExpressionStatement = (node: ExpressionStatement) => {
    console.log(node)
  }
}