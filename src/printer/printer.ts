import {
  ArrayTypeName, ASTNode, BinaryOperation, Block, BooleanLiteral, ContractDefinition, ElementaryTypeName,
  Expression, ExpressionStatement, ForStatement, FunctionCall, FunctionDefinition, Identifier, IfStatement,
  IndexAccess, Mapping, MemberAccess, NumberLiteral, SourceUnit, StateVariableDeclaration, VariableDeclaration,
  VariableDeclarationStatement, visit, Visitor, InlineAssemblyStatement, AssemblyBlock, AssemblyAssignment, AssemblyCall, HexNumber, DecimalNumber, UnaryOp, UnaryOperation, AssemblyLocalDefinition, TupleExpression, ReturnStatement,
} from "solidity-parser-antlr"

export class Printer implements Visitor {
  public originSource: string
  public source: string = ""

  constructor(originSource: string) {
    this.originSource = originSource
  }

  public visitOrPrint(node?: ASTNode | ASTNode[]) {
    if (node) {
      if (Array.isArray(node)) {
        node.forEach((it) => this.visitOrPrint(it))
        return
      }
      if (node.type in this) {
        visit(node, this)
      } else {
        if (node.range) {
          this.source += this.originSource.substr(node.range[0], node.range[1] - node.range[0] + 1)
        }
      }
    }
  }

  public VariableDeclaration = (node: VariableDeclaration) => {
    this.visitOrPrint(node.typeName)
    if (node.visibility && node.visibility !== "default") {
      this.source += " " + node.visibility
    }
    if (node.isDeclaredConst) {
      this.source += " constant"
    }
    if (node.storageLocation) {
      this.source += " " + node.storageLocation
    }
    this.source += " " + node.name
    return false
  }

  public StateVariableDeclaration = (node: StateVariableDeclaration) => {
    this.visitOrPrint(node.variables)
    if (node.initialValue) {
      this.source += " = "
      this.visitOrPrint(node.initialValue)
    }
    this.source += ";"
    return false
  }

  public SourceUnit = (node: SourceUnit) => {
    node.children.forEach((it) => {
      this.visitOrPrint(it)
      this.source += "\n"
    })
    return false
  }

  public Mapping = (node: Mapping) => {
    this.source += "mapping ("
    this.visitOrPrint(node.keyType)
    this.source += "=>"
    this.visitOrPrint(node.valueType)
    this.source += ")"
    return false
  }

  public FunctionDefinition = (node: FunctionDefinition) => {
    if (node.isConstructor) {
      this.source += "constructor "
    } else {
      this.source += "function "
    }
    if (node.name) {
      this.source += node.name + " "
    }
    this.visitOrPrint(node.parameters)
    node.modifiers.forEach((it) => {
      this.source += " "
      this.visitOrPrint(it)
    })
    if (node.visibility !== "default") {
      this.source += " " + node.visibility
    }
    if (node.stateMutability) {
      this.source += " " + node.stateMutability
    }
    if (node.returnParameters) {
      this.source += " "
      this.visitOrPrint(node.returnParameters)
    }
    if (node.body) {
      this.source += " "
      this.visitOrPrint(node.body)
    } else {
      this.source += ";"
    }
    return false
  }

  public ContractDefinition = (node: ContractDefinition) => {
    this.source += node.kind + " " + node.name
    if (node.baseContracts.length > 0) {
      this.source += " is "
      this.visitOrPrint(node.baseContracts[0])
      node.baseContracts.slice(1).forEach((it) => {
        this.source += ", "
        this.visitOrPrint(it)
      })
    }
    this.source += " {\n"
    node.subNodes.forEach((it) => {
      this.visitOrPrint(it)
      this.source += "\n"
    })
    this.source += "}"
    return false
  }

  public InlineAssemblyStatement = (node: InlineAssemblyStatement) => {
    this.source += "assembly "
    if (node.language) {
      this.source += node.language + " "
    }
    this.visitOrPrint(node.body)
    return false
  }

  public AssemblyBlock = (node: AssemblyBlock) => {
    this.source += "{\n"
    node.operations.forEach((it) => {
      this.visitOrPrint(it)
      this.source += "\n"
    })
    this.source += "}\n"
    return false
  }

  public AssemblyLocalDefinition = (node: AssemblyLocalDefinition) => {
    this.source += "let "
    node.names.forEach((it, index) => {
      this.visitOrPrint(it)
      if (index !== node.names.length - 1) {
        this.source += ", "
      }
    })
    this.source += " := "
    this.visitOrPrint(node.expression)
    return false
  }

  public TupleExpression = (node: TupleExpression) => {
    this.source += "("
    node.components.forEach((it, index) => {
      this.visitOrPrint(it)
      if (index !== node.components.length - 1) {
        this.source += ", "
      }
    })
    this.source += ")"
    return false
  }

