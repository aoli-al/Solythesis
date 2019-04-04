// Generated from ./src/antlr/Solidity.g4 by ANTLR 4.7.3-SNAPSHOT


import { ATN } from "antlr4ts/atn/ATN";
import { ATNDeserializer } from "antlr4ts/atn/ATNDeserializer";
import { FailedPredicateException } from "antlr4ts/FailedPredicateException";
import { NotNull } from "antlr4ts/Decorators";
import { NoViableAltException } from "antlr4ts/NoViableAltException";
import { Override } from "antlr4ts/Decorators";
import { Parser } from "antlr4ts/Parser";
import { ParserRuleContext } from "antlr4ts/ParserRuleContext";
import { ParserATNSimulator } from "antlr4ts/atn/ParserATNSimulator";
import { ParseTreeListener } from "antlr4ts/tree/ParseTreeListener";
import { ParseTreeVisitor } from "antlr4ts/tree/ParseTreeVisitor";
import { RecognitionException } from "antlr4ts/RecognitionException";
import { RuleContext } from "antlr4ts/RuleContext";
//import { RuleVersion } from "antlr4ts/RuleVersion";
import { TerminalNode } from "antlr4ts/tree/TerminalNode";
import { Token } from "antlr4ts/Token";
import { TokenStream } from "antlr4ts/TokenStream";
import { Vocabulary } from "antlr4ts/Vocabulary";
import { VocabularyImpl } from "antlr4ts/VocabularyImpl";

import * as Utils from "antlr4ts/misc/Utils";

import { SolidityListener } from "./SolidityListener";
import { SolidityVisitor } from "./SolidityVisitor";


export class SolidityParser extends Parser {
	public static readonly T__0 = 1;
	public static readonly T__1 = 2;
	public static readonly T__2 = 3;
	public static readonly T__3 = 4;
	public static readonly T__4 = 5;
	public static readonly T__5 = 6;
	public static readonly T__6 = 7;
	public static readonly T__7 = 8;
	public static readonly T__8 = 9;
	public static readonly T__9 = 10;
	public static readonly T__10 = 11;
	public static readonly T__11 = 12;
	public static readonly T__12 = 13;
	public static readonly T__13 = 14;
	public static readonly T__14 = 15;
	public static readonly T__15 = 16;
	public static readonly T__16 = 17;
	public static readonly T__17 = 18;
	public static readonly T__18 = 19;
	public static readonly T__19 = 20;
	public static readonly T__20 = 21;
	public static readonly T__21 = 22;
	public static readonly T__22 = 23;
	public static readonly T__23 = 24;
	public static readonly T__24 = 25;
	public static readonly T__25 = 26;
	public static readonly T__26 = 27;
	public static readonly T__27 = 28;
	public static readonly T__28 = 29;
	public static readonly T__29 = 30;
	public static readonly T__30 = 31;
	public static readonly T__31 = 32;
	public static readonly T__32 = 33;
	public static readonly T__33 = 34;
	public static readonly T__34 = 35;
	public static readonly T__35 = 36;
	public static readonly T__36 = 37;
	public static readonly T__37 = 38;
	public static readonly T__38 = 39;
	public static readonly T__39 = 40;
	public static readonly T__40 = 41;
	public static readonly T__41 = 42;
	public static readonly T__42 = 43;
	public static readonly T__43 = 44;
	public static readonly T__44 = 45;
	public static readonly T__45 = 46;
	public static readonly T__46 = 47;
	public static readonly T__47 = 48;
	public static readonly T__48 = 49;
	public static readonly T__49 = 50;
	public static readonly T__50 = 51;
	public static readonly T__51 = 52;
	public static readonly T__52 = 53;
	public static readonly T__53 = 54;
	public static readonly T__54 = 55;
	public static readonly T__55 = 56;
	public static readonly T__56 = 57;
	public static readonly T__57 = 58;
	public static readonly T__58 = 59;
	public static readonly T__59 = 60;
	public static readonly T__60 = 61;
	public static readonly T__61 = 62;
	public static readonly T__62 = 63;
	public static readonly T__63 = 64;
	public static readonly T__64 = 65;
	public static readonly T__65 = 66;
	public static readonly T__66 = 67;
	public static readonly T__67 = 68;
	public static readonly T__68 = 69;
	public static readonly T__69 = 70;
	public static readonly T__70 = 71;
	public static readonly T__71 = 72;
	public static readonly T__72 = 73;
	public static readonly T__73 = 74;
	public static readonly T__74 = 75;
	public static readonly T__75 = 76;
	public static readonly T__76 = 77;
	public static readonly T__77 = 78;
	public static readonly T__78 = 79;
	public static readonly T__79 = 80;
	public static readonly T__80 = 81;
	public static readonly T__81 = 82;
	public static readonly T__82 = 83;
	public static readonly T__83 = 84;
	public static readonly T__84 = 85;
	public static readonly T__85 = 86;
	public static readonly T__86 = 87;
	public static readonly T__87 = 88;
	public static readonly T__88 = 89;
	public static readonly T__89 = 90;
	public static readonly T__90 = 91;
	public static readonly T__91 = 92;
	public static readonly T__92 = 93;
	public static readonly T__93 = 94;
	public static readonly Int = 95;
	public static readonly Uint = 96;
	public static readonly Byte = 97;
	public static readonly Fixed = 98;
	public static readonly Ufixed = 99;
	public static readonly VersionLiteral = 100;
	public static readonly BooleanLiteral = 101;
	public static readonly DecimalNumber = 102;
	public static readonly HexNumber = 103;
	public static readonly NumberUnit = 104;
	public static readonly HexLiteral = 105;
	public static readonly ReservedKeyword = 106;
	public static readonly AnonymousKeyword = 107;
	public static readonly BreakKeyword = 108;
	public static readonly ConstantKeyword = 109;
	public static readonly ContinueKeyword = 110;
	public static readonly ExternalKeyword = 111;
	public static readonly IndexedKeyword = 112;
	public static readonly InternalKeyword = 113;
	public static readonly PayableKeyword = 114;
	public static readonly PrivateKeyword = 115;
	public static readonly PublicKeyword = 116;
	public static readonly PureKeyword = 117;
	public static readonly ViewKeyword = 118;
	public static readonly Identifier = 119;
	public static readonly StringLiteral = 120;
	public static readonly WS = 121;
	public static readonly COMMENT = 122;
	public static readonly LINE_COMMENT = 123;
	public static readonly RULE_sourceUnit = 0;
	public static readonly RULE_pragmaDirective = 1;
	public static readonly RULE_pragmaName = 2;
	public static readonly RULE_pragmaValue = 3;
	public static readonly RULE_version = 4;
	public static readonly RULE_versionOperator = 5;
	public static readonly RULE_versionConstraint = 6;
	public static readonly RULE_importDeclaration = 7;
	public static readonly RULE_standardDefinition = 8;
	public static readonly RULE_constraint = 9;
	public static readonly RULE_importDirective = 10;
	public static readonly RULE_contractDefinition = 11;
	public static readonly RULE_inheritanceSpecifier = 12;
	public static readonly RULE_contractPart = 13;
	public static readonly RULE_stateVariableDeclaration = 14;
	public static readonly RULE_usingForDeclaration = 15;
	public static readonly RULE_structDefinition = 16;
	public static readonly RULE_constructorDefinition = 17;
	public static readonly RULE_modifierDefinition = 18;
	public static readonly RULE_modifierInvocation = 19;
	public static readonly RULE_functionDefinition = 20;
	public static readonly RULE_returnParameters = 21;
	public static readonly RULE_modifierList = 22;
	public static readonly RULE_eventDefinition = 23;
	public static readonly RULE_enumValue = 24;
	public static readonly RULE_enumDefinition = 25;
	public static readonly RULE_parameterList = 26;
	public static readonly RULE_parameter = 27;
	public static readonly RULE_eventParameterList = 28;
	public static readonly RULE_eventParameter = 29;
	public static readonly RULE_functionTypeParameterList = 30;
	public static readonly RULE_functionTypeParameter = 31;
	public static readonly RULE_variableDeclaration = 32;
	public static readonly RULE_typeName = 33;
	public static readonly RULE_userDefinedTypeName = 34;
	public static readonly RULE_mapping = 35;
	public static readonly RULE_functionTypeName = 36;
	public static readonly RULE_storageLocation = 37;
	public static readonly RULE_stateMutability = 38;
	public static readonly RULE_block = 39;
	public static readonly RULE_statement = 40;
	public static readonly RULE_expressionStatement = 41;
	public static readonly RULE_ifStatement = 42;
	public static readonly RULE_whileStatement = 43;
	public static readonly RULE_simpleStatement = 44;
	public static readonly RULE_forStatement = 45;
	public static readonly RULE_inlineAssemblyStatement = 46;
	public static readonly RULE_doWhileStatement = 47;
	public static readonly RULE_continueStatement = 48;
	public static readonly RULE_breakStatement = 49;
	public static readonly RULE_returnStatement = 50;
	public static readonly RULE_throwStatement = 51;
	public static readonly RULE_emitStatement = 52;
	public static readonly RULE_variableDeclarationStatement = 53;
	public static readonly RULE_variableDeclarationList = 54;
	public static readonly RULE_identifierList = 55;
	public static readonly RULE_elementaryTypeName = 56;
	public static readonly RULE_expression = 57;
	public static readonly RULE_forAllExpression = 58;
	public static readonly RULE_sumExpression = 59;
	public static readonly RULE_primaryExpression = 60;
	public static readonly RULE_expressionList = 61;
	public static readonly RULE_nameValueList = 62;
	public static readonly RULE_nameValue = 63;
	public static readonly RULE_functionCallArguments = 64;
	public static readonly RULE_functionCall = 65;
	public static readonly RULE_assemblyBlock = 66;
	public static readonly RULE_assemblyItem = 67;
	public static readonly RULE_assemblyExpression = 68;
	public static readonly RULE_assemblyCall = 69;
	public static readonly RULE_assemblyLocalDefinition = 70;
	public static readonly RULE_assemblyAssignment = 71;
	public static readonly RULE_assemblyIdentifierOrList = 72;
	public static readonly RULE_assemblyIdentifierList = 73;
	public static readonly RULE_assemblyStackAssignment = 74;
	public static readonly RULE_labelDefinition = 75;
	public static readonly RULE_assemblySwitch = 76;
	public static readonly RULE_assemblyCase = 77;
	public static readonly RULE_assemblyFunctionDefinition = 78;
	public static readonly RULE_assemblyFunctionReturns = 79;
	public static readonly RULE_assemblyFor = 80;
	public static readonly RULE_assemblyIf = 81;
	public static readonly RULE_assemblyLiteral = 82;
	public static readonly RULE_subAssembly = 83;
	public static readonly RULE_tupleExpression = 84;
	public static readonly RULE_elementaryTypeNameExpression = 85;
	public static readonly RULE_numberLiteral = 86;
	public static readonly RULE_identifier = 87;
	// tslint:disable:no-trailing-whitespace
	public static readonly ruleNames: string[] = [
		"sourceUnit", "pragmaDirective", "pragmaName", "pragmaValue", "version", 
		"versionOperator", "versionConstraint", "importDeclaration", "standardDefinition", 
		"constraint", "importDirective", "contractDefinition", "inheritanceSpecifier", 
		"contractPart", "stateVariableDeclaration", "usingForDeclaration", "structDefinition", 
		"constructorDefinition", "modifierDefinition", "modifierInvocation", "functionDefinition", 
		"returnParameters", "modifierList", "eventDefinition", "enumValue", "enumDefinition", 
		"parameterList", "parameter", "eventParameterList", "eventParameter", 
		"functionTypeParameterList", "functionTypeParameter", "variableDeclaration", 
		"typeName", "userDefinedTypeName", "mapping", "functionTypeName", "storageLocation", 
		"stateMutability", "block", "statement", "expressionStatement", "ifStatement", 
		"whileStatement", "simpleStatement", "forStatement", "inlineAssemblyStatement", 
		"doWhileStatement", "continueStatement", "breakStatement", "returnStatement", 
		"throwStatement", "emitStatement", "variableDeclarationStatement", "variableDeclarationList", 
		"identifierList", "elementaryTypeName", "expression", "forAllExpression", 
		"sumExpression", "primaryExpression", "expressionList", "nameValueList", 
		"nameValue", "functionCallArguments", "functionCall", "assemblyBlock", 
		"assemblyItem", "assemblyExpression", "assemblyCall", "assemblyLocalDefinition", 
		"assemblyAssignment", "assemblyIdentifierOrList", "assemblyIdentifierList", 
		"assemblyStackAssignment", "labelDefinition", "assemblySwitch", "assemblyCase", 
		"assemblyFunctionDefinition", "assemblyFunctionReturns", "assemblyFor", 
		"assemblyIf", "assemblyLiteral", "subAssembly", "tupleExpression", "elementaryTypeNameExpression", 
		"numberLiteral", "identifier",
	];

	private static readonly _LITERAL_NAMES: Array<string | undefined> = [
		undefined, "'pragma'", "';'", "'^'", "'~'", "'>='", "'>'", "'<'", "'<='", 
		"'='", "'as'", "'standard'", "'{'", "'}'", "'constraint'", "'import'", 
		"'*'", "'from'", "','", "'contract'", "'interface'", "'library'", "'is'", 
		"'('", "')'", "'using'", "'for'", "'struct'", "'constructor'", "'modifier'", 
		"'function'", "'returns'", "'event'", "'enum'", "'['", "']'", "'address'", 
		"'.'", "'mapping'", "'=>'", "'memory'", "'storage'", "'calldata'", "'if'", 
		"'else'", "'while'", "'assembly'", "'do'", "'return'", "'throw'", "'emit'", 
		"'var'", "'bool'", "'string'", "'byte'", "'++'", "'--'", "'new'", "'+'", 
		"'-'", "'after'", "'delete'", "'!'", "'**'", "'/'", "'%'", "'<<'", "'>>'", 
		"'&'", "'|'", "'=='", "'!='", "'&&'", "'||'", "'?'", "':'", "'|='", "'^='", 
		"'&='", "'<<='", "'>>='", "'+='", "'-='", "'*='", "'/='", "'%='", "'ForAll'", 
		"'Sum'", "'let'", "':='", "'=:'", "'switch'", "'case'", "'default'", "'->'", 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, "'anonymous'", 
		"'break'", "'constant'", "'continue'", "'external'", "'indexed'", "'internal'", 
		"'payable'", "'private'", "'public'", "'pure'", "'view'",
	];
	private static readonly _SYMBOLIC_NAMES: Array<string | undefined> = [
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, undefined, undefined, undefined, 
		undefined, undefined, undefined, undefined, "Int", "Uint", "Byte", "Fixed", 
		"Ufixed", "VersionLiteral", "BooleanLiteral", "DecimalNumber", "HexNumber", 
		"NumberUnit", "HexLiteral", "ReservedKeyword", "AnonymousKeyword", "BreakKeyword", 
		"ConstantKeyword", "ContinueKeyword", "ExternalKeyword", "IndexedKeyword", 
		"InternalKeyword", "PayableKeyword", "PrivateKeyword", "PublicKeyword", 
		"PureKeyword", "ViewKeyword", "Identifier", "StringLiteral", "WS", "COMMENT", 
		"LINE_COMMENT",
	];
	public static readonly VOCABULARY: Vocabulary = new VocabularyImpl(SolidityParser._LITERAL_NAMES, SolidityParser._SYMBOLIC_NAMES, []);

	// @Override
	// @NotNull
	public get vocabulary(): Vocabulary {
		return SolidityParser.VOCABULARY;
	}
	// tslint:enable:no-trailing-whitespace

	// @Override
	public get grammarFileName(): string { return "Solidity.g4"; }

	// @Override
	public get ruleNames(): string[] { return SolidityParser.ruleNames; }

	// @Override
	public get serializedATN(): string { return SolidityParser._serializedATN; }

