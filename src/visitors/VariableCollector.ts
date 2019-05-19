import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, ElementaryTypeName, NumberLiteral, BooleanLiteral, MemberAccess, ASTNode, ContractDefinition, Block, Mapping, FunctionDefinition, FunctionCall, ArrayTypeName, ForStatement, TypeName} from "solidity-parser-antlr";


export class VariableCollector implements Visitor {
  variables: Map<string, TypeName> = new Map()
  StateVariableDeclaration = (node: StateVariableDeclaration) => {
    node.variables.forEach(it => {
      this.variables.set(it.name, it.typeName)
    })
  }
}