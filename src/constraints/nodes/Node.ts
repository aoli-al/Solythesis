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
  left: Expresssion
  right: Expresssion
}

export interface Identifier extends BaseNode {
  type: "Identifier"
  name: string
  isMu: boolean
}

export interface Forall extends BaseNode {
  type: "ForAllExpression"
  memoryLocation: Map<string, number>
  index: string
  name: string[]
  mu: Identifier[]
  universe: Map<string, [string, string]>
  muWithTypes: Map<string, ElementaryTypeName>
  unboundedMu: Set<string>
  condition: Expresssion
}

export interface Sum extends BaseNode {
  type: "SumExpression"
  mu: Identifier[]
  free: Identifier[]
  expression: Expresssion
  condition: Expresssion
  cacheName: string
  name: string
  universe: Map<string, [string, string]>
  muWithTypes: Map<string, ElementaryTypeName>
  unboundedMu: Set<string>
}

export interface IndexedAccess extends BaseNode {
  type: "IndexedAccess"
  object: Expresssion
  index: Identifier
}

export interface MemberAccess extends BaseNode {
  type: "MemberAccess"
  expression: Expresssion
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
  | Expresssion

export type Expresssion =
  | IndexedAccess
  | BinaryExpression
  | MemberAccess
  | Identifier
  | PrimaryExpression

export type QuantityExp =
  | Sum
  | Forall


export const ExpressionTypes: SyntaxKind[] = ["PrimaryExpression", "BinaryExpression", "IndexedAccess",
  "MemberAccess", "Identifier"]