	constructor(input: TokenStream) {
		super(input);
		this._interp = new ParserATNSimulator(SolidityParser._ATN, this);
	}
	// @RuleVersion(0)
	public sourceUnit(): SourceUnitContext {
		let _localctx: SourceUnitContext = new SourceUnitContext(this._ctx, this.state);
		this.enterRule(_localctx, 0, SolidityParser.RULE_sourceUnit);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 182;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__0) | (1 << SolidityParser.T__10) | (1 << SolidityParser.T__14) | (1 << SolidityParser.T__18) | (1 << SolidityParser.T__19) | (1 << SolidityParser.T__20))) !== 0)) {
				{
				this.state = 180;
				this._errHandler.sync(this);
				switch (this._input.LA(1)) {
				case SolidityParser.T__0:
					{
					this.state = 176;
					this.pragmaDirective();
					}
					break;
				case SolidityParser.T__14:
					{
					this.state = 177;
					this.importDirective();
					}
					break;
				case SolidityParser.T__18:
				case SolidityParser.T__19:
				case SolidityParser.T__20:
					{
					this.state = 178;
					this.contractDefinition();
					}
					break;
				case SolidityParser.T__10:
					{
					this.state = 179;
					this.standardDefinition();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				this.state = 184;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			this.state = 185;
			this.match(SolidityParser.EOF);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public pragmaDirective(): PragmaDirectiveContext {
		let _localctx: PragmaDirectiveContext = new PragmaDirectiveContext(this._ctx, this.state);
		this.enterRule(_localctx, 2, SolidityParser.RULE_pragmaDirective);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 187;
			this.match(SolidityParser.T__0);
			this.state = 188;
			this.pragmaName();
			this.state = 189;
			this.pragmaValue();
			this.state = 190;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public pragmaName(): PragmaNameContext {
		let _localctx: PragmaNameContext = new PragmaNameContext(this._ctx, this.state);
		this.enterRule(_localctx, 4, SolidityParser.RULE_pragmaName);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 192;
			this.identifier();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public pragmaValue(): PragmaValueContext {
		let _localctx: PragmaValueContext = new PragmaValueContext(this._ctx, this.state);
		this.enterRule(_localctx, 6, SolidityParser.RULE_pragmaValue);
		try {
			this.state = 196;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 2, this._ctx) ) {
			case 1:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 194;
				this.version();
				}
				break;

			case 2:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 195;
				this.expression(0);
				}
				break;
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public version(): VersionContext {
		let _localctx: VersionContext = new VersionContext(this._ctx, this.state);
		this.enterRule(_localctx, 8, SolidityParser.RULE_version);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 198;
			this.versionConstraint();
			this.state = 200;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__2) | (1 << SolidityParser.T__3) | (1 << SolidityParser.T__4) | (1 << SolidityParser.T__5) | (1 << SolidityParser.T__6) | (1 << SolidityParser.T__7) | (1 << SolidityParser.T__8))) !== 0) || _la === SolidityParser.VersionLiteral) {
				{
				this.state = 199;
				this.versionConstraint();
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public versionOperator(): VersionOperatorContext {
		let _localctx: VersionOperatorContext = new VersionOperatorContext(this._ctx, this.state);
		this.enterRule(_localctx, 10, SolidityParser.RULE_versionOperator);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 202;
			_la = this._input.LA(1);
			if (!((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__2) | (1 << SolidityParser.T__3) | (1 << SolidityParser.T__4) | (1 << SolidityParser.T__5) | (1 << SolidityParser.T__6) | (1 << SolidityParser.T__7) | (1 << SolidityParser.T__8))) !== 0))) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public versionConstraint(): VersionConstraintContext {
		let _localctx: VersionConstraintContext = new VersionConstraintContext(this._ctx, this.state);
		this.enterRule(_localctx, 12, SolidityParser.RULE_versionConstraint);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 205;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__2) | (1 << SolidityParser.T__3) | (1 << SolidityParser.T__4) | (1 << SolidityParser.T__5) | (1 << SolidityParser.T__6) | (1 << SolidityParser.T__7) | (1 << SolidityParser.T__8))) !== 0)) {
				{
				this.state = 204;
				this.versionOperator();
				}
			}

			this.state = 207;
			this.match(SolidityParser.VersionLiteral);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public importDeclaration(): ImportDeclarationContext {
		let _localctx: ImportDeclarationContext = new ImportDeclarationContext(this._ctx, this.state);
		this.enterRule(_localctx, 14, SolidityParser.RULE_importDeclaration);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 209;
			this.identifier();
			this.state = 212;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__9) {
				{
				this.state = 210;
				this.match(SolidityParser.T__9);
				this.state = 211;
				this.identifier();
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public standardDefinition(): StandardDefinitionContext {
		let _localctx: StandardDefinitionContext = new StandardDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 16, SolidityParser.RULE_standardDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 214;
			this.match(SolidityParser.T__10);
			this.state = 215;
			this.match(SolidityParser.Identifier);
			this.state = 216;
			this.match(SolidityParser.T__11);
			this.state = 220;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__16) | (1 << SolidityParser.T__24) | (1 << SolidityParser.T__26) | (1 << SolidityParser.T__27) | (1 << SolidityParser.T__28) | (1 << SolidityParser.T__29))) !== 0) || ((((_la - 32)) & ~0x1F) === 0 && ((1 << (_la - 32)) & ((1 << (SolidityParser.T__31 - 32)) | (1 << (SolidityParser.T__32 - 32)) | (1 << (SolidityParser.T__35 - 32)) | (1 << (SolidityParser.T__37 - 32)) | (1 << (SolidityParser.T__50 - 32)) | (1 << (SolidityParser.T__51 - 32)) | (1 << (SolidityParser.T__52 - 32)) | (1 << (SolidityParser.T__53 - 32)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
				{
				{
				this.state = 217;
				this.contractPart();
				}
				}
				this.state = 222;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			this.state = 223;
			this.constraint();
			this.state = 224;
			this.match(SolidityParser.T__12);
			this.state = 225;
			this.match(SolidityParser.EOF);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public constraint(): ConstraintContext {
		let _localctx: ConstraintContext = new ConstraintContext(this._ctx, this.state);
		this.enterRule(_localctx, 18, SolidityParser.RULE_constraint);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 227;
			this.match(SolidityParser.T__13);
			this.state = 228;
			this.expression(0);
			this.state = 229;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public importDirective(): ImportDirectiveContext {
		let _localctx: ImportDirectiveContext = new ImportDirectiveContext(this._ctx, this.state);
		this.enterRule(_localctx, 20, SolidityParser.RULE_importDirective);
		let _la: number;
		try {
			this.state = 265;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 11, this._ctx) ) {
			case 1:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 231;
				this.match(SolidityParser.T__14);
				this.state = 232;
				this.match(SolidityParser.StringLiteral);
				this.state = 235;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if (_la === SolidityParser.T__9) {
					{
					this.state = 233;
					this.match(SolidityParser.T__9);
					this.state = 234;
					this.identifier();
					}
				}

				this.state = 237;
				this.match(SolidityParser.T__1);
				}
				break;

			case 2:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 238;
				this.match(SolidityParser.T__14);
				this.state = 241;
				this._errHandler.sync(this);
				switch (this._input.LA(1)) {
				case SolidityParser.T__15:
					{
					this.state = 239;
					this.match(SolidityParser.T__15);
					}
					break;
				case SolidityParser.T__16:
				case SolidityParser.Identifier:
					{
					this.state = 240;
					this.identifier();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				this.state = 245;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if (_la === SolidityParser.T__9) {
					{
					this.state = 243;
					this.match(SolidityParser.T__9);
					this.state = 244;
					this.identifier();
					}
				}

				this.state = 247;
				this.match(SolidityParser.T__16);
				this.state = 248;
				this.match(SolidityParser.StringLiteral);
				this.state = 249;
				this.match(SolidityParser.T__1);
				}
				break;

			case 3:
				this.enterOuterAlt(_localctx, 3);
				{
				this.state = 250;
				this.match(SolidityParser.T__14);
				this.state = 251;
				this.match(SolidityParser.T__11);
				this.state = 252;
				this.importDeclaration();
				this.state = 257;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 253;
					this.match(SolidityParser.T__17);
					this.state = 254;
					this.importDeclaration();
					}
					}
					this.state = 259;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				this.state = 260;
				this.match(SolidityParser.T__12);
				this.state = 261;
				this.match(SolidityParser.T__16);
				this.state = 262;
				this.match(SolidityParser.StringLiteral);
				this.state = 263;
				this.match(SolidityParser.T__1);
				}
				break;
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public contractDefinition(): ContractDefinitionContext {
		let _localctx: ContractDefinitionContext = new ContractDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 22, SolidityParser.RULE_contractDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 267;
			_la = this._input.LA(1);
			if (!((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__18) | (1 << SolidityParser.T__19) | (1 << SolidityParser.T__20))) !== 0))) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			this.state = 268;
			this.identifier();
			this.state = 278;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__21) {
				{
				this.state = 269;
				this.match(SolidityParser.T__21);
				this.state = 270;
				this.inheritanceSpecifier();
				this.state = 275;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 271;
					this.match(SolidityParser.T__17);
					this.state = 272;
					this.inheritanceSpecifier();
					}
					}
					this.state = 277;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				}
			}

			this.state = 280;
			this.match(SolidityParser.T__11);
			this.state = 284;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__16) | (1 << SolidityParser.T__24) | (1 << SolidityParser.T__26) | (1 << SolidityParser.T__27) | (1 << SolidityParser.T__28) | (1 << SolidityParser.T__29))) !== 0) || ((((_la - 32)) & ~0x1F) === 0 && ((1 << (_la - 32)) & ((1 << (SolidityParser.T__31 - 32)) | (1 << (SolidityParser.T__32 - 32)) | (1 << (SolidityParser.T__35 - 32)) | (1 << (SolidityParser.T__37 - 32)) | (1 << (SolidityParser.T__50 - 32)) | (1 << (SolidityParser.T__51 - 32)) | (1 << (SolidityParser.T__52 - 32)) | (1 << (SolidityParser.T__53 - 32)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
				{
				{
				this.state = 281;
				this.contractPart();
				}
				}
				this.state = 286;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			this.state = 287;
			this.match(SolidityParser.T__12);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public inheritanceSpecifier(): InheritanceSpecifierContext {
		let _localctx: InheritanceSpecifierContext = new InheritanceSpecifierContext(this._ctx, this.state);
		this.enterRule(_localctx, 24, SolidityParser.RULE_inheritanceSpecifier);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 289;
			this.userDefinedTypeName();
			this.state = 301;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__22) {
				{
				this.state = 290;
				this.match(SolidityParser.T__22);
				this.state = 291;
				this.expression(0);
				this.state = 296;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 292;
					this.match(SolidityParser.T__17);
					this.state = 293;
					this.expression(0);
					}
					}
					this.state = 298;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				this.state = 299;
				this.match(SolidityParser.T__23);
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public contractPart(): ContractPartContext {
		let _localctx: ContractPartContext = new ContractPartContext(this._ctx, this.state);
		this.enterRule(_localctx, 26, SolidityParser.RULE_contractPart);
		try {
			this.state = 311;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 17, this._ctx) ) {
			case 1:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 303;
				this.stateVariableDeclaration();
				}
				break;

			case 2:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 304;
				this.usingForDeclaration();
				}
				break;

			case 3:
				this.enterOuterAlt(_localctx, 3);
				{
				this.state = 305;
				this.structDefinition();
				}
				break;

			case 4:
				this.enterOuterAlt(_localctx, 4);
				{
				this.state = 306;
				this.constructorDefinition();
				}
				break;

			case 5:
				this.enterOuterAlt(_localctx, 5);
				{
				this.state = 307;
				this.modifierDefinition();
				}
				break;

			case 6:
				this.enterOuterAlt(_localctx, 6);
				{
				this.state = 308;
				this.functionDefinition();
				}
				break;

			case 7:
				this.enterOuterAlt(_localctx, 7);
				{
				this.state = 309;
				this.eventDefinition();
				}
				break;

			case 8:
				this.enterOuterAlt(_localctx, 8);
				{
				this.state = 310;
				this.enumDefinition();
				}
				break;
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public stateVariableDeclaration(): StateVariableDeclarationContext {
		let _localctx: StateVariableDeclarationContext = new StateVariableDeclarationContext(this._ctx, this.state);
		this.enterRule(_localctx, 28, SolidityParser.RULE_stateVariableDeclaration);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 313;
			this.typeName(0);
			this.state = 317;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while (((((_la - 109)) & ~0x1F) === 0 && ((1 << (_la - 109)) & ((1 << (SolidityParser.ConstantKeyword - 109)) | (1 << (SolidityParser.InternalKeyword - 109)) | (1 << (SolidityParser.PrivateKeyword - 109)) | (1 << (SolidityParser.PublicKeyword - 109)))) !== 0)) {
				{
				{
				this.state = 314;
				_la = this._input.LA(1);
				if (!(((((_la - 109)) & ~0x1F) === 0 && ((1 << (_la - 109)) & ((1 << (SolidityParser.ConstantKeyword - 109)) | (1 << (SolidityParser.InternalKeyword - 109)) | (1 << (SolidityParser.PrivateKeyword - 109)) | (1 << (SolidityParser.PublicKeyword - 109)))) !== 0))) {
				this._errHandler.recoverInline(this);
				} else {
					if (this._input.LA(1) === Token.EOF) {
						this.matchedEOF = true;
					}

					this._errHandler.reportMatch(this);
					this.consume();
				}
				}
				}
				this.state = 319;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			this.state = 320;
			this.identifier();
			this.state = 323;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__8) {
				{
				this.state = 321;
				this.match(SolidityParser.T__8);
				this.state = 322;
				this.expression(0);
				}
			}

			this.state = 325;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public usingForDeclaration(): UsingForDeclarationContext {
		let _localctx: UsingForDeclarationContext = new UsingForDeclarationContext(this._ctx, this.state);
		this.enterRule(_localctx, 30, SolidityParser.RULE_usingForDeclaration);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 327;
			this.match(SolidityParser.T__24);
			this.state = 328;
			this.identifier();
			this.state = 329;
			this.match(SolidityParser.T__25);
			this.state = 332;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__15:
				{
				this.state = 330;
				this.match(SolidityParser.T__15);
				}
				break;
			case SolidityParser.T__16:
			case SolidityParser.T__29:
			case SolidityParser.T__35:
			case SolidityParser.T__37:
			case SolidityParser.T__50:
			case SolidityParser.T__51:
			case SolidityParser.T__52:
			case SolidityParser.T__53:
			case SolidityParser.Int:
			case SolidityParser.Uint:
			case SolidityParser.Byte:
			case SolidityParser.Fixed:
			case SolidityParser.Ufixed:
			case SolidityParser.Identifier:
				{
				this.state = 331;
				this.typeName(0);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			this.state = 334;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public structDefinition(): StructDefinitionContext {
		let _localctx: StructDefinitionContext = new StructDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 32, SolidityParser.RULE_structDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 336;
			this.match(SolidityParser.T__26);
			this.state = 337;
			this.identifier();
			this.state = 338;
			this.match(SolidityParser.T__11);
			this.state = 349;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.T__29 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__37 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
				{
				this.state = 339;
				this.variableDeclaration();
				this.state = 340;
				this.match(SolidityParser.T__1);
				this.state = 346;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__16 || _la === SolidityParser.T__29 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__37 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
					{
					{
					this.state = 341;
					this.variableDeclaration();
					this.state = 342;
					this.match(SolidityParser.T__1);
					}
					}
					this.state = 348;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				}
			}

			this.state = 351;
			this.match(SolidityParser.T__12);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public constructorDefinition(): ConstructorDefinitionContext {
		let _localctx: ConstructorDefinitionContext = new ConstructorDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 34, SolidityParser.RULE_constructorDefinition);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 353;
			this.match(SolidityParser.T__27);
			this.state = 354;
			this.parameterList();
			this.state = 355;
			this.modifierList();
			this.state = 356;
			this.block();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public modifierDefinition(): ModifierDefinitionContext {
		let _localctx: ModifierDefinitionContext = new ModifierDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 36, SolidityParser.RULE_modifierDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 358;
			this.match(SolidityParser.T__28);
			this.state = 359;
			this.identifier();
			this.state = 361;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__22) {
				{
				this.state = 360;
				this.parameterList();
				}
			}

			this.state = 363;
			this.block();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public modifierInvocation(): ModifierInvocationContext {
		let _localctx: ModifierInvocationContext = new ModifierInvocationContext(this._ctx, this.state);
		this.enterRule(_localctx, 38, SolidityParser.RULE_modifierInvocation);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 365;
			this.identifier();
			this.state = 371;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__22) {
				{
				this.state = 366;
				this.match(SolidityParser.T__22);
				this.state = 368;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
					{
					this.state = 367;
					this.expressionList();
					}
				}

				this.state = 370;
				this.match(SolidityParser.T__23);
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public functionDefinition(): FunctionDefinitionContext {
		let _localctx: FunctionDefinitionContext = new FunctionDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 40, SolidityParser.RULE_functionDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 373;
			this.match(SolidityParser.T__29);
			this.state = 375;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
				{
				this.state = 374;
				this.identifier();
				}
			}

			this.state = 377;
			this.parameterList();
			this.state = 378;
			this.modifierList();
			this.state = 380;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__30) {
				{
				this.state = 379;
				this.returnParameters();
				}
			}

			this.state = 384;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__1:
				{
				this.state = 382;
				this.match(SolidityParser.T__1);
				}
				break;
			case SolidityParser.T__11:
				{
				this.state = 383;
				this.block();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public returnParameters(): ReturnParametersContext {
		let _localctx: ReturnParametersContext = new ReturnParametersContext(this._ctx, this.state);
		this.enterRule(_localctx, 42, SolidityParser.RULE_returnParameters);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 386;
			this.match(SolidityParser.T__30);
			this.state = 387;
			this.parameterList();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public modifierList(): ModifierListContext {
		let _localctx: ModifierListContext = new ModifierListContext(this._ctx, this.state);
		this.enterRule(_localctx, 44, SolidityParser.RULE_modifierList);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 397;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while (_la === SolidityParser.T__16 || ((((_la - 109)) & ~0x1F) === 0 && ((1 << (_la - 109)) & ((1 << (SolidityParser.ConstantKeyword - 109)) | (1 << (SolidityParser.ExternalKeyword - 109)) | (1 << (SolidityParser.InternalKeyword - 109)) | (1 << (SolidityParser.PayableKeyword - 109)) | (1 << (SolidityParser.PrivateKeyword - 109)) | (1 << (SolidityParser.PublicKeyword - 109)) | (1 << (SolidityParser.PureKeyword - 109)) | (1 << (SolidityParser.ViewKeyword - 109)) | (1 << (SolidityParser.Identifier - 109)))) !== 0)) {
				{
				this.state = 395;
				this._errHandler.sync(this);
				switch (this._input.LA(1)) {
				case SolidityParser.T__16:
				case SolidityParser.Identifier:
					{
					this.state = 389;
					this.modifierInvocation();
					}
					break;
				case SolidityParser.ConstantKeyword:
				case SolidityParser.PayableKeyword:
				case SolidityParser.PureKeyword:
				case SolidityParser.ViewKeyword:
					{
					this.state = 390;
					this.stateMutability();
					}
					break;
				case SolidityParser.ExternalKeyword:
					{
					this.state = 391;
					this.match(SolidityParser.ExternalKeyword);
					}
					break;
				case SolidityParser.PublicKeyword:
					{
					this.state = 392;
					this.match(SolidityParser.PublicKeyword);
					}
					break;
				case SolidityParser.InternalKeyword:
					{
					this.state = 393;
					this.match(SolidityParser.InternalKeyword);
					}
					break;
				case SolidityParser.PrivateKeyword:
					{
					this.state = 394;
					this.match(SolidityParser.PrivateKeyword);
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				this.state = 399;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public eventDefinition(): EventDefinitionContext {
		let _localctx: EventDefinitionContext = new EventDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 46, SolidityParser.RULE_eventDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 400;
			this.match(SolidityParser.T__31);
			this.state = 401;
			this.identifier();
			this.state = 402;
			this.eventParameterList();
			this.state = 404;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.AnonymousKeyword) {
				{
				this.state = 403;
				this.match(SolidityParser.AnonymousKeyword);
				}
			}

			this.state = 406;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public enumValue(): EnumValueContext {
		let _localctx: EnumValueContext = new EnumValueContext(this._ctx, this.state);
		this.enterRule(_localctx, 48, SolidityParser.RULE_enumValue);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 408;
			this.identifier();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public enumDefinition(): EnumDefinitionContext {
		let _localctx: EnumDefinitionContext = new EnumDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 50, SolidityParser.RULE_enumDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 410;
			this.match(SolidityParser.T__32);
			this.state = 411;
			this.identifier();
			this.state = 412;
			this.match(SolidityParser.T__11);
			this.state = 414;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
				{
				this.state = 413;
				this.enumValue();
				}
			}

			this.state = 420;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while (_la === SolidityParser.T__17) {
				{
				{
				this.state = 416;
				this.match(SolidityParser.T__17);
				this.state = 417;
				this.enumValue();
				}
				}
				this.state = 422;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			this.state = 423;
			this.match(SolidityParser.T__12);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public parameterList(): ParameterListContext {
		let _localctx: ParameterListContext = new ParameterListContext(this._ctx, this.state);
		this.enterRule(_localctx, 52, SolidityParser.RULE_parameterList);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 425;
			this.match(SolidityParser.T__22);
			this.state = 434;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.T__29 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__37 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
				{
				this.state = 426;
				this.parameter();
				this.state = 431;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 427;
					this.match(SolidityParser.T__17);
					this.state = 428;
					this.parameter();
					}
					}
					this.state = 433;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				}
			}

			this.state = 436;
			this.match(SolidityParser.T__23);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public parameter(): ParameterContext {
		let _localctx: ParameterContext = new ParameterContext(this._ctx, this.state);
		this.enterRule(_localctx, 54, SolidityParser.RULE_parameter);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 438;
			this.typeName(0);
			this.state = 440;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (((((_la - 40)) & ~0x1F) === 0 && ((1 << (_la - 40)) & ((1 << (SolidityParser.T__39 - 40)) | (1 << (SolidityParser.T__40 - 40)) | (1 << (SolidityParser.T__41 - 40)))) !== 0)) {
				{
				this.state = 439;
				this.storageLocation();
				}
			}

			this.state = 443;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
				{
				this.state = 442;
				this.identifier();
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public eventParameterList(): EventParameterListContext {
		let _localctx: EventParameterListContext = new EventParameterListContext(this._ctx, this.state);
		this.enterRule(_localctx, 56, SolidityParser.RULE_eventParameterList);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 445;
			this.match(SolidityParser.T__22);
			this.state = 454;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.T__29 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__37 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
				{
				this.state = 446;
				this.eventParameter();
				this.state = 451;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 447;
					this.match(SolidityParser.T__17);
					this.state = 448;
					this.eventParameter();
					}
					}
					this.state = 453;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				}
			}

			this.state = 456;
			this.match(SolidityParser.T__23);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public eventParameter(): EventParameterContext {
		let _localctx: EventParameterContext = new EventParameterContext(this._ctx, this.state);
		this.enterRule(_localctx, 58, SolidityParser.RULE_eventParameter);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 458;
			this.typeName(0);
			this.state = 460;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.IndexedKeyword) {
				{
				this.state = 459;
				this.match(SolidityParser.IndexedKeyword);
				}
			}

			this.state = 463;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
				{
				this.state = 462;
				this.identifier();
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public functionTypeParameterList(): FunctionTypeParameterListContext {
		let _localctx: FunctionTypeParameterListContext = new FunctionTypeParameterListContext(this._ctx, this.state);
		this.enterRule(_localctx, 60, SolidityParser.RULE_functionTypeParameterList);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 465;
			this.match(SolidityParser.T__22);
			this.state = 474;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.T__29 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__37 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
				{
				this.state = 466;
				this.functionTypeParameter();
				this.state = 471;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 467;
					this.match(SolidityParser.T__17);
					this.state = 468;
					this.functionTypeParameter();
					}
					}
					this.state = 473;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				}
			}

			this.state = 476;
			this.match(SolidityParser.T__23);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public functionTypeParameter(): FunctionTypeParameterContext {
		let _localctx: FunctionTypeParameterContext = new FunctionTypeParameterContext(this._ctx, this.state);
		this.enterRule(_localctx, 62, SolidityParser.RULE_functionTypeParameter);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 478;
			this.typeName(0);
			this.state = 480;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (((((_la - 40)) & ~0x1F) === 0 && ((1 << (_la - 40)) & ((1 << (SolidityParser.T__39 - 40)) | (1 << (SolidityParser.T__40 - 40)) | (1 << (SolidityParser.T__41 - 40)))) !== 0)) {
				{
				this.state = 479;
				this.storageLocation();
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public variableDeclaration(): VariableDeclarationContext {
		let _localctx: VariableDeclarationContext = new VariableDeclarationContext(this._ctx, this.state);
		this.enterRule(_localctx, 64, SolidityParser.RULE_variableDeclaration);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 482;
			this.typeName(0);
			this.state = 484;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (((((_la - 40)) & ~0x1F) === 0 && ((1 << (_la - 40)) & ((1 << (SolidityParser.T__39 - 40)) | (1 << (SolidityParser.T__40 - 40)) | (1 << (SolidityParser.T__41 - 40)))) !== 0)) {
				{
				this.state = 483;
				this.storageLocation();
				}
			}

			this.state = 486;
			this.identifier();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}

	public typeName(): TypeNameContext;
	public typeName(_p: number): TypeNameContext;
	// @RuleVersion(0)
	public typeName(_p?: number): TypeNameContext {
		if (_p === undefined) {
			_p = 0;
		}

		let _parentctx: ParserRuleContext = this._ctx;
		let _parentState: number = this.state;
		let _localctx: TypeNameContext = new TypeNameContext(this._ctx, _parentState);
		let _prevctx: TypeNameContext = _localctx;
		let _startState: number = 66;
		this.enterRecursionRule(_localctx, 66, SolidityParser.RULE_typeName, _p);
		let _la: number;
		try {
			let _alt: number;
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 495;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 46, this._ctx) ) {
			case 1:
				{
				this.state = 489;
				this.elementaryTypeName();
				}
				break;

			case 2:
				{
				this.state = 490;
				this.userDefinedTypeName();
				}
				break;

			case 3:
				{
				this.state = 491;
				this.mapping();
				}
				break;

			case 4:
				{
				this.state = 492;
				this.functionTypeName();
				}
				break;

			case 5:
				{
				this.state = 493;
				this.match(SolidityParser.T__35);
				this.state = 494;
				this.match(SolidityParser.PayableKeyword);
				}
				break;
			}
			this._ctx._stop = this._input.tryLT(-1);
			this.state = 505;
			this._errHandler.sync(this);
			_alt = this.interpreter.adaptivePredict(this._input, 48, this._ctx);
			while (_alt !== 2 && _alt !== ATN.INVALID_ALT_NUMBER) {
				if (_alt === 1) {
					if (this._parseListeners != null) {
						this.triggerExitRuleEvent();
					}
					_prevctx = _localctx;
					{
					{
					_localctx = new TypeNameContext(_parentctx, _parentState);
					this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_typeName);
					this.state = 497;
					if (!(this.precpred(this._ctx, 3))) {
						throw new FailedPredicateException(this, "this.precpred(this._ctx, 3)");
					}
					this.state = 498;
					this.match(SolidityParser.T__33);
					this.state = 500;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
					if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
						{
						this.state = 499;
						this.expression(0);
						}
					}

					this.state = 502;
					this.match(SolidityParser.T__34);
					}
					}
				}
				this.state = 507;
				this._errHandler.sync(this);
				_alt = this.interpreter.adaptivePredict(this._input, 48, this._ctx);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public userDefinedTypeName(): UserDefinedTypeNameContext {
		let _localctx: UserDefinedTypeNameContext = new UserDefinedTypeNameContext(this._ctx, this.state);
		this.enterRule(_localctx, 68, SolidityParser.RULE_userDefinedTypeName);
		try {
			let _alt: number;
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 508;
			this.identifier();
			this.state = 513;
			this._errHandler.sync(this);
			_alt = this.interpreter.adaptivePredict(this._input, 49, this._ctx);
			while (_alt !== 2 && _alt !== ATN.INVALID_ALT_NUMBER) {
				if (_alt === 1) {
					{
					{
					this.state = 509;
					this.match(SolidityParser.T__36);
					this.state = 510;
					this.identifier();
					}
					}
				}
				this.state = 515;
				this._errHandler.sync(this);
				_alt = this.interpreter.adaptivePredict(this._input, 49, this._ctx);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public mapping(): MappingContext {
		let _localctx: MappingContext = new MappingContext(this._ctx, this.state);
		this.enterRule(_localctx, 70, SolidityParser.RULE_mapping);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 516;
			this.match(SolidityParser.T__37);
			this.state = 517;
			this.match(SolidityParser.T__22);
			this.state = 518;
			this.elementaryTypeName();
			this.state = 519;
			this.match(SolidityParser.T__38);
			this.state = 520;
			this.typeName(0);
			this.state = 521;
			this.match(SolidityParser.T__23);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public functionTypeName(): FunctionTypeNameContext {
		let _localctx: FunctionTypeNameContext = new FunctionTypeNameContext(this._ctx, this.state);
		this.enterRule(_localctx, 72, SolidityParser.RULE_functionTypeName);
		try {
			let _alt: number;
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 523;
			this.match(SolidityParser.T__29);
			this.state = 524;
			this.functionTypeParameterList();
			this.state = 530;
			this._errHandler.sync(this);
			_alt = this.interpreter.adaptivePredict(this._input, 51, this._ctx);
			while (_alt !== 2 && _alt !== ATN.INVALID_ALT_NUMBER) {
				if (_alt === 1) {
					{
					this.state = 528;
					this._errHandler.sync(this);
					switch (this._input.LA(1)) {
					case SolidityParser.InternalKeyword:
						{
						this.state = 525;
						this.match(SolidityParser.InternalKeyword);
						}
						break;
					case SolidityParser.ExternalKeyword:
						{
						this.state = 526;
						this.match(SolidityParser.ExternalKeyword);
						}
						break;
					case SolidityParser.ConstantKeyword:
					case SolidityParser.PayableKeyword:
					case SolidityParser.PureKeyword:
					case SolidityParser.ViewKeyword:
						{
						this.state = 527;
						this.stateMutability();
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
				}
				this.state = 532;
				this._errHandler.sync(this);
				_alt = this.interpreter.adaptivePredict(this._input, 51, this._ctx);
			}
			this.state = 535;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 52, this._ctx) ) {
			case 1:
				{
				this.state = 533;
				this.match(SolidityParser.T__30);
				this.state = 534;
				this.functionTypeParameterList();
				}
				break;
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public storageLocation(): StorageLocationContext {
		let _localctx: StorageLocationContext = new StorageLocationContext(this._ctx, this.state);
		this.enterRule(_localctx, 74, SolidityParser.RULE_storageLocation);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 537;
			_la = this._input.LA(1);
			if (!(((((_la - 40)) & ~0x1F) === 0 && ((1 << (_la - 40)) & ((1 << (SolidityParser.T__39 - 40)) | (1 << (SolidityParser.T__40 - 40)) | (1 << (SolidityParser.T__41 - 40)))) !== 0))) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public stateMutability(): StateMutabilityContext {
		let _localctx: StateMutabilityContext = new StateMutabilityContext(this._ctx, this.state);
		this.enterRule(_localctx, 76, SolidityParser.RULE_stateMutability);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 539;
			_la = this._input.LA(1);
			if (!(((((_la - 109)) & ~0x1F) === 0 && ((1 << (_la - 109)) & ((1 << (SolidityParser.ConstantKeyword - 109)) | (1 << (SolidityParser.PayableKeyword - 109)) | (1 << (SolidityParser.PureKeyword - 109)) | (1 << (SolidityParser.ViewKeyword - 109)))) !== 0))) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public block(): BlockContext {
		let _localctx: BlockContext = new BlockContext(this._ctx, this.state);
		this.enterRule(_localctx, 78, SolidityParser.RULE_block);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 541;
			this.match(SolidityParser.T__11);
			this.state = 545;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__11) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22) | (1 << SolidityParser.T__25) | (1 << SolidityParser.T__29))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__37 - 34)) | (1 << (SolidityParser.T__42 - 34)) | (1 << (SolidityParser.T__44 - 34)) | (1 << (SolidityParser.T__45 - 34)) | (1 << (SolidityParser.T__46 - 34)) | (1 << (SolidityParser.T__47 - 34)) | (1 << (SolidityParser.T__48 - 34)) | (1 << (SolidityParser.T__49 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)) | (1 << (SolidityParser.BreakKeyword - 86)) | (1 << (SolidityParser.ContinueKeyword - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
				{
				{
				this.state = 542;
				this.statement();
				}
				}
				this.state = 547;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			this.state = 548;
			this.match(SolidityParser.T__12);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public statement(): StatementContext {
		let _localctx: StatementContext = new StatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 80, SolidityParser.RULE_statement);
		try {
			this.state = 562;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__42:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 550;
				this.ifStatement();
				}
				break;
			case SolidityParser.T__44:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 551;
				this.whileStatement();
				}
				break;
			case SolidityParser.T__25:
				this.enterOuterAlt(_localctx, 3);
				{
				this.state = 552;
				this.forStatement();
				}
				break;
			case SolidityParser.T__11:
				this.enterOuterAlt(_localctx, 4);
				{
				this.state = 553;
				this.block();
				}
				break;
			case SolidityParser.T__45:
				this.enterOuterAlt(_localctx, 5);
				{
				this.state = 554;
				this.inlineAssemblyStatement();
				}
				break;
			case SolidityParser.T__46:
				this.enterOuterAlt(_localctx, 6);
				{
				this.state = 555;
				this.doWhileStatement();
				}
				break;
			case SolidityParser.ContinueKeyword:
				this.enterOuterAlt(_localctx, 7);
				{
				this.state = 556;
				this.continueStatement();
				}
				break;
			case SolidityParser.BreakKeyword:
				this.enterOuterAlt(_localctx, 8);
				{
				this.state = 557;
				this.breakStatement();
				}
				break;
			case SolidityParser.T__47:
				this.enterOuterAlt(_localctx, 9);
				{
				this.state = 558;
				this.returnStatement();
				}
				break;
			case SolidityParser.T__48:
				this.enterOuterAlt(_localctx, 10);
				{
				this.state = 559;
				this.throwStatement();
				}
				break;
			case SolidityParser.T__49:
				this.enterOuterAlt(_localctx, 11);
				{
				this.state = 560;
				this.emitStatement();
				}
				break;
			case SolidityParser.T__3:
			case SolidityParser.T__16:
			case SolidityParser.T__22:
			case SolidityParser.T__29:
			case SolidityParser.T__33:
			case SolidityParser.T__35:
			case SolidityParser.T__37:
			case SolidityParser.T__50:
			case SolidityParser.T__51:
			case SolidityParser.T__52:
			case SolidityParser.T__53:
			case SolidityParser.T__54:
			case SolidityParser.T__55:
			case SolidityParser.T__56:
			case SolidityParser.T__57:
			case SolidityParser.T__58:
			case SolidityParser.T__59:
			case SolidityParser.T__60:
			case SolidityParser.T__61:
			case SolidityParser.T__85:
			case SolidityParser.T__86:
			case SolidityParser.Int:
			case SolidityParser.Uint:
			case SolidityParser.Byte:
			case SolidityParser.Fixed:
			case SolidityParser.Ufixed:
			case SolidityParser.BooleanLiteral:
			case SolidityParser.DecimalNumber:
			case SolidityParser.HexNumber:
			case SolidityParser.HexLiteral:
			case SolidityParser.Identifier:
			case SolidityParser.StringLiteral:
				this.enterOuterAlt(_localctx, 12);
				{
				this.state = 561;
				this.simpleStatement();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public expressionStatement(): ExpressionStatementContext {
		let _localctx: ExpressionStatementContext = new ExpressionStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 82, SolidityParser.RULE_expressionStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 564;
			this.expression(0);
			this.state = 565;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public ifStatement(): IfStatementContext {
		let _localctx: IfStatementContext = new IfStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 84, SolidityParser.RULE_ifStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 567;
			this.match(SolidityParser.T__42);
			this.state = 568;
			this.match(SolidityParser.T__22);
			this.state = 569;
			this.expression(0);
			this.state = 570;
			this.match(SolidityParser.T__23);
			this.state = 571;
			this.statement();
			this.state = 574;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 55, this._ctx) ) {
			case 1:
				{
				this.state = 572;
				this.match(SolidityParser.T__43);
				this.state = 573;
				this.statement();
				}
				break;
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public whileStatement(): WhileStatementContext {
		let _localctx: WhileStatementContext = new WhileStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 86, SolidityParser.RULE_whileStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 576;
			this.match(SolidityParser.T__44);
			this.state = 577;
			this.match(SolidityParser.T__22);
			this.state = 578;
			this.expression(0);
			this.state = 579;
			this.match(SolidityParser.T__23);
			this.state = 580;
			this.statement();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public simpleStatement(): SimpleStatementContext {
		let _localctx: SimpleStatementContext = new SimpleStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 88, SolidityParser.RULE_simpleStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 584;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 56, this._ctx) ) {
			case 1:
				{
				this.state = 582;
				this.variableDeclarationStatement();
				}
				break;

			case 2:
				{
				this.state = 583;
				this.expressionStatement();
				}
				break;
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public forStatement(): ForStatementContext {
		let _localctx: ForStatementContext = new ForStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 90, SolidityParser.RULE_forStatement);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 586;
			this.match(SolidityParser.T__25);
			this.state = 587;
			this.match(SolidityParser.T__22);
			this.state = 590;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__3:
			case SolidityParser.T__16:
			case SolidityParser.T__22:
			case SolidityParser.T__29:
			case SolidityParser.T__33:
			case SolidityParser.T__35:
			case SolidityParser.T__37:
			case SolidityParser.T__50:
			case SolidityParser.T__51:
			case SolidityParser.T__52:
			case SolidityParser.T__53:
			case SolidityParser.T__54:
			case SolidityParser.T__55:
			case SolidityParser.T__56:
			case SolidityParser.T__57:
			case SolidityParser.T__58:
			case SolidityParser.T__59:
			case SolidityParser.T__60:
			case SolidityParser.T__61:
			case SolidityParser.T__85:
			case SolidityParser.T__86:
			case SolidityParser.Int:
			case SolidityParser.Uint:
			case SolidityParser.Byte:
			case SolidityParser.Fixed:
			case SolidityParser.Ufixed:
			case SolidityParser.BooleanLiteral:
			case SolidityParser.DecimalNumber:
			case SolidityParser.HexNumber:
			case SolidityParser.HexLiteral:
			case SolidityParser.Identifier:
			case SolidityParser.StringLiteral:
				{
				this.state = 588;
				this.simpleStatement();
				}
				break;
			case SolidityParser.T__1:
				{
				this.state = 589;
				this.match(SolidityParser.T__1);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			this.state = 593;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
				{
				this.state = 592;
				this.expression(0);
				}
			}

			this.state = 595;
			this.match(SolidityParser.T__1);
			this.state = 597;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
				{
				this.state = 596;
				this.expression(0);
				}
			}

			this.state = 599;
			this.match(SolidityParser.T__23);
			this.state = 600;
			this.statement();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public inlineAssemblyStatement(): InlineAssemblyStatementContext {
		let _localctx: InlineAssemblyStatementContext = new InlineAssemblyStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 92, SolidityParser.RULE_inlineAssemblyStatement);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 602;
			this.match(SolidityParser.T__45);
			this.state = 604;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.StringLiteral) {
				{
				this.state = 603;
				this.match(SolidityParser.StringLiteral);
				}
			}

			this.state = 606;
			this.assemblyBlock();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public doWhileStatement(): DoWhileStatementContext {
		let _localctx: DoWhileStatementContext = new DoWhileStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 94, SolidityParser.RULE_doWhileStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 608;
			this.match(SolidityParser.T__46);
			this.state = 609;
			this.statement();
			this.state = 610;
			this.match(SolidityParser.T__44);
			this.state = 611;
			this.match(SolidityParser.T__22);
			this.state = 612;
			this.expression(0);
			this.state = 613;
			this.match(SolidityParser.T__23);
			this.state = 614;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public continueStatement(): ContinueStatementContext {
		let _localctx: ContinueStatementContext = new ContinueStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 96, SolidityParser.RULE_continueStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 616;
			this.match(SolidityParser.ContinueKeyword);
			this.state = 617;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public breakStatement(): BreakStatementContext {
		let _localctx: BreakStatementContext = new BreakStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 98, SolidityParser.RULE_breakStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 619;
			this.match(SolidityParser.BreakKeyword);
			this.state = 620;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public returnStatement(): ReturnStatementContext {
		let _localctx: ReturnStatementContext = new ReturnStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 100, SolidityParser.RULE_returnStatement);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 622;
			this.match(SolidityParser.T__47);
			this.state = 624;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
				{
				this.state = 623;
				this.expression(0);
				}
			}

			this.state = 626;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public throwStatement(): ThrowStatementContext {
		let _localctx: ThrowStatementContext = new ThrowStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 102, SolidityParser.RULE_throwStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 628;
			this.match(SolidityParser.T__48);
			this.state = 629;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public emitStatement(): EmitStatementContext {
		let _localctx: EmitStatementContext = new EmitStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 104, SolidityParser.RULE_emitStatement);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 631;
			this.match(SolidityParser.T__49);
			this.state = 632;
			this.functionCall();
			this.state = 633;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public variableDeclarationStatement(): VariableDeclarationStatementContext {
		let _localctx: VariableDeclarationStatementContext = new VariableDeclarationStatementContext(this._ctx, this.state);
		this.enterRule(_localctx, 106, SolidityParser.RULE_variableDeclarationStatement);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 642;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 62, this._ctx) ) {
			case 1:
				{
				this.state = 635;
				this.match(SolidityParser.T__50);
				this.state = 636;
				this.identifierList();
				}
				break;

			case 2:
				{
				this.state = 637;
				this.variableDeclaration();
				}
				break;

			case 3:
				{
				this.state = 638;
				this.match(SolidityParser.T__22);
				this.state = 639;
				this.variableDeclarationList();
				this.state = 640;
				this.match(SolidityParser.T__23);
				}
				break;
			}
			this.state = 646;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__8) {
				{
				this.state = 644;
				this.match(SolidityParser.T__8);
				this.state = 645;
				this.expression(0);
				}
			}

			this.state = 648;
			this.match(SolidityParser.T__1);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public variableDeclarationList(): VariableDeclarationListContext {
		let _localctx: VariableDeclarationListContext = new VariableDeclarationListContext(this._ctx, this.state);
		this.enterRule(_localctx, 108, SolidityParser.RULE_variableDeclarationList);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 651;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.T__29 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__37 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
				{
				this.state = 650;
				this.variableDeclaration();
				}
			}

			this.state = 659;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while (_la === SolidityParser.T__17) {
				{
				{
				this.state = 653;
				this.match(SolidityParser.T__17);
				this.state = 655;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if (_la === SolidityParser.T__16 || _la === SolidityParser.T__29 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__37 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)) | (1 << (SolidityParser.Identifier - 95)))) !== 0)) {
					{
					this.state = 654;
					this.variableDeclaration();
					}
				}

				}
				}
				this.state = 661;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public identifierList(): IdentifierListContext {
		let _localctx: IdentifierListContext = new IdentifierListContext(this._ctx, this.state);
		this.enterRule(_localctx, 110, SolidityParser.RULE_identifierList);
		let _la: number;
		try {
			let _alt: number;
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 662;
			this.match(SolidityParser.T__22);
			this.state = 669;
			this._errHandler.sync(this);
			_alt = this.interpreter.adaptivePredict(this._input, 68, this._ctx);
			while (_alt !== 2 && _alt !== ATN.INVALID_ALT_NUMBER) {
				if (_alt === 1) {
					{
					{
					this.state = 664;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
					if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
						{
						this.state = 663;
						this.identifier();
						}
					}

					this.state = 666;
					this.match(SolidityParser.T__17);
					}
					}
				}
				this.state = 671;
				this._errHandler.sync(this);
				_alt = this.interpreter.adaptivePredict(this._input, 68, this._ctx);
			}
			this.state = 673;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
				{
				this.state = 672;
				this.identifier();
				}
			}

			this.state = 675;
			this.match(SolidityParser.T__23);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public elementaryTypeName(): ElementaryTypeNameContext {
		let _localctx: ElementaryTypeNameContext = new ElementaryTypeNameContext(this._ctx, this.state);
		this.enterRule(_localctx, 112, SolidityParser.RULE_elementaryTypeName);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 677;
			_la = this._input.LA(1);
			if (!(((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__50 - 36)) | (1 << (SolidityParser.T__51 - 36)) | (1 << (SolidityParser.T__52 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 95)) & ~0x1F) === 0 && ((1 << (_la - 95)) & ((1 << (SolidityParser.Int - 95)) | (1 << (SolidityParser.Uint - 95)) | (1 << (SolidityParser.Byte - 95)) | (1 << (SolidityParser.Fixed - 95)) | (1 << (SolidityParser.Ufixed - 95)))) !== 0))) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}

	public expression(): ExpressionContext;
	public expression(_p: number): ExpressionContext;
	// @RuleVersion(0)
	public expression(_p?: number): ExpressionContext {
		if (_p === undefined) {
			_p = 0;
		}

		let _parentctx: ParserRuleContext = this._ctx;
		let _parentState: number = this.state;
		let _localctx: ExpressionContext = new ExpressionContext(this._ctx, _parentState);
		let _prevctx: ExpressionContext = _localctx;
		let _startState: number = 114;
		this.enterRecursionRule(_localctx, 114, SolidityParser.RULE_expression, _p);
		let _la: number;
		try {
			let _alt: number;
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 699;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 70, this._ctx) ) {
			case 1:
				{
				this.state = 680;
				this.match(SolidityParser.T__56);
				this.state = 681;
				this.typeName(0);
				}
				break;

			case 2:
				{
				this.state = 682;
				this.match(SolidityParser.T__22);
				this.state = 683;
				this.expression(0);
				this.state = 684;
				this.match(SolidityParser.T__23);
				}
				break;

			case 3:
				{
				this.state = 686;
				_la = this._input.LA(1);
				if (!(_la === SolidityParser.T__54 || _la === SolidityParser.T__55)) {
				this._errHandler.recoverInline(this);
				} else {
					if (this._input.LA(1) === Token.EOF) {
						this.matchedEOF = true;
					}

					this._errHandler.reportMatch(this);
					this.consume();
				}
				this.state = 687;
				this.expression(21);
				}
				break;

			case 4:
				{
				this.state = 688;
				_la = this._input.LA(1);
				if (!(_la === SolidityParser.T__57 || _la === SolidityParser.T__58)) {
				this._errHandler.recoverInline(this);
				} else {
					if (this._input.LA(1) === Token.EOF) {
						this.matchedEOF = true;
					}

					this._errHandler.reportMatch(this);
					this.consume();
				}
				this.state = 689;
				this.expression(20);
				}
				break;

			case 5:
				{
				this.state = 690;
				_la = this._input.LA(1);
				if (!(_la === SolidityParser.T__59 || _la === SolidityParser.T__60)) {
				this._errHandler.recoverInline(this);
				} else {
					if (this._input.LA(1) === Token.EOF) {
						this.matchedEOF = true;
					}

					this._errHandler.reportMatch(this);
					this.consume();
				}
				this.state = 691;
				this.expression(19);
				}
				break;

			case 6:
				{
				this.state = 692;
				this.match(SolidityParser.T__61);
				this.state = 693;
				this.expression(18);
				}
				break;

			case 7:
				{
				this.state = 694;
				this.match(SolidityParser.T__3);
				this.state = 695;
				this.expression(17);
				}
				break;

			case 8:
				{
				this.state = 696;
				this.forAllExpression();
				}
				break;

			case 9:
				{
				this.state = 697;
				this.sumExpression();
				}
				break;

			case 10:
				{
				this.state = 698;
				this.primaryExpression();
				}
				break;
			}
			this._ctx._stop = this._input.tryLT(-1);
			this.state = 760;
			this._errHandler.sync(this);
			_alt = this.interpreter.adaptivePredict(this._input, 72, this._ctx);
			while (_alt !== 2 && _alt !== ATN.INVALID_ALT_NUMBER) {
				if (_alt === 1) {
					if (this._parseListeners != null) {
						this.triggerExitRuleEvent();
					}
					_prevctx = _localctx;
					{
					this.state = 758;
					this._errHandler.sync(this);
					switch ( this.interpreter.adaptivePredict(this._input, 71, this._ctx) ) {
					case 1:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 701;
						if (!(this.precpred(this._ctx, 16))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 16)");
						}
						this.state = 702;
						this.match(SolidityParser.T__62);
						this.state = 703;
						this.expression(17);
						}
						break;

					case 2:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 704;
						if (!(this.precpred(this._ctx, 15))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 15)");
						}
						this.state = 705;
						_la = this._input.LA(1);
						if (!(_la === SolidityParser.T__15 || _la === SolidityParser.T__63 || _la === SolidityParser.T__64)) {
						this._errHandler.recoverInline(this);
						} else {
							if (this._input.LA(1) === Token.EOF) {
								this.matchedEOF = true;
							}

							this._errHandler.reportMatch(this);
							this.consume();
						}
						this.state = 706;
						this.expression(16);
						}
						break;

					case 3:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 707;
						if (!(this.precpred(this._ctx, 14))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 14)");
						}
						this.state = 708;
						_la = this._input.LA(1);
						if (!(_la === SolidityParser.T__57 || _la === SolidityParser.T__58)) {
						this._errHandler.recoverInline(this);
						} else {
							if (this._input.LA(1) === Token.EOF) {
								this.matchedEOF = true;
							}

							this._errHandler.reportMatch(this);
							this.consume();
						}
						this.state = 709;
						this.expression(15);
						}
						break;

					case 4:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 710;
						if (!(this.precpred(this._ctx, 13))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 13)");
						}
						this.state = 711;
						_la = this._input.LA(1);
						if (!(_la === SolidityParser.T__65 || _la === SolidityParser.T__66)) {
						this._errHandler.recoverInline(this);
						} else {
							if (this._input.LA(1) === Token.EOF) {
								this.matchedEOF = true;
							}

							this._errHandler.reportMatch(this);
							this.consume();
						}
						this.state = 712;
						this.expression(14);
						}
						break;

					case 5:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 713;
						if (!(this.precpred(this._ctx, 12))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 12)");
						}
						this.state = 714;
						this.match(SolidityParser.T__67);
						this.state = 715;
						this.expression(13);
						}
						break;

					case 6:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 716;
						if (!(this.precpred(this._ctx, 11))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 11)");
						}
						this.state = 717;
						this.match(SolidityParser.T__2);
						this.state = 718;
						this.expression(12);
						}
						break;

					case 7:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 719;
						if (!(this.precpred(this._ctx, 10))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 10)");
						}
						this.state = 720;
						this.match(SolidityParser.T__68);
						this.state = 721;
						this.expression(11);
						}
						break;

					case 8:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 722;
						if (!(this.precpred(this._ctx, 9))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 9)");
						}
						this.state = 723;
						_la = this._input.LA(1);
						if (!((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__4) | (1 << SolidityParser.T__5) | (1 << SolidityParser.T__6) | (1 << SolidityParser.T__7))) !== 0))) {
						this._errHandler.recoverInline(this);
						} else {
							if (this._input.LA(1) === Token.EOF) {
								this.matchedEOF = true;
							}

							this._errHandler.reportMatch(this);
							this.consume();
						}
						this.state = 724;
						this.expression(10);
						}
						break;

					case 9:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 725;
						if (!(this.precpred(this._ctx, 8))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 8)");
						}
						this.state = 726;
						_la = this._input.LA(1);
						if (!(_la === SolidityParser.T__69 || _la === SolidityParser.T__70)) {
						this._errHandler.recoverInline(this);
						} else {
							if (this._input.LA(1) === Token.EOF) {
								this.matchedEOF = true;
							}

							this._errHandler.reportMatch(this);
							this.consume();
						}
						this.state = 727;
						this.expression(9);
						}
						break;

					case 10:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 728;
						if (!(this.precpred(this._ctx, 7))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 7)");
						}
						this.state = 729;
						this.match(SolidityParser.T__71);
						this.state = 730;
						this.expression(8);
						}
						break;

					case 11:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 731;
						if (!(this.precpred(this._ctx, 6))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 6)");
						}
						this.state = 732;
						this.match(SolidityParser.T__72);
						this.state = 733;
						this.expression(7);
						}
						break;

					case 12:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 734;
						if (!(this.precpred(this._ctx, 5))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 5)");
						}
						this.state = 735;
						this.match(SolidityParser.T__73);
						this.state = 736;
						this.expression(0);
						this.state = 737;
						this.match(SolidityParser.T__74);
						this.state = 738;
						this.expression(6);
						}
						break;

					case 13:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 740;
						if (!(this.precpred(this._ctx, 4))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 4)");
						}
						this.state = 741;
						_la = this._input.LA(1);
						if (!(_la === SolidityParser.T__8 || ((((_la - 76)) & ~0x1F) === 0 && ((1 << (_la - 76)) & ((1 << (SolidityParser.T__75 - 76)) | (1 << (SolidityParser.T__76 - 76)) | (1 << (SolidityParser.T__77 - 76)) | (1 << (SolidityParser.T__78 - 76)) | (1 << (SolidityParser.T__79 - 76)) | (1 << (SolidityParser.T__80 - 76)) | (1 << (SolidityParser.T__81 - 76)) | (1 << (SolidityParser.T__82 - 76)) | (1 << (SolidityParser.T__83 - 76)) | (1 << (SolidityParser.T__84 - 76)))) !== 0))) {
						this._errHandler.recoverInline(this);
						} else {
							if (this._input.LA(1) === Token.EOF) {
								this.matchedEOF = true;
							}

							this._errHandler.reportMatch(this);
							this.consume();
						}
						this.state = 742;
						this.expression(5);
						}
						break;

					case 14:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 743;
						if (!(this.precpred(this._ctx, 27))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 27)");
						}
						this.state = 744;
						_la = this._input.LA(1);
						if (!(_la === SolidityParser.T__54 || _la === SolidityParser.T__55)) {
						this._errHandler.recoverInline(this);
						} else {
							if (this._input.LA(1) === Token.EOF) {
								this.matchedEOF = true;
							}

							this._errHandler.reportMatch(this);
							this.consume();
						}
						}
						break;

					case 15:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 745;
						if (!(this.precpred(this._ctx, 25))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 25)");
						}
						this.state = 746;
						this.match(SolidityParser.T__33);
						this.state = 747;
						this.expression(0);
						this.state = 748;
						this.match(SolidityParser.T__34);
						}
						break;

					case 16:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 750;
						if (!(this.precpred(this._ctx, 24))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 24)");
						}
						this.state = 751;
						this.match(SolidityParser.T__22);
						this.state = 752;
						this.functionCallArguments();
						this.state = 753;
						this.match(SolidityParser.T__23);
						}
						break;

					case 17:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						this.pushNewRecursionContext(_localctx, _startState, SolidityParser.RULE_expression);
						this.state = 755;
						if (!(this.precpred(this._ctx, 23))) {
							throw new FailedPredicateException(this, "this.precpred(this._ctx, 23)");
						}
						this.state = 756;
						this.match(SolidityParser.T__36);
						this.state = 757;
						this.identifier();
						}
						break;
					}
					}
				}
				this.state = 762;
				this._errHandler.sync(this);
				_alt = this.interpreter.adaptivePredict(this._input, 72, this._ctx);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public forAllExpression(): ForAllExpressionContext {
		let _localctx: ForAllExpressionContext = new ForAllExpressionContext(this._ctx, this.state);
		this.enterRule(_localctx, 116, SolidityParser.RULE_forAllExpression);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 763;
			this.match(SolidityParser.T__85);
			this.state = 764;
			this.identifier();
			this.state = 765;
			this.match(SolidityParser.T__17);
			this.state = 766;
			this.expression(0);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public sumExpression(): SumExpressionContext {
		let _localctx: SumExpressionContext = new SumExpressionContext(this._ctx, this.state);
		this.enterRule(_localctx, 118, SolidityParser.RULE_sumExpression);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 768;
			this.match(SolidityParser.T__86);
			this.state = 769;
			this.identifier();
			this.state = 770;
			this.match(SolidityParser.T__17);
			this.state = 771;
			this.expression(0);
			this.state = 772;
			this.match(SolidityParser.T__17);
			this.state = 773;
			this.expression(0);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public primaryExpression(): PrimaryExpressionContext {
		let _localctx: PrimaryExpressionContext = new PrimaryExpressionContext(this._ctx, this.state);
		this.enterRule(_localctx, 120, SolidityParser.RULE_primaryExpression);
		try {
			this.state = 782;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.BooleanLiteral:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 775;
				this.match(SolidityParser.BooleanLiteral);
				}
				break;
			case SolidityParser.DecimalNumber:
			case SolidityParser.HexNumber:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 776;
				this.numberLiteral();
				}
				break;
			case SolidityParser.HexLiteral:
				this.enterOuterAlt(_localctx, 3);
				{
				this.state = 777;
				this.match(SolidityParser.HexLiteral);
				}
				break;
			case SolidityParser.StringLiteral:
				this.enterOuterAlt(_localctx, 4);
				{
				this.state = 778;
				this.match(SolidityParser.StringLiteral);
				}
				break;
			case SolidityParser.T__16:
			case SolidityParser.Identifier:
				this.enterOuterAlt(_localctx, 5);
				{
				this.state = 779;
				this.identifier();
				}
				break;
			case SolidityParser.T__22:
			case SolidityParser.T__33:
				this.enterOuterAlt(_localctx, 6);
				{
				this.state = 780;
				this.tupleExpression();
				}
				break;
			case SolidityParser.T__35:
			case SolidityParser.T__50:
			case SolidityParser.T__51:
			case SolidityParser.T__52:
			case SolidityParser.T__53:
			case SolidityParser.Int:
			case SolidityParser.Uint:
			case SolidityParser.Byte:
			case SolidityParser.Fixed:
			case SolidityParser.Ufixed:
				this.enterOuterAlt(_localctx, 7);
				{
				this.state = 781;
				this.elementaryTypeNameExpression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public expressionList(): ExpressionListContext {
		let _localctx: ExpressionListContext = new ExpressionListContext(this._ctx, this.state);
		this.enterRule(_localctx, 122, SolidityParser.RULE_expressionList);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 784;
			this.expression(0);
			this.state = 789;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while (_la === SolidityParser.T__17) {
				{
				{
				this.state = 785;
				this.match(SolidityParser.T__17);
				this.state = 786;
				this.expression(0);
				}
				}
				this.state = 791;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public nameValueList(): NameValueListContext {
		let _localctx: NameValueListContext = new NameValueListContext(this._ctx, this.state);
		this.enterRule(_localctx, 124, SolidityParser.RULE_nameValueList);
		let _la: number;
		try {
			let _alt: number;
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 792;
			this.nameValue();
			this.state = 797;
			this._errHandler.sync(this);
			_alt = this.interpreter.adaptivePredict(this._input, 75, this._ctx);
			while (_alt !== 2 && _alt !== ATN.INVALID_ALT_NUMBER) {
				if (_alt === 1) {
					{
					{
					this.state = 793;
					this.match(SolidityParser.T__17);
					this.state = 794;
					this.nameValue();
					}
					}
				}
				this.state = 799;
				this._errHandler.sync(this);
				_alt = this.interpreter.adaptivePredict(this._input, 75, this._ctx);
			}
			this.state = 801;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__17) {
				{
				this.state = 800;
				this.match(SolidityParser.T__17);
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public nameValue(): NameValueContext {
		let _localctx: NameValueContext = new NameValueContext(this._ctx, this.state);
		this.enterRule(_localctx, 126, SolidityParser.RULE_nameValue);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 803;
			this.identifier();
			this.state = 804;
			this.match(SolidityParser.T__74);
			this.state = 805;
			this.expression(0);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public functionCallArguments(): FunctionCallArgumentsContext {
		let _localctx: FunctionCallArgumentsContext = new FunctionCallArgumentsContext(this._ctx, this.state);
		this.enterRule(_localctx, 128, SolidityParser.RULE_functionCallArguments);
		let _la: number;
		try {
			this.state = 815;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__11:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 807;
				this.match(SolidityParser.T__11);
				this.state = 809;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
					{
					this.state = 808;
					this.nameValueList();
					}
				}

				this.state = 811;
				this.match(SolidityParser.T__12);
				}
				break;
			case SolidityParser.T__3:
			case SolidityParser.T__16:
			case SolidityParser.T__22:
			case SolidityParser.T__23:
			case SolidityParser.T__33:
			case SolidityParser.T__35:
			case SolidityParser.T__50:
			case SolidityParser.T__51:
			case SolidityParser.T__52:
			case SolidityParser.T__53:
			case SolidityParser.T__54:
			case SolidityParser.T__55:
			case SolidityParser.T__56:
			case SolidityParser.T__57:
			case SolidityParser.T__58:
			case SolidityParser.T__59:
			case SolidityParser.T__60:
			case SolidityParser.T__61:
			case SolidityParser.T__85:
			case SolidityParser.T__86:
			case SolidityParser.Int:
			case SolidityParser.Uint:
			case SolidityParser.Byte:
			case SolidityParser.Fixed:
			case SolidityParser.Ufixed:
			case SolidityParser.BooleanLiteral:
			case SolidityParser.DecimalNumber:
			case SolidityParser.HexNumber:
			case SolidityParser.HexLiteral:
			case SolidityParser.Identifier:
			case SolidityParser.StringLiteral:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 813;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
					{
					this.state = 812;
					this.expressionList();
					}
				}

				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public functionCall(): FunctionCallContext {
		let _localctx: FunctionCallContext = new FunctionCallContext(this._ctx, this.state);
		this.enterRule(_localctx, 130, SolidityParser.RULE_functionCall);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 817;
			this.expression(0);
			this.state = 818;
			this.match(SolidityParser.T__22);
			this.state = 819;
			this.functionCallArguments();
			this.state = 820;
			this.match(SolidityParser.T__23);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyBlock(): AssemblyBlockContext {
		let _localctx: AssemblyBlockContext = new AssemblyBlockContext(this._ctx, this.state);
		this.enterRule(_localctx, 132, SolidityParser.RULE_assemblyBlock);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 822;
			this.match(SolidityParser.T__11);
			this.state = 826;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__11) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22) | (1 << SolidityParser.T__25) | (1 << SolidityParser.T__29))) !== 0) || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__42 - 36)) | (1 << (SolidityParser.T__45 - 36)) | (1 << (SolidityParser.T__47 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 88)) & ~0x1F) === 0 && ((1 << (_la - 88)) & ((1 << (SolidityParser.T__87 - 88)) | (1 << (SolidityParser.T__89 - 88)) | (1 << (SolidityParser.T__90 - 88)) | (1 << (SolidityParser.DecimalNumber - 88)) | (1 << (SolidityParser.HexNumber - 88)) | (1 << (SolidityParser.HexLiteral - 88)) | (1 << (SolidityParser.BreakKeyword - 88)) | (1 << (SolidityParser.ContinueKeyword - 88)) | (1 << (SolidityParser.Identifier - 88)))) !== 0) || _la === SolidityParser.StringLiteral) {
				{
				{
				this.state = 823;
				this.assemblyItem();
				}
				}
				this.state = 828;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			this.state = 829;
			this.match(SolidityParser.T__12);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyItem(): AssemblyItemContext {
		let _localctx: AssemblyItemContext = new AssemblyItemContext(this._ctx, this.state);
		this.enterRule(_localctx, 134, SolidityParser.RULE_assemblyItem);
		try {
			this.state = 848;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 81, this._ctx) ) {
			case 1:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 831;
				this.identifier();
				}
				break;

			case 2:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 832;
				this.assemblyBlock();
				}
				break;

			case 3:
				this.enterOuterAlt(_localctx, 3);
				{
				this.state = 833;
				this.assemblyExpression();
				}
				break;

			case 4:
				this.enterOuterAlt(_localctx, 4);
				{
				this.state = 834;
				this.assemblyLocalDefinition();
				}
				break;

			case 5:
				this.enterOuterAlt(_localctx, 5);
				{
				this.state = 835;
				this.assemblyAssignment();
				}
				break;

			case 6:
				this.enterOuterAlt(_localctx, 6);
				{
				this.state = 836;
				this.assemblyStackAssignment();
				}
				break;

			case 7:
				this.enterOuterAlt(_localctx, 7);
				{
				this.state = 837;
				this.labelDefinition();
				}
				break;

			case 8:
				this.enterOuterAlt(_localctx, 8);
				{
				this.state = 838;
				this.assemblySwitch();
				}
				break;

			case 9:
				this.enterOuterAlt(_localctx, 9);
				{
				this.state = 839;
				this.assemblyFunctionDefinition();
				}
				break;

			case 10:
				this.enterOuterAlt(_localctx, 10);
				{
				this.state = 840;
				this.assemblyFor();
				}
				break;

			case 11:
				this.enterOuterAlt(_localctx, 11);
				{
				this.state = 841;
				this.assemblyIf();
				}
				break;

			case 12:
				this.enterOuterAlt(_localctx, 12);
				{
				this.state = 842;
				this.match(SolidityParser.BreakKeyword);
				}
				break;

			case 13:
				this.enterOuterAlt(_localctx, 13);
				{
				this.state = 843;
				this.match(SolidityParser.ContinueKeyword);
				}
				break;

			case 14:
				this.enterOuterAlt(_localctx, 14);
				{
				this.state = 844;
				this.subAssembly();
				}
				break;

			case 15:
				this.enterOuterAlt(_localctx, 15);
				{
				this.state = 845;
				this.numberLiteral();
				}
				break;

			case 16:
				this.enterOuterAlt(_localctx, 16);
				{
				this.state = 846;
				this.match(SolidityParser.StringLiteral);
				}
				break;

			case 17:
				this.enterOuterAlt(_localctx, 17);
				{
				this.state = 847;
				this.match(SolidityParser.HexLiteral);
				}
				break;
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyExpression(): AssemblyExpressionContext {
		let _localctx: AssemblyExpressionContext = new AssemblyExpressionContext(this._ctx, this.state);
		this.enterRule(_localctx, 136, SolidityParser.RULE_assemblyExpression);
		try {
			this.state = 852;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__16:
			case SolidityParser.T__35:
			case SolidityParser.T__47:
			case SolidityParser.T__53:
			case SolidityParser.Identifier:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 850;
				this.assemblyCall();
				}
				break;
			case SolidityParser.DecimalNumber:
			case SolidityParser.HexNumber:
			case SolidityParser.HexLiteral:
			case SolidityParser.StringLiteral:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 851;
				this.assemblyLiteral();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyCall(): AssemblyCallContext {
		let _localctx: AssemblyCallContext = new AssemblyCallContext(this._ctx, this.state);
		this.enterRule(_localctx, 138, SolidityParser.RULE_assemblyCall);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 858;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__47:
				{
				this.state = 854;
				this.match(SolidityParser.T__47);
				}
				break;
			case SolidityParser.T__35:
				{
				this.state = 855;
				this.match(SolidityParser.T__35);
				}
				break;
			case SolidityParser.T__53:
				{
				this.state = 856;
				this.match(SolidityParser.T__53);
				}
				break;
			case SolidityParser.T__16:
			case SolidityParser.Identifier:
				{
				this.state = 857;
				this.identifier();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			this.state = 872;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 86, this._ctx) ) {
			case 1:
				{
				this.state = 860;
				this.match(SolidityParser.T__22);
				this.state = 862;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if (_la === SolidityParser.T__16 || ((((_la - 36)) & ~0x1F) === 0 && ((1 << (_la - 36)) & ((1 << (SolidityParser.T__35 - 36)) | (1 << (SolidityParser.T__47 - 36)) | (1 << (SolidityParser.T__53 - 36)))) !== 0) || ((((_la - 102)) & ~0x1F) === 0 && ((1 << (_la - 102)) & ((1 << (SolidityParser.DecimalNumber - 102)) | (1 << (SolidityParser.HexNumber - 102)) | (1 << (SolidityParser.HexLiteral - 102)) | (1 << (SolidityParser.Identifier - 102)) | (1 << (SolidityParser.StringLiteral - 102)))) !== 0)) {
					{
					this.state = 861;
					this.assemblyExpression();
					}
				}

				this.state = 868;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 864;
					this.match(SolidityParser.T__17);
					this.state = 865;
					this.assemblyExpression();
					}
					}
					this.state = 870;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				this.state = 871;
				this.match(SolidityParser.T__23);
				}
				break;
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyLocalDefinition(): AssemblyLocalDefinitionContext {
		let _localctx: AssemblyLocalDefinitionContext = new AssemblyLocalDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 140, SolidityParser.RULE_assemblyLocalDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 874;
			this.match(SolidityParser.T__87);
			this.state = 875;
			this.assemblyIdentifierOrList();
			this.state = 878;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__88) {
				{
				this.state = 876;
				this.match(SolidityParser.T__88);
				this.state = 877;
				this.assemblyExpression();
				}
			}

			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyAssignment(): AssemblyAssignmentContext {
		let _localctx: AssemblyAssignmentContext = new AssemblyAssignmentContext(this._ctx, this.state);
		this.enterRule(_localctx, 142, SolidityParser.RULE_assemblyAssignment);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 880;
			this.assemblyIdentifierOrList();
			this.state = 881;
			this.match(SolidityParser.T__88);
			this.state = 882;
			this.assemblyExpression();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyIdentifierOrList(): AssemblyIdentifierOrListContext {
		let _localctx: AssemblyIdentifierOrListContext = new AssemblyIdentifierOrListContext(this._ctx, this.state);
		this.enterRule(_localctx, 144, SolidityParser.RULE_assemblyIdentifierOrList);
		try {
			this.state = 889;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__16:
			case SolidityParser.Identifier:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 884;
				this.identifier();
				}
				break;
			case SolidityParser.T__22:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 885;
				this.match(SolidityParser.T__22);
				this.state = 886;
				this.assemblyIdentifierList();
				this.state = 887;
				this.match(SolidityParser.T__23);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyIdentifierList(): AssemblyIdentifierListContext {
		let _localctx: AssemblyIdentifierListContext = new AssemblyIdentifierListContext(this._ctx, this.state);
		this.enterRule(_localctx, 146, SolidityParser.RULE_assemblyIdentifierList);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 891;
			this.identifier();
			this.state = 896;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while (_la === SolidityParser.T__17) {
				{
				{
				this.state = 892;
				this.match(SolidityParser.T__17);
				this.state = 893;
				this.identifier();
				}
				}
				this.state = 898;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyStackAssignment(): AssemblyStackAssignmentContext {
		let _localctx: AssemblyStackAssignmentContext = new AssemblyStackAssignmentContext(this._ctx, this.state);
		this.enterRule(_localctx, 148, SolidityParser.RULE_assemblyStackAssignment);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 899;
			this.match(SolidityParser.T__89);
			this.state = 900;
			this.identifier();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public labelDefinition(): LabelDefinitionContext {
		let _localctx: LabelDefinitionContext = new LabelDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 150, SolidityParser.RULE_labelDefinition);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 902;
			this.identifier();
			this.state = 903;
			this.match(SolidityParser.T__74);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblySwitch(): AssemblySwitchContext {
		let _localctx: AssemblySwitchContext = new AssemblySwitchContext(this._ctx, this.state);
		this.enterRule(_localctx, 152, SolidityParser.RULE_assemblySwitch);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 905;
			this.match(SolidityParser.T__90);
			this.state = 906;
			this.assemblyExpression();
			this.state = 910;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			while (_la === SolidityParser.T__91 || _la === SolidityParser.T__92) {
				{
				{
				this.state = 907;
				this.assemblyCase();
				}
				}
				this.state = 912;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyCase(): AssemblyCaseContext {
		let _localctx: AssemblyCaseContext = new AssemblyCaseContext(this._ctx, this.state);
		this.enterRule(_localctx, 154, SolidityParser.RULE_assemblyCase);
		try {
			this.state = 919;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__91:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 913;
				this.match(SolidityParser.T__91);
				this.state = 914;
				this.assemblyLiteral();
				this.state = 915;
				this.assemblyBlock();
				}
				break;
			case SolidityParser.T__92:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 917;
				this.match(SolidityParser.T__92);
				this.state = 918;
				this.assemblyBlock();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyFunctionDefinition(): AssemblyFunctionDefinitionContext {
		let _localctx: AssemblyFunctionDefinitionContext = new AssemblyFunctionDefinitionContext(this._ctx, this.state);
		this.enterRule(_localctx, 156, SolidityParser.RULE_assemblyFunctionDefinition);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 921;
			this.match(SolidityParser.T__29);
			this.state = 922;
			this.identifier();
			this.state = 923;
			this.match(SolidityParser.T__22);
			this.state = 925;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__16 || _la === SolidityParser.Identifier) {
				{
				this.state = 924;
				this.assemblyIdentifierList();
				}
			}

			this.state = 927;
			this.match(SolidityParser.T__23);
			this.state = 929;
			this._errHandler.sync(this);
			_la = this._input.LA(1);
			if (_la === SolidityParser.T__93) {
				{
				this.state = 928;
				this.assemblyFunctionReturns();
				}
			}

			this.state = 931;
			this.assemblyBlock();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyFunctionReturns(): AssemblyFunctionReturnsContext {
		let _localctx: AssemblyFunctionReturnsContext = new AssemblyFunctionReturnsContext(this._ctx, this.state);
		this.enterRule(_localctx, 158, SolidityParser.RULE_assemblyFunctionReturns);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			{
			this.state = 933;
			this.match(SolidityParser.T__93);
			this.state = 934;
			this.assemblyIdentifierList();
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyFor(): AssemblyForContext {
		let _localctx: AssemblyForContext = new AssemblyForContext(this._ctx, this.state);
		this.enterRule(_localctx, 160, SolidityParser.RULE_assemblyFor);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 936;
			this.match(SolidityParser.T__25);
			this.state = 939;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__11:
				{
				this.state = 937;
				this.assemblyBlock();
				}
				break;
			case SolidityParser.T__16:
			case SolidityParser.T__35:
			case SolidityParser.T__47:
			case SolidityParser.T__53:
			case SolidityParser.DecimalNumber:
			case SolidityParser.HexNumber:
			case SolidityParser.HexLiteral:
			case SolidityParser.Identifier:
			case SolidityParser.StringLiteral:
				{
				this.state = 938;
				this.assemblyExpression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			this.state = 941;
			this.assemblyExpression();
			this.state = 944;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__11:
				{
				this.state = 942;
				this.assemblyBlock();
				}
				break;
			case SolidityParser.T__16:
			case SolidityParser.T__35:
			case SolidityParser.T__47:
			case SolidityParser.T__53:
			case SolidityParser.DecimalNumber:
			case SolidityParser.HexNumber:
			case SolidityParser.HexLiteral:
			case SolidityParser.Identifier:
			case SolidityParser.StringLiteral:
				{
				this.state = 943;
				this.assemblyExpression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			this.state = 946;
			this.assemblyBlock();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyIf(): AssemblyIfContext {
		let _localctx: AssemblyIfContext = new AssemblyIfContext(this._ctx, this.state);
		this.enterRule(_localctx, 162, SolidityParser.RULE_assemblyIf);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 948;
			this.match(SolidityParser.T__42);
			this.state = 949;
			this.assemblyExpression();
			this.state = 950;
			this.assemblyBlock();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public assemblyLiteral(): AssemblyLiteralContext {
		let _localctx: AssemblyLiteralContext = new AssemblyLiteralContext(this._ctx, this.state);
		this.enterRule(_localctx, 164, SolidityParser.RULE_assemblyLiteral);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 952;
			_la = this._input.LA(1);
			if (!(((((_la - 102)) & ~0x1F) === 0 && ((1 << (_la - 102)) & ((1 << (SolidityParser.DecimalNumber - 102)) | (1 << (SolidityParser.HexNumber - 102)) | (1 << (SolidityParser.HexLiteral - 102)) | (1 << (SolidityParser.StringLiteral - 102)))) !== 0))) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public subAssembly(): SubAssemblyContext {
		let _localctx: SubAssemblyContext = new SubAssemblyContext(this._ctx, this.state);
		this.enterRule(_localctx, 166, SolidityParser.RULE_subAssembly);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 954;
			this.match(SolidityParser.T__45);
			this.state = 955;
			this.identifier();
			this.state = 956;
			this.assemblyBlock();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public tupleExpression(): TupleExpressionContext {
		let _localctx: TupleExpressionContext = new TupleExpressionContext(this._ctx, this.state);
		this.enterRule(_localctx, 168, SolidityParser.RULE_tupleExpression);
		let _la: number;
		try {
			this.state = 984;
			this._errHandler.sync(this);
			switch (this._input.LA(1)) {
			case SolidityParser.T__22:
				this.enterOuterAlt(_localctx, 1);
				{
				this.state = 958;
				this.match(SolidityParser.T__22);
				{
				this.state = 960;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
					{
					this.state = 959;
					this.expression(0);
					}
				}

				this.state = 968;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				while (_la === SolidityParser.T__17) {
					{
					{
					this.state = 962;
					this.match(SolidityParser.T__17);
					this.state = 964;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
					if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
						{
						this.state = 963;
						this.expression(0);
						}
					}

					}
					}
					this.state = 970;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
				}
				}
				this.state = 971;
				this.match(SolidityParser.T__23);
				}
				break;
			case SolidityParser.T__33:
				this.enterOuterAlt(_localctx, 2);
				{
				this.state = 972;
				this.match(SolidityParser.T__33);
				this.state = 981;
				this._errHandler.sync(this);
				_la = this._input.LA(1);
				if ((((_la) & ~0x1F) === 0 && ((1 << _la) & ((1 << SolidityParser.T__3) | (1 << SolidityParser.T__16) | (1 << SolidityParser.T__22))) !== 0) || ((((_la - 34)) & ~0x1F) === 0 && ((1 << (_la - 34)) & ((1 << (SolidityParser.T__33 - 34)) | (1 << (SolidityParser.T__35 - 34)) | (1 << (SolidityParser.T__50 - 34)) | (1 << (SolidityParser.T__51 - 34)) | (1 << (SolidityParser.T__52 - 34)) | (1 << (SolidityParser.T__53 - 34)) | (1 << (SolidityParser.T__54 - 34)) | (1 << (SolidityParser.T__55 - 34)) | (1 << (SolidityParser.T__56 - 34)) | (1 << (SolidityParser.T__57 - 34)) | (1 << (SolidityParser.T__58 - 34)) | (1 << (SolidityParser.T__59 - 34)) | (1 << (SolidityParser.T__60 - 34)) | (1 << (SolidityParser.T__61 - 34)))) !== 0) || ((((_la - 86)) & ~0x1F) === 0 && ((1 << (_la - 86)) & ((1 << (SolidityParser.T__85 - 86)) | (1 << (SolidityParser.T__86 - 86)) | (1 << (SolidityParser.Int - 86)) | (1 << (SolidityParser.Uint - 86)) | (1 << (SolidityParser.Byte - 86)) | (1 << (SolidityParser.Fixed - 86)) | (1 << (SolidityParser.Ufixed - 86)) | (1 << (SolidityParser.BooleanLiteral - 86)) | (1 << (SolidityParser.DecimalNumber - 86)) | (1 << (SolidityParser.HexNumber - 86)) | (1 << (SolidityParser.HexLiteral - 86)))) !== 0) || _la === SolidityParser.Identifier || _la === SolidityParser.StringLiteral) {
					{
					this.state = 973;
					this.expression(0);
					this.state = 978;
					this._errHandler.sync(this);
					_la = this._input.LA(1);
					while (_la === SolidityParser.T__17) {
						{
						{
						this.state = 974;
						this.match(SolidityParser.T__17);
						this.state = 975;
						this.expression(0);
						}
						}
						this.state = 980;
						this._errHandler.sync(this);
						_la = this._input.LA(1);
					}
					}
				}

				this.state = 983;
				this.match(SolidityParser.T__34);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public elementaryTypeNameExpression(): ElementaryTypeNameExpressionContext {
		let _localctx: ElementaryTypeNameExpressionContext = new ElementaryTypeNameExpressionContext(this._ctx, this.state);
		this.enterRule(_localctx, 170, SolidityParser.RULE_elementaryTypeNameExpression);
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 986;
			this.elementaryTypeName();
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public numberLiteral(): NumberLiteralContext {
		let _localctx: NumberLiteralContext = new NumberLiteralContext(this._ctx, this.state);
		this.enterRule(_localctx, 172, SolidityParser.RULE_numberLiteral);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 988;
			_la = this._input.LA(1);
			if (!(_la === SolidityParser.DecimalNumber || _la === SolidityParser.HexNumber)) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			this.state = 990;
			this._errHandler.sync(this);
			switch ( this.interpreter.adaptivePredict(this._input, 102, this._ctx) ) {
			case 1:
				{
				this.state = 989;
				this.match(SolidityParser.NumberUnit);
				}
				break;
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}
	// @RuleVersion(0)
	public identifier(): IdentifierContext {
		let _localctx: IdentifierContext = new IdentifierContext(this._ctx, this.state);
		this.enterRule(_localctx, 174, SolidityParser.RULE_identifier);
		let _la: number;
		try {
			this.enterOuterAlt(_localctx, 1);
			{
			this.state = 992;
			_la = this._input.LA(1);
			if (!(_la === SolidityParser.T__16 || _la === SolidityParser.Identifier)) {
			this._errHandler.recoverInline(this);
			} else {
				if (this._input.LA(1) === Token.EOF) {
					this.matchedEOF = true;
				}

				this._errHandler.reportMatch(this);
				this.consume();
			}
			}
		}
		catch (re) {
			if (re instanceof RecognitionException) {
				_localctx.exception = re;
				this._errHandler.reportError(this, re);
				this._errHandler.recover(this, re);
			} else {
				throw re;
			}
		}
		finally {
			this.exitRule();
		}
		return _localctx;
	}

	public sempred(_localctx: RuleContext, ruleIndex: number, predIndex: number): boolean {
		switch (ruleIndex) {
		case 33:
			return this.typeName_sempred(_localctx as TypeNameContext, predIndex);

		case 57:
			return this.expression_sempred(_localctx as ExpressionContext, predIndex);
		}
		return true;
	}
	private typeName_sempred(_localctx: TypeNameContext, predIndex: number): boolean {
		switch (predIndex) {
		case 0:
			return this.precpred(this._ctx, 3);
		}
		return true;
	}
	private expression_sempred(_localctx: ExpressionContext, predIndex: number): boolean {
		switch (predIndex) {
		case 1:
			return this.precpred(this._ctx, 16);

		case 2:
			return this.precpred(this._ctx, 15);

		case 3:
			return this.precpred(this._ctx, 14);

		case 4:
			return this.precpred(this._ctx, 13);

		case 5:
			return this.precpred(this._ctx, 12);

		case 6:
			return this.precpred(this._ctx, 11);

		case 7:
			return this.precpred(this._ctx, 10);

		case 8:
			return this.precpred(this._ctx, 9);

		case 9:
			return this.precpred(this._ctx, 8);

		case 10:
			return this.precpred(this._ctx, 7);

		case 11:
			return this.precpred(this._ctx, 6);

		case 12:
			return this.precpred(this._ctx, 5);

		case 13:
			return this.precpred(this._ctx, 4);

		case 14:
			return this.precpred(this._ctx, 27);

		case 15:
			return this.precpred(this._ctx, 25);

		case 16:
			return this.precpred(this._ctx, 24);

		case 17:
			return this.precpred(this._ctx, 23);
		}
		return true;
	}

	private static readonly _serializedATNSegments: number = 2;
	private static readonly _serializedATNSegment0: string =
		"\x03\uC91D\uCABA\u058D\uAFBA\u4F53\u0607\uEA8B\uC241\x03}\u03E5\x04\x02" +
		"\t\x02\x04\x03\t\x03\x04\x04\t\x04\x04\x05\t\x05\x04\x06\t\x06\x04\x07" +
		"\t\x07\x04\b\t\b\x04\t\t\t\x04\n\t\n\x04\v\t\v\x04\f\t\f\x04\r\t\r\x04" +
		"\x0E\t\x0E\x04\x0F\t\x0F\x04\x10\t\x10\x04\x11\t\x11\x04\x12\t\x12\x04" +
		"\x13\t\x13\x04\x14\t\x14\x04\x15\t\x15\x04\x16\t\x16\x04\x17\t\x17\x04" +
		"\x18\t\x18\x04\x19\t\x19\x04\x1A\t\x1A\x04\x1B\t\x1B\x04\x1C\t\x1C\x04" +
		"\x1D\t\x1D\x04\x1E\t\x1E\x04\x1F\t\x1F\x04 \t \x04!\t!\x04\"\t\"\x04#" +
		"\t#\x04$\t$\x04%\t%\x04&\t&\x04\'\t\'\x04(\t(\x04)\t)\x04*\t*\x04+\t+" +
		"\x04,\t,\x04-\t-\x04.\t.\x04/\t/\x040\t0\x041\t1\x042\t2\x043\t3\x044" +
		"\t4\x045\t5\x046\t6\x047\t7\x048\t8\x049\t9\x04:\t:\x04;\t;\x04<\t<\x04" +
		"=\t=\x04>\t>\x04?\t?\x04@\t@\x04A\tA\x04B\tB\x04C\tC\x04D\tD\x04E\tE\x04" +
		"F\tF\x04G\tG\x04H\tH\x04I\tI\x04J\tJ\x04K\tK\x04L\tL\x04M\tM\x04N\tN\x04" +
		"O\tO\x04P\tP\x04Q\tQ\x04R\tR\x04S\tS\x04T\tT\x04U\tU\x04V\tV\x04W\tW\x04" +
		"X\tX\x04Y\tY\x03\x02\x03\x02\x03\x02\x03\x02\x07\x02\xB7\n\x02\f\x02\x0E" +
		"\x02\xBA\v\x02\x03\x02\x03\x02\x03\x03\x03\x03\x03\x03\x03\x03\x03\x03" +
		"\x03\x04\x03\x04\x03\x05\x03\x05\x05\x05\xC7\n\x05\x03\x06\x03\x06\x05" +
		"\x06\xCB\n\x06\x03\x07\x03\x07\x03\b\x05\b\xD0\n\b\x03\b\x03\b\x03\t\x03" +
		"\t\x03\t\x05\t\xD7\n\t\x03\n\x03\n\x03\n\x03\n\x07\n\xDD\n\n\f\n\x0E\n" +
		"\xE0\v\n\x03\n\x03\n\x03\n\x03\n\x03\v\x03\v\x03\v\x03\v\x03\f\x03\f\x03" +
		"\f\x03\f\x05\f\xEE\n\f\x03\f\x03\f\x03\f\x03\f\x05\f\xF4\n\f\x03\f\x03" +
		"\f\x05\f\xF8\n\f\x03\f\x03\f\x03\f\x03\f\x03\f\x03\f\x03\f\x03\f\x07\f" +
		"\u0102\n\f\f\f\x0E\f\u0105\v\f\x03\f\x03\f\x03\f\x03\f\x03\f\x05\f\u010C" +
		"\n\f\x03\r\x03\r\x03\r\x03\r\x03\r\x03\r\x07\r\u0114\n\r\f\r\x0E\r\u0117" +
		"\v\r\x05\r\u0119\n\r\x03\r\x03\r\x07\r\u011D\n\r\f\r\x0E\r\u0120\v\r\x03" +
		"\r\x03\r\x03\x0E\x03\x0E\x03\x0E\x03\x0E\x03\x0E\x07\x0E\u0129\n\x0E\f" +
		"\x0E\x0E\x0E\u012C\v\x0E\x03\x0E\x03\x0E\x05\x0E\u0130\n\x0E\x03\x0F\x03" +
		"\x0F\x03\x0F\x03\x0F\x03\x0F\x03\x0F\x03\x0F\x03\x0F\x05\x0F\u013A\n\x0F" +
		"\x03\x10\x03\x10\x07\x10\u013E\n\x10\f\x10\x0E\x10\u0141\v\x10\x03\x10" +
		"\x03\x10\x03\x10\x05\x10\u0146\n\x10\x03\x10\x03\x10\x03\x11\x03\x11\x03" +
		"\x11\x03\x11\x03\x11\x05\x11\u014F\n\x11\x03\x11\x03\x11\x03\x12\x03\x12" +
		"\x03\x12\x03\x12\x03\x12\x03\x12\x03\x12\x03\x12\x07\x12\u015B\n\x12\f" +
		"\x12\x0E\x12\u015E\v\x12\x05\x12\u0160\n\x12\x03\x12\x03\x12\x03\x13\x03" +
		"\x13\x03\x13\x03\x13\x03\x13\x03\x14\x03\x14\x03\x14\x05\x14\u016C\n\x14" +
		"\x03\x14\x03\x14\x03\x15\x03\x15\x03\x15\x05\x15\u0173\n\x15\x03\x15\x05" +
		"\x15\u0176\n\x15\x03\x16\x03\x16\x05\x16\u017A\n\x16\x03\x16\x03\x16\x03" +
		"\x16\x05\x16\u017F\n\x16\x03\x16\x03\x16\x05\x16\u0183\n\x16\x03\x17\x03" +
		"\x17\x03\x17\x03\x18\x03\x18\x03\x18\x03\x18\x03\x18\x03\x18\x07\x18\u018E" +
		"\n\x18\f\x18\x0E\x18\u0191\v\x18\x03\x19\x03\x19\x03\x19\x03\x19\x05\x19" +
		"\u0197\n\x19\x03\x19\x03\x19\x03\x1A\x03\x1A\x03\x1B\x03\x1B\x03\x1B\x03" +
		"\x1B\x05\x1B\u01A1\n\x1B\x03\x1B\x03\x1B\x07\x1B\u01A5\n\x1B\f\x1B\x0E" +
		"\x1B\u01A8\v\x1B\x03\x1B\x03\x1B\x03\x1C\x03\x1C\x03\x1C\x03\x1C\x07\x1C" +
		"\u01B0\n\x1C\f\x1C\x0E\x1C\u01B3\v\x1C\x05\x1C\u01B5\n\x1C\x03\x1C\x03" +
		"\x1C\x03\x1D\x03\x1D\x05\x1D\u01BB\n\x1D\x03\x1D\x05\x1D\u01BE\n\x1D\x03" +
		"\x1E\x03\x1E\x03\x1E\x03\x1E\x07\x1E\u01C4\n\x1E\f\x1E\x0E\x1E\u01C7\v" +
		"\x1E\x05\x1E\u01C9\n\x1E\x03\x1E\x03\x1E\x03\x1F\x03\x1F\x05\x1F\u01CF" +
		"\n\x1F\x03\x1F\x05\x1F\u01D2\n\x1F\x03 \x03 \x03 \x03 \x07 \u01D8\n \f" +
		" \x0E \u01DB\v \x05 \u01DD\n \x03 \x03 \x03!\x03!\x05!\u01E3\n!\x03\"" +
		"\x03\"\x05\"\u01E7\n\"\x03\"\x03\"\x03#\x03#\x03#\x03#\x03#\x03#\x03#" +
		"\x05#\u01F2\n#\x03#\x03#\x03#\x05#\u01F7\n#\x03#\x07#\u01FA\n#\f#\x0E" +
		"#\u01FD\v#\x03$\x03$\x03$\x07$\u0202\n$\f$\x0E$\u0205\v$\x03%\x03%\x03" +
		"%\x03%\x03%\x03%\x03%\x03&\x03&\x03&\x03&\x03&\x07&\u0213\n&\f&\x0E&\u0216" +
		"\v&\x03&\x03&\x05&\u021A\n&\x03\'\x03\'\x03(\x03(\x03)\x03)\x07)\u0222" +
		"\n)\f)\x0E)\u0225\v)\x03)\x03)\x03*\x03*\x03*\x03*\x03*\x03*\x03*\x03" +
		"*\x03*\x03*\x03*\x03*\x05*\u0235\n*\x03+\x03+\x03+\x03,\x03,\x03,\x03" +
		",\x03,\x03,\x03,\x05,\u0241\n,\x03-\x03-\x03-\x03-\x03-\x03-\x03.\x03" +
		".\x05.\u024B\n.\x03/\x03/\x03/\x03/\x05/\u0251\n/\x03/\x05/\u0254\n/\x03" +
		"/\x03/\x05/\u0258\n/\x03/\x03/\x03/\x030\x030\x050\u025F\n0\x030\x030" +
		"\x031\x031\x031\x031\x031\x031\x031\x031\x032\x032\x032\x033\x033\x03" +
		"3\x034\x034\x054\u0273\n4\x034\x034\x035\x035\x035\x036\x036\x036\x03" +
		"6\x037\x037\x037\x037\x037\x037\x037\x057\u0285\n7\x037\x037\x057\u0289" +
		"\n7\x037\x037\x038\x058\u028E\n8\x038\x038\x058\u0292\n8\x078\u0294\n" +
		"8\f8\x0E8\u0297\v8\x039\x039\x059\u029B\n9\x039\x079\u029E\n9\f9\x0E9" +
		"\u02A1\v9\x039\x059\u02A4\n9\x039\x039\x03:\x03:\x03;\x03;\x03;\x03;\x03" +
		";\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03" +
		";\x03;\x05;\u02BE\n;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03" +
		";\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03" +
		";\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03" +
		";\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03;\x03" +
		";\x03;\x03;\x03;\x03;\x03;\x07;\u02F9\n;\f;\x0E;\u02FC\v;\x03<\x03<\x03" +
		"<\x03<\x03<\x03=\x03=\x03=\x03=\x03=\x03=\x03=\x03>\x03>\x03>\x03>\x03" +
		">\x03>\x03>\x05>\u0311\n>\x03?\x03?\x03?\x07?\u0316\n?\f?\x0E?\u0319\v" +
		"?\x03@\x03@\x03@\x07@\u031E\n@\f@\x0E@\u0321\v@\x03@\x05@\u0324\n@\x03" +
		"A\x03A\x03A\x03A\x03B\x03B\x05B\u032C\nB\x03B\x03B\x05B\u0330\nB\x05B" +
		"\u0332\nB\x03C\x03C\x03C\x03C\x03C\x03D\x03D\x07D\u033B\nD\fD\x0ED\u033E" +
		"\vD\x03D\x03D\x03E\x03E\x03E\x03E\x03E\x03E\x03E\x03E\x03E\x03E\x03E\x03" +
		"E\x03E\x03E\x03E\x03E\x03E\x05E\u0353\nE\x03F\x03F\x05F\u0357\nF\x03G" +
		"\x03G\x03G\x03G\x05G\u035D\nG\x03G\x03G\x05G\u0361\nG\x03G\x03G\x07G\u0365" +
		"\nG\fG\x0EG\u0368\vG\x03G\x05G\u036B\nG\x03H\x03H\x03H\x03H\x05H\u0371" +
		"\nH\x03I\x03I\x03I\x03I\x03J\x03J\x03J\x03J\x03J\x05J\u037C\nJ\x03K\x03" +
		"K\x03K\x07K\u0381\nK\fK\x0EK\u0384\vK\x03L\x03L\x03L\x03M\x03M\x03M\x03" +
		"N\x03N\x03N\x07N\u038F\nN\fN\x0EN\u0392\vN\x03O\x03O\x03O\x03O\x03O\x03" +
		"O\x05O\u039A\nO\x03P\x03P\x03P\x03P\x05P\u03A0\nP\x03P\x03P\x05P\u03A4" +
		"\nP\x03P\x03P\x03Q\x03Q\x03Q\x03R\x03R\x03R\x05R\u03AE\nR\x03R\x03R\x03" +
		"R\x05R\u03B3\nR\x03R\x03R\x03S\x03S\x03S\x03S\x03T\x03T\x03U\x03U\x03" +
		"U\x03U\x03V\x03V\x05V\u03C3\nV\x03V\x03V\x05V\u03C7\nV\x07V\u03C9\nV\f" +
		"V\x0EV\u03CC\vV\x03V\x03V\x03V\x03V\x03V\x07V\u03D3\nV\fV\x0EV\u03D6\v" +
		"V\x05V\u03D8\nV\x03V\x05V\u03DB\nV\x03W\x03W\x03X\x03X\x05X\u03E1\nX\x03" +
		"Y\x03Y\x03Y\x02\x02\x04DtZ\x02\x02\x04\x02\x06\x02\b\x02\n\x02\f\x02\x0E" +
		"\x02\x10\x02\x12\x02\x14\x02\x16\x02\x18\x02\x1A\x02\x1C\x02\x1E\x02 " +
		"\x02\"\x02$\x02&\x02(\x02*\x02,\x02.\x020\x022\x024\x026\x028\x02:\x02" +
		"<\x02>\x02@\x02B\x02D\x02F\x02H\x02J\x02L\x02N\x02P\x02R\x02T\x02V\x02" +
		"X\x02Z\x02\\\x02^\x02`\x02b\x02d\x02f\x02h\x02j\x02l\x02n\x02p\x02r\x02" +
		"t\x02v\x02x\x02z\x02|\x02~\x02\x80\x02\x82\x02\x84\x02\x86\x02\x88\x02" +
		"\x8A\x02\x8C\x02\x8E\x02\x90\x02\x92\x02\x94\x02\x96\x02\x98\x02\x9A\x02" +
		"\x9C\x02\x9E\x02\xA0\x02\xA2\x02\xA4\x02\xA6\x02\xA8\x02\xAA\x02\xAC\x02" +
		"\xAE\x02\xB0\x02\x02\x13\x03\x02\x05\v\x03\x02\x15\x17\x05\x02oossuv\x03" +
		"\x02*,\x05\x02oottwx\x05\x02&&58ae\x03\x029:\x03\x02<=\x03\x02>?\x04\x02" +
		"\x12\x12BC\x03\x02DE\x03\x02\x07\n\x03\x02HI\x04\x02\v\vNW\x05\x02hik" +
		"kzz\x03\x02hi\x04\x02\x13\x13yy\x02\u043C\x02\xB8\x03\x02\x02\x02\x04" +
		"\xBD\x03\x02\x02\x02\x06\xC2\x03\x02\x02\x02\b\xC6\x03\x02\x02\x02\n\xC8" +
		"\x03\x02\x02\x02\f\xCC\x03\x02\x02\x02\x0E\xCF\x03\x02\x02\x02\x10\xD3" +
		"\x03\x02\x02\x02\x12\xD8\x03\x02\x02\x02\x14\xE5\x03\x02\x02\x02\x16\u010B" +
		"\x03\x02\x02\x02\x18\u010D\x03\x02\x02\x02\x1A\u0123\x03\x02\x02\x02\x1C" +
		"\u0139\x03\x02\x02\x02\x1E\u013B\x03\x02\x02\x02 \u0149\x03\x02\x02\x02" +
		"\"\u0152\x03\x02\x02\x02$\u0163\x03\x02\x02\x02&\u0168\x03\x02\x02\x02" +
		"(\u016F\x03\x02\x02\x02*\u0177\x03\x02\x02\x02,\u0184\x03\x02\x02\x02" +
		".\u018F\x03\x02\x02\x020\u0192\x03\x02\x02\x022\u019A\x03\x02\x02\x02" +
		"4\u019C\x03\x02\x02\x026\u01AB\x03\x02\x02\x028\u01B8\x03\x02\x02\x02" +
		":\u01BF\x03\x02\x02\x02<\u01CC\x03\x02\x02\x02>\u01D3\x03\x02\x02\x02" +
		"@\u01E0\x03\x02\x02\x02B\u01E4\x03\x02\x02\x02D\u01F1\x03\x02\x02\x02" +
		"F\u01FE\x03\x02\x02\x02H\u0206\x03\x02\x02\x02J\u020D\x03\x02\x02\x02" +
		"L\u021B\x03\x02\x02\x02N\u021D\x03\x02\x02\x02P\u021F\x03\x02\x02\x02" +
		"R\u0234\x03\x02\x02\x02T\u0236\x03\x02\x02\x02V\u0239\x03\x02\x02\x02" +
		"X\u0242\x03\x02\x02\x02Z\u024A\x03\x02\x02\x02\\\u024C\x03\x02\x02\x02" +
		"^\u025C\x03\x02\x02\x02`\u0262\x03\x02\x02\x02b\u026A\x03\x02\x02\x02" +
		"d\u026D\x03\x02\x02\x02f\u0270\x03\x02\x02\x02h\u0276\x03\x02\x02\x02" +
		"j\u0279\x03\x02\x02\x02l\u0284\x03\x02\x02\x02n\u028D\x03\x02\x02\x02" +
		"p\u0298\x03\x02\x02\x02r\u02A7\x03\x02\x02\x02t\u02BD\x03\x02\x02\x02" +
		"v\u02FD\x03\x02\x02\x02x\u0302\x03\x02\x02\x02z\u0310\x03\x02\x02\x02" +
		"|\u0312\x03\x02\x02\x02~\u031A\x03\x02\x02\x02\x80\u0325\x03\x02\x02\x02" +
		"\x82\u0331\x03\x02\x02\x02\x84\u0333\x03\x02\x02\x02\x86\u0338\x03\x02" +
		"\x02\x02\x88\u0352\x03\x02\x02\x02\x8A\u0356\x03\x02\x02\x02\x8C\u035C" +
		"\x03\x02\x02\x02\x8E\u036C\x03\x02\x02\x02\x90\u0372\x03\x02\x02\x02\x92" +
		"\u037B\x03\x02\x02\x02\x94\u037D\x03\x02\x02\x02\x96\u0385\x03\x02\x02" +
		"\x02\x98\u0388\x03\x02\x02\x02\x9A\u038B\x03\x02\x02\x02\x9C\u0399\x03" +
		"\x02\x02\x02\x9E\u039B\x03\x02\x02\x02\xA0\u03A7\x03\x02\x02\x02\xA2\u03AA" +
		"\x03\x02\x02\x02\xA4\u03B6\x03\x02\x02\x02\xA6\u03BA\x03\x02\x02\x02\xA8" +
		"\u03BC\x03\x02\x02\x02\xAA\u03DA\x03\x02\x02\x02\xAC\u03DC\x03\x02\x02" +
		"\x02\xAE\u03DE\x03\x02\x02\x02\xB0\u03E2\x03\x02\x02\x02\xB2\xB7\x05\x04" +
		"\x03\x02\xB3\xB7\x05\x16\f\x02\xB4\xB7\x05\x18\r\x02\xB5\xB7\x05\x12\n" +
		"\x02\xB6\xB2\x03\x02\x02\x02\xB6\xB3\x03\x02\x02\x02\xB6\xB4\x03\x02\x02" +
		"\x02\xB6\xB5\x03\x02\x02\x02\xB7\xBA\x03\x02\x02\x02\xB8\xB6\x03\x02\x02" +
		"\x02\xB8\xB9\x03\x02\x02\x02\xB9\xBB\x03\x02\x02\x02\xBA\xB8\x03\x02\x02" +
		"\x02\xBB\xBC\x07\x02\x02\x03\xBC\x03\x03\x02\x02\x02\xBD\xBE\x07\x03\x02" +
		"\x02\xBE\xBF\x05\x06\x04\x02\xBF\xC0\x05\b\x05\x02\xC0\xC1\x07\x04\x02" +
		"\x02\xC1\x05\x03\x02\x02\x02\xC2\xC3\x05\xB0Y\x02\xC3\x07\x03\x02\x02" +
		"\x02\xC4\xC7\x05\n\x06\x02\xC5\xC7\x05t;\x02\xC6\xC4\x03\x02\x02\x02\xC6" +
		"\xC5\x03\x02\x02\x02\xC7\t\x03\x02\x02\x02\xC8\xCA\x05\x0E\b\x02\xC9\xCB" +
		"\x05\x0E\b\x02\xCA\xC9\x03\x02\x02\x02\xCA\xCB\x03\x02\x02\x02\xCB\v\x03" +
		"\x02\x02\x02\xCC\xCD\t\x02\x02\x02\xCD\r\x03\x02\x02\x02\xCE\xD0\x05\f" +
		"\x07\x02\xCF\xCE\x03\x02\x02\x02\xCF\xD0\x03\x02\x02\x02\xD0\xD1\x03\x02" +
		"\x02\x02\xD1\xD2\x07f\x02\x02\xD2\x0F\x03\x02\x02\x02\xD3\xD6\x05\xB0" +
		"Y\x02\xD4\xD5\x07\f\x02\x02\xD5\xD7\x05\xB0Y\x02\xD6\xD4\x03\x02\x02\x02" +
		"\xD6\xD7\x03\x02\x02\x02\xD7\x11\x03\x02\x02\x02\xD8\xD9\x07\r\x02\x02" +
		"\xD9\xDA\x07y\x02\x02\xDA\xDE\x07\x0E\x02\x02\xDB\xDD\x05\x1C\x0F\x02" +
		"\xDC\xDB\x03\x02\x02\x02\xDD\xE0\x03\x02\x02\x02\xDE\xDC\x03\x02\x02\x02" +
		"\xDE\xDF\x03\x02\x02\x02\xDF\xE1\x03\x02\x02\x02\xE0\xDE\x03\x02\x02\x02" +
		"\xE1\xE2\x05\x14\v\x02\xE2\xE3\x07\x0F\x02\x02\xE3\xE4\x07\x02\x02\x03" +
		"\xE4\x13\x03\x02\x02\x02\xE5\xE6\x07\x10\x02\x02\xE6\xE7\x05t;\x02\xE7" +
		"\xE8\x07\x04\x02\x02\xE8\x15\x03\x02\x02\x02\xE9\xEA\x07\x11\x02\x02\xEA" +
		"\xED\x07z\x02\x02\xEB\xEC\x07\f\x02\x02\xEC\xEE\x05\xB0Y\x02\xED\xEB\x03" +
		"\x02\x02\x02\xED\xEE\x03\x02\x02\x02\xEE\xEF\x03\x02\x02\x02\xEF\u010C" +
		"\x07\x04\x02\x02\xF0\xF3\x07\x11\x02\x02\xF1\xF4\x07\x12\x02\x02\xF2\xF4" +
		"\x05\xB0Y\x02\xF3\xF1\x03\x02\x02\x02\xF3\xF2\x03\x02\x02\x02\xF4\xF7" +
		"\x03\x02\x02\x02\xF5\xF6\x07\f\x02\x02\xF6\xF8\x05\xB0Y\x02\xF7\xF5\x03" +
		"\x02\x02\x02\xF7\xF8\x03\x02\x02\x02\xF8\xF9\x03\x02\x02\x02\xF9\xFA\x07" +
		"\x13\x02\x02\xFA\xFB\x07z\x02\x02\xFB\u010C\x07\x04\x02\x02\xFC\xFD\x07" +
		"\x11\x02\x02\xFD\xFE\x07\x0E\x02\x02\xFE\u0103\x05\x10\t\x02\xFF\u0100" +
		"\x07\x14\x02\x02\u0100\u0102\x05\x10\t\x02\u0101\xFF\x03\x02\x02\x02\u0102" +
		"\u0105\x03\x02\x02\x02\u0103\u0101\x03\x02\x02\x02\u0103\u0104\x03\x02" +
		"\x02\x02\u0104\u0106\x03\x02\x02\x02\u0105\u0103\x03\x02\x02\x02\u0106" +
		"\u0107\x07\x0F\x02\x02\u0107\u0108\x07\x13\x02\x02\u0108\u0109\x07z\x02" +
		"\x02\u0109\u010A\x07\x04\x02\x02\u010A\u010C\x03\x02\x02\x02\u010B\xE9" +
		"\x03\x02\x02\x02\u010B\xF0\x03\x02\x02\x02\u010B\xFC\x03\x02\x02\x02\u010C" +
		"\x17\x03\x02\x02\x02\u010D\u010E\t\x03\x02\x02\u010E\u0118\x05\xB0Y\x02" +
		"\u010F\u0110\x07\x18\x02\x02\u0110\u0115\x05\x1A\x0E\x02\u0111\u0112\x07" +
		"\x14\x02\x02\u0112\u0114\x05\x1A\x0E\x02\u0113\u0111\x03\x02\x02\x02\u0114" +
		"\u0117\x03\x02\x02\x02\u0115\u0113\x03\x02\x02\x02\u0115\u0116\x03\x02" +
		"\x02\x02\u0116\u0119\x03\x02\x02\x02\u0117\u0115\x03\x02\x02\x02\u0118" +
		"\u010F\x03\x02\x02\x02\u0118\u0119\x03\x02\x02\x02\u0119\u011A\x03\x02" +
		"\x02\x02\u011A\u011E\x07\x0E\x02\x02\u011B\u011D\x05\x1C\x0F\x02\u011C" +
		"\u011B\x03\x02\x02\x02\u011D\u0120\x03\x02\x02\x02\u011E\u011C\x03\x02" +
		"\x02\x02\u011E\u011F\x03\x02\x02\x02\u011F\u0121\x03\x02\x02\x02\u0120" +
		"\u011E\x03\x02\x02\x02\u0121\u0122\x07\x0F\x02\x02\u0122\x19\x03\x02\x02" +
		"\x02\u0123\u012F\x05F$\x02\u0124\u0125\x07\x19\x02\x02\u0125\u012A\x05" +
		"t;\x02\u0126\u0127\x07\x14\x02\x02\u0127\u0129\x05t;\x02\u0128\u0126\x03" +
		"\x02\x02\x02\u0129\u012C\x03\x02\x02\x02\u012A\u0128\x03\x02\x02\x02\u012A" +
		"\u012B\x03\x02\x02\x02\u012B\u012D\x03\x02\x02\x02\u012C\u012A\x03\x02" +
		"\x02\x02\u012D\u012E\x07\x1A\x02\x02\u012E\u0130\x03\x02\x02\x02\u012F" +
		"\u0124\x03\x02\x02\x02\u012F\u0130\x03\x02\x02\x02\u0130\x1B\x03\x02\x02" +
		"\x02\u0131\u013A\x05\x1E\x10\x02\u0132\u013A\x05 \x11\x02\u0133\u013A" +
		"\x05\"\x12\x02\u0134\u013A\x05$\x13\x02\u0135\u013A\x05&\x14\x02\u0136" +
		"\u013A\x05*\x16\x02\u0137\u013A\x050\x19\x02\u0138\u013A\x054\x1B\x02" +
		"\u0139\u0131\x03\x02\x02\x02\u0139\u0132\x03\x02\x02\x02\u0139\u0133\x03" +
		"\x02\x02\x02\u0139\u0134\x03\x02\x02\x02\u0139\u0135\x03\x02\x02\x02\u0139" +
		"\u0136\x03\x02\x02\x02\u0139\u0137\x03\x02\x02\x02\u0139\u0138\x03\x02" +
		"\x02\x02\u013A\x1D\x03\x02\x02\x02\u013B\u013F\x05D#\x02\u013C\u013E\t" +
		"\x04\x02\x02\u013D\u013C\x03\x02\x02\x02\u013E\u0141\x03\x02\x02\x02\u013F" +
		"\u013D\x03\x02\x02\x02\u013F\u0140\x03\x02\x02\x02\u0140\u0142\x03\x02" +
		"\x02\x02\u0141\u013F\x03\x02\x02\x02\u0142\u0145\x05\xB0Y\x02\u0143\u0144" +
		"\x07\v\x02\x02\u0144\u0146\x05t;\x02\u0145\u0143\x03\x02\x02\x02\u0145" +
		"\u0146\x03\x02\x02\x02\u0146\u0147\x03\x02\x02\x02\u0147\u0148\x07\x04" +
		"\x02\x02\u0148\x1F\x03\x02\x02\x02\u0149\u014A\x07\x1B\x02\x02\u014A\u014B" +
		"\x05\xB0Y\x02\u014B\u014E\x07\x1C\x02\x02\u014C\u014F\x07\x12\x02\x02" +
		"\u014D\u014F\x05D#\x02\u014E\u014C\x03\x02\x02\x02\u014E\u014D\x03\x02" +
		"\x02\x02\u014F\u0150\x03\x02\x02\x02\u0150\u0151\x07\x04\x02\x02\u0151" +
		"!\x03\x02\x02\x02\u0152\u0153\x07\x1D\x02\x02\u0153\u0154\x05\xB0Y\x02" +
		"\u0154\u015F\x07\x0E\x02\x02\u0155\u0156\x05B\"\x02\u0156\u015C\x07\x04" +
		"\x02\x02\u0157\u0158\x05B\"\x02\u0158\u0159\x07\x04\x02\x02\u0159\u015B" +
		"\x03\x02\x02\x02\u015A\u0157\x03\x02\x02\x02\u015B\u015E\x03\x02\x02\x02" +
		"\u015C\u015A\x03\x02\x02\x02\u015C\u015D\x03\x02\x02\x02\u015D\u0160\x03" +
		"\x02\x02\x02\u015E\u015C\x03\x02\x02\x02\u015F\u0155\x03\x02\x02\x02\u015F" +
		"\u0160\x03\x02\x02\x02\u0160\u0161\x03\x02\x02\x02\u0161\u0162\x07\x0F" +
		"\x02\x02\u0162#\x03\x02\x02\x02\u0163\u0164\x07\x1E\x02\x02\u0164\u0165" +
		"\x056\x1C\x02\u0165\u0166\x05.\x18\x02\u0166\u0167\x05P)\x02\u0167%\x03" +
		"\x02\x02\x02\u0168\u0169\x07\x1F\x02\x02\u0169\u016B\x05\xB0Y\x02\u016A" +
		"\u016C\x056\x1C\x02\u016B\u016A\x03\x02\x02\x02\u016B\u016C\x03\x02\x02" +
		"\x02\u016C\u016D\x03\x02\x02\x02\u016D\u016E\x05P)\x02\u016E\'\x03\x02" +
		"\x02\x02\u016F\u0175\x05\xB0Y\x02\u0170\u0172\x07\x19\x02\x02\u0171\u0173" +
		"\x05|?\x02\u0172\u0171\x03\x02\x02\x02\u0172\u0173\x03\x02\x02\x02\u0173" +
		"\u0174\x03\x02\x02\x02\u0174\u0176\x07\x1A\x02\x02\u0175\u0170\x03\x02" +
		"\x02\x02\u0175\u0176\x03\x02\x02\x02\u0176)\x03\x02\x02\x02\u0177\u0179" +
		"\x07 \x02\x02\u0178\u017A\x05\xB0Y\x02\u0179\u0178\x03\x02\x02\x02\u0179" +
		"\u017A\x03\x02\x02\x02\u017A\u017B\x03\x02\x02\x02\u017B\u017C\x056\x1C" +
		"\x02\u017C\u017E\x05.\x18\x02\u017D\u017F\x05,\x17\x02\u017E\u017D\x03" +
		"\x02\x02\x02\u017E\u017F\x03\x02\x02\x02\u017F\u0182\x03\x02\x02\x02\u0180" +
		"\u0183\x07\x04\x02\x02\u0181\u0183\x05P)\x02\u0182\u0180\x03\x02\x02\x02" +
		"\u0182\u0181\x03\x02\x02\x02\u0183+\x03\x02\x02\x02\u0184\u0185\x07!\x02" +
		"\x02\u0185\u0186\x056\x1C\x02\u0186-\x03\x02\x02\x02\u0187\u018E\x05(" +
		"\x15\x02\u0188\u018E\x05N(\x02\u0189\u018E\x07q\x02\x02\u018A\u018E\x07" +
		"v\x02\x02\u018B\u018E\x07s\x02\x02\u018C\u018E\x07u\x02\x02\u018D\u0187" +
		"\x03\x02\x02\x02\u018D\u0188\x03\x02\x02\x02\u018D\u0189\x03\x02\x02\x02" +
		"\u018D\u018A\x03\x02\x02\x02\u018D\u018B\x03\x02\x02\x02\u018D\u018C\x03" +
		"\x02\x02\x02\u018E\u0191\x03\x02\x02\x02\u018F\u018D\x03\x02\x02\x02\u018F" +
		"\u0190\x03\x02\x02\x02\u0190/\x03\x02\x02\x02\u0191\u018F\x03\x02\x02" +
		"\x02\u0192\u0193\x07\"\x02\x02\u0193\u0194\x05\xB0Y\x02\u0194\u0196\x05" +
		":\x1E\x02\u0195\u0197\x07m\x02\x02\u0196\u0195\x03\x02\x02\x02\u0196\u0197" +
		"\x03\x02\x02\x02\u0197\u0198\x03\x02\x02\x02\u0198\u0199\x07\x04\x02\x02" +
		"\u01991\x03\x02\x02\x02\u019A\u019B\x05\xB0Y\x02\u019B3\x03\x02\x02\x02" +
		"\u019C\u019D\x07#\x02\x02\u019D\u019E\x05\xB0Y\x02\u019E\u01A0\x07\x0E" +
		"\x02\x02\u019F\u01A1\x052\x1A\x02\u01A0\u019F\x03\x02\x02\x02\u01A0\u01A1" +
		"\x03\x02\x02\x02\u01A1\u01A6\x03\x02\x02\x02\u01A2\u01A3\x07\x14\x02\x02" +
		"\u01A3\u01A5\x052\x1A\x02\u01A4\u01A2\x03\x02\x02\x02\u01A5\u01A8\x03" +
		"\x02\x02\x02\u01A6\u01A4\x03\x02\x02\x02\u01A6\u01A7\x03\x02\x02\x02\u01A7" +
		"\u01A9\x03\x02\x02\x02\u01A8\u01A6\x03\x02\x02\x02\u01A9\u01AA\x07\x0F" +
		"\x02\x02\u01AA5\x03\x02\x02\x02\u01AB\u01B4\x07\x19\x02\x02\u01AC\u01B1" +
		"\x058\x1D\x02\u01AD\u01AE\x07\x14\x02\x02\u01AE\u01B0\x058\x1D\x02\u01AF" +
		"\u01AD\x03\x02\x02\x02\u01B0\u01B3\x03\x02\x02\x02\u01B1\u01AF\x03\x02" +
		"\x02\x02\u01B1\u01B2\x03\x02\x02\x02\u01B2\u01B5\x03\x02\x02\x02\u01B3" +
		"\u01B1\x03\x02\x02\x02\u01B4\u01AC\x03\x02\x02\x02\u01B4\u01B5\x03\x02" +
		"\x02\x02\u01B5\u01B6\x03\x02\x02\x02\u01B6\u01B7\x07\x1A\x02\x02\u01B7" +
		"7\x03\x02\x02\x02\u01B8\u01BA\x05D#\x02\u01B9\u01BB\x05L\'\x02\u01BA\u01B9" +
		"\x03\x02\x02\x02\u01BA\u01BB\x03\x02\x02\x02\u01BB\u01BD\x03\x02\x02\x02" +
		"\u01BC\u01BE\x05\xB0Y\x02\u01BD\u01BC\x03\x02\x02\x02\u01BD\u01BE\x03" +
		"\x02\x02\x02\u01BE9\x03\x02\x02\x02\u01BF\u01C8\x07\x19\x02\x02\u01C0" +
		"\u01C5\x05<\x1F\x02\u01C1\u01C2\x07\x14\x02\x02\u01C2\u01C4\x05<\x1F\x02" +
		"\u01C3\u01C1\x03\x02\x02\x02\u01C4\u01C7\x03\x02\x02\x02\u01C5\u01C3\x03" +
		"\x02\x02\x02\u01C5\u01C6\x03\x02\x02\x02\u01C6\u01C9\x03\x02\x02\x02\u01C7" +
		"\u01C5\x03\x02\x02\x02\u01C8\u01C0\x03\x02\x02\x02\u01C8\u01C9\x03\x02" +
		"\x02\x02\u01C9\u01CA\x03\x02\x02\x02\u01CA\u01CB\x07\x1A\x02\x02\u01CB" +
		";\x03\x02\x02\x02\u01CC\u01CE\x05D#\x02\u01CD\u01CF\x07r\x02\x02\u01CE" +
		"\u01CD\x03\x02\x02\x02\u01CE\u01CF\x03\x02\x02\x02\u01CF\u01D1\x03\x02" +
		"\x02\x02\u01D0\u01D2\x05\xB0Y\x02\u01D1\u01D0\x03\x02\x02\x02\u01D1\u01D2" +
		"\x03\x02\x02\x02\u01D2=\x03\x02\x02\x02\u01D3\u01DC\x07";
	private static readonly _serializedATNSegment1: string =
		"\x19\x02\x02\u01D4\u01D9\x05@!\x02\u01D5\u01D6\x07\x14\x02\x02\u01D6\u01D8" +
		"\x05@!\x02\u01D7\u01D5\x03\x02\x02\x02\u01D8\u01DB\x03\x02\x02\x02\u01D9" +
		"\u01D7\x03\x02\x02\x02\u01D9\u01DA\x03\x02\x02\x02\u01DA\u01DD\x03\x02" +
		"\x02\x02\u01DB\u01D9\x03\x02\x02\x02\u01DC\u01D4\x03\x02\x02\x02\u01DC" +
		"\u01DD\x03\x02\x02\x02\u01DD\u01DE\x03\x02\x02\x02\u01DE\u01DF\x07\x1A" +
		"\x02\x02\u01DF?\x03\x02\x02\x02\u01E0\u01E2\x05D#\x02\u01E1\u01E3\x05" +
		"L\'\x02\u01E2\u01E1\x03\x02\x02\x02\u01E2\u01E3\x03\x02\x02\x02\u01E3" +
		"A\x03\x02\x02\x02\u01E4\u01E6\x05D#\x02\u01E5\u01E7\x05L\'\x02\u01E6\u01E5" +
		"\x03\x02\x02\x02\u01E6\u01E7\x03\x02\x02\x02\u01E7\u01E8\x03\x02\x02\x02" +
		"\u01E8\u01E9\x05\xB0Y\x02\u01E9C\x03\x02\x02\x02\u01EA\u01EB\b#\x01\x02" +
		"\u01EB\u01F2\x05r:\x02\u01EC\u01F2\x05F$\x02\u01ED\u01F2\x05H%\x02\u01EE" +
		"\u01F2\x05J&\x02\u01EF\u01F0\x07&\x02\x02\u01F0\u01F2\x07t\x02\x02\u01F1" +
		"\u01EA\x03\x02\x02\x02\u01F1\u01EC\x03\x02\x02\x02\u01F1\u01ED\x03\x02" +
		"\x02\x02\u01F1\u01EE\x03\x02\x02\x02\u01F1\u01EF\x03\x02\x02\x02\u01F2" +
		"\u01FB\x03\x02\x02\x02\u01F3\u01F4\f\x05\x02\x02\u01F4\u01F6\x07$\x02" +
		"\x02\u01F5\u01F7\x05t;\x02\u01F6\u01F5\x03\x02\x02\x02\u01F6\u01F7\x03" +
		"\x02\x02\x02\u01F7\u01F8\x03\x02\x02\x02\u01F8\u01FA\x07%\x02\x02\u01F9" +
		"\u01F3\x03\x02\x02\x02\u01FA\u01FD\x03\x02\x02\x02\u01FB\u01F9\x03\x02" +
		"\x02\x02\u01FB\u01FC\x03\x02\x02\x02\u01FCE\x03\x02\x02\x02\u01FD\u01FB" +
		"\x03\x02\x02\x02\u01FE\u0203\x05\xB0Y\x02\u01FF\u0200\x07\'\x02\x02\u0200" +
		"\u0202\x05\xB0Y\x02\u0201\u01FF\x03\x02\x02\x02\u0202\u0205\x03\x02\x02" +
		"\x02\u0203\u0201\x03\x02\x02\x02\u0203\u0204\x03\x02\x02\x02\u0204G\x03" +
		"\x02\x02\x02\u0205\u0203\x03\x02\x02\x02\u0206\u0207\x07(\x02\x02\u0207" +
		"\u0208\x07\x19\x02\x02\u0208\u0209\x05r:\x02\u0209\u020A\x07)\x02\x02" +
		"\u020A\u020B\x05D#\x02\u020B\u020C\x07\x1A\x02\x02\u020CI\x03\x02\x02" +
		"\x02\u020D\u020E\x07 \x02\x02\u020E\u0214\x05> \x02\u020F\u0213\x07s\x02" +
		"\x02\u0210\u0213\x07q\x02\x02\u0211\u0213\x05N(\x02\u0212\u020F\x03\x02" +
		"\x02\x02\u0212\u0210\x03\x02\x02\x02\u0212\u0211\x03\x02\x02\x02\u0213" +
		"\u0216\x03\x02\x02\x02\u0214\u0212\x03\x02\x02\x02\u0214\u0215\x03\x02" +
		"\x02\x02\u0215\u0219\x03\x02\x02\x02\u0216\u0214\x03\x02\x02\x02\u0217" +
		"\u0218\x07!\x02\x02\u0218\u021A\x05> \x02\u0219\u0217\x03\x02\x02\x02" +
		"\u0219\u021A\x03\x02\x02\x02\u021AK\x03\x02\x02\x02\u021B\u021C\t\x05" +
		"\x02\x02\u021CM\x03\x02\x02\x02\u021D\u021E\t\x06\x02\x02\u021EO\x03\x02" +
		"\x02\x02\u021F\u0223\x07\x0E\x02\x02\u0220\u0222\x05R*\x02\u0221\u0220" +
		"\x03\x02\x02\x02\u0222\u0225\x03\x02\x02\x02\u0223\u0221\x03\x02\x02\x02" +
		"\u0223\u0224\x03\x02\x02\x02\u0224\u0226\x03\x02\x02\x02\u0225\u0223\x03" +
		"\x02\x02\x02\u0226\u0227\x07\x0F\x02\x02\u0227Q\x03\x02\x02\x02\u0228" +
		"\u0235\x05V,\x02\u0229\u0235\x05X-\x02\u022A\u0235\x05\\/\x02\u022B\u0235" +
		"\x05P)\x02\u022C\u0235\x05^0\x02\u022D\u0235\x05`1\x02\u022E\u0235\x05" +
		"b2\x02\u022F\u0235\x05d3\x02\u0230\u0235\x05f4\x02\u0231\u0235\x05h5\x02" +
		"\u0232\u0235\x05j6\x02\u0233\u0235\x05Z.\x02\u0234\u0228\x03\x02\x02\x02" +
		"\u0234\u0229\x03\x02\x02\x02\u0234\u022A\x03\x02\x02\x02\u0234\u022B\x03" +
		"\x02\x02\x02\u0234\u022C\x03\x02\x02\x02\u0234\u022D\x03\x02\x02\x02\u0234" +
		"\u022E\x03\x02\x02\x02\u0234\u022F\x03\x02\x02\x02\u0234\u0230\x03\x02" +
		"\x02\x02\u0234\u0231\x03\x02\x02\x02\u0234\u0232\x03\x02\x02\x02\u0234" +
		"\u0233\x03\x02\x02\x02\u0235S\x03\x02\x02\x02\u0236\u0237\x05t;\x02\u0237" +
		"\u0238\x07\x04\x02\x02\u0238U\x03\x02\x02\x02\u0239\u023A\x07-\x02\x02" +
		"\u023A\u023B\x07\x19\x02\x02\u023B\u023C\x05t;\x02\u023C\u023D\x07\x1A" +
		"\x02\x02\u023D\u0240\x05R*\x02\u023E\u023F\x07.\x02\x02\u023F\u0241\x05" +
		"R*\x02\u0240\u023E\x03\x02\x02\x02\u0240\u0241\x03\x02\x02\x02\u0241W" +
		"\x03\x02\x02\x02\u0242\u0243\x07/\x02\x02\u0243\u0244\x07\x19\x02\x02" +
		"\u0244\u0245\x05t;\x02\u0245\u0246\x07\x1A\x02\x02\u0246\u0247\x05R*\x02" +
		"\u0247Y\x03\x02\x02\x02\u0248\u024B\x05l7\x02\u0249\u024B\x05T+\x02\u024A" +
		"\u0248\x03\x02\x02\x02\u024A\u0249\x03\x02\x02\x02\u024B[\x03\x02\x02" +
		"\x02\u024C\u024D\x07\x1C\x02\x02\u024D\u0250\x07\x19\x02\x02\u024E\u0251" +
		"\x05Z.\x02\u024F\u0251\x07\x04\x02\x02\u0250\u024E\x03\x02\x02\x02\u0250" +
		"\u024F\x03\x02\x02\x02\u0251\u0253\x03\x02\x02\x02\u0252\u0254\x05t;\x02" +
		"\u0253\u0252\x03\x02\x02\x02\u0253\u0254\x03\x02\x02\x02\u0254\u0255\x03" +
		"\x02\x02\x02\u0255\u0257\x07\x04\x02\x02\u0256\u0258\x05t;\x02\u0257\u0256" +
		"\x03\x02\x02\x02\u0257\u0258\x03\x02\x02\x02\u0258\u0259\x03\x02\x02\x02" +
		"\u0259\u025A\x07\x1A\x02\x02\u025A\u025B\x05R*\x02\u025B]\x03\x02\x02" +
		"\x02\u025C\u025E\x070\x02\x02\u025D\u025F\x07z\x02\x02\u025E\u025D\x03" +
		"\x02\x02\x02\u025E\u025F\x03\x02\x02\x02\u025F\u0260\x03\x02\x02\x02\u0260" +
		"\u0261\x05\x86D\x02\u0261_\x03\x02\x02\x02\u0262\u0263\x071\x02\x02\u0263" +
		"\u0264\x05R*\x02\u0264\u0265\x07/\x02\x02\u0265\u0266\x07\x19\x02\x02" +
		"\u0266\u0267\x05t;\x02\u0267\u0268\x07\x1A\x02\x02\u0268\u0269\x07\x04" +
		"\x02\x02\u0269a\x03\x02\x02\x02\u026A\u026B\x07p\x02\x02\u026B\u026C\x07" +
		"\x04\x02\x02\u026Cc\x03\x02\x02\x02\u026D\u026E\x07n\x02\x02\u026E\u026F" +
		"\x07\x04\x02\x02\u026Fe\x03\x02\x02\x02\u0270\u0272\x072\x02\x02\u0271" +
		"\u0273\x05t;\x02\u0272\u0271\x03\x02\x02\x02\u0272\u0273\x03\x02\x02\x02" +
		"\u0273\u0274\x03\x02\x02\x02\u0274\u0275\x07\x04\x02\x02\u0275g\x03\x02" +
		"\x02\x02\u0276\u0277\x073\x02\x02\u0277\u0278\x07\x04\x02\x02\u0278i\x03" +
		"\x02\x02\x02\u0279\u027A\x074\x02\x02\u027A\u027B\x05\x84C\x02\u027B\u027C" +
		"\x07\x04\x02\x02\u027Ck\x03\x02\x02\x02\u027D\u027E\x075\x02\x02\u027E" +
		"\u0285\x05p9\x02\u027F\u0285\x05B\"\x02\u0280\u0281\x07\x19\x02\x02\u0281" +
		"\u0282\x05n8\x02\u0282\u0283\x07\x1A\x02\x02\u0283\u0285\x03\x02\x02\x02" +
		"\u0284\u027D\x03\x02\x02\x02\u0284\u027F\x03\x02\x02\x02\u0284\u0280\x03" +
		"\x02\x02\x02\u0285\u0288\x03\x02\x02\x02\u0286\u0287\x07\v\x02\x02\u0287" +
		"\u0289\x05t;\x02\u0288\u0286\x03\x02\x02\x02\u0288\u0289\x03\x02\x02\x02" +
		"\u0289\u028A\x03\x02\x02\x02\u028A\u028B\x07\x04\x02\x02\u028Bm\x03\x02" +
		"\x02\x02\u028C\u028E\x05B\"\x02\u028D\u028C\x03\x02\x02\x02\u028D\u028E" +
		"\x03\x02\x02\x02\u028E\u0295\x03\x02\x02\x02\u028F\u0291\x07\x14\x02\x02" +
		"\u0290\u0292\x05B\"\x02\u0291\u0290\x03\x02\x02\x02\u0291\u0292\x03\x02" +
		"\x02\x02\u0292\u0294\x03\x02\x02\x02\u0293\u028F\x03\x02\x02\x02\u0294" +
		"\u0297\x03\x02\x02\x02\u0295\u0293\x03\x02\x02\x02\u0295\u0296\x03\x02" +
		"\x02\x02\u0296o\x03\x02\x02\x02\u0297\u0295\x03\x02\x02\x02\u0298\u029F" +
		"\x07\x19\x02\x02\u0299\u029B\x05\xB0Y\x02\u029A\u0299\x03\x02\x02\x02" +
		"\u029A\u029B\x03\x02\x02\x02\u029B\u029C\x03\x02\x02\x02\u029C\u029E\x07" +
		"\x14\x02\x02\u029D\u029A\x03\x02\x02\x02\u029E\u02A1\x03\x02\x02\x02\u029F" +
		"\u029D\x03\x02\x02\x02\u029F\u02A0\x03\x02\x02\x02\u02A0\u02A3\x03\x02" +
		"\x02\x02\u02A1\u029F\x03\x02\x02\x02\u02A2\u02A4\x05\xB0Y\x02\u02A3\u02A2" +
		"\x03\x02\x02\x02\u02A3\u02A4\x03\x02\x02\x02\u02A4\u02A5\x03\x02\x02\x02" +
		"\u02A5\u02A6\x07\x1A\x02\x02\u02A6q\x03\x02\x02\x02\u02A7\u02A8\t\x07" +
		"\x02\x02\u02A8s\x03\x02\x02\x02\u02A9\u02AA\b;\x01\x02\u02AA\u02AB\x07" +
		";\x02\x02\u02AB\u02BE\x05D#\x02\u02AC\u02AD\x07\x19\x02\x02\u02AD\u02AE" +
		"\x05t;\x02\u02AE\u02AF\x07\x1A\x02\x02\u02AF\u02BE\x03\x02\x02\x02\u02B0" +
		"\u02B1\t\b\x02\x02\u02B1\u02BE\x05t;\x17\u02B2\u02B3\t\t\x02\x02\u02B3" +
		"\u02BE\x05t;\x16\u02B4\u02B5\t\n\x02\x02\u02B5\u02BE\x05t;\x15\u02B6\u02B7" +
		"\x07@\x02\x02\u02B7\u02BE\x05t;\x14\u02B8\u02B9\x07\x06\x02\x02\u02B9" +
		"\u02BE\x05t;\x13\u02BA\u02BE\x05v<\x02\u02BB\u02BE\x05x=\x02\u02BC\u02BE" +
		"\x05z>\x02\u02BD\u02A9\x03\x02\x02\x02\u02BD\u02AC\x03\x02\x02\x02\u02BD" +
		"\u02B0\x03\x02\x02\x02\u02BD\u02B2\x03\x02\x02\x02\u02BD\u02B4\x03\x02" +
		"\x02\x02\u02BD\u02B6\x03\x02\x02\x02\u02BD\u02B8\x03\x02\x02\x02\u02BD" +
		"\u02BA\x03\x02\x02\x02\u02BD\u02BB\x03\x02\x02\x02\u02BD\u02BC\x03\x02" +
		"\x02\x02\u02BE\u02FA\x03\x02\x02\x02\u02BF\u02C0\f\x12\x02\x02\u02C0\u02C1" +
		"\x07A\x02\x02\u02C1\u02F9\x05t;\x13\u02C2\u02C3\f\x11\x02\x02\u02C3\u02C4" +
		"\t\v\x02\x02\u02C4\u02F9\x05t;\x12\u02C5\u02C6\f\x10\x02\x02\u02C6\u02C7" +
		"\t\t\x02\x02\u02C7\u02F9\x05t;\x11\u02C8\u02C9\f\x0F\x02\x02\u02C9\u02CA" +
		"\t\f\x02\x02\u02CA\u02F9\x05t;\x10\u02CB\u02CC\f\x0E\x02\x02\u02CC\u02CD" +
		"\x07F\x02\x02\u02CD\u02F9\x05t;\x0F\u02CE\u02CF\f\r\x02\x02\u02CF\u02D0" +
		"\x07\x05\x02\x02\u02D0\u02F9\x05t;\x0E\u02D1\u02D2\f\f\x02\x02\u02D2\u02D3" +
		"\x07G\x02\x02\u02D3\u02F9\x05t;\r\u02D4\u02D5\f\v\x02\x02\u02D5\u02D6" +
		"\t\r\x02\x02\u02D6\u02F9\x05t;\f\u02D7\u02D8\f\n\x02\x02\u02D8\u02D9\t" +
		"\x0E\x02\x02\u02D9\u02F9\x05t;\v\u02DA\u02DB\f\t\x02\x02\u02DB\u02DC\x07" +
		"J\x02\x02\u02DC\u02F9\x05t;\n\u02DD\u02DE\f\b\x02\x02\u02DE\u02DF\x07" +
		"K\x02\x02\u02DF\u02F9\x05t;\t\u02E0\u02E1\f\x07\x02\x02\u02E1\u02E2\x07" +
		"L\x02\x02\u02E2\u02E3\x05t;\x02\u02E3\u02E4\x07M\x02\x02\u02E4\u02E5\x05" +
		"t;\b\u02E5\u02F9\x03\x02\x02\x02\u02E6\u02E7\f\x06\x02\x02\u02E7\u02E8" +
		"\t\x0F\x02\x02\u02E8\u02F9\x05t;\x07\u02E9\u02EA\f\x1D\x02\x02\u02EA\u02F9" +
		"\t\b\x02\x02\u02EB\u02EC\f\x1B\x02\x02\u02EC\u02ED\x07$\x02\x02\u02ED" +
		"\u02EE\x05t;\x02\u02EE\u02EF\x07%\x02\x02\u02EF\u02F9\x03\x02\x02\x02" +
		"\u02F0\u02F1\f\x1A\x02\x02\u02F1\u02F2\x07\x19\x02\x02\u02F2\u02F3\x05" +
		"\x82B\x02\u02F3\u02F4\x07\x1A\x02\x02\u02F4\u02F9\x03\x02\x02\x02\u02F5" +
		"\u02F6\f\x19\x02\x02\u02F6\u02F7\x07\'\x02\x02\u02F7\u02F9\x05\xB0Y\x02" +
		"\u02F8\u02BF\x03\x02\x02\x02\u02F8\u02C2\x03\x02\x02\x02\u02F8\u02C5\x03" +
		"\x02\x02\x02\u02F8\u02C8\x03\x02\x02\x02\u02F8\u02CB\x03\x02\x02\x02\u02F8" +
		"\u02CE\x03\x02\x02\x02\u02F8\u02D1\x03\x02\x02\x02\u02F8\u02D4\x03\x02" +
		"\x02\x02\u02F8\u02D7\x03\x02\x02\x02\u02F8\u02DA\x03\x02\x02\x02\u02F8" +
		"\u02DD\x03\x02\x02\x02\u02F8\u02E0\x03\x02\x02\x02\u02F8\u02E6\x03\x02" +
		"\x02\x02\u02F8\u02E9\x03\x02\x02\x02\u02F8\u02EB\x03\x02\x02\x02\u02F8" +
		"\u02F0\x03\x02\x02\x02\u02F8\u02F5\x03\x02\x02\x02\u02F9\u02FC\x03\x02" +
		"\x02\x02\u02FA\u02F8\x03\x02\x02\x02\u02FA\u02FB\x03\x02\x02\x02\u02FB" +
		"u\x03\x02\x02\x02\u02FC\u02FA\x03\x02\x02\x02\u02FD\u02FE\x07X\x02\x02" +
		"\u02FE\u02FF\x05\xB0Y\x02\u02FF\u0300\x07\x14\x02\x02\u0300\u0301\x05" +
		"t;\x02\u0301w\x03\x02\x02\x02\u0302\u0303\x07Y\x02\x02\u0303\u0304\x05" +
		"\xB0Y\x02\u0304\u0305\x07\x14\x02\x02\u0305\u0306\x05t;\x02\u0306\u0307" +
		"\x07\x14\x02\x02\u0307\u0308\x05t;\x02\u0308y\x03\x02\x02\x02\u0309\u0311" +
		"\x07g\x02\x02\u030A\u0311\x05\xAEX\x02\u030B\u0311\x07k\x02\x02\u030C" +
		"\u0311\x07z\x02\x02\u030D\u0311\x05\xB0Y\x02\u030E\u0311\x05\xAAV\x02" +
		"\u030F\u0311\x05\xACW\x02\u0310\u0309\x03\x02\x02\x02\u0310\u030A\x03" +
		"\x02\x02\x02\u0310\u030B\x03\x02\x02\x02\u0310\u030C\x03\x02\x02\x02\u0310" +
		"\u030D\x03\x02\x02\x02\u0310\u030E\x03\x02\x02\x02\u0310\u030F\x03\x02" +
		"\x02\x02\u0311{\x03\x02\x02\x02\u0312\u0317\x05t;\x02\u0313\u0314\x07" +
		"\x14\x02\x02\u0314\u0316\x05t;\x02\u0315\u0313\x03\x02\x02\x02\u0316\u0319" +
		"\x03\x02\x02\x02\u0317\u0315\x03\x02\x02\x02\u0317\u0318\x03\x02\x02\x02" +
		"\u0318}\x03\x02\x02\x02\u0319\u0317\x03\x02\x02\x02\u031A\u031F\x05\x80" +
		"A\x02\u031B\u031C\x07\x14\x02\x02\u031C\u031E\x05\x80A\x02\u031D\u031B" +
		"\x03\x02\x02\x02\u031E\u0321\x03\x02\x02\x02\u031F\u031D\x03\x02\x02\x02" +
		"\u031F\u0320\x03\x02\x02\x02\u0320\u0323\x03\x02\x02\x02\u0321\u031F\x03" +
		"\x02\x02\x02\u0322\u0324\x07\x14\x02\x02\u0323\u0322\x03\x02\x02\x02\u0323" +
		"\u0324\x03\x02\x02\x02\u0324\x7F\x03\x02\x02\x02\u0325\u0326\x05\xB0Y" +
		"\x02\u0326\u0327\x07M\x02\x02\u0327\u0328\x05t;\x02\u0328\x81\x03\x02" +
		"\x02\x02\u0329\u032B\x07\x0E\x02\x02\u032A\u032C\x05~@\x02\u032B\u032A" +
		"\x03\x02\x02\x02\u032B\u032C\x03\x02\x02\x02\u032C\u032D\x03\x02\x02\x02" +
		"\u032D\u0332\x07\x0F\x02\x02\u032E\u0330\x05|?\x02\u032F\u032E\x03\x02" +
		"\x02\x02\u032F\u0330\x03\x02\x02\x02\u0330\u0332\x03\x02\x02\x02\u0331" +
		"\u0329\x03\x02\x02\x02\u0331\u032F\x03\x02\x02\x02\u0332\x83\x03\x02\x02" +
		"\x02\u0333\u0334\x05t;\x02\u0334\u0335\x07\x19\x02\x02\u0335\u0336\x05" +
		"\x82B\x02\u0336\u0337\x07\x1A\x02\x02\u0337\x85\x03\x02\x02\x02\u0338" +
		"\u033C\x07\x0E\x02\x02\u0339\u033B\x05\x88E\x02\u033A\u0339\x03\x02\x02" +
		"\x02\u033B\u033E\x03\x02\x02\x02\u033C\u033A\x03\x02\x02\x02\u033C\u033D" +
		"\x03\x02\x02\x02\u033D\u033F\x03\x02\x02\x02\u033E\u033C\x03\x02\x02\x02" +
		"\u033F\u0340\x07\x0F\x02\x02\u0340\x87\x03\x02\x02\x02\u0341\u0353\x05" +
		"\xB0Y\x02\u0342\u0353\x05\x86D\x02\u0343\u0353\x05\x8AF\x02\u0344\u0353" +
		"\x05\x8EH\x02\u0345\u0353\x05\x90I\x02\u0346\u0353\x05\x96L\x02\u0347" +
		"\u0353\x05\x98M\x02\u0348\u0353\x05\x9AN\x02\u0349\u0353\x05\x9EP\x02" +
		"\u034A\u0353\x05\xA2R\x02\u034B\u0353\x05\xA4S\x02\u034C\u0353\x07n\x02" +
		"\x02\u034D\u0353\x07p\x02\x02\u034E\u0353\x05\xA8U\x02\u034F\u0353\x05" +
		"\xAEX\x02\u0350\u0353\x07z\x02\x02\u0351\u0353\x07k\x02\x02\u0352\u0341" +
		"\x03\x02\x02\x02\u0352\u0342\x03\x02\x02\x02\u0352\u0343\x03\x02\x02\x02" +
		"\u0352\u0344\x03\x02\x02\x02\u0352\u0345\x03\x02\x02\x02\u0352\u0346\x03" +
		"\x02\x02\x02\u0352\u0347\x03\x02\x02\x02\u0352\u0348\x03\x02\x02\x02\u0352" +
		"\u0349\x03\x02\x02\x02\u0352\u034A\x03\x02\x02\x02\u0352\u034B\x03\x02" +
		"\x02\x02\u0352\u034C\x03\x02\x02\x02\u0352\u034D\x03\x02\x02\x02\u0352" +
		"\u034E\x03\x02\x02\x02\u0352\u034F\x03\x02\x02\x02\u0352\u0350\x03\x02" +
		"\x02\x02\u0352\u0351\x03\x02\x02\x02\u0353\x89\x03\x02\x02\x02\u0354\u0357" +
		"\x05\x8CG\x02\u0355\u0357\x05\xA6T\x02\u0356\u0354\x03\x02\x02\x02\u0356" +
		"\u0355\x03\x02\x02\x02\u0357\x8B\x03\x02\x02\x02\u0358\u035D\x072\x02" +
		"\x02\u0359\u035D\x07&\x02\x02\u035A\u035D\x078\x02\x02\u035B\u035D\x05" +
		"\xB0Y\x02\u035C\u0358\x03\x02\x02\x02\u035C\u0359\x03\x02\x02\x02\u035C" +
		"\u035A\x03\x02\x02\x02\u035C\u035B\x03\x02\x02\x02\u035D\u036A\x03\x02" +
		"\x02\x02\u035E\u0360\x07\x19\x02\x02\u035F\u0361\x05\x8AF\x02\u0360\u035F" +
		"\x03\x02\x02\x02\u0360\u0361\x03\x02\x02\x02\u0361\u0366\x03\x02\x02\x02" +
		"\u0362\u0363\x07\x14\x02\x02\u0363\u0365\x05\x8AF\x02\u0364\u0362\x03" +
		"\x02\x02\x02\u0365\u0368\x03\x02\x02\x02\u0366\u0364\x03\x02\x02\x02\u0366" +
		"\u0367\x03\x02\x02\x02\u0367\u0369\x03\x02\x02\x02\u0368\u0366\x03\x02" +
		"\x02\x02\u0369\u036B\x07\x1A\x02\x02\u036A\u035E\x03\x02\x02\x02\u036A" +
		"\u036B\x03\x02\x02\x02\u036B\x8D\x03\x02\x02\x02\u036C\u036D\x07Z\x02" +
		"\x02\u036D\u0370\x05\x92J\x02\u036E\u036F\x07[\x02\x02\u036F\u0371\x05" +
		"\x8AF\x02\u0370\u036E\x03\x02\x02\x02\u0370\u0371\x03\x02\x02\x02\u0371" +
		"\x8F\x03\x02\x02\x02\u0372\u0373\x05\x92J\x02\u0373\u0374\x07[\x02\x02" +
		"\u0374\u0375\x05\x8AF\x02\u0375\x91\x03\x02\x02\x02\u0376\u037C\x05\xB0" +
		"Y\x02\u0377\u0378\x07\x19\x02\x02\u0378\u0379\x05\x94K\x02\u0379\u037A" +
		"\x07\x1A\x02\x02\u037A\u037C\x03\x02\x02\x02\u037B\u0376\x03\x02\x02\x02" +
		"\u037B\u0377\x03\x02\x02\x02\u037C\x93\x03\x02\x02\x02\u037D\u0382\x05" +
		"\xB0Y\x02\u037E\u037F\x07\x14\x02\x02\u037F\u0381\x05\xB0Y\x02\u0380\u037E" +
		"\x03\x02\x02\x02\u0381\u0384\x03\x02\x02\x02\u0382\u0380\x03\x02\x02\x02" +
		"\u0382\u0383\x03\x02\x02\x02\u0383\x95\x03\x02\x02\x02\u0384\u0382\x03" +
		"\x02\x02\x02\u0385\u0386\x07\\\x02\x02\u0386\u0387\x05\xB0Y\x02\u0387" +
		"\x97\x03\x02\x02\x02\u0388\u0389\x05\xB0Y\x02\u0389\u038A\x07M\x02\x02" +
		"\u038A\x99\x03\x02\x02\x02\u038B\u038C\x07]\x02\x02\u038C\u0390\x05\x8A" +
		"F\x02\u038D\u038F\x05\x9CO\x02\u038E\u038D\x03\x02\x02\x02\u038F\u0392" +
		"\x03\x02\x02\x02\u0390\u038E\x03\x02\x02\x02\u0390\u0391\x03\x02\x02\x02" +
		"\u0391\x9B\x03\x02\x02\x02\u0392\u0390\x03\x02\x02\x02\u0393\u0394\x07" +
		"^\x02\x02\u0394\u0395\x05\xA6T\x02\u0395\u0396\x05\x86D\x02\u0396\u039A" +
		"\x03\x02\x02\x02\u0397\u0398\x07_\x02\x02\u0398\u039A\x05\x86D\x02\u0399" +
		"\u0393\x03\x02\x02\x02\u0399\u0397\x03\x02\x02\x02\u039A\x9D\x03\x02\x02" +
		"\x02\u039B\u039C\x07 \x02\x02\u039C\u039D\x05\xB0Y\x02\u039D\u039F\x07" +
		"\x19\x02\x02\u039E\u03A0\x05\x94K\x02\u039F\u039E\x03\x02\x02\x02\u039F" +
		"\u03A0\x03\x02\x02\x02\u03A0\u03A1\x03\x02\x02\x02\u03A1\u03A3\x07\x1A" +
		"\x02\x02\u03A2\u03A4\x05\xA0Q\x02\u03A3\u03A2\x03\x02\x02\x02\u03A3\u03A4" +
		"\x03\x02\x02\x02\u03A4\u03A5\x03\x02\x02\x02\u03A5\u03A6\x05\x86D\x02" +
		"\u03A6\x9F\x03\x02\x02\x02\u03A7\u03A8\x07`\x02\x02\u03A8\u03A9\x05\x94" +
		"K\x02\u03A9\xA1\x03\x02\x02\x02\u03AA\u03AD\x07\x1C\x02\x02\u03AB\u03AE" +
		"\x05\x86D\x02\u03AC\u03AE\x05\x8AF\x02\u03AD\u03AB\x03\x02\x02\x02\u03AD" +
		"\u03AC\x03\x02\x02\x02\u03AE\u03AF\x03\x02\x02\x02\u03AF\u03B2\x05\x8A" +
		"F\x02\u03B0\u03B3\x05\x86D\x02\u03B1\u03B3\x05\x8AF\x02\u03B2\u03B0\x03" +
		"\x02\x02\x02\u03B2\u03B1\x03\x02\x02\x02\u03B3\u03B4\x03\x02\x02\x02\u03B4" +
		"\u03B5\x05\x86D\x02\u03B5\xA3\x03\x02\x02\x02\u03B6\u03B7\x07-\x02\x02" +
		"\u03B7\u03B8\x05\x8AF\x02\u03B8\u03B9\x05\x86D\x02\u03B9\xA5\x03\x02\x02" +
		"\x02\u03BA\u03BB\t\x10\x02\x02\u03BB\xA7\x03\x02\x02\x02\u03BC\u03BD\x07" +
		"0\x02\x02\u03BD\u03BE\x05\xB0Y\x02\u03BE\u03BF\x05\x86D\x02\u03BF\xA9" +
		"\x03\x02\x02\x02\u03C0\u03C2\x07\x19\x02\x02\u03C1\u03C3\x05t;\x02\u03C2" +
		"\u03C1\x03\x02\x02\x02\u03C2\u03C3\x03\x02\x02\x02\u03C3\u03CA\x03\x02" +
		"\x02\x02\u03C4\u03C6\x07\x14\x02\x02\u03C5\u03C7\x05t;\x02\u03C6\u03C5" +
		"\x03\x02\x02\x02\u03C6\u03C7\x03\x02\x02\x02\u03C7\u03C9\x03\x02\x02\x02" +
		"\u03C8\u03C4\x03\x02\x02\x02\u03C9\u03CC\x03\x02\x02\x02\u03CA\u03C8\x03" +
		"\x02\x02\x02\u03CA\u03CB\x03\x02\x02\x02\u03CB\u03CD\x03\x02\x02\x02\u03CC" +
		"\u03CA\x03\x02\x02\x02\u03CD\u03DB\x07\x1A\x02\x02\u03CE\u03D7\x07$\x02" +
		"\x02\u03CF\u03D4\x05t;\x02\u03D0\u03D1\x07\x14\x02\x02\u03D1\u03D3\x05" +
		"t;\x02\u03D2\u03D0\x03\x02\x02\x02\u03D3\u03D6\x03\x02\x02\x02\u03D4\u03D2" +
		"\x03\x02\x02\x02\u03D4\u03D5\x03\x02\x02\x02\u03D5\u03D8\x03\x02\x02\x02" +
		"\u03D6\u03D4\x03\x02\x02\x02\u03D7\u03CF\x03\x02\x02\x02\u03D7\u03D8\x03" +
		"\x02\x02\x02\u03D8\u03D9\x03\x02\x02\x02\u03D9\u03DB\x07%\x02\x02\u03DA" +
		"\u03C0\x03\x02\x02\x02\u03DA\u03CE\x03\x02\x02\x02\u03DB\xAB\x03\x02\x02" +
		"\x02\u03DC\u03DD\x05r:\x02\u03DD\xAD\x03\x02\x02\x02\u03DE\u03E0\t\x11" +
		"\x02\x02\u03DF\u03E1\x07j\x02\x02\u03E0\u03DF\x03\x02\x02\x02\u03E0\u03E1" +
		"\x03\x02\x02\x02\u03E1\xAF\x03\x02\x02\x02\u03E2\u03E3\t\x12\x02\x02\u03E3" +
		"\xB1\x03\x02\x02\x02i\xB6\xB8\xC6\xCA\xCF\xD6\xDE\xED\xF3\xF7\u0103\u010B" +
		"\u0115\u0118\u011E\u012A\u012F\u0139\u013F\u0145\u014E\u015C\u015F\u016B" +
		"\u0172\u0175\u0179\u017E\u0182\u018D\u018F\u0196\u01A0\u01A6\u01B1\u01B4" +
		"\u01BA\u01BD\u01C5\u01C8\u01CE\u01D1\u01D9\u01DC\u01E2\u01E6\u01F1\u01F6" +
		"\u01FB\u0203\u0212\u0214\u0219\u0223\u0234\u0240\u024A\u0250\u0253\u0257" +
		"\u025E\u0272\u0284\u0288\u028D\u0291\u0295\u029A\u029F\u02A3\u02BD\u02F8" +
		"\u02FA\u0310\u0317\u031F\u0323\u032B\u032F\u0331\u033C\u0352\u0356\u035C" +
		"\u0360\u0366\u036A\u0370\u037B\u0382\u0390\u0399\u039F\u03A3\u03AD\u03B2" +
		"\u03C2\u03C6\u03CA\u03D4\u03D7\u03DA\u03E0";
	public static readonly _serializedATN: string = Utils.join(
		[
			SolidityParser._serializedATNSegment0,
			SolidityParser._serializedATNSegment1,
		],
		"",
	);
	public static __ATN: ATN;
	public static get _ATN(): ATN {
		if (!SolidityParser.__ATN) {
			SolidityParser.__ATN = new ATNDeserializer().deserialize(Utils.toCharArray(SolidityParser._serializedATN));
		}

		return SolidityParser.__ATN;
	}

}

export class SourceUnitContext extends ParserRuleContext {
	public EOF(): TerminalNode { return this.getToken(SolidityParser.EOF, 0); }
	public pragmaDirective(): PragmaDirectiveContext[];
	public pragmaDirective(i: number): PragmaDirectiveContext;
	public pragmaDirective(i?: number): PragmaDirectiveContext | PragmaDirectiveContext[] {
		if (i === undefined) {
			return this.getRuleContexts(PragmaDirectiveContext);
		} else {
			return this.getRuleContext(i, PragmaDirectiveContext);
		}
	}
	public importDirective(): ImportDirectiveContext[];
	public importDirective(i: number): ImportDirectiveContext;
	public importDirective(i?: number): ImportDirectiveContext | ImportDirectiveContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ImportDirectiveContext);
		} else {
			return this.getRuleContext(i, ImportDirectiveContext);
		}
	}
	public contractDefinition(): ContractDefinitionContext[];
	public contractDefinition(i: number): ContractDefinitionContext;
	public contractDefinition(i?: number): ContractDefinitionContext | ContractDefinitionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ContractDefinitionContext);
		} else {
			return this.getRuleContext(i, ContractDefinitionContext);
		}
	}
	public standardDefinition(): StandardDefinitionContext[];
	public standardDefinition(i: number): StandardDefinitionContext;
	public standardDefinition(i?: number): StandardDefinitionContext | StandardDefinitionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(StandardDefinitionContext);
		} else {
			return this.getRuleContext(i, StandardDefinitionContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_sourceUnit; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterSourceUnit) {
			listener.enterSourceUnit(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitSourceUnit) {
			listener.exitSourceUnit(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitSourceUnit) {
			return visitor.visitSourceUnit(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class PragmaDirectiveContext extends ParserRuleContext {
	public pragmaName(): PragmaNameContext {
		return this.getRuleContext(0, PragmaNameContext);
	}
	public pragmaValue(): PragmaValueContext {
		return this.getRuleContext(0, PragmaValueContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_pragmaDirective; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterPragmaDirective) {
			listener.enterPragmaDirective(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitPragmaDirective) {
			listener.exitPragmaDirective(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitPragmaDirective) {
			return visitor.visitPragmaDirective(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class PragmaNameContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_pragmaName; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterPragmaName) {
			listener.enterPragmaName(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitPragmaName) {
			listener.exitPragmaName(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitPragmaName) {
			return visitor.visitPragmaName(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class PragmaValueContext extends ParserRuleContext {
	public version(): VersionContext | undefined {
		return this.tryGetRuleContext(0, VersionContext);
	}
	public expression(): ExpressionContext | undefined {
		return this.tryGetRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_pragmaValue; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterPragmaValue) {
			listener.enterPragmaValue(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitPragmaValue) {
			listener.exitPragmaValue(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitPragmaValue) {
			return visitor.visitPragmaValue(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class VersionContext extends ParserRuleContext {
	public versionConstraint(): VersionConstraintContext[];
	public versionConstraint(i: number): VersionConstraintContext;
	public versionConstraint(i?: number): VersionConstraintContext | VersionConstraintContext[] {
		if (i === undefined) {
			return this.getRuleContexts(VersionConstraintContext);
		} else {
			return this.getRuleContext(i, VersionConstraintContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_version; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterVersion) {
			listener.enterVersion(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitVersion) {
			listener.exitVersion(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitVersion) {
			return visitor.visitVersion(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class VersionOperatorContext extends ParserRuleContext {
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_versionOperator; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterVersionOperator) {
			listener.enterVersionOperator(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitVersionOperator) {
			listener.exitVersionOperator(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitVersionOperator) {
			return visitor.visitVersionOperator(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class VersionConstraintContext extends ParserRuleContext {
	public VersionLiteral(): TerminalNode { return this.getToken(SolidityParser.VersionLiteral, 0); }
	public versionOperator(): VersionOperatorContext | undefined {
		return this.tryGetRuleContext(0, VersionOperatorContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_versionConstraint; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterVersionConstraint) {
			listener.enterVersionConstraint(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitVersionConstraint) {
			listener.exitVersionConstraint(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitVersionConstraint) {
			return visitor.visitVersionConstraint(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ImportDeclarationContext extends ParserRuleContext {
	public identifier(): IdentifierContext[];
	public identifier(i: number): IdentifierContext;
	public identifier(i?: number): IdentifierContext | IdentifierContext[] {
		if (i === undefined) {
			return this.getRuleContexts(IdentifierContext);
		} else {
			return this.getRuleContext(i, IdentifierContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_importDeclaration; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterImportDeclaration) {
			listener.enterImportDeclaration(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitImportDeclaration) {
			listener.exitImportDeclaration(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitImportDeclaration) {
			return visitor.visitImportDeclaration(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class StandardDefinitionContext extends ParserRuleContext {
	public Identifier(): TerminalNode { return this.getToken(SolidityParser.Identifier, 0); }
	public constraint(): ConstraintContext {
		return this.getRuleContext(0, ConstraintContext);
	}
	public EOF(): TerminalNode { return this.getToken(SolidityParser.EOF, 0); }
	public contractPart(): ContractPartContext[];
	public contractPart(i: number): ContractPartContext;
	public contractPart(i?: number): ContractPartContext | ContractPartContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ContractPartContext);
		} else {
			return this.getRuleContext(i, ContractPartContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_standardDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterStandardDefinition) {
			listener.enterStandardDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitStandardDefinition) {
			listener.exitStandardDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitStandardDefinition) {
			return visitor.visitStandardDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ConstraintContext extends ParserRuleContext {
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_constraint; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterConstraint) {
			listener.enterConstraint(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitConstraint) {
			listener.exitConstraint(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitConstraint) {
			return visitor.visitConstraint(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ImportDirectiveContext extends ParserRuleContext {
	public StringLiteral(): TerminalNode { return this.getToken(SolidityParser.StringLiteral, 0); }
	public identifier(): IdentifierContext[];
	public identifier(i: number): IdentifierContext;
	public identifier(i?: number): IdentifierContext | IdentifierContext[] {
		if (i === undefined) {
			return this.getRuleContexts(IdentifierContext);
		} else {
			return this.getRuleContext(i, IdentifierContext);
		}
	}
	public importDeclaration(): ImportDeclarationContext[];
	public importDeclaration(i: number): ImportDeclarationContext;
	public importDeclaration(i?: number): ImportDeclarationContext | ImportDeclarationContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ImportDeclarationContext);
		} else {
			return this.getRuleContext(i, ImportDeclarationContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_importDirective; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterImportDirective) {
			listener.enterImportDirective(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitImportDirective) {
			listener.exitImportDirective(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitImportDirective) {
			return visitor.visitImportDirective(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ContractDefinitionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public inheritanceSpecifier(): InheritanceSpecifierContext[];
	public inheritanceSpecifier(i: number): InheritanceSpecifierContext;
	public inheritanceSpecifier(i?: number): InheritanceSpecifierContext | InheritanceSpecifierContext[] {
		if (i === undefined) {
			return this.getRuleContexts(InheritanceSpecifierContext);
		} else {
			return this.getRuleContext(i, InheritanceSpecifierContext);
		}
	}
	public contractPart(): ContractPartContext[];
	public contractPart(i: number): ContractPartContext;
	public contractPart(i?: number): ContractPartContext | ContractPartContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ContractPartContext);
		} else {
			return this.getRuleContext(i, ContractPartContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_contractDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterContractDefinition) {
			listener.enterContractDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitContractDefinition) {
			listener.exitContractDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitContractDefinition) {
			return visitor.visitContractDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class InheritanceSpecifierContext extends ParserRuleContext {
	public userDefinedTypeName(): UserDefinedTypeNameContext {
		return this.getRuleContext(0, UserDefinedTypeNameContext);
	}
	public expression(): ExpressionContext[];
	public expression(i: number): ExpressionContext;
	public expression(i?: number): ExpressionContext | ExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ExpressionContext);
		} else {
			return this.getRuleContext(i, ExpressionContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_inheritanceSpecifier; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterInheritanceSpecifier) {
			listener.enterInheritanceSpecifier(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitInheritanceSpecifier) {
			listener.exitInheritanceSpecifier(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitInheritanceSpecifier) {
			return visitor.visitInheritanceSpecifier(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ContractPartContext extends ParserRuleContext {
	public stateVariableDeclaration(): StateVariableDeclarationContext | undefined {
		return this.tryGetRuleContext(0, StateVariableDeclarationContext);
	}
	public usingForDeclaration(): UsingForDeclarationContext | undefined {
		return this.tryGetRuleContext(0, UsingForDeclarationContext);
	}
	public structDefinition(): StructDefinitionContext | undefined {
		return this.tryGetRuleContext(0, StructDefinitionContext);
	}
	public constructorDefinition(): ConstructorDefinitionContext | undefined {
		return this.tryGetRuleContext(0, ConstructorDefinitionContext);
	}
	public modifierDefinition(): ModifierDefinitionContext | undefined {
		return this.tryGetRuleContext(0, ModifierDefinitionContext);
	}
	public functionDefinition(): FunctionDefinitionContext | undefined {
		return this.tryGetRuleContext(0, FunctionDefinitionContext);
	}
	public eventDefinition(): EventDefinitionContext | undefined {
		return this.tryGetRuleContext(0, EventDefinitionContext);
	}
	public enumDefinition(): EnumDefinitionContext | undefined {
		return this.tryGetRuleContext(0, EnumDefinitionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_contractPart; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterContractPart) {
			listener.enterContractPart(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitContractPart) {
			listener.exitContractPart(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitContractPart) {
			return visitor.visitContractPart(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class StateVariableDeclarationContext extends ParserRuleContext {
	public typeName(): TypeNameContext {
		return this.getRuleContext(0, TypeNameContext);
	}
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public expression(): ExpressionContext | undefined {
		return this.tryGetRuleContext(0, ExpressionContext);
	}
	public PublicKeyword(): TerminalNode[];
	public PublicKeyword(i: number): TerminalNode;
	public PublicKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.PublicKeyword);
		} else {
			return this.getToken(SolidityParser.PublicKeyword, i);
		}
	}
	public InternalKeyword(): TerminalNode[];
	public InternalKeyword(i: number): TerminalNode;
	public InternalKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.InternalKeyword);
		} else {
			return this.getToken(SolidityParser.InternalKeyword, i);
		}
	}
	public PrivateKeyword(): TerminalNode[];
	public PrivateKeyword(i: number): TerminalNode;
	public PrivateKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.PrivateKeyword);
		} else {
			return this.getToken(SolidityParser.PrivateKeyword, i);
		}
	}
	public ConstantKeyword(): TerminalNode[];
	public ConstantKeyword(i: number): TerminalNode;
	public ConstantKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.ConstantKeyword);
		} else {
			return this.getToken(SolidityParser.ConstantKeyword, i);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_stateVariableDeclaration; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterStateVariableDeclaration) {
			listener.enterStateVariableDeclaration(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitStateVariableDeclaration) {
			listener.exitStateVariableDeclaration(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitStateVariableDeclaration) {
			return visitor.visitStateVariableDeclaration(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class UsingForDeclarationContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public typeName(): TypeNameContext | undefined {
		return this.tryGetRuleContext(0, TypeNameContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_usingForDeclaration; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterUsingForDeclaration) {
			listener.enterUsingForDeclaration(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitUsingForDeclaration) {
			listener.exitUsingForDeclaration(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitUsingForDeclaration) {
			return visitor.visitUsingForDeclaration(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class StructDefinitionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public variableDeclaration(): VariableDeclarationContext[];
	public variableDeclaration(i: number): VariableDeclarationContext;
	public variableDeclaration(i?: number): VariableDeclarationContext | VariableDeclarationContext[] {
		if (i === undefined) {
			return this.getRuleContexts(VariableDeclarationContext);
		} else {
			return this.getRuleContext(i, VariableDeclarationContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_structDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterStructDefinition) {
			listener.enterStructDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitStructDefinition) {
			listener.exitStructDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitStructDefinition) {
			return visitor.visitStructDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ConstructorDefinitionContext extends ParserRuleContext {
	public parameterList(): ParameterListContext {
		return this.getRuleContext(0, ParameterListContext);
	}
	public modifierList(): ModifierListContext {
		return this.getRuleContext(0, ModifierListContext);
	}
	public block(): BlockContext {
		return this.getRuleContext(0, BlockContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_constructorDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterConstructorDefinition) {
			listener.enterConstructorDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitConstructorDefinition) {
			listener.exitConstructorDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitConstructorDefinition) {
			return visitor.visitConstructorDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ModifierDefinitionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public block(): BlockContext {
		return this.getRuleContext(0, BlockContext);
	}
	public parameterList(): ParameterListContext | undefined {
		return this.tryGetRuleContext(0, ParameterListContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_modifierDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterModifierDefinition) {
			listener.enterModifierDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitModifierDefinition) {
			listener.exitModifierDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitModifierDefinition) {
			return visitor.visitModifierDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ModifierInvocationContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public expressionList(): ExpressionListContext | undefined {
		return this.tryGetRuleContext(0, ExpressionListContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_modifierInvocation; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterModifierInvocation) {
			listener.enterModifierInvocation(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitModifierInvocation) {
			listener.exitModifierInvocation(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitModifierInvocation) {
			return visitor.visitModifierInvocation(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class FunctionDefinitionContext extends ParserRuleContext {
	public parameterList(): ParameterListContext {
		return this.getRuleContext(0, ParameterListContext);
	}
	public modifierList(): ModifierListContext {
		return this.getRuleContext(0, ModifierListContext);
	}
	public block(): BlockContext | undefined {
		return this.tryGetRuleContext(0, BlockContext);
	}
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	public returnParameters(): ReturnParametersContext | undefined {
		return this.tryGetRuleContext(0, ReturnParametersContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_functionDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterFunctionDefinition) {
			listener.enterFunctionDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitFunctionDefinition) {
			listener.exitFunctionDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitFunctionDefinition) {
			return visitor.visitFunctionDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ReturnParametersContext extends ParserRuleContext {
	public parameterList(): ParameterListContext {
		return this.getRuleContext(0, ParameterListContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_returnParameters; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterReturnParameters) {
			listener.enterReturnParameters(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitReturnParameters) {
			listener.exitReturnParameters(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitReturnParameters) {
			return visitor.visitReturnParameters(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ModifierListContext extends ParserRuleContext {
	public modifierInvocation(): ModifierInvocationContext[];
	public modifierInvocation(i: number): ModifierInvocationContext;
	public modifierInvocation(i?: number): ModifierInvocationContext | ModifierInvocationContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ModifierInvocationContext);
		} else {
			return this.getRuleContext(i, ModifierInvocationContext);
		}
	}
	public stateMutability(): StateMutabilityContext[];
	public stateMutability(i: number): StateMutabilityContext;
	public stateMutability(i?: number): StateMutabilityContext | StateMutabilityContext[] {
		if (i === undefined) {
			return this.getRuleContexts(StateMutabilityContext);
		} else {
			return this.getRuleContext(i, StateMutabilityContext);
		}
	}
	public ExternalKeyword(): TerminalNode[];
	public ExternalKeyword(i: number): TerminalNode;
	public ExternalKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.ExternalKeyword);
		} else {
			return this.getToken(SolidityParser.ExternalKeyword, i);
		}
	}
	public PublicKeyword(): TerminalNode[];
	public PublicKeyword(i: number): TerminalNode;
	public PublicKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.PublicKeyword);
		} else {
			return this.getToken(SolidityParser.PublicKeyword, i);
		}
	}
	public InternalKeyword(): TerminalNode[];
	public InternalKeyword(i: number): TerminalNode;
	public InternalKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.InternalKeyword);
		} else {
			return this.getToken(SolidityParser.InternalKeyword, i);
		}
	}
	public PrivateKeyword(): TerminalNode[];
	public PrivateKeyword(i: number): TerminalNode;
	public PrivateKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.PrivateKeyword);
		} else {
			return this.getToken(SolidityParser.PrivateKeyword, i);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_modifierList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterModifierList) {
			listener.enterModifierList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitModifierList) {
			listener.exitModifierList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitModifierList) {
			return visitor.visitModifierList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class EventDefinitionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public eventParameterList(): EventParameterListContext {
		return this.getRuleContext(0, EventParameterListContext);
	}
	public AnonymousKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.AnonymousKeyword, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_eventDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterEventDefinition) {
			listener.enterEventDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitEventDefinition) {
			listener.exitEventDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitEventDefinition) {
			return visitor.visitEventDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class EnumValueContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_enumValue; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterEnumValue) {
			listener.enterEnumValue(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitEnumValue) {
			listener.exitEnumValue(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitEnumValue) {
			return visitor.visitEnumValue(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class EnumDefinitionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public enumValue(): EnumValueContext[];
	public enumValue(i: number): EnumValueContext;
	public enumValue(i?: number): EnumValueContext | EnumValueContext[] {
		if (i === undefined) {
			return this.getRuleContexts(EnumValueContext);
		} else {
			return this.getRuleContext(i, EnumValueContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_enumDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterEnumDefinition) {
			listener.enterEnumDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitEnumDefinition) {
			listener.exitEnumDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitEnumDefinition) {
			return visitor.visitEnumDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ParameterListContext extends ParserRuleContext {
	public parameter(): ParameterContext[];
	public parameter(i: number): ParameterContext;
	public parameter(i?: number): ParameterContext | ParameterContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ParameterContext);
		} else {
			return this.getRuleContext(i, ParameterContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_parameterList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterParameterList) {
			listener.enterParameterList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitParameterList) {
			listener.exitParameterList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitParameterList) {
			return visitor.visitParameterList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ParameterContext extends ParserRuleContext {
	public typeName(): TypeNameContext {
		return this.getRuleContext(0, TypeNameContext);
	}
	public storageLocation(): StorageLocationContext | undefined {
		return this.tryGetRuleContext(0, StorageLocationContext);
	}
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_parameter; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterParameter) {
			listener.enterParameter(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitParameter) {
			listener.exitParameter(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitParameter) {
			return visitor.visitParameter(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class EventParameterListContext extends ParserRuleContext {
	public eventParameter(): EventParameterContext[];
	public eventParameter(i: number): EventParameterContext;
	public eventParameter(i?: number): EventParameterContext | EventParameterContext[] {
		if (i === undefined) {
			return this.getRuleContexts(EventParameterContext);
		} else {
			return this.getRuleContext(i, EventParameterContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_eventParameterList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterEventParameterList) {
			listener.enterEventParameterList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitEventParameterList) {
			listener.exitEventParameterList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitEventParameterList) {
			return visitor.visitEventParameterList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class EventParameterContext extends ParserRuleContext {
	public typeName(): TypeNameContext {
		return this.getRuleContext(0, TypeNameContext);
	}
	public IndexedKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.IndexedKeyword, 0); }
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_eventParameter; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterEventParameter) {
			listener.enterEventParameter(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitEventParameter) {
			listener.exitEventParameter(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitEventParameter) {
			return visitor.visitEventParameter(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class FunctionTypeParameterListContext extends ParserRuleContext {
	public functionTypeParameter(): FunctionTypeParameterContext[];
	public functionTypeParameter(i: number): FunctionTypeParameterContext;
	public functionTypeParameter(i?: number): FunctionTypeParameterContext | FunctionTypeParameterContext[] {
		if (i === undefined) {
			return this.getRuleContexts(FunctionTypeParameterContext);
		} else {
			return this.getRuleContext(i, FunctionTypeParameterContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_functionTypeParameterList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterFunctionTypeParameterList) {
			listener.enterFunctionTypeParameterList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitFunctionTypeParameterList) {
			listener.exitFunctionTypeParameterList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitFunctionTypeParameterList) {
			return visitor.visitFunctionTypeParameterList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class FunctionTypeParameterContext extends ParserRuleContext {
	public typeName(): TypeNameContext {
		return this.getRuleContext(0, TypeNameContext);
	}
	public storageLocation(): StorageLocationContext | undefined {
		return this.tryGetRuleContext(0, StorageLocationContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_functionTypeParameter; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterFunctionTypeParameter) {
			listener.enterFunctionTypeParameter(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitFunctionTypeParameter) {
			listener.exitFunctionTypeParameter(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitFunctionTypeParameter) {
			return visitor.visitFunctionTypeParameter(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class VariableDeclarationContext extends ParserRuleContext {
	public typeName(): TypeNameContext {
		return this.getRuleContext(0, TypeNameContext);
	}
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public storageLocation(): StorageLocationContext | undefined {
		return this.tryGetRuleContext(0, StorageLocationContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_variableDeclaration; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterVariableDeclaration) {
			listener.enterVariableDeclaration(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitVariableDeclaration) {
			listener.exitVariableDeclaration(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitVariableDeclaration) {
			return visitor.visitVariableDeclaration(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class TypeNameContext extends ParserRuleContext {
	public elementaryTypeName(): ElementaryTypeNameContext | undefined {
		return this.tryGetRuleContext(0, ElementaryTypeNameContext);
	}
	public userDefinedTypeName(): UserDefinedTypeNameContext | undefined {
		return this.tryGetRuleContext(0, UserDefinedTypeNameContext);
	}
	public mapping(): MappingContext | undefined {
		return this.tryGetRuleContext(0, MappingContext);
	}
	public typeName(): TypeNameContext | undefined {
		return this.tryGetRuleContext(0, TypeNameContext);
	}
	public expression(): ExpressionContext | undefined {
		return this.tryGetRuleContext(0, ExpressionContext);
	}
	public functionTypeName(): FunctionTypeNameContext | undefined {
		return this.tryGetRuleContext(0, FunctionTypeNameContext);
	}
	public PayableKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.PayableKeyword, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_typeName; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterTypeName) {
			listener.enterTypeName(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitTypeName) {
			listener.exitTypeName(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitTypeName) {
			return visitor.visitTypeName(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class UserDefinedTypeNameContext extends ParserRuleContext {
	public identifier(): IdentifierContext[];
	public identifier(i: number): IdentifierContext;
	public identifier(i?: number): IdentifierContext | IdentifierContext[] {
		if (i === undefined) {
			return this.getRuleContexts(IdentifierContext);
		} else {
			return this.getRuleContext(i, IdentifierContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_userDefinedTypeName; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterUserDefinedTypeName) {
			listener.enterUserDefinedTypeName(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitUserDefinedTypeName) {
			listener.exitUserDefinedTypeName(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitUserDefinedTypeName) {
			return visitor.visitUserDefinedTypeName(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class MappingContext extends ParserRuleContext {
	public elementaryTypeName(): ElementaryTypeNameContext {
		return this.getRuleContext(0, ElementaryTypeNameContext);
	}
	public typeName(): TypeNameContext {
		return this.getRuleContext(0, TypeNameContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_mapping; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterMapping) {
			listener.enterMapping(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitMapping) {
			listener.exitMapping(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitMapping) {
			return visitor.visitMapping(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class FunctionTypeNameContext extends ParserRuleContext {
	public functionTypeParameterList(): FunctionTypeParameterListContext[];
	public functionTypeParameterList(i: number): FunctionTypeParameterListContext;
	public functionTypeParameterList(i?: number): FunctionTypeParameterListContext | FunctionTypeParameterListContext[] {
		if (i === undefined) {
			return this.getRuleContexts(FunctionTypeParameterListContext);
		} else {
			return this.getRuleContext(i, FunctionTypeParameterListContext);
		}
	}
	public InternalKeyword(): TerminalNode[];
	public InternalKeyword(i: number): TerminalNode;
	public InternalKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.InternalKeyword);
		} else {
			return this.getToken(SolidityParser.InternalKeyword, i);
		}
	}
	public ExternalKeyword(): TerminalNode[];
	public ExternalKeyword(i: number): TerminalNode;
	public ExternalKeyword(i?: number): TerminalNode | TerminalNode[] {
		if (i === undefined) {
			return this.getTokens(SolidityParser.ExternalKeyword);
		} else {
			return this.getToken(SolidityParser.ExternalKeyword, i);
		}
	}
	public stateMutability(): StateMutabilityContext[];
	public stateMutability(i: number): StateMutabilityContext;
	public stateMutability(i?: number): StateMutabilityContext | StateMutabilityContext[] {
		if (i === undefined) {
			return this.getRuleContexts(StateMutabilityContext);
		} else {
			return this.getRuleContext(i, StateMutabilityContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_functionTypeName; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterFunctionTypeName) {
			listener.enterFunctionTypeName(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitFunctionTypeName) {
			listener.exitFunctionTypeName(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitFunctionTypeName) {
			return visitor.visitFunctionTypeName(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class StorageLocationContext extends ParserRuleContext {
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_storageLocation; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterStorageLocation) {
			listener.enterStorageLocation(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitStorageLocation) {
			listener.exitStorageLocation(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitStorageLocation) {
			return visitor.visitStorageLocation(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class StateMutabilityContext extends ParserRuleContext {
	public PureKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.PureKeyword, 0); }
	public ConstantKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.ConstantKeyword, 0); }
	public ViewKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.ViewKeyword, 0); }
	public PayableKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.PayableKeyword, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_stateMutability; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterStateMutability) {
			listener.enterStateMutability(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitStateMutability) {
			listener.exitStateMutability(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitStateMutability) {
			return visitor.visitStateMutability(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class BlockContext extends ParserRuleContext {
	public statement(): StatementContext[];
	public statement(i: number): StatementContext;
	public statement(i?: number): StatementContext | StatementContext[] {
		if (i === undefined) {
			return this.getRuleContexts(StatementContext);
		} else {
			return this.getRuleContext(i, StatementContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_block; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterBlock) {
			listener.enterBlock(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitBlock) {
			listener.exitBlock(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitBlock) {
			return visitor.visitBlock(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class StatementContext extends ParserRuleContext {
	public ifStatement(): IfStatementContext | undefined {
		return this.tryGetRuleContext(0, IfStatementContext);
	}
	public whileStatement(): WhileStatementContext | undefined {
		return this.tryGetRuleContext(0, WhileStatementContext);
	}
	public forStatement(): ForStatementContext | undefined {
		return this.tryGetRuleContext(0, ForStatementContext);
	}
	public block(): BlockContext | undefined {
		return this.tryGetRuleContext(0, BlockContext);
	}
	public inlineAssemblyStatement(): InlineAssemblyStatementContext | undefined {
		return this.tryGetRuleContext(0, InlineAssemblyStatementContext);
	}
	public doWhileStatement(): DoWhileStatementContext | undefined {
		return this.tryGetRuleContext(0, DoWhileStatementContext);
	}
	public continueStatement(): ContinueStatementContext | undefined {
		return this.tryGetRuleContext(0, ContinueStatementContext);
	}
	public breakStatement(): BreakStatementContext | undefined {
		return this.tryGetRuleContext(0, BreakStatementContext);
	}
	public returnStatement(): ReturnStatementContext | undefined {
		return this.tryGetRuleContext(0, ReturnStatementContext);
	}
	public throwStatement(): ThrowStatementContext | undefined {
		return this.tryGetRuleContext(0, ThrowStatementContext);
	}
	public emitStatement(): EmitStatementContext | undefined {
		return this.tryGetRuleContext(0, EmitStatementContext);
	}
	public simpleStatement(): SimpleStatementContext | undefined {
		return this.tryGetRuleContext(0, SimpleStatementContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_statement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterStatement) {
			listener.enterStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitStatement) {
			listener.exitStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitStatement) {
			return visitor.visitStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ExpressionStatementContext extends ParserRuleContext {
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_expressionStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterExpressionStatement) {
			listener.enterExpressionStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitExpressionStatement) {
			listener.exitExpressionStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitExpressionStatement) {
			return visitor.visitExpressionStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class IfStatementContext extends ParserRuleContext {
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	public statement(): StatementContext[];
	public statement(i: number): StatementContext;
	public statement(i?: number): StatementContext | StatementContext[] {
		if (i === undefined) {
			return this.getRuleContexts(StatementContext);
		} else {
			return this.getRuleContext(i, StatementContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_ifStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterIfStatement) {
			listener.enterIfStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitIfStatement) {
			listener.exitIfStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitIfStatement) {
			return visitor.visitIfStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class WhileStatementContext extends ParserRuleContext {
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	public statement(): StatementContext {
		return this.getRuleContext(0, StatementContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_whileStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterWhileStatement) {
			listener.enterWhileStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitWhileStatement) {
			listener.exitWhileStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitWhileStatement) {
			return visitor.visitWhileStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class SimpleStatementContext extends ParserRuleContext {
	public variableDeclarationStatement(): VariableDeclarationStatementContext | undefined {
		return this.tryGetRuleContext(0, VariableDeclarationStatementContext);
	}
	public expressionStatement(): ExpressionStatementContext | undefined {
		return this.tryGetRuleContext(0, ExpressionStatementContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_simpleStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterSimpleStatement) {
			listener.enterSimpleStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitSimpleStatement) {
			listener.exitSimpleStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitSimpleStatement) {
			return visitor.visitSimpleStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ForStatementContext extends ParserRuleContext {
	public statement(): StatementContext {
		return this.getRuleContext(0, StatementContext);
	}
	public simpleStatement(): SimpleStatementContext | undefined {
		return this.tryGetRuleContext(0, SimpleStatementContext);
	}
	public expression(): ExpressionContext[];
	public expression(i: number): ExpressionContext;
	public expression(i?: number): ExpressionContext | ExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ExpressionContext);
		} else {
			return this.getRuleContext(i, ExpressionContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_forStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterForStatement) {
			listener.enterForStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitForStatement) {
			listener.exitForStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitForStatement) {
			return visitor.visitForStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class InlineAssemblyStatementContext extends ParserRuleContext {
	public assemblyBlock(): AssemblyBlockContext {
		return this.getRuleContext(0, AssemblyBlockContext);
	}
	public StringLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.StringLiteral, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_inlineAssemblyStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterInlineAssemblyStatement) {
			listener.enterInlineAssemblyStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitInlineAssemblyStatement) {
			listener.exitInlineAssemblyStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitInlineAssemblyStatement) {
			return visitor.visitInlineAssemblyStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class DoWhileStatementContext extends ParserRuleContext {
	public statement(): StatementContext {
		return this.getRuleContext(0, StatementContext);
	}
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_doWhileStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterDoWhileStatement) {
			listener.enterDoWhileStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitDoWhileStatement) {
			listener.exitDoWhileStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitDoWhileStatement) {
			return visitor.visitDoWhileStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ContinueStatementContext extends ParserRuleContext {
	public ContinueKeyword(): TerminalNode { return this.getToken(SolidityParser.ContinueKeyword, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_continueStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterContinueStatement) {
			listener.enterContinueStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitContinueStatement) {
			listener.exitContinueStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitContinueStatement) {
			return visitor.visitContinueStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class BreakStatementContext extends ParserRuleContext {
	public BreakKeyword(): TerminalNode { return this.getToken(SolidityParser.BreakKeyword, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_breakStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterBreakStatement) {
			listener.enterBreakStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitBreakStatement) {
			listener.exitBreakStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitBreakStatement) {
			return visitor.visitBreakStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ReturnStatementContext extends ParserRuleContext {
	public expression(): ExpressionContext | undefined {
		return this.tryGetRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_returnStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterReturnStatement) {
			listener.enterReturnStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitReturnStatement) {
			listener.exitReturnStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitReturnStatement) {
			return visitor.visitReturnStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ThrowStatementContext extends ParserRuleContext {
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_throwStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterThrowStatement) {
			listener.enterThrowStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitThrowStatement) {
			listener.exitThrowStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitThrowStatement) {
			return visitor.visitThrowStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class EmitStatementContext extends ParserRuleContext {
	public functionCall(): FunctionCallContext {
		return this.getRuleContext(0, FunctionCallContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_emitStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterEmitStatement) {
			listener.enterEmitStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitEmitStatement) {
			listener.exitEmitStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitEmitStatement) {
			return visitor.visitEmitStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class VariableDeclarationStatementContext extends ParserRuleContext {
	public identifierList(): IdentifierListContext | undefined {
		return this.tryGetRuleContext(0, IdentifierListContext);
	}
	public variableDeclaration(): VariableDeclarationContext | undefined {
		return this.tryGetRuleContext(0, VariableDeclarationContext);
	}
	public variableDeclarationList(): VariableDeclarationListContext | undefined {
		return this.tryGetRuleContext(0, VariableDeclarationListContext);
	}
	public expression(): ExpressionContext | undefined {
		return this.tryGetRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_variableDeclarationStatement; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterVariableDeclarationStatement) {
			listener.enterVariableDeclarationStatement(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitVariableDeclarationStatement) {
			listener.exitVariableDeclarationStatement(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitVariableDeclarationStatement) {
			return visitor.visitVariableDeclarationStatement(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class VariableDeclarationListContext extends ParserRuleContext {
	public variableDeclaration(): VariableDeclarationContext[];
	public variableDeclaration(i: number): VariableDeclarationContext;
	public variableDeclaration(i?: number): VariableDeclarationContext | VariableDeclarationContext[] {
		if (i === undefined) {
			return this.getRuleContexts(VariableDeclarationContext);
		} else {
			return this.getRuleContext(i, VariableDeclarationContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_variableDeclarationList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterVariableDeclarationList) {
			listener.enterVariableDeclarationList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitVariableDeclarationList) {
			listener.exitVariableDeclarationList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitVariableDeclarationList) {
			return visitor.visitVariableDeclarationList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class IdentifierListContext extends ParserRuleContext {
	public identifier(): IdentifierContext[];
	public identifier(i: number): IdentifierContext;
	public identifier(i?: number): IdentifierContext | IdentifierContext[] {
		if (i === undefined) {
			return this.getRuleContexts(IdentifierContext);
		} else {
			return this.getRuleContext(i, IdentifierContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_identifierList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterIdentifierList) {
			listener.enterIdentifierList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitIdentifierList) {
			listener.exitIdentifierList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitIdentifierList) {
			return visitor.visitIdentifierList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ElementaryTypeNameContext extends ParserRuleContext {
	public Int(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.Int, 0); }
	public Uint(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.Uint, 0); }
	public Byte(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.Byte, 0); }
	public Fixed(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.Fixed, 0); }
	public Ufixed(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.Ufixed, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_elementaryTypeName; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterElementaryTypeName) {
			listener.enterElementaryTypeName(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitElementaryTypeName) {
			listener.exitElementaryTypeName(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitElementaryTypeName) {
			return visitor.visitElementaryTypeName(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ExpressionContext extends ParserRuleContext {
	public expression(): ExpressionContext[];
	public expression(i: number): ExpressionContext;
	public expression(i?: number): ExpressionContext | ExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ExpressionContext);
		} else {
			return this.getRuleContext(i, ExpressionContext);
		}
	}
	public typeName(): TypeNameContext | undefined {
		return this.tryGetRuleContext(0, TypeNameContext);
	}
	public functionCallArguments(): FunctionCallArgumentsContext | undefined {
		return this.tryGetRuleContext(0, FunctionCallArgumentsContext);
	}
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	public forAllExpression(): ForAllExpressionContext | undefined {
		return this.tryGetRuleContext(0, ForAllExpressionContext);
	}
	public sumExpression(): SumExpressionContext | undefined {
		return this.tryGetRuleContext(0, SumExpressionContext);
	}
	public primaryExpression(): PrimaryExpressionContext | undefined {
		return this.tryGetRuleContext(0, PrimaryExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_expression; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterExpression) {
			listener.enterExpression(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitExpression) {
			listener.exitExpression(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitExpression) {
			return visitor.visitExpression(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ForAllExpressionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_forAllExpression; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterForAllExpression) {
			listener.enterForAllExpression(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitForAllExpression) {
			listener.exitForAllExpression(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitForAllExpression) {
			return visitor.visitForAllExpression(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class SumExpressionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public expression(): ExpressionContext[];
	public expression(i: number): ExpressionContext;
	public expression(i?: number): ExpressionContext | ExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ExpressionContext);
		} else {
			return this.getRuleContext(i, ExpressionContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_sumExpression; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterSumExpression) {
			listener.enterSumExpression(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitSumExpression) {
			listener.exitSumExpression(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitSumExpression) {
			return visitor.visitSumExpression(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class PrimaryExpressionContext extends ParserRuleContext {
	public BooleanLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.BooleanLiteral, 0); }
	public numberLiteral(): NumberLiteralContext | undefined {
		return this.tryGetRuleContext(0, NumberLiteralContext);
	}
	public HexLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.HexLiteral, 0); }
	public StringLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.StringLiteral, 0); }
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	public tupleExpression(): TupleExpressionContext | undefined {
		return this.tryGetRuleContext(0, TupleExpressionContext);
	}
	public elementaryTypeNameExpression(): ElementaryTypeNameExpressionContext | undefined {
		return this.tryGetRuleContext(0, ElementaryTypeNameExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_primaryExpression; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterPrimaryExpression) {
			listener.enterPrimaryExpression(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitPrimaryExpression) {
			listener.exitPrimaryExpression(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitPrimaryExpression) {
			return visitor.visitPrimaryExpression(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ExpressionListContext extends ParserRuleContext {
	public expression(): ExpressionContext[];
	public expression(i: number): ExpressionContext;
	public expression(i?: number): ExpressionContext | ExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ExpressionContext);
		} else {
			return this.getRuleContext(i, ExpressionContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_expressionList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterExpressionList) {
			listener.enterExpressionList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitExpressionList) {
			listener.exitExpressionList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitExpressionList) {
			return visitor.visitExpressionList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class NameValueListContext extends ParserRuleContext {
	public nameValue(): NameValueContext[];
	public nameValue(i: number): NameValueContext;
	public nameValue(i?: number): NameValueContext | NameValueContext[] {
		if (i === undefined) {
			return this.getRuleContexts(NameValueContext);
		} else {
			return this.getRuleContext(i, NameValueContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_nameValueList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterNameValueList) {
			listener.enterNameValueList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitNameValueList) {
			listener.exitNameValueList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitNameValueList) {
			return visitor.visitNameValueList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class NameValueContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_nameValue; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterNameValue) {
			listener.enterNameValue(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitNameValue) {
			listener.exitNameValue(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitNameValue) {
			return visitor.visitNameValue(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class FunctionCallArgumentsContext extends ParserRuleContext {
	public nameValueList(): NameValueListContext | undefined {
		return this.tryGetRuleContext(0, NameValueListContext);
	}
	public expressionList(): ExpressionListContext | undefined {
		return this.tryGetRuleContext(0, ExpressionListContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_functionCallArguments; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterFunctionCallArguments) {
			listener.enterFunctionCallArguments(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitFunctionCallArguments) {
			listener.exitFunctionCallArguments(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitFunctionCallArguments) {
			return visitor.visitFunctionCallArguments(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class FunctionCallContext extends ParserRuleContext {
	public expression(): ExpressionContext {
		return this.getRuleContext(0, ExpressionContext);
	}
	public functionCallArguments(): FunctionCallArgumentsContext {
		return this.getRuleContext(0, FunctionCallArgumentsContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_functionCall; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterFunctionCall) {
			listener.enterFunctionCall(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitFunctionCall) {
			listener.exitFunctionCall(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitFunctionCall) {
			return visitor.visitFunctionCall(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyBlockContext extends ParserRuleContext {
	public assemblyItem(): AssemblyItemContext[];
	public assemblyItem(i: number): AssemblyItemContext;
	public assemblyItem(i?: number): AssemblyItemContext | AssemblyItemContext[] {
		if (i === undefined) {
			return this.getRuleContexts(AssemblyItemContext);
		} else {
			return this.getRuleContext(i, AssemblyItemContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyBlock; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyBlock) {
			listener.enterAssemblyBlock(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyBlock) {
			listener.exitAssemblyBlock(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyBlock) {
			return visitor.visitAssemblyBlock(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyItemContext extends ParserRuleContext {
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	public assemblyBlock(): AssemblyBlockContext | undefined {
		return this.tryGetRuleContext(0, AssemblyBlockContext);
	}
	public assemblyExpression(): AssemblyExpressionContext | undefined {
		return this.tryGetRuleContext(0, AssemblyExpressionContext);
	}
	public assemblyLocalDefinition(): AssemblyLocalDefinitionContext | undefined {
		return this.tryGetRuleContext(0, AssemblyLocalDefinitionContext);
	}
	public assemblyAssignment(): AssemblyAssignmentContext | undefined {
		return this.tryGetRuleContext(0, AssemblyAssignmentContext);
	}
	public assemblyStackAssignment(): AssemblyStackAssignmentContext | undefined {
		return this.tryGetRuleContext(0, AssemblyStackAssignmentContext);
	}
	public labelDefinition(): LabelDefinitionContext | undefined {
		return this.tryGetRuleContext(0, LabelDefinitionContext);
	}
	public assemblySwitch(): AssemblySwitchContext | undefined {
		return this.tryGetRuleContext(0, AssemblySwitchContext);
	}
	public assemblyFunctionDefinition(): AssemblyFunctionDefinitionContext | undefined {
		return this.tryGetRuleContext(0, AssemblyFunctionDefinitionContext);
	}
	public assemblyFor(): AssemblyForContext | undefined {
		return this.tryGetRuleContext(0, AssemblyForContext);
	}
	public assemblyIf(): AssemblyIfContext | undefined {
		return this.tryGetRuleContext(0, AssemblyIfContext);
	}
	public BreakKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.BreakKeyword, 0); }
	public ContinueKeyword(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.ContinueKeyword, 0); }
	public subAssembly(): SubAssemblyContext | undefined {
		return this.tryGetRuleContext(0, SubAssemblyContext);
	}
	public numberLiteral(): NumberLiteralContext | undefined {
		return this.tryGetRuleContext(0, NumberLiteralContext);
	}
	public StringLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.StringLiteral, 0); }
	public HexLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.HexLiteral, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyItem; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyItem) {
			listener.enterAssemblyItem(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyItem) {
			listener.exitAssemblyItem(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyItem) {
			return visitor.visitAssemblyItem(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyExpressionContext extends ParserRuleContext {
	public assemblyCall(): AssemblyCallContext | undefined {
		return this.tryGetRuleContext(0, AssemblyCallContext);
	}
	public assemblyLiteral(): AssemblyLiteralContext | undefined {
		return this.tryGetRuleContext(0, AssemblyLiteralContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyExpression; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyExpression) {
			listener.enterAssemblyExpression(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyExpression) {
			listener.exitAssemblyExpression(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyExpression) {
			return visitor.visitAssemblyExpression(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyCallContext extends ParserRuleContext {
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	public assemblyExpression(): AssemblyExpressionContext[];
	public assemblyExpression(i: number): AssemblyExpressionContext;
	public assemblyExpression(i?: number): AssemblyExpressionContext | AssemblyExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(AssemblyExpressionContext);
		} else {
			return this.getRuleContext(i, AssemblyExpressionContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyCall; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyCall) {
			listener.enterAssemblyCall(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyCall) {
			listener.exitAssemblyCall(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyCall) {
			return visitor.visitAssemblyCall(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyLocalDefinitionContext extends ParserRuleContext {
	public assemblyIdentifierOrList(): AssemblyIdentifierOrListContext {
		return this.getRuleContext(0, AssemblyIdentifierOrListContext);
	}
	public assemblyExpression(): AssemblyExpressionContext | undefined {
		return this.tryGetRuleContext(0, AssemblyExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyLocalDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyLocalDefinition) {
			listener.enterAssemblyLocalDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyLocalDefinition) {
			listener.exitAssemblyLocalDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyLocalDefinition) {
			return visitor.visitAssemblyLocalDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyAssignmentContext extends ParserRuleContext {
	public assemblyIdentifierOrList(): AssemblyIdentifierOrListContext {
		return this.getRuleContext(0, AssemblyIdentifierOrListContext);
	}
	public assemblyExpression(): AssemblyExpressionContext {
		return this.getRuleContext(0, AssemblyExpressionContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyAssignment; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyAssignment) {
			listener.enterAssemblyAssignment(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyAssignment) {
			listener.exitAssemblyAssignment(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyAssignment) {
			return visitor.visitAssemblyAssignment(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyIdentifierOrListContext extends ParserRuleContext {
	public identifier(): IdentifierContext | undefined {
		return this.tryGetRuleContext(0, IdentifierContext);
	}
	public assemblyIdentifierList(): AssemblyIdentifierListContext | undefined {
		return this.tryGetRuleContext(0, AssemblyIdentifierListContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyIdentifierOrList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyIdentifierOrList) {
			listener.enterAssemblyIdentifierOrList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyIdentifierOrList) {
			listener.exitAssemblyIdentifierOrList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyIdentifierOrList) {
			return visitor.visitAssemblyIdentifierOrList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyIdentifierListContext extends ParserRuleContext {
	public identifier(): IdentifierContext[];
	public identifier(i: number): IdentifierContext;
	public identifier(i?: number): IdentifierContext | IdentifierContext[] {
		if (i === undefined) {
			return this.getRuleContexts(IdentifierContext);
		} else {
			return this.getRuleContext(i, IdentifierContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyIdentifierList; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyIdentifierList) {
			listener.enterAssemblyIdentifierList(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyIdentifierList) {
			listener.exitAssemblyIdentifierList(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyIdentifierList) {
			return visitor.visitAssemblyIdentifierList(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyStackAssignmentContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyStackAssignment; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyStackAssignment) {
			listener.enterAssemblyStackAssignment(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyStackAssignment) {
			listener.exitAssemblyStackAssignment(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyStackAssignment) {
			return visitor.visitAssemblyStackAssignment(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class LabelDefinitionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_labelDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterLabelDefinition) {
			listener.enterLabelDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitLabelDefinition) {
			listener.exitLabelDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitLabelDefinition) {
			return visitor.visitLabelDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblySwitchContext extends ParserRuleContext {
	public assemblyExpression(): AssemblyExpressionContext {
		return this.getRuleContext(0, AssemblyExpressionContext);
	}
	public assemblyCase(): AssemblyCaseContext[];
	public assemblyCase(i: number): AssemblyCaseContext;
	public assemblyCase(i?: number): AssemblyCaseContext | AssemblyCaseContext[] {
		if (i === undefined) {
			return this.getRuleContexts(AssemblyCaseContext);
		} else {
			return this.getRuleContext(i, AssemblyCaseContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblySwitch; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblySwitch) {
			listener.enterAssemblySwitch(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblySwitch) {
			listener.exitAssemblySwitch(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblySwitch) {
			return visitor.visitAssemblySwitch(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyCaseContext extends ParserRuleContext {
	public assemblyLiteral(): AssemblyLiteralContext | undefined {
		return this.tryGetRuleContext(0, AssemblyLiteralContext);
	}
	public assemblyBlock(): AssemblyBlockContext {
		return this.getRuleContext(0, AssemblyBlockContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyCase; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyCase) {
			listener.enterAssemblyCase(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyCase) {
			listener.exitAssemblyCase(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyCase) {
			return visitor.visitAssemblyCase(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyFunctionDefinitionContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public assemblyBlock(): AssemblyBlockContext {
		return this.getRuleContext(0, AssemblyBlockContext);
	}
	public assemblyIdentifierList(): AssemblyIdentifierListContext | undefined {
		return this.tryGetRuleContext(0, AssemblyIdentifierListContext);
	}
	public assemblyFunctionReturns(): AssemblyFunctionReturnsContext | undefined {
		return this.tryGetRuleContext(0, AssemblyFunctionReturnsContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyFunctionDefinition; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyFunctionDefinition) {
			listener.enterAssemblyFunctionDefinition(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyFunctionDefinition) {
			listener.exitAssemblyFunctionDefinition(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyFunctionDefinition) {
			return visitor.visitAssemblyFunctionDefinition(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyFunctionReturnsContext extends ParserRuleContext {
	public assemblyIdentifierList(): AssemblyIdentifierListContext | undefined {
		return this.tryGetRuleContext(0, AssemblyIdentifierListContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyFunctionReturns; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyFunctionReturns) {
			listener.enterAssemblyFunctionReturns(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyFunctionReturns) {
			listener.exitAssemblyFunctionReturns(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyFunctionReturns) {
			return visitor.visitAssemblyFunctionReturns(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyForContext extends ParserRuleContext {
	public assemblyExpression(): AssemblyExpressionContext[];
	public assemblyExpression(i: number): AssemblyExpressionContext;
	public assemblyExpression(i?: number): AssemblyExpressionContext | AssemblyExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(AssemblyExpressionContext);
		} else {
			return this.getRuleContext(i, AssemblyExpressionContext);
		}
	}
	public assemblyBlock(): AssemblyBlockContext[];
	public assemblyBlock(i: number): AssemblyBlockContext;
	public assemblyBlock(i?: number): AssemblyBlockContext | AssemblyBlockContext[] {
		if (i === undefined) {
			return this.getRuleContexts(AssemblyBlockContext);
		} else {
			return this.getRuleContext(i, AssemblyBlockContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyFor; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyFor) {
			listener.enterAssemblyFor(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyFor) {
			listener.exitAssemblyFor(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyFor) {
			return visitor.visitAssemblyFor(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyIfContext extends ParserRuleContext {
	public assemblyExpression(): AssemblyExpressionContext {
		return this.getRuleContext(0, AssemblyExpressionContext);
	}
	public assemblyBlock(): AssemblyBlockContext {
		return this.getRuleContext(0, AssemblyBlockContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyIf; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyIf) {
			listener.enterAssemblyIf(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyIf) {
			listener.exitAssemblyIf(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyIf) {
			return visitor.visitAssemblyIf(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class AssemblyLiteralContext extends ParserRuleContext {
	public StringLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.StringLiteral, 0); }
	public DecimalNumber(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.DecimalNumber, 0); }
	public HexNumber(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.HexNumber, 0); }
	public HexLiteral(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.HexLiteral, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_assemblyLiteral; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterAssemblyLiteral) {
			listener.enterAssemblyLiteral(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitAssemblyLiteral) {
			listener.exitAssemblyLiteral(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitAssemblyLiteral) {
			return visitor.visitAssemblyLiteral(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class SubAssemblyContext extends ParserRuleContext {
	public identifier(): IdentifierContext {
		return this.getRuleContext(0, IdentifierContext);
	}
	public assemblyBlock(): AssemblyBlockContext {
		return this.getRuleContext(0, AssemblyBlockContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_subAssembly; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterSubAssembly) {
			listener.enterSubAssembly(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitSubAssembly) {
			listener.exitSubAssembly(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitSubAssembly) {
			return visitor.visitSubAssembly(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class TupleExpressionContext extends ParserRuleContext {
	public expression(): ExpressionContext[];
	public expression(i: number): ExpressionContext;
	public expression(i?: number): ExpressionContext | ExpressionContext[] {
		if (i === undefined) {
			return this.getRuleContexts(ExpressionContext);
		} else {
			return this.getRuleContext(i, ExpressionContext);
		}
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_tupleExpression; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterTupleExpression) {
			listener.enterTupleExpression(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitTupleExpression) {
			listener.exitTupleExpression(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitTupleExpression) {
			return visitor.visitTupleExpression(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class ElementaryTypeNameExpressionContext extends ParserRuleContext {
	public elementaryTypeName(): ElementaryTypeNameContext {
		return this.getRuleContext(0, ElementaryTypeNameContext);
	}
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_elementaryTypeNameExpression; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterElementaryTypeNameExpression) {
			listener.enterElementaryTypeNameExpression(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitElementaryTypeNameExpression) {
			listener.exitElementaryTypeNameExpression(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitElementaryTypeNameExpression) {
			return visitor.visitElementaryTypeNameExpression(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class NumberLiteralContext extends ParserRuleContext {
	public DecimalNumber(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.DecimalNumber, 0); }
	public HexNumber(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.HexNumber, 0); }
	public NumberUnit(): TerminalNode | undefined { return this.tryGetToken(SolidityParser.NumberUnit, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_numberLiteral; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterNumberLiteral) {
			listener.enterNumberLiteral(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitNumberLiteral) {
			listener.exitNumberLiteral(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitNumberLiteral) {
			return visitor.visitNumberLiteral(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


export class IdentifierContext extends ParserRuleContext {
	public Identifier(): TerminalNode { return this.getToken(SolidityParser.Identifier, 0); }
	constructor(parent: ParserRuleContext | undefined, invokingState: number) {
		super(parent, invokingState);
	}
	// @Override
	public get ruleIndex(): number { return SolidityParser.RULE_identifier; }
	// @Override
	public enterRule(listener: SolidityListener): void {
		if (listener.enterIdentifier) {
			listener.enterIdentifier(this);
		}
	}
	// @Override
	public exitRule(listener: SolidityListener): void {
		if (listener.exitIdentifier) {
			listener.exitIdentifier(this);
		}
	}
	// @Override
	public accept<Result>(visitor: SolidityVisitor<Result>): Result {
		if (visitor.visitIdentifier) {
			return visitor.visitIdentifier(this);
		} else {
			return visitor.visitChildren(this);
		}
	}
}


