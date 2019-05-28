import { IndexAccess, Visitor } from "solidity-parser-antlr"
import { equal } from "../constraints/utilities"

export class IndexAccessCollector implements Visitor {
  public nodes: IndexAccess[] = []

  public IndexAccess = (node: IndexAccess) => {
    if (this.nodes.filter((it) => equal(node, it)).length > 0) { return }
    this.nodes.push(node)
    return false
  }
}
