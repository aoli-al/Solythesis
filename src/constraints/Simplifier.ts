import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, FunctionDefinition, ContractDefinition, Statement, ASTNode, Block, ReturnStatement, BaseASTNode } from "solidity-parser-antlr";
import { Node } from "./nodes/Node";
import { Printer } from "../printer/printer";
import { createBaseASTNode, getMonitoredStateVariables, getUpdatedVariable } from "./utilities";
import * as _ from "lodash";
import { isMainThread } from "worker_threads";

const updateOps = ['-=', '+=', '*=', '/=']

export class Simplifier implements Visitor {
  ExpressionStatement = (node: ExpressionStatement) => {
    if (node.expression.type != 'BinaryOperation') return true
  }


}