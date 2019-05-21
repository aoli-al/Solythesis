import parser, { visit, StateVariableDeclaration } from 'solidity-parser-antlr';
import fs from 'fs'
import { ANTLRInputStream, CommonTokenStream } from 'antlr4ts';
import { SolidityLexer } from './antlr/SolidityLexer';
import { SolidityParser } from './antlr/SolidityParser';
import { ConstraintBuilder } from './constraints/ConstraintBuilder';
import { Decorator } from './constraints/Decorator';
import { Printer } from './printer/Printer';
import { VariableCollector } from './visitors/VariableCollector';
import { GenStateVariables as StateVariableGenerator } from './constraints/StateVariableGenerator';
import { QuantityExp } from './constraints/nodes/Node';

const contract = fs.readFileSync('./tests/test.sol')
const constraint = fs.readFileSync('./tests/constraints.txt')

const ast = parser.parse(contract.toString('utf-8'), {range: true})
const variableCollector = new VariableCollector()
visit(ast, variableCollector)

const inputStream = new ANTLRInputStream(constraint.toString('utf-8'))
const lexer = new SolidityLexer(inputStream)
const tokenStream = new CommonTokenStream(lexer)
const p = new SolidityParser(tokenStream)
const constraintBuilder = new ConstraintBuilder()
const stateVarGen = new StateVariableGenerator(variableCollector.variables)

const stateVars: Map<string, StateVariableDeclaration[]> = new Map()
constraintBuilder.visit(p.sourceUnit())
constraintBuilder.constraint.forEach((constraints, contract) => {
  stateVars.set(contract,
    constraints
      .filter(it => it.type == 'ForAllExpression' || it.type == 'SumExpression')
      .map(it => stateVarGen.analysis(it as QuantityExp)).reduce((left, right) => [...left, ...right]))
})
const decorator =
  new Decorator([...constraintBuilder.constraint.values()].reduce((left, right) => [...left, ...right]),
    stateVars)
decorator.visit(ast)
const printer = new Printer(contract.toString('utf-8'))
visit(ast, printer)
fs.writeFileSync('./tests/out.sol', printer.source)
console.log(printer.source)