import { Visitor, SourceUnit, Expression, ExpressionStatement, BinaryOperation, visit, IndexAccess, IfStatement, VariableDeclaration, VariableDeclarationStatement, StateVariableDeclaration, Identifier, ElementaryTypeName, NumberLiteral, BooleanLiteral, MemberAccess, ASTNode, ContractDefinition, Block, Mapping, FunctionDefinition, FunctionCall, ArrayTypeName} from "solidity-parser-antlr";

export class Printer implements Visitor {
  originSource: string
  source: string = ""

  constructor(originSource: string) {
    this.originSource = originSource
  }

  visitOrPrint(node: ASTNode | ASTNode[]) {
    if (Array.isArray(node)) {
      node.forEach(it => this.visitOrPrint(it))
      return 
    }
    if (node.type in this) {
      visit(node, this)
    }
    else {
      if (node.range) {
        this.source += this.originSource.substr(node.range[0], node.range[1] - node.range[0] + 1)
      }
    }
  }

  VariableDeclaration = (node: VariableDeclaration) => {
    this.visitOrPrint(node.typeName)
    if (node.visibility && node.visibility != 'default') {
      this.source += ' ' + node.visibility
    }
    if (node.isDeclaredConst) {
      this.source += ' constant'
    }
    if (node.storageLocation) {
      this.source += ' ' + node.storageLocation
    }
    this.source += ' ' + node.name
    return false
  }

  StateVariableDeclaration = (node: StateVariableDeclaration) => {
    this.visitOrPrint(node.variables)
    if (node.initialValue) {
      this.source += ' = '
      this.visitOrPrint(node.initialValue)
    }
    this.source += ';'
    return false
  }

  SourceUnit = (node: SourceUnit) => {
    node.children.forEach(it => {
      this.visitOrPrint(it)
      this.source += '\n'
    })
    return false
  }

  Mapping = (node: Mapping) => {
    this.source += 'mapping ('
    this.visitOrPrint(node.keyType)
    this.source += '=>'
    this.visitOrPrint(node.valueType)
    this.source += ')'
    return false
  }

  FunctionDefinition = (node: FunctionDefinition) => {
    if (node.isConstructor) {
      this.source += 'constructor '
    }
    else {
      this.source += 'function '
    }
    if (node.name) {
      this.source += node.name + ' '
    }
    this.visitOrPrint(node.parameters)
    node.modifiers.forEach(it => {
      this.source += ' '
      this.visitOrPrint(it)
    })
    if (node.visibility != 'default') {
      this.source += ' ' + node.visibility
    }
    if (node.stateMutability) {
      this.source += ' ' + node.stateMutability
    }
    if (node.returnParameters) {
      this.source += ' '
      this.visitOrPrint(node.returnParameters)
    }
    if (node.body) {
      this.source += ' '
      this.visitOrPrint(node.body)
    }
    else {
      this.source += ';'
    }
    return false
  }

  ContractDefinition = (node: ContractDefinition) => {
    this.source += node.kind + ' ' + node.name
    if (node.baseContracts.length > 0) {
      this.source += ' is '
      this.visitOrPrint(node.baseContracts[0])
      node.baseContracts.slice(1).forEach(it => {
        this.source += ', '
        this.visitOrPrint(it)
      })
    }
    this.source += ' {\n'
    node.subNodes.forEach(it => {
      this.visitOrPrint(it)
      this.source += '\n'
    })
    this.source += '}'
    return false
  }

  BinaryOperation = (node: BinaryOperation) => {
    this.visitOrPrint(node.left)
    this.source += ' ' + node.operator + ' '
    this.visitOrPrint(node.right)
    return false
  }

  IfStatement = (node: IfStatement) => {
    this.source += 'if ('
    this.visitOrPrint(node.condition)
    this.source += ') '
    this.visitOrPrint(node.trueBody)
    if (node.falseBody) {
      this.source += ' else '
      this.visitOrPrint(node.falseBody)
    }
    return false
  }

  FunctionCall = (node: FunctionCall) => {
    this.visitOrPrint(node.expression)
    this.source += '('
    if (node.names.length > 0) {
      this.source += '{ '
      for (var i = 0; i < node.names.length; i++) {
        this.source += node.names[i] + ' : '
        this.visitOrPrint(node.arguments[i])
        if (i != node.names.length - 1) {
          this.source += ', '
        }
      }
      this.source += ' }'
    }
    else {
      for (var i = 0; i < node.arguments.length; i++) {
        this.visitOrPrint(node.arguments[i])
        if (i != node.arguments.length - 1) {
          this.source += ', '
        }
      }
    }
    this.source += ')'
    return false
  }

  ElementaryTypeName = (node: ElementaryTypeName) => {
    this.source += node.name
  }

  NumberLiteral = (node: NumberLiteral) => {
    this.source += node.number
  }

  BooleanLiteral = (node: BooleanLiteral) => {
    this.source += node.value.toString()
  }

  Block = (node: Block) => {
    this.source += '{\n'
    node.statements.forEach(it => {
      this.visitOrPrint(it)
      this.source += '\n'
    })
    this.source += '}'
    return false
  }

  VariableDeclarationStatement = (node: VariableDeclarationStatement) => {
    if (node.variables.length > 1) {
      this.source += '('
      this.visitOrPrint(node.variables[0])
      node.variables.slice(1).forEach((it: ASTNode) => {
        this.source += ', '
        this.visitOrPrint(it)
      })
      this.source += ')'
    }
    else {
      this.visitOrPrint(node.variables[0])
    }
    if (node.initialValue) {
      this.source += ' = '
      this.visitOrPrint(node.initialValue)
    }
    this.source += ';'
    return false
  }

  Identifier = (node: Identifier) => {
    this.source += node.name
  }

  ArrayTypeName = (node: ArrayTypeName) => {
    this.visitOrPrint(node.baseTypeName)
    this.source += '['
    if (node.length) {
      this.visitOrPrint(node.length)
    }
    this.source += ']'
    return false
  }

  MemberAccess = (node: MemberAccess) => {
    this.visitOrPrint(node.expression)
    this.source += '.' + node.memberName
    return false
  }

  ExpressionStatement = (node: ExpressionStatement) => {
    this.visitOrPrint(node.expression)
    this.source += ';'
    return false
  }
  
  IndexAccess = (node: IndexAccess) => {
    this.visitOrPrint(node.base)
    this.source += '['
    this.visitOrPrint(node.index)
    this.source += ']'
    return false
  }
}