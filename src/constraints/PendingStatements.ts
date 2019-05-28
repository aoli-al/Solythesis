import { Statement } from "solidity-parser-antlr"

export class PendingStatements {
  public pre: Statement[]
  public post: Statement[]

  constructor(pre: Statement[] = [], post: Statement[] = []) {
    this.pre = pre
    this.post = post
  }

  public merge(stmts?: PendingStatements) {
    if (stmts) {
      this.pre.push(...stmts.pre)
      this.post.push(...stmts.post)
    }
  }

  public isEmpty() {
    return this.pre.length === 0 && this.post.length === 0
  }
}
