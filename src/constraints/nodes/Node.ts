import { Type } from "../types/Type";
import { IdentifierContext } from "../../antlr/SolidityParser";

interface Expression {
  parent?: Node
  children: Node[]
  kind: SyntaxKind
}

export type ArithmeticOp = 
  | '+'
  | '-'
  | '*'
  | '/'

export type ComparisonOp = 
  | '<'
  | '>'
  | '<='
  | '>='
  | '=='
  | '!='

export const ComparisonOpList = ['<', '>', '<=', '>=', '==', '!=']

export type BinOp =
  | ArithmeticOp
  | ComparisonOp

export interface PrimaryExpression extends Expression {
  kind: 'PrimaryExpression'
  value: String
}

export interface MuExpression extends Expression {
  kind: 'MuExpression'
  op: BinOp
  left: MuExp
  right: MuExp
}

export interface SExpression extends Expression{
  kind: 'SExpression'
  op: BinOp
  left: SExp
  right: SExp
}

export interface CMPExpression extends Expression{
  kind: 'CMPExpression'
  op: ComparisonOp
  left: Exp
  right: Exp
}

export interface Identifier extends Expression {
  name: string
}

export interface SIdentifier extends Identifier {
  kind: "SIdentifier"
}

export interface MuIdentifier extends Identifier {
  kind: 'MuIdentifier'
}

export interface ForAllExpression extends Expression {
  kind: 'ForAllExpression'
  mu: Identifier
  constraint: Node
}

export interface SumExpression extends Expression {
  kind: 'SumExpression'
  mu: Identifier
  body: MuExp
  constraint: Node
}

export interface IndexedAccess extends Expression {
  object: Node
}

export interface SIndexedAccess extends IndexedAccess {
  kind: 'SIndexedAccess'
  index: SExp
}

export interface MuIndexedAccess extends IndexedAccess {
  kind: 'MuIndexedAccess'
  index: MuIdentifier
}

export interface DummyNode extends Expression {
  kind: 'DummyNode'
}

export type SyntaxKind =
  | 'PrimaryExpression'
  | 'BinaryExpression'
  | 'ForAllExpression'
  | 'SumExpression'
  | 'SIndexedAccess'
  | 'MuIndexedAccess'
  | 'DummyNode'
  | 'MuIdentifier'
  | 'SIdentifier'
  | 'MuExpression'
  | 'SExpression'
  | 'CMPExpression'

export type Node = 
  | DummyNode
  | IndexedAccess
  | ForAllExpression
  | SumExpression
  | Identifier
  | PrimaryExpression
  | CMPExpression
  | MuExp
  | SExp

export type MuExp = 
  | MuExpression
  | MuIndexedAccess
  | PrimaryExpression

export type SExp =
  | SExpression
  | SIndexedAccess
  | SumExpression
  | SIdentifier
  | PrimaryExpression

export type Exp =
  | SExp
  | MuExp

export const SExpTypes: SyntaxKind[] = ['SExpression', 'SIndexedAccess',
  'SumExpression', 'SIdentifier', 'PrimaryExpression']
export const MuExpTypes: SyntaxKind[] = ['MuExpression', 'MuIndexedAccess', 'PrimaryExpression']