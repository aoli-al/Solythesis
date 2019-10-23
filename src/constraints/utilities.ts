import * as dot from "graphlib-dot"
import parser, { SourceUnit, ContractDefinition, FunctionDefinition,
  SimpleStatement, ForStatement, UnaryOperation, UnaryOp } from "solidity-parser-antlr"
import {
  ArrayTypeName, ASTNode, ASTNodeTypeString, BaseASTNode, BinaryOperation, BinOp, Block, ElementaryTypeName,
  Expression, ExpressionStatement, FunctionCall, Identifier, IfStatement, IndexAccess, Mapping, MemberAccess,
  NumberLiteral, Statement, TypeName, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration,
} from "solidity-parser-antlr"
import * as surya from "surya"
import {
  Node,
  SyntaxKind,
} from "./nodes/Node"
import { generateNewVarName } from "./StateVariableGenerator"

function Node(this: Node, kind: SyntaxKind) {
  this.children = []
  this.type = kind
  this.parent = undefined
}

function BaseASTNode(this: BaseASTNode, type: ASTNodeTypeString) {
  this.type = type
}

export let objectAllocator = {
  getBaseASTNodeConstructor: () => BaseASTNode as any,
  getNodeConstructor: () => Node as any,
}

export function createNode(kind: SyntaxKind): Node {
  return new (objectAllocator.getNodeConstructor())(kind)
}

export function createBaseASTNode(type: ASTNodeTypeString) {
  return new (objectAllocator.getBaseASTNodeConstructor())(type)
}

export function createForloop(body: Statement,
                              initExpression?: SimpleStatement,
                              conditionExpression?: Expression,
                              loopExpression?: ExpressionStatement) {
  const forLoop = createBaseASTNode("ForStatement") as ForStatement
  forLoop.initExpression = initExpression
  forLoop.conditionExpression = conditionExpression
  forLoop.loopExpression = loopExpression
  forLoop.body = body
  return forLoop
}

export function createBlock(statements: Statement[]) {
  const node = createBaseASTNode("Block") as Block
  node.statements = statements
  return node
}

export function createIdentifier(name: string) {
  const node = createBaseASTNode("Identifier") as Identifier
  node.name = name
  return node
}

export function createStateVariableDeclaration(variables: VariableDeclaration[],
                                               initialValue?: Expression) {
  const node = createBaseASTNode("StateVariableDeclaration") as StateVariableDeclaration
  node.variables = variables
  node.initialValue = initialValue
  return node
}

export function createElementaryTypeName(name: string) {
  const node = createBaseASTNode("ElementaryTypeName") as ElementaryTypeName
  node.name = name
  return node
}

export function createNumberLiteral(value: string) {
  const node = createBaseASTNode("NumberLiteral") as NumberLiteral
  node.number = value
  return node
}

export function createVariableDeclaration(name: string, type: TypeName, stateVar: boolean, storageLocation?: string) {
  const node = createBaseASTNode("VariableDeclaration") as VariableDeclaration
  node.name = name
  node.isStateVar = stateVar
  node.typeName = type
  node.storageLocation = storageLocation
  if (type.type === "Mapping" || type.type === "ArrayTypeName") {
    node.isIndexed = true
  } else {
    node.isIndexed = false
  }
  return node
}

export function createVariableDeclarationStmt(variables: VariableDeclaration[], initValue?: Expression) {
  const node = createBaseASTNode("VariableDeclarationStatement") as VariableDeclarationStatement
  node.variables = variables
  if (initValue) {
    node.initialValue = initValue
    variables.forEach((it) => it.expression = initValue)
  }
  return node
}

export function createMemberAccess(expression: Expression, memberName: string) {
  const node = createBaseASTNode("MemberAccess") as MemberAccess
  node.expression = expression
  node.memberName = memberName
  return node
}

export function createIfStatment(condition: Expression, trueBody: Statement, falseBody?: Statement) {
  const node = createBaseASTNode("IfStatement") as IfStatement
  node.condition = condition
  node.trueBody = trueBody
  node.falseBody = falseBody
  return node
}

export function createSafeBinaryOperation(left: Expression, right: Expression, op: "+="|"-=") {
  const opMap = {
    "+=": ["+", ">="],
    "-=": ["-", "<="],
  }
  createBinaryOperation(createBinaryOperation(left, right, opMap[op][0] as BinOp), left, ">=")
}

export function createFunctionCall(expression: Expression, args: Expression[] = [], names: string[] = []) {
  const node = createBaseASTNode("FunctionCall") as FunctionCall
  node.expression = expression
  node.arguments = args
  node.names = names
  return node
}

