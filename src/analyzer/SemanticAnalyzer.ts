import assert from "assert"
import { ElementaryTypeName, Mapping, StateVariableDeclaration, TypeName} from "solidity-parser-antlr"
import { ConstraintVisitor } from "../visitors/ConstraintVisitor"
import { QuantityExp, Identifier, ForAllExpression, IndexedAccess, BinaryExpression, ComparisonOpList,
   PrimaryExpression, MemberAccess, SumExpression, Node } from "../constraints/nodes/Node"
import { createElementaryTypeName, createMapping, equal, equalType, createArray } from "../constraints/utilities"
import { PositionMuVarAnalyzer } from "./PositionMuVarAnalyzer"
import { generateNewVarName } from "../constraints/ConstraintBuilder"

export class StandardSemanticAnalyzer extends ConstraintVisitor {
  public contractVars: Map<string, TypeName>
  public muTypeMap: Map<string, TypeName> = new Map()
  public muVars: Set<string> = new Set()
  public expectedType?: TypeName
  constructor(contractVars: Map<string, TypeName>) {
    super()
    this.contractVars = contractVars
  }

  public analysis(constraint: Node) {
    this.muTypeMap = new Map()
    this.muVars = new Set()
    this.visit(constraint)
  }

  public createUniverse(nodes: Identifier[])  {
    const createUniverseForEachIdentifier = (node: Identifier) => {
      const checker = generateNewVarName(node.name + "_checker")
      const store = generateNewVarName(node.name + "_store")
      this.contractVars.set(checker,
        createMapping(node.typeName! as ElementaryTypeName, createElementaryTypeName("bool")))
      this.contractVars.set(store, createArray(node.typeName!))
      return [checker, store]
    }
    const map = new Map()
    nodes.forEach((it) => map.set(it.name, createUniverseForEachIdentifier(it)))
    return map
  }

  public ForAllExpression = (node: ForAllExpression) => {
    this.muVars = new Set(node.mu.map((it) => it.name))
    assert(this.muVars.size === node.mu.length, "You can not declare two \
      free variables with the same name.")
    this.expectedType = createElementaryTypeName("boolean")
    this.visit(node.condition)
    this.expectedType = undefined
    node.mu.forEach((it) => this.visit(it))
    node.universe = this.createUniverse(node.mu)
    new PositionMuVarAnalyzer(node).run()
    node.muWithTypes = this.muTypeMap
  }

  public SumExpression = (node: SumExpression) => {
    this.muVars = new Set([...node.mu, ...node.free].map((it) => it.name))
    assert(this.muVars.size === node.mu.length + node.free.length, "You can not declare two \
      free variables with the same name.")
    this.expectedType = createElementaryTypeName("uint256")
    this.visit(node.expression)
    this.expectedType = createElementaryTypeName("boolean")
    this.visit(node.condition)
    this.expectedType = undefined
    node.free.forEach((it) => this.visit(it))
    node.mu.forEach((it) => this.visit(it))
    const typeStack = node.mu.map((it) => it.typeName!)
    typeStack.push(createElementaryTypeName("uint256"))
    const createMappingRecursive = (stack: TypeName[]): TypeName => {
      if (stack.length === 1) {
        return stack[0]
      }
      return createMapping(stack[0] as ElementaryTypeName, createMappingRecursive(stack.slice(1)))
    }
    node.typeName = createMappingRecursive(typeStack)
    this.contractVars.set(node.name, node.typeName)
    node.universe = this.createUniverse([...node.mu, ...node.free])
    new PositionMuVarAnalyzer(node).run()
    node.muWithTypes = this.muTypeMap
  }

  public Identifier = (node: Identifier) => {
    if (this.muVars.has(node.name)) {
      node.isMu = true
      if (this.muTypeMap.has(node.name)) {
        if (this.expectedType) {
          assert(equalType(this.expectedType, this.muTypeMap.get(node.name)!), "type conflict")
        }
        node.typeName = this.muTypeMap.get(node.name)!
      }
      if (this.expectedType) {
        if (this.muTypeMap.has(node.name)) {
          assert(equalType(this.expectedType, this.muTypeMap.get(node.name)!), "type conflict")
        } else {
          this.muTypeMap.set(node.name, this.expectedType)
        }
        node.typeName = this.expectedType
      }
      return
    } else if (this.contractVars.has(node.name)) {
      node.isMu = false
      node.typeName = this.contractVars.get(node.name)!
      return
    }
    assert(false, "Undeclared variable.")
  }

  public IndexedAccess = (node: IndexedAccess) => {
    this.visit(node.object)
    assert(node.object.typeName && node.object.typeName.type === "Mapping",
      "wrong type for indexed expression")
    if (this.expectedType) {
      assert(equalType(this.expectedType, (node.object.typeName as Mapping).valueType),
        "wrong expected type")
    }
    this.expectedType = (node.object.typeName as Mapping).keyType
    this.visit(node.index)
    this.expectedType = undefined

    node.typeName = (node.object.typeName as Mapping).valueType
  }

  public BinaryExpression = (node: BinaryExpression) => {
    if (ComparisonOpList.includes(node.op) || node.op === "&&") {
      if (this.expectedType) {
        assert(this.expectedType.type === "ElementaryTypeName" &&
          this.expectedType.name === "boolean")
      }
      node.typeName = createElementaryTypeName("boolean")
    } else {
      if (this.expectedType) {
        assert(this.expectedType.type === "ElementaryTypeName" &&
          this.expectedType.name === "uint256")
      }
      node.typeName = createElementaryTypeName("uint256")
    }
    this.expectedType = undefined
    this.visit(node.left)
    this.expectedType = node.left.typeName
    this.visit(node.right)
    this.expectedType = undefined
  }

  public MemberAccess = (node: MemberAccess) => {
    this.visit(node.expression)
    node.typeName = createElementaryTypeName("uint256")
  }

}
