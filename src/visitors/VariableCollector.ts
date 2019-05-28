import { ArrayTypeName, ASTNode, BinaryOperation, Block, BooleanLiteral, ContractDefinition, ElementaryTypeName, Expression, ExpressionStatement, ForStatement, FunctionCall, FunctionDefinition, Identifier, IfStatement, IndexAccess, Mapping, MemberAccess, NumberLiteral, SourceUnit, StateVariableDeclaration, TypeName, VariableDeclaration, VariableDeclarationStatement, visit, Visitor} from "solidity-parser-antlr"

export class VariableCollector implements Visitor {
  public variables: Map<string, TypeName> = new Map()
  public StateVariableDeclaration = (node: StateVariableDeclaration) => {
    node.variables.forEach((it) => {
      this.variables.set(it.name, it.typeName)
    })
  }
}