export function createIndexAccess(base: Expression, index: Expression) {
  const node = createBaseASTNode("IndexAccess") as IndexAccess
  node.base = base
  node.index = index
  return node
}

export function createUnaryOperation(base: Expression, operator: UnaryOp) {
  const node = createBaseASTNode("UnaryOperation") as UnaryOperation
  node.isPrefix = true
  node.subExpression = base
  node.operator = operator
  return node
}

export function createMapping(keyType: ElementaryTypeName, valueType: TypeName) {
  const node = createBaseASTNode("Mapping") as Mapping
  node.keyType = keyType
  node.valueType = valueType
  return node
}

export function createArray(baseTypeName: TypeName, length?: Expression) {
  const node = createBaseASTNode("ArrayTypeName") as ArrayTypeName
  node.baseTypeName = baseTypeName
  node.length = length
  return node
}

export function createBinaryOperation(left: Expression, right: Expression, op: BinOp) {
  const node = createBaseASTNode("BinaryOperation") as BinaryOperation
  node.left = left
  node.right = right
  node.operator = op
  return node
}

export function createExpressionStmt(expression: Expression) {
  const node = createBaseASTNode("ExpressionStatement") as ExpressionStatement
  node.expression = expression
  return node
}

export function getChildren(node: Node): Node[] {
  switch (node.type) {
    case "BinaryExpression": {
      return [node.left, node.right]
    }
    case "ForAllExpression": {
      return [...node.mu, node.condition]
    }
    case "SumExpression": {
      return [...node.mu, ...node.free, node.expression, node.condition]
    }
    case "IndexedAccess": {
      return [node.object, node.index]
    }
  }
  return []
}

export function getSVariables(node: Node): Set<string> {
  switch (node.type) {
    case "Identifier": {
      if (!node.isMu) {
        return new Set([node.name])
      }
    }
  }
  return getChildren(node)
    .map(getSVariables)
    .reduce((accumulator, set) => new Set([...accumulator, ...set]), new Set())
}

export function getMonitoredVariables(node: Node): Set<string> {
  switch (node.type) {
    case "Identifier": {
      if (!node.isMu) {
        return new Set([node.name])
      }
    }
  }
  return getChildren(node)
    .map((name) => getMonitoredVariables(name))
    .reduce((accumulator, set) => new Set([...accumulator, ...set]), new Set())
}

// export function getMuIndices(node: Node, stateVar: string): string[] {
//   switch (node.type) {
//     case "MuIndexedAccess": {
//       if (node.object.type === "SIdentifier" && node.object.name === stateVar) {
//         return [node.index.name]
//       } else {
//         const indecis = getMuIndices(node.object, stateVar)
//         if (indecis.length > 0) {
//           return [...indecis, node.index.name]
//         }
//       }
//     }
//   }
//   return getChildren(node).map((it) => getMuIndices(it, stateVar)).reduce((left, right) => {
//     if (left.length > 0) { return left } else { return right }
//   }, [])
// }

export function createIndexAccessRecursive(object: Expression, expressions: Expression[]): Expression {
  if (expressions.length === 0) { return object }
  const indexAccess = createIndexAccess(object, expressions[0])
  return createIndexAccessRecursive(indexAccess, expressions.slice(1))
}

export function getUpdatedVariable(node: Expression): string {
  switch (node.type) {
    case "Identifier": return node.name
    case "IndexAccess": return getUpdatedVariable(node.base)
    case "MemberAccess": return getUpdatedVariable(node.expression)
  }
  return ""
}

export function checkSafeAdd(left: Expression, right: Expression) {
  const statements: Statement[] = []
  const tmpVar = createIdentifier(generateNewVarName("tmp"))
  statements.push(createVariableDeclarationStmt(
    [createVariableDeclaration(tmpVar.name, createElementaryTypeName("uint256"), false)],
    createBinaryOperation(left, right, "+")))
  statements.push(
    createExpressionStmt(createFunctionCall(createIdentifier("assert"), [createBinaryOperation(tmpVar, left, ">=")])))
  return createBlock(statements)
}

export function getIndexAccessBase(indexAccess: IndexAccess): Expression {
  if (indexAccess.base.type !== "IndexAccess") { return indexAccess.base }
  return getIndexAccessBase(indexAccess.base)
}

export function checkSafeSub(left: Expression, right: Expression) {
  return createExpressionStmt(
    createFunctionCall(createIdentifier("assert"), [createBinaryOperation(left, right, ">=")]))
}

