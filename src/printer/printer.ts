import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, ElementaryTypeName, NumberLiteral, BooleanLiteral } from "solidity-parser-antlr";

export class Printer implements Visitor {
  source: string = ""
  BinaryOperation = (node: BinaryOperation) => {
    visit(node.left, this) 
    this.source += ' ' + node.operator + ' '
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

  ElementaryTypeName = (node: ElementaryTypeName) => {
    this.source += node.name
  }

  VariableDeclaration = (node: VariableDeclaration) => {
    visit(node.typeName, this)
    if (node.storageLocation) {
      this.source += ' ' + node.storageLocation
    }
    this.source += ' '
    visit(node.name, this)
    return false
  }

  NumberLiteral = (node: NumberLiteral) => {
    this.source += node.number
  }

  BooleanLiteral = (node: BooleanLiteral) => {
    this.source = node.value.toString()
  }

  VariableDeclarationStatement = (node: VariableDeclarationStatement) => {
    if (node.variables.length > 1) {
      this.source += '('
      visit(node.variables[0], this)
      node.variables.slice(1).forEach(it => {
        this.source += ', '
        visit(it, this)
      })
      this.source += ')'
    }
    else {
      visit(node.variables[0], this)
    }
    if (node.initialValue) {
      this.source += ' = '
      visit(node.initialValue, this)
    }
    this.source += ';\n'
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