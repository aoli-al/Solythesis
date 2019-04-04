import { Node } from "./nodes/Node";

export type Visitor = (node: Node) => boolean;
interface IVisitor {
  visit(item: Node): any;
}