export function equal(a: Expression, b: Expression): boolean {
  if (a === undefined) { return b === undefined }
  if (b.type !== a.type) { return false }
  const c = b as any
  switch (a.type) {
    case "BinaryOperation":
      return equal(a.left, c.left) && equal(a.right, c.right)
    case "BooleanLiteral":
      return a.value === c.value
    case "Identifier":
      return a.name === c.name
    case "IndexAccess":
      return equal(a.base, c.base) && equal(a.index, c.index)
    case "MemberAccess":
      return a.memberName === c.memberName && equal(a.expression, c.expression)
    case "NumberLiteral":
      return a.number === c.number
    case "FunctionCall":
      return equal(a.expression, c.expression)
        && a.arguments.length === c.arguments.length
        && a.arguments.filter((value, idx) => !equal(value, c.arguments[idx])).length === 0
    case "ElementaryTypeNameExpression":
        return a.typeName.name === c.typeName.name
  }
  return false
}

export function equalType(a: TypeName, b: TypeName): boolean {
  if (a.type !== b.type) { return false }
  const c = b as any
  switch (a.type) {
    case "ArrayTypeName":
      return equalType(a.baseTypeName, c.baseTypeName) && equal(a.length!, c.length!)
    case "ElementaryTypeName":{
      if (a.name === "uint" || a.name === "uint256") {
        return c.name === "uint256" || c.name === "uint"
      } else {
        return a.name === c.name
      }
    }
    case "Mapping":
        return equalType(a.keyType, c.keyType) && equalType(a.valueType, c.valueType)
  }
  return false
}

export function resolveFunctionName(a: Expression) {
  if (a.type === "Identifier") {
    return a.name
  } else if (a.type === "MemberAccess" && a.expression.type === "Identifier") {
    return a.memberName
  }
  return "unknown"
}

export function canOptimize(contract: string, caller: string) {
  const result = surya.ftrace(contract + "::" + caller, "all", [process.argv[2]]) as string
  return !result.includes("🛑")
}

const rawGraph = (surya.graph([process.argv[2]]) as string).split("\n").slice(0, -25).join("\n") + "}"

export function getCallers(contract: string, caller: string): string[] {
  const graph = dot.read(rawGraph)
  const stack = [contract + "." + caller]
  const visited = new Set(stack)
  return graph.predecessors(stack.pop()!) as string []
  // return result.split("\n").slice(1).map((desc) => {
  //   const [left, right] = desc.split("::")
  //   return [left.split(" ").slice(-1)[0], right.split(" ")[0]]
  // })
}

export function getSubFunctions(contract: string, caller: string): Array<[string, string]> {
  const graph = dot.read(rawGraph)
  const stack = [contract + "." + caller]
  const visited = new Set(stack)
  while (stack.length !== 0) {
    const children = graph.successors(stack.pop()!)
    if (children) {
      children.forEach((it) => {
        if (!visited.has(it)) {
          visited.add(it)
          stack.push(it)
        }
      })
    }
  }
  visited.delete(contract + "." + caller)
  return [...visited].map((it) => it.split(".") as [string, string])
  // return result.split("\n").slice(1).map((desc) => {
  //   const [left, right] = desc.split("::")
  //   return [left.split(" ").slice(-1)[0], right.split(" ")[0]]
  // })
}

function getInlineAssembly(assembly: string) {
  const ast = parser.parse(assembly, {}) as SourceUnit
  return ((ast.children[0] as ContractDefinition).subNodes[0] as FunctionDefinition).body!.statements[0]
}

export function createGlobalArray(localName: string, globalName: string) {
  const template = `
  contract C {
    function check() public  {
      assembly {
        ${localName} := mload(0x40)
        mstore(0x40, add(${localName}, 0x280))
        sstore(${globalName}_slot, ${localName})
        mstore(${localName}, 0x260)
      }
    }
  }
  `
  return getInlineAssembly(template)
}

export function loadGlobalArray(localName: string, globalName: string) {
  const template = `
  contract C {
    function check() public  {
      assembly {
        ${localName} := sload(${globalName}_slot)
      }
    }
  }
  `
  return getInlineAssembly(template)
}

export function storeArrayValue(array: string, index: string, value: string) {
  const template = `
  contract C {
    function check() public  {
      assembly {
        mstore(add(${array}, mul(sload(${index}_slot), 32)), ${value})
      }
    }
  }
  `
  return getInlineAssembly(template)
}

export function loadArrayValue(array: string, index: string, variable: string) {
  const template = `
  contract C {
    function check() public  {
      assembly {
        ${variable} := mload(add(${array}, mul(${index}, 32)))
      }
    }
  }
  `
  return getInlineAssembly(template)
}
