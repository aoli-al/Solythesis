import { StateVariableDeclaration, TypeName, Visitor } from "solidity-parser-antlr"

export class VariableCollector implements Visitor {
  public variables: Map<string, TypeName> = new Map()
  public StateVariableDeclaration = (node: StateVariableDeclaration) => {
    node.variables.forEach((it) => {
      this.variables.set(it.name, it.typeName)
    })
  }
}