  public ReturnStatement = (node: ReturnStatement) => {
    this.source += "return "
    if (node.expression) {
      this.visitOrPrint(node.expression)
    }
    this.source += ";"
    return false
  }

  public AssemblyAssignment = (node: AssemblyAssignment) => {
    this.source += node.names.map((it) => it.name).join(",") + " := "
    this.visitOrPrint(node.expression)
    return false
  }

  public AssemblyCall = (node: AssemblyCall) => {
    this.source += node.functionName
    if (node.arguments.length > 0) {
      this.source += "("
      node.arguments.forEach((it, index) => {
        this.visitOrPrint(it)
        if (index !== node.arguments.length - 1) {
          this.source += ", "
        }
      })
      this.source += ")"
    }
    return false
  }

  public HexNumber = (node: HexNumber) => {
    this.source += node.value
    return false
  }

  public DecimalNumber = (node: DecimalNumber) => {
    this.source += node.value
    return false
  }

  public BinaryOperation = (node: BinaryOperation) => {
    this.visitOrPrint(node.left)
    this.source += " " + node.operator + " "
    this.visitOrPrint(node.right)
    return false
  }

  public IfStatement = (node: IfStatement) => {
    this.source += "if ("
    this.visitOrPrint(node.condition)
    this.source += ") "
    this.visitOrPrint(node.trueBody)
    if (node.falseBody) {
      this.source += " else "
      this.visitOrPrint(node.falseBody)
    }
    return false
  }

  public ForStatement = (node: ForStatement) => {
    this.source += "for ("
    if (node.initExpression) { this.visitOrPrint(node.initExpression) } else { this.source += ";" }
    this.source += " "
    this.visitOrPrint(node.conditionExpression)
    this.source += "; "
    if (node.loopExpression) {
      this.visitOrPrint(node.loopExpression.expression)
    }
    this.source += ") "
    this.visitOrPrint(node.body)
    return false
  }

  public FunctionCall = (node: FunctionCall) => {
    this.visitOrPrint(node.expression)
    this.source += "("
    if (node.names.length > 0) {
      this.source += "{ "
      for (let i = 0; i < node.names.length; i++) {
        this.source += node.names[i] + " : "
        this.visitOrPrint(node.arguments[i])
        if (i !== node.names.length - 1) {
          this.source += ", "
        }
      }
      this.source += " }"
    } else {
      for (let i = 0; i < node.arguments.length; i++) {
        this.visitOrPrint(node.arguments[i])
        if (i !== node.arguments.length - 1) {
          this.source += ", "
        }
      }
    }
    this.source += ")"
    return false
  }

  public ElementaryTypeName = (node: ElementaryTypeName) => {
    this.source += node.name
  }

  public NumberLiteral = (node: NumberLiteral) => {
    this.source += node.number
  }

  public BooleanLiteral = (node: BooleanLiteral) => {
    this.source += node.value.toString()
  }

  public Block = (node: Block) => {
    this.source += "{\n"
    node.statements.forEach((it) => {
      this.visitOrPrint(it)
      this.source += "\n"
    })
    this.source += "}\n"
    return false
  }

  public VariableDeclarationStatement = (node: VariableDeclarationStatement) => {
    if (node.variables.length > 1) {
      this.source += "("
      this.visitOrPrint(node.variables[0])
      node.variables.slice(1).forEach((it: ASTNode) => {
        this.source += ", "
        this.visitOrPrint(it)
      })
      this.source += ")"
    } else {
      this.visitOrPrint(node.variables[0])
    }
    if (node.initialValue) {
      this.source += " = "
      this.visitOrPrint(node.initialValue)
    }
    this.source += ";"
    return false
  }

  public Identifier = (node: Identifier) => {
    this.source += node.name
  }

  public UnaryOperation = (node: UnaryOperation) => {
    if (node.isPrefix) {
      this.source += node.operator + " "
    }
    this.visitOrPrint(node.subExpression)
    if (!node.isPrefix) {
      this.source += " " + node.operator
    }
    return false
  }

  public ArrayTypeName = (node: ArrayTypeName) => {
    this.visitOrPrint(node.baseTypeName)
    this.source += "["
    if (node.length) {
      this.visitOrPrint(node.length)
    }
    this.source += "]"
    return false
  }

  public MemberAccess = (node: MemberAccess) => {
    this.visitOrPrint(node.expression)
    this.source += "." + node.memberName
    return false
  }

  public ExpressionStatement = (node: ExpressionStatement) => {
    this.visitOrPrint(node.expression)
    this.source += ";"
    return false
  }

  public IndexAccess = (node: IndexAccess) => {
    this.visitOrPrint(node.base)
    this.source += "["
    this.visitOrPrint(node.index)
    this.source += "]"
    return false
  }
}
