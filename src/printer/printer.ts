import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier } from "solidity-parser-antlr";

export class Printer implements Visitor {
  source: string = ""
  BinaryOperation = (node: BinaryOperation) => {
    visit(node.left, this) 
    this.source += node.operator
    visit(node.right, this)
    return false
  }

  IfStatement = (node: IfStatement) => {
    this.source += 'if ('
    visit(node.condition, this)
    this.source += ') '
    visit(node.trueBody, this)
    if (node.falseBody) {
      this.source += 'else'
      visit(node.falseBody, this)
    }
    return false
  }

  Identifier = (node: Identifier) => {
    this.source += node.name
  }

  ExpressionStatement = (node: ExpressionStatement) => {
    visit(node.expression, this)
    this.source += ';\n'
    return false
  }

  IndexAccess = (node: IndexAccess) => {
    visit(node.base, this)
    this.source += '['
    visit(node.index, this)
    this.source += ']'
    return false
  }
}