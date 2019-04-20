import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, FunctionDefinition, ContractDefinition, Statement, ASTNode, Block } from "solidity-parser-antlr";
import { generate } from "./Generator";
import { Node } from "./nodes/Node";
import { Printer } from "../printer/printer";
import { createBaseASTNode } from "./utilities";

const updateOps = ['=', '-=', '+=', '*=', '/=']

export class Decorator implements Visitor {
  [key: string]: any
  constraints: Node[]
  variables: StateVariableDeclaration[]
  pendingBlocks: Statement[] = []
  constructor(constraints: Node[], variables: StateVariableDeclaration[]) {
    this.constraints = constraints
    this.variables = variables
  }
  buildStatements(statement: Statement) {
    const block = createBaseASTNode('Block') as Block
    block.statements = this.pendingBlocks 
    block.statements.push(statement)
    this.pendingBlocks = []
    return block
  }
  visit(node: any) {
    if (Array.isArray(node)) {
      for (var i = 0; i < node.length; i++) {
        this.visit(node[i])
        if (this.pendingBlocks.length > 0) {
          node[i] = this.buildStatements(node[i])
        }
      }
      return
    }
    if (!node || typeof node != 'object' || !node.hasOwnProperty('type')) return
    var result = true
    if (node.type in this) {
      result = this[node.type](node)
    }
    if (result == false) {
      return
    }

    for (const prop in node) {
      if (node.hasOwnProperty(prop)) {
        this.visit(node[prop])
        if (this.pendingBlocks.length > 0) {
          node[prop] = this.buildStatements(node[prop])
        }
      }
    }
  }
  ContractDefinition = (node: ContractDefinition) => {
    node.subNodes = [...this.variables, ...node.subNodes]
  }
  ExpressionStatement = (node: ExpressionStatement) => {
    if (node.expression.type != 'BinaryOperation') return true
    const binOp = node.expression
    if (updateOps.includes(binOp.operator) && binOp.left.type == 'IndexAccess') {
      const base = binOp.left.base 
      const index = binOp.left.index
      if (base.type == 'Identifier') {
        this.constraints.forEach(it => this.pendingBlocks.push(...generate(it, base, index, binOp.right)))
      }
    }
    return false
  }
}