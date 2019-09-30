import assert from "assert"
import { ElementaryTypeName, Mapping, StateVariableDeclaration, TypeName } from "solidity-parser-antlr"
import { ConstraintVisitor } from "../visitors/ConstraintVisitor"
import {Forall, QuantityExp, Sum, Identifier } from "./nodes/Node"
import {
  createArray, createBaseASTNode, createElementaryTypeName, createMapping,
  createStateVariableDeclaration, createVariableDeclaration,
} from "./utilities"

let counter = 0
export function generateNewVarName(base: string) {
  return base + "_" + (counter++).toString()
}

export class GenStateVariables {
  public dynamicArrays: number = 0
  public forallOptimization: boolean
  public stateVars: StateVariableDeclaration[] = []
  constructor(globalMemory: boolean = true) {
    this.forallOptimization = globalMemory
  }
  public analysis(constraint: QuantityExp) {
    if (constraint.type === "ForAllExpression") {
      this.Forall(constraint)
    } else {
      this.Sum(constraint)
    }
    return this.stateVars
  }

  public createStateVariable(name: string, typeName: TypeName) {
    this.stateVars.push(createStateVariableDeclaration([createVariableDeclaration(name, typeName, true)]))
  }

  public createUniverse(nodes: Identifier[])  {
    const createUniverseForEachIdentifier = (node: Identifier) => {
      const checker = generateNewVarName(node.name + "_checker")
      const store = generateNewVarName(node.name + "_store")

      this.createStateVariable(checker,
        createMapping(node.typeName! as ElementaryTypeName, createElementaryTypeName("boolean")))
      this.createStateVariable(checker, createArray(node.typeName!))
      return [checker, store]
    }
    const map = new Map()
    nodes.forEach((it) => map.set(it.name, createUniverseForEachIdentifier(it)))
    return map
  }

  private Sum(node: Sum) {
    this.createStateVariable(node.name, node.typeName!)
    node.universe = this.createUniverse([...node.mu, ...node.free])
  }

  private Forall(node: Forall) {
    node.universe = this.createUniverse(node.mu)
  }
}
