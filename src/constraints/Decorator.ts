import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier } from "solidity-parser-antlr";
import { generate } from "./Generator";
import { Node } from "./nodes/Node";
import { Printer } from "../printer/printer";


export class Decorator implements Visitor {
  constraints: Node[]
  constructor(constraints: Node[]) {
    this.constraints = constraints
  }
  Expression = (node: Expression) => {
    console.log(node)
  }
  BinaryOperation = (node: BinaryOperation) => {
    if (node.operator == '=' && node.left.type == 'IndexAccess') {
      const base = node.left.base 
      const index = node.left.index
      if (base.type == 'Identifier') {
        this.constraints.map(it => generate(it, base, index, node.right)).forEach(it => it.forEach(node => visit(node, new Printer())))
      }
    }
    return false
  }
  ExpressionStatement = (node: ExpressionStatement) => {
    console.log(node)
  }

  IfStatement = (node: IfStatement) => {
    console.log(node)
  }

  VariableDeclaration = (node: VariableDeclaration) => {
    console.log(node)
  }

  VariableDeclarationStatement = (node: VariableDeclarationStatement) => {
    console.log(node)
  }

  StateVariableDeclaration = (node: StateVariableDeclaration) => {
    console.log(node)
  }
}