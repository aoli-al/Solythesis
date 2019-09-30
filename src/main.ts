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
import { ConstraintsCollector } from "./constraints/ConstraintsCollector";
import { StandardSemanticAnalyzer } from "./analyzer/SemanticAnalyzer"

function generate(contractPath: string, constraintPath: string,
                  postfix: string, stateVarOpt: boolean, forallOpt: boolean) {
  const contract = fs.readFileSync(contractPath)
  const constraint = fs.readFileSync(process.argv[3])
  const ast = parser.parse(contract.toString("utf-8"), { range: true })
  const variableCollector = new VariableCollector()
  visit(ast, variableCollector)

  const inputStream = new ANTLRInputStream(constraint.toString("utf-8"))
  const lexer = new SolidityLexer(inputStream)
  const tokenStream = new CommonTokenStream(lexer)
  const p = new SolidityParser(tokenStream)
  const constraintBuilder = new ConstraintBuilder()
  constraintBuilder.visit(p.sourceUnit())
  const constraints = [...constraintBuilder.constraint.values()].reduce((left, right) => [...left, ...right])
  const semanticAnalyzer = new StandardSemanticAnalyzer(variableCollector.variables)
  constraints.forEach((it) => semanticAnalyzer.visit(it))

  const stateVarGen = new StateVariableGenerator(forallOpt)
  const stateVars: Map<string, StateVariableDeclaration[]> = new Map()
  constraintBuilder.constraint.forEach((cons, contr) => {
    stateVars.set(contr,
      cons
        .filter((it) => it.type === "ForAllExpression" || it.type === "SumExpression")
        .map((it) => stateVarGen.analysis(it as QuantityExp)).reduce((left, right) => [...left, ...right]))
  })
  const constraintsCollector = new ConstraintsCollector(constraints)
  constraintsCollector.visit(ast)
  const decorator =
    new AssertionDectorator(constraints, constraintsCollector.functionConstraints,
      stateVars, semanticAnalyzer.contractVars, stateVarOpt, forallOpt)
  decorator.visit(ast)
  const printer = new Printer(contract.toString("utf-8"))
  visit(ast, printer)

  function fileNameAndExt(path: string): [string, string] {
    return [path.substr(0, path.lastIndexOf(".")), path.substr(path.lastIndexOf(".") + 1, path.length)]
  }
  const [file, ext] = fileNameAndExt(process.argv[2])

  fs.writeFileSync(file + "_" + postfix + "." + ext, printer.source)

}

generate(process.argv[2], process.argv[3], "secured", true, true)
generate(process.argv[2], process.argv[3], "noopt", false, false)
