import assert from "assert"
import { ElementaryTypeName, Mapping, StateVariableDeclaration, TypeName } from "solidity-parser-antlr"
import { ConstraintVisitor } from "../visitors/ConstraintVisitor"
import {ForAllExpression, MuIndexedAccess, QuantityExp, SIdentifier, SumExpression } from "./nodes/Node"
import {
  createArray, createBaseASTNode, createElementaryTypeName, createMapping,
  createStateVariableDeclaration, createVariableDeclaration,
} from "./utilities"

let counter = 0
export function generateNewVarName(base: string) {
  return base + "_" + (counter++).toString()
}

export class GenStateVariables extends ConstraintVisitor {
  public currentTypeName?: TypeName
  public contractVars: Map<string, TypeName>
  public stateVariables: StateVariableDeclaration[] = []
  public muWithTypes: Map<string, ElementaryTypeName> = new Map()
  public dynamicArrays: number = 0
  public forallOptimization: boolean
  constructor(contractVars: Map<string, TypeName>, globalMemory: boolean = true) {
    super()
    this.contractVars = contractVars
    this.forallOptimization = globalMemory
  }
  public analysis(constraint: QuantityExp) {
    this.muWithTypes = new Map()
    this.stateVariables = []
    this.visit(constraint)
    this.stateVariables.forEach((it) => {
      this.contractVars.set(it.variables[0].name, it.variables[0].typeName)
    })
    return this.stateVariables
  }

  public MuIndexedAccess = (node: MuIndexedAccess) => {
    this.visit(node.object)
    if (!this.currentTypeName || this.currentTypeName.type !== "Mapping") { return }
    if (this.muWithTypes.has(node.index.name)) {
      assert((this.muWithTypes.get(node.index.name) as ElementaryTypeName).name === this.currentTypeName.keyType.name)
    } else {
      this.muWithTypes.set(node.index.name, this.currentTypeName.keyType)
    }
    this.currentTypeName = this.currentTypeName.valueType
  }

  public SIdentifier = (node: SIdentifier) => {
    this.currentTypeName = this.contractVars.get(node.name)
  }

  public createStateVariable(name: string, typeStack: TypeName[]) {
    const createMappingRecursive = (stack: TypeName[]): TypeName => {
      if (stack.length === 1) {
        return stack[0]
      }
      return createMapping(stack[0] as ElementaryTypeName, createMappingRecursive(stack.slice(1)))
    }
    const variables = [createVariableDeclaration(name,
      typeStack.length === 1 ? typeStack[0] : createMappingRecursive(typeStack), true)]
    this.stateVariables.push(createStateVariableDeclaration(variables))
  }

  public SumExpression = (node: SumExpression) => {
    const typeStack: ElementaryTypeName[] = []
    this.visit(node.body)
    this.visit(node.constraint)
    node.free = node.free.filter((it) => this.muWithTypes.has(it.name))
    node.free.forEach((it) => {
      typeStack.push(this.muWithTypes.get(it.name)!)
    })
    if (node.constraint.type === "MuIndexedAccess") {
      typeStack.push(this.currentTypeName! as ElementaryTypeName)
    }
    typeStack.push(createElementaryTypeName("uint256"))
    this.createStateVariable(node.name, typeStack)
  }

  public ForAllExpression = (node: ForAllExpression) => {
    if (node.constraint.type === "CMPExpression") {
      node.name = [generateNewVarName("cmp")]
      this.createStateVariable(node.name[0], [createElementaryTypeName("uint256")])
    } else {
      this.visit(node.constraint)
      node.mu = node.mu.filter((it) => this.muWithTypes.has(it.name))
      node.muWithTypes = this.muWithTypes
      node.name = []
      node.memoryLocation = new Map()
      node.index = generateNewVarName("index")
      node.mu.forEach((it) => {
        const name = generateNewVarName(it.name + "_addr")
        if (this.forallOptimization) {
          this.createStateVariable(name, [createElementaryTypeName("uint256")])
          node.memoryLocation.set(it.name, this.dynamicArrays)
          this.dynamicArrays += 1
        } else {
          this.createStateVariable(it.name, [createArray(node.muWithTypes.get(it.name)!)])
        }
        node.name.push(name)
      })
      this.createStateVariable(node.index, [createElementaryTypeName("uint256")])
    }
  }
}
