import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, FunctionDefinition, ContractDefinition, Statement, ASTNode, Block, ReturnStatement, BaseASTNode } from "solidity-parser-antlr";
import { generateUpdates, generateAssertions} from "./Generator";
import { Node } from "./nodes/Node";
import { Printer } from "../printer/printer";
import { createBaseASTNode, getMonitoredStateVariables, getUpdatedVariable } from "./utilities";
import * as _ from "lodash";
import { isMainThread } from "worker_threads";

const updateOps = ['=', '-=', '+=', '*=', '/=']

export class Decorator implements Visitor {
  [key: string]: any
  constraints: Node[]
  variables: StateVariableDeclaration[]
  pendingBlocks: Statement[] = []
  checkConstraints: Set<Node> = new Set()
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
  addAssertions(node: ReturnStatement) {
    const block = createBaseASTNode('Block') as Block
    block.statements = [...this.checkConstraints].map(it => generateAssertions(it)).reduce((pre, cur) => [...pre, ...cur], [])
    block.statements.push(node)
    return block
  }
  visit(node: any) {
    if (Array.isArray(node)) {
      for (var i = 0; i < node.length; i++) {
        this.visit(node[i])
        if (this.pendingBlocks.length > 0) {
          node[i] = this.buildStatements(node[i])
        }
        if ((node[i] as ASTNode).type == 'ReturnStatement') {
          node[i] = this.addAssertions(node[i])
        }
      }
      return
    }
    if (!_.has(node, 'type')) return
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
        if (_.has(node[prop], 'type') && node[prop].type == 'ReturnStatement') {
          node[prop] = this.addAssertions(node[prop])
        }
      }
    }
  }
  ContractDefinition = (node: ContractDefinition) => {
    node.subNodes = [...this.variables, ...node.subNodes]
  }
  FunctionDefinition = (node: FunctionDefinition) => {
    this.checkConstraints = new Set()
    this.visit(node.body)
    const block = createBaseASTNode('Block') as Block
    block.statements = [...this.checkConstraints].map(it => generateAssertions(it)).reduce((pre, cur) => [...pre, ...cur], [])
    if (node.body) {
      node.body.statements.push(block)
    }
    return false
  }
  ExpressionStatement = (node: ExpressionStatement) => {
    if (node.expression.type != 'BinaryOperation') return true
    const binOp = node.expression
    if (updateOps.includes(binOp.operator)) {
      if (binOp.left.type == 'IndexAccess') {
        const base = binOp.left.base
        const index = binOp.left.index
        if (base.type == 'Identifier') {
          this.constraints.forEach(it => this.pendingBlocks.push(...generateUpdates(it, base, index, binOp)))
        }
      }
      const variable = getUpdatedVariable(binOp.left)
      if (variable) {
        this.constraints.filter(it => getMonitoredStateVariables(it).has(variable)).forEach(it => this.checkConstraints.add(it))
      }
    }
    return false
  }
}