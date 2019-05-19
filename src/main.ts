import parser, { visit } from 'solidity-parser-antlr';
import fs from 'fs'
import { ANTLRInputStream, CommonTokenStream } from 'antlr4ts';
import { SolidityLexer } from './antlr/SolidityLexer';
import { SolidityParser } from './antlr/SolidityParser';
import { ConstraintBuilder } from './constraints/ConstraintBuilder';
import { Decorator } from './constraints/Decorator';
import { Printer } from './printer/Printer';
import { VariableCollector } from './visitors/VariableCollector';

const contract = fs.readFileSync('./tests/test.sol')
const constraint = fs.readFileSync('./tests/constraints.txt')

const ast = parser.parse(contract.toString('utf-8'), {range: true})
const variableCollector = new VariableCollector()
visit(ast, variableCollector)

const inputStream = new ANTLRInputStream(constraint.toString('utf-8'))
const lexer = new SolidityLexer(inputStream)
const tokenStream = new CommonTokenStream(lexer)
const p = new SolidityParser(tokenStream)
const visitor = new ConstraintBuilder()
const node = visitor.visit(p.sourceUnit())
const decorator = new Decorator(visitor.constraint, visitor.variables)
decorator.visit(ast)
const printer = new Printer(contract.toString('utf-8'))
visit(ast, printer)
fs.writeFileSync('./tests/out.sol', printer.source)
console.log(printer.source)