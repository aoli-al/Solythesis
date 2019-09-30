import assert from "assert"
import { ElementaryTypeName, Mapping, StateVariableDeclaration, TypeName} from "solidity-parser-antlr"
import { ConstraintVisitor } from "src/visitors/ConstraintVisitor"
import { QuantityExp, Identifier, Forall, IndexedAccess, BinaryExpression, ComparisonOpList,
   PrimaryExpression, MemberAccess, Sum } from "src/constraints/nodes/Node"
import { createElementaryTypeName, createMapping } from "src/constraints/utilities"
import { NameValueContext } from "src/antlr/SolidityParser"

export class StandardSemanticAnalyzer extends ConstraintVisitor {
  public contractVars: Map<string, TypeName>
  public muTypeMap: Map<string, TypeName> = new Map()
  public muVars: Set<string> = new Set()
  public expectedType?: TypeName
  constructor(contractVars: Map<string, TypeName>) {
    super()
    this.contractVars = contractVars
  }

  public analysis(constraint: QuantityExp) {
    this.muTypeMap = new Map()
    this.visit(constraint)
  }

  public Forall = (node: Forall) => {
    this.muVars = new Set(node.mu.map((it) => it.name))
    assert(this.muVars.size === node.mu.length, "You can not declare two \
      free variables with the same name.")
    this.expectedType = createElementaryTypeName("boolean")
    this.visit(node.condition)
    node.mu.forEach((it) => this.visit(it))
  }

  public Sum = (node: Sum) => {
    this.muVars = new Set([...node.mu, ...node.free].map((it) => it.name))
    assert(this.muVars.size === node.mu.length + node.free.length, "You can not declare two \
      free variables with the same name.")
    this.expectedType = createElementaryTypeName("uint256")
    this.visit(node.expression)
    this.expectedType = createElementaryTypeName("boolean")
    this.visit(node.condition)
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
  }

  public Identifier = (node: Identifier) => {
    if (this.muVars.has(node.name)) {
      node.isMu = true
      if (this.muTypeMap.has(node.name)) {
        if (this.expectedType) {
          assert(this.expectedType === this.muTypeMap.get(node.name), "type conflict")
        }
        node.typeName = this.muTypeMap.get(node.name)!
      }
      if (this.expectedType) {
        if (this.muTypeMap.has(node.name)) {
          assert(this.expectedType === this.muTypeMap.get(node.name), "type conflict")
        } else {
          this.muTypeMap.set(node.name, this.expectedType)
        }
        node.typeName = this.expectedType
      }
    } else if (this.contractVars.has(node.name)) {
      node.isMu = false
      node.typeName = this.contractVars.get(node.name)!
    }
    assert(false, "Undeclared variable.")
  }

  public IndexedAccess = (node: IndexedAccess) => {
    this.visit(node.object)
    assert(node.object.typeName && node.object.typeName.type === "Mapping",
      "wrong type for indexed expression")
    if (this.expectedType) {
      assert(this.expectedType === (node.object.typeName as Mapping).valueType,
        "wrong expected type")
    }
    this.expectedType = (node.object.typeName as Mapping).keyType
    this.visit(node.index)
    this.expectedType = undefined

    node.typeName = (node.object.typeName as Mapping).valueType
  }

  public BinaryExpression = (node: BinaryExpression) => {
    if (node.op in ComparisonOpList || node.op === "&&") {
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
    this.visit(node.left)
    this.expectedType = node.left.typeName
    this.visit(node.right)
  }

  public MemberAccess = (node: MemberAccess) => {
    this.visit(node.expression)
    node.typeName = createElementaryTypeName("uint256")
  }

}
