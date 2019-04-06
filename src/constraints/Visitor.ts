import { Node, SumExpression, ForAllExpression, SExpression, MuExpression, PrimaryExpression, SIndexedAccess, MuIdentifier, SIdentifier, CMPExpression } from "./nodes/Node";
import { callbackify } from "util";
import { Expression } from "solidity-parser-antlr";

export interface Visitor {
  [key: string]: ((node: any) => any) | undefined
  SumExpression?: (node: SumExpression) => any
  ForAllExpression?: (node: ForAllExpression) => any
  SExpression?: (node: SExpression) => any
  MuExpression?: (node: MuExpression) => any
  PrimaryExpression?: (node: PrimaryExpression) => any
  SIndexedAccess: (node: SIndexedAccess) => any
  MuIdentifier: (node: MuIdentifier) => any
  SIdentifier: (node: SIdentifier) => any
  CMPExpression: (node: CMPExpression) => any
}