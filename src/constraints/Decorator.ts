import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, FunctionDefinition, ContractDefinition } from "solidity-parser-antlr";
import { generate } from "./Generator";
import { Node } from "./nodes/Node";
import { Printer } from "../printer/printer";

const updateOps = ['=', '-=', '+=', '*=', '/=']

export class Decorator implements Visitor {
  constraints: Node[]
  constructor(constraints: Node[]) {
    this.constraints = constraints
  }
  Expression = (node: Expression) => {
    console.log(node)
  }
  FunctionDefinition = (node: FunctionDefinition) => {
    console.log(node)
  }
  ContractDefinition = (node: ContractDefinition) => {
    
  }
  BinaryOperation = (node: BinaryOperation) => {
    if (updateOps.includes(node.operator) && node.left.type == 'IndexAccess') {
      const base = node.left.base 
      const index = node.left.index
      if (base.type == 'Identifier') {
        this.constraints.map(it => generate(it, base, index, node.right)).forEach(it => it.forEach(node => {
          const printer = new Printer()
          visit(node, printer)
          console.log(printer.source)
        }))
      }
    }
    return false
  }
  ExpressionStatement = (node: ExpressionStatement) => {
  }
  IfStatement = (node: IfStatement) => {
  }
  VariableDeclaration = (node: VariableDeclaration) => {
  }
  VariableDeclarationStatement = (node: VariableDeclarationStatement) => {
  }
  StateVariableDeclaration = (node: StateVariableDeclaration) => {
    console.log(node)
  }
}