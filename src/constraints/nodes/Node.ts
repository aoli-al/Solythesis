import { ElementaryTypeName, TypeName } from "solidity-parser-antlr"

interface BaseNode {
  parent?: Node
  children: Node[]
  type: SyntaxKind
  typeName?: TypeName
}

export type ArithmeticOp =
  | "+"
  | "-"
  | "*"
  | "/"

export type ComparisonOp =
  | "<"
  | ">"
  | "<="
  | ">="
  | "=="
  | "!="

export const ComparisonOpList = ["<", ">", "<=", ">=", "==", "!="]

export type TypeString =
  | "boolean"
  | "number"

export type BinOp =
  | ArithmeticOp
  | ComparisonOp
  | "&&"

export interface PrimaryExpression extends BaseNode {
  type: "PrimaryExpression"
  value: string
  typeName: ElementaryTypeName
}

export interface BinaryExpression extends BaseNode {
  type: "BinaryExpression"
  op: BinOp
  left: Expression
  right: Expression
}

export interface Identifier extends BaseNode {
  type: "Identifier"
  name: string
  isMu: boolean
}

export interface ForAllExpression extends BaseNode {
  type: "ForAllExpression"
  memoryLocation: Map<string, number>
  index: string
  muStateVars: Map<string, string>
  mu: Identifier[]
  universe: Map<string, [string, string]>
  muWithTypes: Map<string, ElementaryTypeName>
  unboundedMu: Set<string>
  positionMuVarMap: Map<string, Expression>
  positionMuVarAssertions: Expression[]
  positionMuDependencyMap: Map<string, Set<string>>
  condition: Expression
}

export interface SumExpression extends BaseNode {
  type: "SumExpression"
  mu: Identifier[]
  free: Identifier[]
  expression: Expression
  condition: Expression
  cacheName: string
  name: string
  universe: Map<string, [string, string]>
  muWithTypes: Map<string, ElementaryTypeName>
  positionMuVarMap: Map<string, Expression>
  positionMuVarAssertions: Expression[]
  positionMuDependencyMap: Map<string, Set<string>>
  unboundedMu: Set<string>
}

export interface IndexedAccess extends BaseNode {
  type: "IndexedAccess"
  object: Expression
  index: Identifier
}

export interface MemberAccess extends BaseNode {
  type: "MemberAccess"
  expression: Expression
  memberName: string
}

export interface DummyNode extends BaseNode {
  type: "DummyNode"
}

export type SyntaxKind =
  | "PrimaryExpression"
  | "ForAllExpression"
  | "SumExpression"
  | "DummyNode"
  | "IndexedAccess"
  | "Identifier"
  | "MemberAccess"
  | "BinaryExpression"

export type Node =
  | DummyNode
  | QuantityExp
  | Expression

export type Expression =
  | IndexedAccess
  | BinaryExpression
  | MemberAccess
  | Identifier
  | PrimaryExpression

export type QuantityExp =
  | SumExpression
  | ForAllExpression

export const ExpressionTypes: SyntaxKind[] = ["PrimaryExpression", "BinaryExpression", "IndexedAccess",
  "MemberAccess", "Identifier"]
