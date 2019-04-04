import { Type } from "../types/Type";

export interface Node {
  parent?: Node
  children: Node[]
  kind: SyntaxKind
}

export interface Expression extends Node { 
  type: Type
}

export interface PrimaryExpression extends Expression {
  value: String
  kind: SyntaxKind.PrimaryExpression
}

export interface BinaryExpression extends Expression {
  kind: SyntaxKind.BinaryExpression
  left: Node
  right: Node
  operator: string
}

export interface Identifier extends Expression {
  kind: SyntaxKind.Identifier
  name: string
}

export interface ForAllExpression extends Expression {
  kind: SyntaxKind.ForAllExpression
  mu: Node
  constraint: Node
}

export interface SumExpression extends Expression {
  kind: SyntaxKind.SumExpression
  mu: Node
  body: Node
  constraint: Node
}

export interface IndexedAccess extends Expression {
  kind: SyntaxKind.IndexedAccess
  object: Node
  index: Node
}

export const enum SyntaxKind {
  PrimaryExpression,
  BinaryExpression,
  ForAllExpression,
  SumExpression,
  IndexedAccess,
  DummyNode,
  Identifier,
}