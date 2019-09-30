import {
  BinOp, Block, ContractDefinition, Expression, ExpressionStatement, ForStatement, FunctionDefinition,
  Identifier, ReturnStatement, Statement, StateVariableDeclaration, TypeName, Visitor, ArrayTypeName, FunctionCall, IndexAccess, ASTNode,
} from "solidity-parser-antlr"
import { ContractVisitor } from "../visitors/ContractVisitor"

export class UniverseAnalyzer extends ContractVisitor implements Visitor {

}