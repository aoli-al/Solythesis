import assert from "assert"
import { ElementaryTypeName, Mapping, StateVariableDeclaration, TypeName } from "solidity-parser-antlr"
import { ConstraintVisitor } from "../visitors/ConstraintVisitor"
import {ForAllExpression, QuantityExp, SumExpression, Identifier } from "./nodes/Node"
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
    this.stateVars = []
    this.createUniverse(constraint)
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

  public createUniverse(node: QuantityExp)  {
    node.unboundedMu.forEach((it) => {
      const [checker, store] = node.universe.get(it)!
      this.createStateVariable(checker,
        createMapping(node.muWithTypes.get(it)! as ElementaryTypeName, createElementaryTypeName("bool")))
      this.createStateVariable(store, createArray(node.muWithTypes.get(it)!))
    })
  }

  private Sum(node: SumExpression) {
    this.createStateVariable(node.name, node.typeName!)
  }

  private Forall(node: ForAllExpression) {
    node.memoryLocation = new Map()
    node.mu.filter((it) => !node.unboundedMu.has(it.name)).forEach((it) => {
      const name = generateNewVarName(it.name + "_addr")
      if (this.forallOptimization) {
        this.createStateVariable(name, createElementaryTypeName("uint256"))
        node.memoryLocation.set(it.name, this.dynamicArrays)
        this.dynamicArrays += 1
      } else {
        this.createStateVariable(it.name, createArray(node.muWithTypes.get(it.name)!))
      }
      node.muStateVars.set(it.name, name)
    })
    if (node.mu.length !== node.unboundedMu.size) {
      this.createStateVariable(node.index, createElementaryTypeName("uint256"))
    }
  }
}
