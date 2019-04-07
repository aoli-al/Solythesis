import { Type } from "../types/Type";
import { IdentifierContext } from "../../antlr/SolidityParser";

interface Expression {
  [key: string]: any;
  parent?: Node
  children: Node[]
  type: SyntaxKind
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
  type: 'PrimaryExpression'
  value: String
}

export interface BinaryExpression extends Expression {
  op: BinOp
  left: Exp
  right: Exp
}

export interface MuExpression extends BinaryExpression {
  type: 'MuExpression'
  left: MuExp
  right: MuExp
}

export interface SExpression extends BinaryExpression {
  type: 'SExpression'
  left: SExp
  right: SExp
}

export interface CMPExpression extends BinaryExpression {
  type: 'CMPExpression'
  op: ComparisonOp
}

export interface Identifier extends Expression {
  name: string
}

export interface SIdentifier extends Identifier {
  type: "SIdentifier"
}

export interface MuIdentifier extends Identifier {
  type: 'MuIdentifier'
}

export interface ForAllExpression extends Expression {
  type: 'ForAllExpression'
  mu: Iden
  constraint: Node
}

export interface SumExpression extends Expression {
  type: 'SumExpression'
  mu: Iden
  body: MuExp
  constraint: Node
  name: string
}

export interface IndexedAccess extends Expression {
  object: SIdentifier
  index: Exp
}

export interface SIndexedAccess extends IndexedAccess {
  type: 'SIndexedAccess'
  index: SExp
}

export interface MuIndexedAccess extends IndexedAccess {
  type: 'MuIndexedAccess'
  index: MuIdentifier
}

export interface DummyNode extends Expression {
  type: 'DummyNode'
}

export type SyntaxKind =
  | 'PrimaryExpression'
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
  | ForAllExpression
  | SumExpression
  | PrimaryExpression
  | CMPExpression
  | MuExp
  | SExp

export type MuExp = 
  | MuExpression
  | MuIndexedAccess
  | PrimaryExpression
  | MuIdentifier

export type SExp =
  | SExpression
  | SIndexedAccess
  | SumExpression
  | SIdentifier
  | PrimaryExpression

export type Exp =
  | SExp
  | MuExp

export type Iden =
  | SIdentifier
  | MuIdentifier

export const SExpTypes: SyntaxKind[] = ['SExpression', 'SIndexedAccess',
  'SumExpression', 'SIdentifier', 'PrimaryExpression']
export const MuExpTypes: SyntaxKind[] = ['MuExpression', 'MuIndexedAccess', 'PrimaryExpression']