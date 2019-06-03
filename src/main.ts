import { ANTLRInputStream, CommonTokenStream } from "antlr4ts"
import fs from "fs"
import parser, { StateVariableDeclaration, visit } from "solidity-parser-antlr"
import { SolidityLexer } from "./antlr/SolidityLexer"
import { SolidityParser } from "./antlr/SolidityParser"
import { ConstraintBuilder } from "./constraints/ConstraintBuilder"
import { QuantityExp } from "./constraints/nodes/Node"
import { AssertionDectorator } from "./constraints/AssertionVarDecorator"
import { GenStateVariables as StateVariableGenerator } from "./constraints/StateVariableGenerator"
import { Printer } from "./printer/Printer"
import { VariableCollector } from "./visitors/VariableCollector"

const contract = fs.readFileSync(process.argv[2])
const constraint = fs.readFileSync(process.argv[3])

const ast = parser.parse(contract.toString("utf-8"), {range: true})
const variableCollector = new VariableCollector()
visit(ast, variableCollector)

const inputStream = new ANTLRInputStream(constraint.toString("utf-8"))
const lexer = new SolidityLexer(inputStream)
const tokenStream = new CommonTokenStream(lexer)
const p = new SolidityParser(tokenStream)
const constraintBuilder = new ConstraintBuilder()
const stateVarGen = new StateVariableGenerator(variableCollector.variables)

const stateVars: Map<string, StateVariableDeclaration[]> = new Map()
constraintBuilder.visit(p.sourceUnit())
constraintBuilder.constraint.forEach((constraints, c) => {
  stateVars.set(c,
    constraints
      .filter((it) => it.type === "ForAllExpression" || it.type === "SumExpression")
      .map((it) => stateVarGen.analysis(it as QuantityExp)).reduce((left, right) => [...left, ...right]))
})
const decorator =
  new AssertionDectorator([...constraintBuilder.constraint.values()].reduce((left, right) => [...left, ...right]),
    stateVars, stateVarGen.contractVars, true, true)
decorator.visit(ast)
const printer = new Printer(contract.toString("utf-8"))
visit(ast, printer)

function fileNameAndExt(path: string): [string, string] {
  return [path.substr(0, path.lastIndexOf(".")), path.substr(path.lastIndexOf(".") + 1, path.length)]
}
const [file, ext] = fileNameAndExt(process.argv[2])

fs.writeFileSync(file + "_secured." + ext, printer.source)
console.log(printer.source)
