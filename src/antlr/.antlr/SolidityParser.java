// Generated from /Users/leo/repos/solythesis/src/antlr/Solidity.g4 by ANTLR 4.7.1
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class SolidityParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.7.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, T__32=33, T__33=34, T__34=35, T__35=36, T__36=37, T__37=38, 
		T__38=39, T__39=40, T__40=41, T__41=42, T__42=43, T__43=44, T__44=45, 
		T__45=46, T__46=47, T__47=48, T__48=49, T__49=50, T__50=51, T__51=52, 
		T__52=53, T__53=54, T__54=55, T__55=56, T__56=57, T__57=58, T__58=59, 
		T__59=60, T__60=61, T__61=62, T__62=63, T__63=64, T__64=65, T__65=66, 
		T__66=67, T__67=68, T__68=69, T__69=70, T__70=71, T__71=72, T__72=73, 
		T__73=74, T__74=75, T__75=76, T__76=77, T__77=78, T__78=79, T__79=80, 
		T__80=81, T__81=82, T__82=83, T__83=84, T__84=85, T__85=86, T__86=87, 
		T__87=88, T__88=89, T__89=90, T__90=91, T__91=92, T__92=93, T__93=94, 
		Int=95, Uint=96, Byte=97, Fixed=98, Ufixed=99, VersionLiteral=100, BooleanLiteral=101, 
		DecimalNumber=102, HexNumber=103, NumberUnit=104, HexLiteral=105, ReservedKeyword=106, 
		AnonymousKeyword=107, BreakKeyword=108, ConstantKeyword=109, ContinueKeyword=110, 
		ExternalKeyword=111, IndexedKeyword=112, InternalKeyword=113, PayableKeyword=114, 
		PrivateKeyword=115, PublicKeyword=116, PureKeyword=117, ViewKeyword=118, 
		Identifier=119, StringLiteral=120, WS=121, COMMENT=122, LINE_COMMENT=123;
	public static final int
		RULE_sourceUnit = 0, RULE_pragmaDirective = 1, RULE_pragmaName = 2, RULE_pragmaValue = 3, 
		RULE_version = 4, RULE_versionOperator = 5, RULE_versionConstraint = 6, 
		RULE_importDeclaration = 7, RULE_standardDefinition = 8, RULE_constraint = 9, 
		RULE_importDirective = 10, RULE_contractDefinition = 11, RULE_inheritanceSpecifier = 12, 
		RULE_contractPart = 13, RULE_stateVariableDeclaration = 14, RULE_usingForDeclaration = 15, 
		RULE_structDefinition = 16, RULE_constructorDefinition = 17, RULE_modifierDefinition = 18, 
		RULE_modifierInvocation = 19, RULE_functionDefinition = 20, RULE_returnParameters = 21, 
		RULE_modifierList = 22, RULE_eventDefinition = 23, RULE_enumValue = 24, 
		RULE_enumDefinition = 25, RULE_parameterList = 26, RULE_parameter = 27, 
		RULE_eventParameterList = 28, RULE_eventParameter = 29, RULE_functionTypeParameterList = 30, 
		RULE_functionTypeParameter = 31, RULE_variableDeclaration = 32, RULE_typeName = 33, 
		RULE_userDefinedTypeName = 34, RULE_mapping = 35, RULE_functionTypeName = 36, 
		RULE_storageLocation = 37, RULE_stateMutability = 38, RULE_block = 39, 
		RULE_statement = 40, RULE_expressionStatement = 41, RULE_ifStatement = 42, 
		RULE_whileStatement = 43, RULE_simpleStatement = 44, RULE_forStatement = 45, 
		RULE_inlineAssemblyStatement = 46, RULE_doWhileStatement = 47, RULE_continueStatement = 48, 
		RULE_breakStatement = 49, RULE_returnStatement = 50, RULE_throwStatement = 51, 
		RULE_emitStatement = 52, RULE_variableDeclarationStatement = 53, RULE_variableDeclarationList = 54, 
		RULE_identifierList = 55, RULE_elementaryTypeName = 56, RULE_expression = 57, 
		RULE_forAllExpression = 58, RULE_sumExpression = 59, RULE_primaryExpression = 60, 
		RULE_expressionList = 61, RULE_nameValueList = 62, RULE_nameValue = 63, 
		RULE_functionCallArguments = 64, RULE_functionCall = 65, RULE_assemblyBlock = 66, 
		RULE_assemblyItem = 67, RULE_assemblyExpression = 68, RULE_assemblyCall = 69, 
		RULE_assemblyLocalDefinition = 70, RULE_assemblyAssignment = 71, RULE_assemblyIdentifierOrList = 72, 
		RULE_assemblyIdentifierList = 73, RULE_assemblyStackAssignment = 74, RULE_labelDefinition = 75, 
		RULE_assemblySwitch = 76, RULE_assemblyCase = 77, RULE_assemblyFunctionDefinition = 78, 
		RULE_assemblyFunctionReturns = 79, RULE_assemblyFor = 80, RULE_assemblyIf = 81, 
		RULE_assemblyLiteral = 82, RULE_subAssembly = 83, RULE_tupleExpression = 84, 
		RULE_elementaryTypeNameExpression = 85, RULE_numberLiteral = 86, RULE_identifier = 87;
	public static final String[] ruleNames = {
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
		"numberLiteral", "identifier"
	};

	private static final String[] _LITERAL_NAMES = {
		null, "'pragma'", "';'", "'^'", "'~'", "'>='", "'>'", "'<'", "'<='", "'='", 
		"'as'", "'standard'", "'{'", "'}'", "'constraint'", "'import'", "'*'", 
		"'from'", "','", "'contract'", "'interface'", "'library'", "'is'", "'('", 
		"')'", "'using'", "'for'", "'struct'", "'constructor'", "'modifier'", 
		"'function'", "'returns'", "'event'", "'enum'", "'['", "']'", "'address'", 
		"'.'", "'mapping'", "'=>'", "'memory'", "'storage'", "'calldata'", "'if'", 
		"'else'", "'while'", "'assembly'", "'do'", "'return'", "'throw'", "'emit'", 
		"'var'", "'bool'", "'string'", "'byte'", "'++'", "'--'", "'new'", "'+'", 
		"'-'", "'after'", "'delete'", "'!'", "'**'", "'/'", "'%'", "'<<'", "'>>'", 
		"'&'", "'|'", "'=='", "'!='", "'&&'", "'||'", "'?'", "':'", "'|='", "'^='", 
		"'&='", "'<<='", "'>>='", "'+='", "'-='", "'*='", "'/='", "'%='", "'ForAll'", 
		"'Sum'", "'let'", "':='", "'=:'", "'switch'", "'case'", "'default'", "'->'", 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		"'anonymous'", "'break'", "'constant'", "'continue'", "'external'", "'indexed'", 
		"'internal'", "'payable'", "'private'", "'public'", "'pure'", "'view'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, null, 
		null, null, null, null, null, null, null, null, null, null, null, "Int", 
		"Uint", "Byte", "Fixed", "Ufixed", "VersionLiteral", "BooleanLiteral", 
		"DecimalNumber", "HexNumber", "NumberUnit", "HexLiteral", "ReservedKeyword", 
		"AnonymousKeyword", "BreakKeyword", "ConstantKeyword", "ContinueKeyword", 
		"ExternalKeyword", "IndexedKeyword", "InternalKeyword", "PayableKeyword", 
		"PrivateKeyword", "PublicKeyword", "PureKeyword", "ViewKeyword", "Identifier", 
		"StringLiteral", "WS", "COMMENT", "LINE_COMMENT"
	};
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Solidity.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public SolidityParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class SourceUnitContext extends ParserRuleContext {
		public TerminalNode EOF() { return getToken(SolidityParser.EOF, 0); }
		public List<PragmaDirectiveContext> pragmaDirective() {
			return getRuleContexts(PragmaDirectiveContext.class);
		}
		public PragmaDirectiveContext pragmaDirective(int i) {
			return getRuleContext(PragmaDirectiveContext.class,i);
		}
		public List<ImportDirectiveContext> importDirective() {
			return getRuleContexts(ImportDirectiveContext.class);
		}
		public ImportDirectiveContext importDirective(int i) {
			return getRuleContext(ImportDirectiveContext.class,i);
		}
		public List<ContractDefinitionContext> contractDefinition() {
			return getRuleContexts(ContractDefinitionContext.class);
		}
		public ContractDefinitionContext contractDefinition(int i) {
			return getRuleContext(ContractDefinitionContext.class,i);
		}
		public List<StandardDefinitionContext> standardDefinition() {
			return getRuleContexts(StandardDefinitionContext.class);
		}
		public StandardDefinitionContext standardDefinition(int i) {
			return getRuleContext(StandardDefinitionContext.class,i);
		}
		public SourceUnitContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sourceUnit; }
	}

	public final SourceUnitContext sourceUnit() throws RecognitionException {
		SourceUnitContext _localctx = new SourceUnitContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_sourceUnit);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(182);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__10) | (1L << T__14) | (1L << T__18) | (1L << T__19) | (1L << T__20))) != 0)) {
				{
				setState(180);
				_errHandler.sync(this);
				switch (_input.LA(1)) {
				case T__0:
					{
					setState(176);
					pragmaDirective();
					}
					break;
				case T__14:
					{
					setState(177);
					importDirective();
					}
					break;
				case T__18:
				case T__19:
				case T__20:
					{
					setState(178);
					contractDefinition();
					}
					break;
				case T__10:
					{
					setState(179);
					standardDefinition();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				setState(184);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(185);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PragmaDirectiveContext extends ParserRuleContext {
		public PragmaNameContext pragmaName() {
			return getRuleContext(PragmaNameContext.class,0);
		}
		public PragmaValueContext pragmaValue() {
			return getRuleContext(PragmaValueContext.class,0);
		}
		public PragmaDirectiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragmaDirective; }
	}

	public final PragmaDirectiveContext pragmaDirective() throws RecognitionException {
		PragmaDirectiveContext _localctx = new PragmaDirectiveContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_pragmaDirective);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(187);
			match(T__0);
			setState(188);
			pragmaName();
			setState(189);
			pragmaValue();
			setState(190);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PragmaNameContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public PragmaNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragmaName; }
	}

	public final PragmaNameContext pragmaName() throws RecognitionException {
		PragmaNameContext _localctx = new PragmaNameContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_pragmaName);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(192);
			identifier();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PragmaValueContext extends ParserRuleContext {
		public VersionContext version() {
			return getRuleContext(VersionContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public PragmaValueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pragmaValue; }
	}

	public final PragmaValueContext pragmaValue() throws RecognitionException {
		PragmaValueContext _localctx = new PragmaValueContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_pragmaValue);
		try {
			setState(196);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,2,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(194);
				version();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(195);
				expression(0);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VersionContext extends ParserRuleContext {
		public List<VersionConstraintContext> versionConstraint() {
			return getRuleContexts(VersionConstraintContext.class);
		}
		public VersionConstraintContext versionConstraint(int i) {
			return getRuleContext(VersionConstraintContext.class,i);
		}
		public VersionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_version; }
	}

	public final VersionContext version() throws RecognitionException {
		VersionContext _localctx = new VersionContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_version);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(198);
			versionConstraint();
			setState(200);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__2) | (1L << T__3) | (1L << T__4) | (1L << T__5) | (1L << T__6) | (1L << T__7) | (1L << T__8))) != 0) || _la==VersionLiteral) {
				{
				setState(199);
				versionConstraint();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VersionOperatorContext extends ParserRuleContext {
		public VersionOperatorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_versionOperator; }
	}

	public final VersionOperatorContext versionOperator() throws RecognitionException {
		VersionOperatorContext _localctx = new VersionOperatorContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_versionOperator);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(202);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__2) | (1L << T__3) | (1L << T__4) | (1L << T__5) | (1L << T__6) | (1L << T__7) | (1L << T__8))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VersionConstraintContext extends ParserRuleContext {
		public TerminalNode VersionLiteral() { return getToken(SolidityParser.VersionLiteral, 0); }
		public VersionOperatorContext versionOperator() {
			return getRuleContext(VersionOperatorContext.class,0);
		}
		public VersionConstraintContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_versionConstraint; }
	}

	public final VersionConstraintContext versionConstraint() throws RecognitionException {
		VersionConstraintContext _localctx = new VersionConstraintContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_versionConstraint);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(205);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__2) | (1L << T__3) | (1L << T__4) | (1L << T__5) | (1L << T__6) | (1L << T__7) | (1L << T__8))) != 0)) {
				{
				setState(204);
				versionOperator();
				}
			}

			setState(207);
			match(VersionLiteral);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ImportDeclarationContext extends ParserRuleContext {
		public List<IdentifierContext> identifier() {
			return getRuleContexts(IdentifierContext.class);
		}
		public IdentifierContext identifier(int i) {
			return getRuleContext(IdentifierContext.class,i);
		}
		public ImportDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_importDeclaration; }
	}

	public final ImportDeclarationContext importDeclaration() throws RecognitionException {
		ImportDeclarationContext _localctx = new ImportDeclarationContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_importDeclaration);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(209);
			identifier();
			setState(212);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__9) {
				{
				setState(210);
				match(T__9);
				setState(211);
				identifier();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StandardDefinitionContext extends ParserRuleContext {
		public TerminalNode Identifier() { return getToken(SolidityParser.Identifier, 0); }
		public ConstraintContext constraint() {
			return getRuleContext(ConstraintContext.class,0);
		}
		public TerminalNode EOF() { return getToken(SolidityParser.EOF, 0); }
		public List<ContractPartContext> contractPart() {
			return getRuleContexts(ContractPartContext.class);
		}
		public ContractPartContext contractPart(int i) {
			return getRuleContext(ContractPartContext.class,i);
		}
		public StandardDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_standardDefinition; }
	}

	public final StandardDefinitionContext standardDefinition() throws RecognitionException {
		StandardDefinitionContext _localctx = new StandardDefinitionContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_standardDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(214);
			match(T__10);
			setState(215);
			match(Identifier);
			setState(216);
			match(T__11);
			setState(220);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__24) | (1L << T__26) | (1L << T__27) | (1L << T__28) | (1L << T__29) | (1L << T__31) | (1L << T__32) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
				{
				{
				setState(217);
				contractPart();
				}
				}
				setState(222);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(223);
			constraint();
			setState(224);
			match(T__12);
			setState(225);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ConstraintContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public ConstraintContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_constraint; }
	}

	public final ConstraintContext constraint() throws RecognitionException {
		ConstraintContext _localctx = new ConstraintContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_constraint);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(227);
			match(T__13);
			setState(228);
			expression(0);
			setState(229);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ImportDirectiveContext extends ParserRuleContext {
		public TerminalNode StringLiteral() { return getToken(SolidityParser.StringLiteral, 0); }
		public List<IdentifierContext> identifier() {
			return getRuleContexts(IdentifierContext.class);
		}
		public IdentifierContext identifier(int i) {
			return getRuleContext(IdentifierContext.class,i);
		}
		public List<ImportDeclarationContext> importDeclaration() {
			return getRuleContexts(ImportDeclarationContext.class);
		}
		public ImportDeclarationContext importDeclaration(int i) {
			return getRuleContext(ImportDeclarationContext.class,i);
		}
		public ImportDirectiveContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_importDirective; }
	}

	public final ImportDirectiveContext importDirective() throws RecognitionException {
		ImportDirectiveContext _localctx = new ImportDirectiveContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_importDirective);
		int _la;
		try {
			setState(265);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,11,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(231);
				match(T__14);
				setState(232);
				match(StringLiteral);
				setState(235);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__9) {
					{
					setState(233);
					match(T__9);
					setState(234);
					identifier();
					}
				}

				setState(237);
				match(T__1);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(238);
				match(T__14);
				setState(241);
				_errHandler.sync(this);
				switch (_input.LA(1)) {
				case T__15:
					{
					setState(239);
					match(T__15);
					}
					break;
				case T__16:
				case Identifier:
					{
					setState(240);
					identifier();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(245);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__9) {
					{
					setState(243);
					match(T__9);
					setState(244);
					identifier();
					}
				}

				setState(247);
				match(T__16);
				setState(248);
				match(StringLiteral);
				setState(249);
				match(T__1);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(250);
				match(T__14);
				setState(251);
				match(T__11);
				setState(252);
				importDeclaration();
				setState(257);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(253);
					match(T__17);
					setState(254);
					importDeclaration();
					}
					}
					setState(259);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(260);
				match(T__12);
				setState(261);
				match(T__16);
				setState(262);
				match(StringLiteral);
				setState(263);
				match(T__1);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ContractDefinitionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public List<InheritanceSpecifierContext> inheritanceSpecifier() {
			return getRuleContexts(InheritanceSpecifierContext.class);
		}
		public InheritanceSpecifierContext inheritanceSpecifier(int i) {
			return getRuleContext(InheritanceSpecifierContext.class,i);
		}
		public List<ContractPartContext> contractPart() {
			return getRuleContexts(ContractPartContext.class);
		}
		public ContractPartContext contractPart(int i) {
			return getRuleContext(ContractPartContext.class,i);
		}
		public ContractDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_contractDefinition; }
	}

	public final ContractDefinitionContext contractDefinition() throws RecognitionException {
		ContractDefinitionContext _localctx = new ContractDefinitionContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_contractDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(267);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__18) | (1L << T__19) | (1L << T__20))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(268);
			identifier();
			setState(278);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__21) {
				{
				setState(269);
				match(T__21);
				setState(270);
				inheritanceSpecifier();
				setState(275);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(271);
					match(T__17);
					setState(272);
					inheritanceSpecifier();
					}
					}
					setState(277);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			setState(280);
			match(T__11);
			setState(284);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__24) | (1L << T__26) | (1L << T__27) | (1L << T__28) | (1L << T__29) | (1L << T__31) | (1L << T__32) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
				{
				{
				setState(281);
				contractPart();
				}
				}
				setState(286);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(287);
			match(T__12);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class InheritanceSpecifierContext extends ParserRuleContext {
		public UserDefinedTypeNameContext userDefinedTypeName() {
			return getRuleContext(UserDefinedTypeNameContext.class,0);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public InheritanceSpecifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_inheritanceSpecifier; }
	}

	public final InheritanceSpecifierContext inheritanceSpecifier() throws RecognitionException {
		InheritanceSpecifierContext _localctx = new InheritanceSpecifierContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_inheritanceSpecifier);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(289);
			userDefinedTypeName();
			setState(301);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__22) {
				{
				setState(290);
				match(T__22);
				setState(291);
				expression(0);
				setState(296);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(292);
					match(T__17);
					setState(293);
					expression(0);
					}
					}
					setState(298);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(299);
				match(T__23);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ContractPartContext extends ParserRuleContext {
		public StateVariableDeclarationContext stateVariableDeclaration() {
			return getRuleContext(StateVariableDeclarationContext.class,0);
		}
		public UsingForDeclarationContext usingForDeclaration() {
			return getRuleContext(UsingForDeclarationContext.class,0);
		}
		public StructDefinitionContext structDefinition() {
			return getRuleContext(StructDefinitionContext.class,0);
		}
		public ConstructorDefinitionContext constructorDefinition() {
			return getRuleContext(ConstructorDefinitionContext.class,0);
		}
		public ModifierDefinitionContext modifierDefinition() {
			return getRuleContext(ModifierDefinitionContext.class,0);
		}
		public FunctionDefinitionContext functionDefinition() {
			return getRuleContext(FunctionDefinitionContext.class,0);
		}
		public EventDefinitionContext eventDefinition() {
			return getRuleContext(EventDefinitionContext.class,0);
		}
		public EnumDefinitionContext enumDefinition() {
			return getRuleContext(EnumDefinitionContext.class,0);
		}
		public ContractPartContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_contractPart; }
	}

	public final ContractPartContext contractPart() throws RecognitionException {
		ContractPartContext _localctx = new ContractPartContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_contractPart);
		try {
			setState(311);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,17,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(303);
				stateVariableDeclaration();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(304);
				usingForDeclaration();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(305);
				structDefinition();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(306);
				constructorDefinition();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(307);
				modifierDefinition();
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(308);
				functionDefinition();
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(309);
				eventDefinition();
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(310);
				enumDefinition();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StateVariableDeclarationContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public List<TerminalNode> PublicKeyword() { return getTokens(SolidityParser.PublicKeyword); }
		public TerminalNode PublicKeyword(int i) {
			return getToken(SolidityParser.PublicKeyword, i);
		}
		public List<TerminalNode> InternalKeyword() { return getTokens(SolidityParser.InternalKeyword); }
		public TerminalNode InternalKeyword(int i) {
			return getToken(SolidityParser.InternalKeyword, i);
		}
		public List<TerminalNode> PrivateKeyword() { return getTokens(SolidityParser.PrivateKeyword); }
		public TerminalNode PrivateKeyword(int i) {
			return getToken(SolidityParser.PrivateKeyword, i);
		}
		public List<TerminalNode> ConstantKeyword() { return getTokens(SolidityParser.ConstantKeyword); }
		public TerminalNode ConstantKeyword(int i) {
			return getToken(SolidityParser.ConstantKeyword, i);
		}
		public StateVariableDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stateVariableDeclaration; }
	}

	public final StateVariableDeclarationContext stateVariableDeclaration() throws RecognitionException {
		StateVariableDeclarationContext _localctx = new StateVariableDeclarationContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_stateVariableDeclaration);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(313);
			typeName(0);
			setState(317);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (((((_la - 109)) & ~0x3f) == 0 && ((1L << (_la - 109)) & ((1L << (ConstantKeyword - 109)) | (1L << (InternalKeyword - 109)) | (1L << (PrivateKeyword - 109)) | (1L << (PublicKeyword - 109)))) != 0)) {
				{
				{
				setState(314);
				_la = _input.LA(1);
				if ( !(((((_la - 109)) & ~0x3f) == 0 && ((1L << (_la - 109)) & ((1L << (ConstantKeyword - 109)) | (1L << (InternalKeyword - 109)) | (1L << (PrivateKeyword - 109)) | (1L << (PublicKeyword - 109)))) != 0)) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
				}
				setState(319);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(320);
			identifier();
			setState(323);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__8) {
				{
				setState(321);
				match(T__8);
				setState(322);
				expression(0);
				}
			}

			setState(325);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class UsingForDeclarationContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public UsingForDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_usingForDeclaration; }
	}

	public final UsingForDeclarationContext usingForDeclaration() throws RecognitionException {
		UsingForDeclarationContext _localctx = new UsingForDeclarationContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_usingForDeclaration);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(327);
			match(T__24);
			setState(328);
			identifier();
			setState(329);
			match(T__25);
			setState(332);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__15:
				{
				setState(330);
				match(T__15);
				}
				break;
			case T__16:
			case T__29:
			case T__35:
			case T__37:
			case T__50:
			case T__51:
			case T__52:
			case T__53:
			case Int:
			case Uint:
			case Byte:
			case Fixed:
			case Ufixed:
			case Identifier:
				{
				setState(331);
				typeName(0);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(334);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StructDefinitionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public List<VariableDeclarationContext> variableDeclaration() {
			return getRuleContexts(VariableDeclarationContext.class);
		}
		public VariableDeclarationContext variableDeclaration(int i) {
			return getRuleContext(VariableDeclarationContext.class,i);
		}
		public StructDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_structDefinition; }
	}

	public final StructDefinitionContext structDefinition() throws RecognitionException {
		StructDefinitionContext _localctx = new StructDefinitionContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_structDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(336);
			match(T__26);
			setState(337);
			identifier();
			setState(338);
			match(T__11);
			setState(349);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__29) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
				{
				setState(339);
				variableDeclaration();
				setState(340);
				match(T__1);
				setState(346);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__29) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
					{
					{
					setState(341);
					variableDeclaration();
					setState(342);
					match(T__1);
					}
					}
					setState(348);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			setState(351);
			match(T__12);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ConstructorDefinitionContext extends ParserRuleContext {
		public ParameterListContext parameterList() {
			return getRuleContext(ParameterListContext.class,0);
		}
		public ModifierListContext modifierList() {
			return getRuleContext(ModifierListContext.class,0);
		}
		public BlockContext block() {
			return getRuleContext(BlockContext.class,0);
		}
		public ConstructorDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_constructorDefinition; }
	}

	public final ConstructorDefinitionContext constructorDefinition() throws RecognitionException {
		ConstructorDefinitionContext _localctx = new ConstructorDefinitionContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_constructorDefinition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(353);
			match(T__27);
			setState(354);
			parameterList();
			setState(355);
			modifierList();
			setState(356);
			block();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ModifierDefinitionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public BlockContext block() {
			return getRuleContext(BlockContext.class,0);
		}
		public ParameterListContext parameterList() {
			return getRuleContext(ParameterListContext.class,0);
		}
		public ModifierDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_modifierDefinition; }
	}

	public final ModifierDefinitionContext modifierDefinition() throws RecognitionException {
		ModifierDefinitionContext _localctx = new ModifierDefinitionContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_modifierDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(358);
			match(T__28);
			setState(359);
			identifier();
			setState(361);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__22) {
				{
				setState(360);
				parameterList();
				}
			}

			setState(363);
			block();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ModifierInvocationContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public ExpressionListContext expressionList() {
			return getRuleContext(ExpressionListContext.class,0);
		}
		public ModifierInvocationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_modifierInvocation; }
	}

	public final ModifierInvocationContext modifierInvocation() throws RecognitionException {
		ModifierInvocationContext _localctx = new ModifierInvocationContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_modifierInvocation);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(365);
			identifier();
			setState(371);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__22) {
				{
				setState(366);
				match(T__22);
				setState(368);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
					{
					setState(367);
					expressionList();
					}
				}

				setState(370);
				match(T__23);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionDefinitionContext extends ParserRuleContext {
		public ParameterListContext parameterList() {
			return getRuleContext(ParameterListContext.class,0);
		}
		public ModifierListContext modifierList() {
			return getRuleContext(ModifierListContext.class,0);
		}
		public BlockContext block() {
			return getRuleContext(BlockContext.class,0);
		}
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public ReturnParametersContext returnParameters() {
			return getRuleContext(ReturnParametersContext.class,0);
		}
		public FunctionDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionDefinition; }
	}

	public final FunctionDefinitionContext functionDefinition() throws RecognitionException {
		FunctionDefinitionContext _localctx = new FunctionDefinitionContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_functionDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(373);
			match(T__29);
			setState(375);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16 || _la==Identifier) {
				{
				setState(374);
				identifier();
				}
			}

			setState(377);
			parameterList();
			setState(378);
			modifierList();
			setState(380);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__30) {
				{
				setState(379);
				returnParameters();
				}
			}

			setState(384);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__1:
				{
				setState(382);
				match(T__1);
				}
				break;
			case T__11:
				{
				setState(383);
				block();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ReturnParametersContext extends ParserRuleContext {
		public ParameterListContext parameterList() {
			return getRuleContext(ParameterListContext.class,0);
		}
		public ReturnParametersContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_returnParameters; }
	}

	public final ReturnParametersContext returnParameters() throws RecognitionException {
		ReturnParametersContext _localctx = new ReturnParametersContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_returnParameters);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(386);
			match(T__30);
			setState(387);
			parameterList();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ModifierListContext extends ParserRuleContext {
		public List<ModifierInvocationContext> modifierInvocation() {
			return getRuleContexts(ModifierInvocationContext.class);
		}
		public ModifierInvocationContext modifierInvocation(int i) {
			return getRuleContext(ModifierInvocationContext.class,i);
		}
		public List<StateMutabilityContext> stateMutability() {
			return getRuleContexts(StateMutabilityContext.class);
		}
		public StateMutabilityContext stateMutability(int i) {
			return getRuleContext(StateMutabilityContext.class,i);
		}
		public List<TerminalNode> ExternalKeyword() { return getTokens(SolidityParser.ExternalKeyword); }
		public TerminalNode ExternalKeyword(int i) {
			return getToken(SolidityParser.ExternalKeyword, i);
		}
		public List<TerminalNode> PublicKeyword() { return getTokens(SolidityParser.PublicKeyword); }
		public TerminalNode PublicKeyword(int i) {
			return getToken(SolidityParser.PublicKeyword, i);
		}
		public List<TerminalNode> InternalKeyword() { return getTokens(SolidityParser.InternalKeyword); }
		public TerminalNode InternalKeyword(int i) {
			return getToken(SolidityParser.InternalKeyword, i);
		}
		public List<TerminalNode> PrivateKeyword() { return getTokens(SolidityParser.PrivateKeyword); }
		public TerminalNode PrivateKeyword(int i) {
			return getToken(SolidityParser.PrivateKeyword, i);
		}
		public ModifierListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_modifierList; }
	}

	public final ModifierListContext modifierList() throws RecognitionException {
		ModifierListContext _localctx = new ModifierListContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_modifierList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(397);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__16 || ((((_la - 109)) & ~0x3f) == 0 && ((1L << (_la - 109)) & ((1L << (ConstantKeyword - 109)) | (1L << (ExternalKeyword - 109)) | (1L << (InternalKeyword - 109)) | (1L << (PayableKeyword - 109)) | (1L << (PrivateKeyword - 109)) | (1L << (PublicKeyword - 109)) | (1L << (PureKeyword - 109)) | (1L << (ViewKeyword - 109)) | (1L << (Identifier - 109)))) != 0)) {
				{
				setState(395);
				_errHandler.sync(this);
				switch (_input.LA(1)) {
				case T__16:
				case Identifier:
					{
					setState(389);
					modifierInvocation();
					}
					break;
				case ConstantKeyword:
				case PayableKeyword:
				case PureKeyword:
				case ViewKeyword:
					{
					setState(390);
					stateMutability();
					}
					break;
				case ExternalKeyword:
					{
					setState(391);
					match(ExternalKeyword);
					}
					break;
				case PublicKeyword:
					{
					setState(392);
					match(PublicKeyword);
					}
					break;
				case InternalKeyword:
					{
					setState(393);
					match(InternalKeyword);
					}
					break;
				case PrivateKeyword:
					{
					setState(394);
					match(PrivateKeyword);
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				setState(399);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EventDefinitionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public EventParameterListContext eventParameterList() {
			return getRuleContext(EventParameterListContext.class,0);
		}
		public TerminalNode AnonymousKeyword() { return getToken(SolidityParser.AnonymousKeyword, 0); }
		public EventDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_eventDefinition; }
	}

	public final EventDefinitionContext eventDefinition() throws RecognitionException {
		EventDefinitionContext _localctx = new EventDefinitionContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_eventDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(400);
			match(T__31);
			setState(401);
			identifier();
			setState(402);
			eventParameterList();
			setState(404);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==AnonymousKeyword) {
				{
				setState(403);
				match(AnonymousKeyword);
				}
			}

			setState(406);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EnumValueContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public EnumValueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enumValue; }
	}

	public final EnumValueContext enumValue() throws RecognitionException {
		EnumValueContext _localctx = new EnumValueContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_enumValue);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(408);
			identifier();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EnumDefinitionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public List<EnumValueContext> enumValue() {
			return getRuleContexts(EnumValueContext.class);
		}
		public EnumValueContext enumValue(int i) {
			return getRuleContext(EnumValueContext.class,i);
		}
		public EnumDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_enumDefinition; }
	}

	public final EnumDefinitionContext enumDefinition() throws RecognitionException {
		EnumDefinitionContext _localctx = new EnumDefinitionContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_enumDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(410);
			match(T__32);
			setState(411);
			identifier();
			setState(412);
			match(T__11);
			setState(414);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16 || _la==Identifier) {
				{
				setState(413);
				enumValue();
				}
			}

			setState(420);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__17) {
				{
				{
				setState(416);
				match(T__17);
				setState(417);
				enumValue();
				}
				}
				setState(422);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(423);
			match(T__12);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ParameterListContext extends ParserRuleContext {
		public List<ParameterContext> parameter() {
			return getRuleContexts(ParameterContext.class);
		}
		public ParameterContext parameter(int i) {
			return getRuleContext(ParameterContext.class,i);
		}
		public ParameterListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_parameterList; }
	}

	public final ParameterListContext parameterList() throws RecognitionException {
		ParameterListContext _localctx = new ParameterListContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_parameterList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(425);
			match(T__22);
			setState(434);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__29) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
				{
				setState(426);
				parameter();
				setState(431);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(427);
					match(T__17);
					setState(428);
					parameter();
					}
					}
					setState(433);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			setState(436);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ParameterContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public StorageLocationContext storageLocation() {
			return getRuleContext(StorageLocationContext.class,0);
		}
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public ParameterContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_parameter; }
	}

	public final ParameterContext parameter() throws RecognitionException {
		ParameterContext _localctx = new ParameterContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_parameter);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(438);
			typeName(0);
			setState(440);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__39) | (1L << T__40) | (1L << T__41))) != 0)) {
				{
				setState(439);
				storageLocation();
				}
			}

			setState(443);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16 || _la==Identifier) {
				{
				setState(442);
				identifier();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EventParameterListContext extends ParserRuleContext {
		public List<EventParameterContext> eventParameter() {
			return getRuleContexts(EventParameterContext.class);
		}
		public EventParameterContext eventParameter(int i) {
			return getRuleContext(EventParameterContext.class,i);
		}
		public EventParameterListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_eventParameterList; }
	}

	public final EventParameterListContext eventParameterList() throws RecognitionException {
		EventParameterListContext _localctx = new EventParameterListContext(_ctx, getState());
		enterRule(_localctx, 56, RULE_eventParameterList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(445);
			match(T__22);
			setState(454);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__29) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
				{
				setState(446);
				eventParameter();
				setState(451);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(447);
					match(T__17);
					setState(448);
					eventParameter();
					}
					}
					setState(453);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			setState(456);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EventParameterContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public TerminalNode IndexedKeyword() { return getToken(SolidityParser.IndexedKeyword, 0); }
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public EventParameterContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_eventParameter; }
	}

	public final EventParameterContext eventParameter() throws RecognitionException {
		EventParameterContext _localctx = new EventParameterContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_eventParameter);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(458);
			typeName(0);
			setState(460);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==IndexedKeyword) {
				{
				setState(459);
				match(IndexedKeyword);
				}
			}

			setState(463);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16 || _la==Identifier) {
				{
				setState(462);
				identifier();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionTypeParameterListContext extends ParserRuleContext {
		public List<FunctionTypeParameterContext> functionTypeParameter() {
			return getRuleContexts(FunctionTypeParameterContext.class);
		}
		public FunctionTypeParameterContext functionTypeParameter(int i) {
			return getRuleContext(FunctionTypeParameterContext.class,i);
		}
		public FunctionTypeParameterListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionTypeParameterList; }
	}

	public final FunctionTypeParameterListContext functionTypeParameterList() throws RecognitionException {
		FunctionTypeParameterListContext _localctx = new FunctionTypeParameterListContext(_ctx, getState());
		enterRule(_localctx, 60, RULE_functionTypeParameterList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(465);
			match(T__22);
			setState(474);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__29) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
				{
				setState(466);
				functionTypeParameter();
				setState(471);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(467);
					match(T__17);
					setState(468);
					functionTypeParameter();
					}
					}
					setState(473);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			setState(476);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionTypeParameterContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public StorageLocationContext storageLocation() {
			return getRuleContext(StorageLocationContext.class,0);
		}
		public FunctionTypeParameterContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionTypeParameter; }
	}

	public final FunctionTypeParameterContext functionTypeParameter() throws RecognitionException {
		FunctionTypeParameterContext _localctx = new FunctionTypeParameterContext(_ctx, getState());
		enterRule(_localctx, 62, RULE_functionTypeParameter);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(478);
			typeName(0);
			setState(480);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__39) | (1L << T__40) | (1L << T__41))) != 0)) {
				{
				setState(479);
				storageLocation();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VariableDeclarationContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public StorageLocationContext storageLocation() {
			return getRuleContext(StorageLocationContext.class,0);
		}
		public VariableDeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_variableDeclaration; }
	}

	public final VariableDeclarationContext variableDeclaration() throws RecognitionException {
		VariableDeclarationContext _localctx = new VariableDeclarationContext(_ctx, getState());
		enterRule(_localctx, 64, RULE_variableDeclaration);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(482);
			typeName(0);
			setState(484);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__39) | (1L << T__40) | (1L << T__41))) != 0)) {
				{
				setState(483);
				storageLocation();
				}
			}

			setState(486);
			identifier();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeNameContext extends ParserRuleContext {
		public ElementaryTypeNameContext elementaryTypeName() {
			return getRuleContext(ElementaryTypeNameContext.class,0);
		}
		public UserDefinedTypeNameContext userDefinedTypeName() {
			return getRuleContext(UserDefinedTypeNameContext.class,0);
		}
		public MappingContext mapping() {
			return getRuleContext(MappingContext.class,0);
		}
		public FunctionTypeNameContext functionTypeName() {
			return getRuleContext(FunctionTypeNameContext.class,0);
		}
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TypeNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_typeName; }
	}

	public final TypeNameContext typeName() throws RecognitionException {
		return typeName(0);
	}

	private TypeNameContext typeName(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		TypeNameContext _localctx = new TypeNameContext(_ctx, _parentState);
		TypeNameContext _prevctx = _localctx;
		int _startState = 66;
		enterRecursionRule(_localctx, 66, RULE_typeName, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(495);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,46,_ctx) ) {
			case 1:
				{
				setState(489);
				elementaryTypeName();
				}
				break;
			case 2:
				{
				setState(490);
				userDefinedTypeName();
				}
				break;
			case 3:
				{
				setState(491);
				mapping();
				}
				break;
			case 4:
				{
				setState(492);
				functionTypeName();
				}
				break;
			case 5:
				{
				setState(493);
				match(T__35);
				setState(494);
				match(PayableKeyword);
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(505);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,48,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new TypeNameContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_typeName);
					setState(497);
					if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
					setState(498);
					match(T__33);
					setState(500);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
						{
						setState(499);
						expression(0);
						}
					}

					setState(502);
					match(T__34);
					}
					} 
				}
				setState(507);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,48,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class UserDefinedTypeNameContext extends ParserRuleContext {
		public List<IdentifierContext> identifier() {
			return getRuleContexts(IdentifierContext.class);
		}
		public IdentifierContext identifier(int i) {
			return getRuleContext(IdentifierContext.class,i);
		}
		public UserDefinedTypeNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_userDefinedTypeName; }
	}

	public final UserDefinedTypeNameContext userDefinedTypeName() throws RecognitionException {
		UserDefinedTypeNameContext _localctx = new UserDefinedTypeNameContext(_ctx, getState());
		enterRule(_localctx, 68, RULE_userDefinedTypeName);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(508);
			identifier();
			setState(513);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,49,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(509);
					match(T__36);
					setState(510);
					identifier();
					}
					} 
				}
				setState(515);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,49,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class MappingContext extends ParserRuleContext {
		public ElementaryTypeNameContext elementaryTypeName() {
			return getRuleContext(ElementaryTypeNameContext.class,0);
		}
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public MappingContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_mapping; }
	}

	public final MappingContext mapping() throws RecognitionException {
		MappingContext _localctx = new MappingContext(_ctx, getState());
		enterRule(_localctx, 70, RULE_mapping);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(516);
			match(T__37);
			setState(517);
			match(T__22);
			setState(518);
			elementaryTypeName();
			setState(519);
			match(T__38);
			setState(520);
			typeName(0);
			setState(521);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionTypeNameContext extends ParserRuleContext {
		public List<FunctionTypeParameterListContext> functionTypeParameterList() {
			return getRuleContexts(FunctionTypeParameterListContext.class);
		}
		public FunctionTypeParameterListContext functionTypeParameterList(int i) {
			return getRuleContext(FunctionTypeParameterListContext.class,i);
		}
		public List<TerminalNode> InternalKeyword() { return getTokens(SolidityParser.InternalKeyword); }
		public TerminalNode InternalKeyword(int i) {
			return getToken(SolidityParser.InternalKeyword, i);
		}
		public List<TerminalNode> ExternalKeyword() { return getTokens(SolidityParser.ExternalKeyword); }
		public TerminalNode ExternalKeyword(int i) {
			return getToken(SolidityParser.ExternalKeyword, i);
		}
		public List<StateMutabilityContext> stateMutability() {
			return getRuleContexts(StateMutabilityContext.class);
		}
		public StateMutabilityContext stateMutability(int i) {
			return getRuleContext(StateMutabilityContext.class,i);
		}
		public FunctionTypeNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionTypeName; }
	}

	public final FunctionTypeNameContext functionTypeName() throws RecognitionException {
		FunctionTypeNameContext _localctx = new FunctionTypeNameContext(_ctx, getState());
		enterRule(_localctx, 72, RULE_functionTypeName);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(523);
			match(T__29);
			setState(524);
			functionTypeParameterList();
			setState(530);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,51,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					setState(528);
					_errHandler.sync(this);
					switch (_input.LA(1)) {
					case InternalKeyword:
						{
						setState(525);
						match(InternalKeyword);
						}
						break;
					case ExternalKeyword:
						{
						setState(526);
						match(ExternalKeyword);
						}
						break;
					case ConstantKeyword:
					case PayableKeyword:
					case PureKeyword:
					case ViewKeyword:
						{
						setState(527);
						stateMutability();
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					} 
				}
				setState(532);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,51,_ctx);
			}
			setState(535);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,52,_ctx) ) {
			case 1:
				{
				setState(533);
				match(T__30);
				setState(534);
				functionTypeParameterList();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StorageLocationContext extends ParserRuleContext {
		public StorageLocationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_storageLocation; }
	}

	public final StorageLocationContext storageLocation() throws RecognitionException {
		StorageLocationContext _localctx = new StorageLocationContext(_ctx, getState());
		enterRule(_localctx, 74, RULE_storageLocation);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(537);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__39) | (1L << T__40) | (1L << T__41))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StateMutabilityContext extends ParserRuleContext {
		public TerminalNode PureKeyword() { return getToken(SolidityParser.PureKeyword, 0); }
		public TerminalNode ConstantKeyword() { return getToken(SolidityParser.ConstantKeyword, 0); }
		public TerminalNode ViewKeyword() { return getToken(SolidityParser.ViewKeyword, 0); }
		public TerminalNode PayableKeyword() { return getToken(SolidityParser.PayableKeyword, 0); }
		public StateMutabilityContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stateMutability; }
	}

	public final StateMutabilityContext stateMutability() throws RecognitionException {
		StateMutabilityContext _localctx = new StateMutabilityContext(_ctx, getState());
		enterRule(_localctx, 76, RULE_stateMutability);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(539);
			_la = _input.LA(1);
			if ( !(((((_la - 109)) & ~0x3f) == 0 && ((1L << (_la - 109)) & ((1L << (ConstantKeyword - 109)) | (1L << (PayableKeyword - 109)) | (1L << (PureKeyword - 109)) | (1L << (ViewKeyword - 109)))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BlockContext extends ParserRuleContext {
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public BlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_block; }
	}

	public final BlockContext block() throws RecognitionException {
		BlockContext _localctx = new BlockContext(_ctx, getState());
		enterRule(_localctx, 78, RULE_block);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(541);
			match(T__11);
			setState(545);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__11) | (1L << T__16) | (1L << T__22) | (1L << T__25) | (1L << T__29) | (1L << T__33) | (1L << T__35) | (1L << T__37) | (1L << T__42) | (1L << T__44) | (1L << T__45) | (1L << T__46) | (1L << T__47) | (1L << T__48) | (1L << T__49) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (BreakKeyword - 86)) | (1L << (ContinueKeyword - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
				{
				{
				setState(542);
				statement();
				}
				}
				setState(547);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(548);
			match(T__12);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementContext extends ParserRuleContext {
		public IfStatementContext ifStatement() {
			return getRuleContext(IfStatementContext.class,0);
		}
		public WhileStatementContext whileStatement() {
			return getRuleContext(WhileStatementContext.class,0);
		}
		public ForStatementContext forStatement() {
			return getRuleContext(ForStatementContext.class,0);
		}
		public BlockContext block() {
			return getRuleContext(BlockContext.class,0);
		}
		public InlineAssemblyStatementContext inlineAssemblyStatement() {
			return getRuleContext(InlineAssemblyStatementContext.class,0);
		}
		public DoWhileStatementContext doWhileStatement() {
			return getRuleContext(DoWhileStatementContext.class,0);
		}
		public ContinueStatementContext continueStatement() {
			return getRuleContext(ContinueStatementContext.class,0);
		}
		public BreakStatementContext breakStatement() {
			return getRuleContext(BreakStatementContext.class,0);
		}
		public ReturnStatementContext returnStatement() {
			return getRuleContext(ReturnStatementContext.class,0);
		}
		public ThrowStatementContext throwStatement() {
			return getRuleContext(ThrowStatementContext.class,0);
		}
		public EmitStatementContext emitStatement() {
			return getRuleContext(EmitStatementContext.class,0);
		}
		public SimpleStatementContext simpleStatement() {
			return getRuleContext(SimpleStatementContext.class,0);
		}
		public StatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statement; }
	}

	public final StatementContext statement() throws RecognitionException {
		StatementContext _localctx = new StatementContext(_ctx, getState());
		enterRule(_localctx, 80, RULE_statement);
		try {
			setState(562);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__42:
				enterOuterAlt(_localctx, 1);
				{
				setState(550);
				ifStatement();
				}
				break;
			case T__44:
				enterOuterAlt(_localctx, 2);
				{
				setState(551);
				whileStatement();
				}
				break;
			case T__25:
				enterOuterAlt(_localctx, 3);
				{
				setState(552);
				forStatement();
				}
				break;
			case T__11:
				enterOuterAlt(_localctx, 4);
				{
				setState(553);
				block();
				}
				break;
			case T__45:
				enterOuterAlt(_localctx, 5);
				{
				setState(554);
				inlineAssemblyStatement();
				}
				break;
			case T__46:
				enterOuterAlt(_localctx, 6);
				{
				setState(555);
				doWhileStatement();
				}
				break;
			case ContinueKeyword:
				enterOuterAlt(_localctx, 7);
				{
				setState(556);
				continueStatement();
				}
				break;
			case BreakKeyword:
				enterOuterAlt(_localctx, 8);
				{
				setState(557);
				breakStatement();
				}
				break;
			case T__47:
				enterOuterAlt(_localctx, 9);
				{
				setState(558);
				returnStatement();
				}
				break;
			case T__48:
				enterOuterAlt(_localctx, 10);
				{
				setState(559);
				throwStatement();
				}
				break;
			case T__49:
				enterOuterAlt(_localctx, 11);
				{
				setState(560);
				emitStatement();
				}
				break;
			case T__3:
			case T__16:
			case T__22:
			case T__29:
			case T__33:
			case T__35:
			case T__37:
			case T__50:
			case T__51:
			case T__52:
			case T__53:
			case T__54:
			case T__55:
			case T__56:
			case T__57:
			case T__58:
			case T__59:
			case T__60:
			case T__61:
			case T__85:
			case T__86:
			case Int:
			case Uint:
			case Byte:
			case Fixed:
			case Ufixed:
			case BooleanLiteral:
			case DecimalNumber:
			case HexNumber:
			case HexLiteral:
			case Identifier:
			case StringLiteral:
				enterOuterAlt(_localctx, 12);
				{
				setState(561);
				simpleStatement();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpressionStatementContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public ExpressionStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expressionStatement; }
	}

	public final ExpressionStatementContext expressionStatement() throws RecognitionException {
		ExpressionStatementContext _localctx = new ExpressionStatementContext(_ctx, getState());
		enterRule(_localctx, 82, RULE_expressionStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(564);
			expression(0);
			setState(565);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IfStatementContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public IfStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ifStatement; }
	}

	public final IfStatementContext ifStatement() throws RecognitionException {
		IfStatementContext _localctx = new IfStatementContext(_ctx, getState());
		enterRule(_localctx, 84, RULE_ifStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(567);
			match(T__42);
			setState(568);
			match(T__22);
			setState(569);
			expression(0);
			setState(570);
			match(T__23);
			setState(571);
			statement();
			setState(574);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,55,_ctx) ) {
			case 1:
				{
				setState(572);
				match(T__43);
				setState(573);
				statement();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class WhileStatementContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public WhileStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_whileStatement; }
	}

	public final WhileStatementContext whileStatement() throws RecognitionException {
		WhileStatementContext _localctx = new WhileStatementContext(_ctx, getState());
		enterRule(_localctx, 86, RULE_whileStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(576);
			match(T__44);
			setState(577);
			match(T__22);
			setState(578);
			expression(0);
			setState(579);
			match(T__23);
			setState(580);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SimpleStatementContext extends ParserRuleContext {
		public VariableDeclarationStatementContext variableDeclarationStatement() {
			return getRuleContext(VariableDeclarationStatementContext.class,0);
		}
		public ExpressionStatementContext expressionStatement() {
			return getRuleContext(ExpressionStatementContext.class,0);
		}
		public SimpleStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_simpleStatement; }
	}

	public final SimpleStatementContext simpleStatement() throws RecognitionException {
		SimpleStatementContext _localctx = new SimpleStatementContext(_ctx, getState());
		enterRule(_localctx, 88, RULE_simpleStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(584);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,56,_ctx) ) {
			case 1:
				{
				setState(582);
				variableDeclarationStatement();
				}
				break;
			case 2:
				{
				setState(583);
				expressionStatement();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ForStatementContext extends ParserRuleContext {
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public SimpleStatementContext simpleStatement() {
			return getRuleContext(SimpleStatementContext.class,0);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public ForStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_forStatement; }
	}

	public final ForStatementContext forStatement() throws RecognitionException {
		ForStatementContext _localctx = new ForStatementContext(_ctx, getState());
		enterRule(_localctx, 90, RULE_forStatement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(586);
			match(T__25);
			setState(587);
			match(T__22);
			setState(590);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__3:
			case T__16:
			case T__22:
			case T__29:
			case T__33:
			case T__35:
			case T__37:
			case T__50:
			case T__51:
			case T__52:
			case T__53:
			case T__54:
			case T__55:
			case T__56:
			case T__57:
			case T__58:
			case T__59:
			case T__60:
			case T__61:
			case T__85:
			case T__86:
			case Int:
			case Uint:
			case Byte:
			case Fixed:
			case Ufixed:
			case BooleanLiteral:
			case DecimalNumber:
			case HexNumber:
			case HexLiteral:
			case Identifier:
			case StringLiteral:
				{
				setState(588);
				simpleStatement();
				}
				break;
			case T__1:
				{
				setState(589);
				match(T__1);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(593);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
				{
				setState(592);
				expression(0);
				}
			}

			setState(595);
			match(T__1);
			setState(597);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
				{
				setState(596);
				expression(0);
				}
			}

			setState(599);
			match(T__23);
			setState(600);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class InlineAssemblyStatementContext extends ParserRuleContext {
		public AssemblyBlockContext assemblyBlock() {
			return getRuleContext(AssemblyBlockContext.class,0);
		}
		public TerminalNode StringLiteral() { return getToken(SolidityParser.StringLiteral, 0); }
		public InlineAssemblyStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_inlineAssemblyStatement; }
	}

	public final InlineAssemblyStatementContext inlineAssemblyStatement() throws RecognitionException {
		InlineAssemblyStatementContext _localctx = new InlineAssemblyStatementContext(_ctx, getState());
		enterRule(_localctx, 92, RULE_inlineAssemblyStatement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(602);
			match(T__45);
			setState(604);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==StringLiteral) {
				{
				setState(603);
				match(StringLiteral);
				}
			}

			setState(606);
			assemblyBlock();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DoWhileStatementContext extends ParserRuleContext {
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public DoWhileStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_doWhileStatement; }
	}

	public final DoWhileStatementContext doWhileStatement() throws RecognitionException {
		DoWhileStatementContext _localctx = new DoWhileStatementContext(_ctx, getState());
		enterRule(_localctx, 94, RULE_doWhileStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(608);
			match(T__46);
			setState(609);
			statement();
			setState(610);
			match(T__44);
			setState(611);
			match(T__22);
			setState(612);
			expression(0);
			setState(613);
			match(T__23);
			setState(614);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ContinueStatementContext extends ParserRuleContext {
		public ContinueStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_continueStatement; }
	}

	public final ContinueStatementContext continueStatement() throws RecognitionException {
		ContinueStatementContext _localctx = new ContinueStatementContext(_ctx, getState());
		enterRule(_localctx, 96, RULE_continueStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(616);
			match(ContinueKeyword);
			setState(617);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BreakStatementContext extends ParserRuleContext {
		public BreakStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_breakStatement; }
	}

	public final BreakStatementContext breakStatement() throws RecognitionException {
		BreakStatementContext _localctx = new BreakStatementContext(_ctx, getState());
		enterRule(_localctx, 98, RULE_breakStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(619);
			match(BreakKeyword);
			setState(620);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ReturnStatementContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public ReturnStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_returnStatement; }
	}

	public final ReturnStatementContext returnStatement() throws RecognitionException {
		ReturnStatementContext _localctx = new ReturnStatementContext(_ctx, getState());
		enterRule(_localctx, 100, RULE_returnStatement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(622);
			match(T__47);
			setState(624);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
				{
				setState(623);
				expression(0);
				}
			}

			setState(626);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ThrowStatementContext extends ParserRuleContext {
		public ThrowStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_throwStatement; }
	}

	public final ThrowStatementContext throwStatement() throws RecognitionException {
		ThrowStatementContext _localctx = new ThrowStatementContext(_ctx, getState());
		enterRule(_localctx, 102, RULE_throwStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(628);
			match(T__48);
			setState(629);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class EmitStatementContext extends ParserRuleContext {
		public FunctionCallContext functionCall() {
			return getRuleContext(FunctionCallContext.class,0);
		}
		public EmitStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_emitStatement; }
	}

	public final EmitStatementContext emitStatement() throws RecognitionException {
		EmitStatementContext _localctx = new EmitStatementContext(_ctx, getState());
		enterRule(_localctx, 104, RULE_emitStatement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(631);
			match(T__49);
			setState(632);
			functionCall();
			setState(633);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VariableDeclarationStatementContext extends ParserRuleContext {
		public IdentifierListContext identifierList() {
			return getRuleContext(IdentifierListContext.class,0);
		}
		public VariableDeclarationContext variableDeclaration() {
			return getRuleContext(VariableDeclarationContext.class,0);
		}
		public VariableDeclarationListContext variableDeclarationList() {
			return getRuleContext(VariableDeclarationListContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public VariableDeclarationStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_variableDeclarationStatement; }
	}

	public final VariableDeclarationStatementContext variableDeclarationStatement() throws RecognitionException {
		VariableDeclarationStatementContext _localctx = new VariableDeclarationStatementContext(_ctx, getState());
		enterRule(_localctx, 106, RULE_variableDeclarationStatement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(642);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,62,_ctx) ) {
			case 1:
				{
				setState(635);
				match(T__50);
				setState(636);
				identifierList();
				}
				break;
			case 2:
				{
				setState(637);
				variableDeclaration();
				}
				break;
			case 3:
				{
				setState(638);
				match(T__22);
				setState(639);
				variableDeclarationList();
				setState(640);
				match(T__23);
				}
				break;
			}
			setState(646);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__8) {
				{
				setState(644);
				match(T__8);
				setState(645);
				expression(0);
				}
			}

			setState(648);
			match(T__1);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VariableDeclarationListContext extends ParserRuleContext {
		public List<VariableDeclarationContext> variableDeclaration() {
			return getRuleContexts(VariableDeclarationContext.class);
		}
		public VariableDeclarationContext variableDeclaration(int i) {
			return getRuleContext(VariableDeclarationContext.class,i);
		}
		public VariableDeclarationListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_variableDeclarationList; }
	}

	public final VariableDeclarationListContext variableDeclarationList() throws RecognitionException {
		VariableDeclarationListContext _localctx = new VariableDeclarationListContext(_ctx, getState());
		enterRule(_localctx, 108, RULE_variableDeclarationList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(651);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__29) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
				{
				setState(650);
				variableDeclaration();
				}
			}

			setState(659);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__17) {
				{
				{
				setState(653);
				match(T__17);
				setState(655);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__29) | (1L << T__35) | (1L << T__37) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53))) != 0) || ((((_la - 95)) & ~0x3f) == 0 && ((1L << (_la - 95)) & ((1L << (Int - 95)) | (1L << (Uint - 95)) | (1L << (Byte - 95)) | (1L << (Fixed - 95)) | (1L << (Ufixed - 95)) | (1L << (Identifier - 95)))) != 0)) {
					{
					setState(654);
					variableDeclaration();
					}
				}

				}
				}
				setState(661);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IdentifierListContext extends ParserRuleContext {
		public List<IdentifierContext> identifier() {
			return getRuleContexts(IdentifierContext.class);
		}
		public IdentifierContext identifier(int i) {
			return getRuleContext(IdentifierContext.class,i);
		}
		public IdentifierListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_identifierList; }
	}

	public final IdentifierListContext identifierList() throws RecognitionException {
		IdentifierListContext _localctx = new IdentifierListContext(_ctx, getState());
		enterRule(_localctx, 110, RULE_identifierList);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(662);
			match(T__22);
			setState(669);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,68,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(664);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if (_la==T__16 || _la==Identifier) {
						{
						setState(663);
						identifier();
						}
					}

					setState(666);
					match(T__17);
					}
					} 
				}
				setState(671);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,68,_ctx);
			}
			setState(673);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16 || _la==Identifier) {
				{
				setState(672);
				identifier();
				}
			}

			setState(675);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ElementaryTypeNameContext extends ParserRuleContext {
		public TerminalNode Int() { return getToken(SolidityParser.Int, 0); }
		public TerminalNode Uint() { return getToken(SolidityParser.Uint, 0); }
		public TerminalNode Byte() { return getToken(SolidityParser.Byte, 0); }
		public TerminalNode Fixed() { return getToken(SolidityParser.Fixed, 0); }
		public TerminalNode Ufixed() { return getToken(SolidityParser.Ufixed, 0); }
		public ElementaryTypeNameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elementaryTypeName; }
	}

	public final ElementaryTypeNameContext elementaryTypeName() throws RecognitionException {
		ElementaryTypeNameContext _localctx = new ElementaryTypeNameContext(_ctx, getState());
		enterRule(_localctx, 112, RULE_elementaryTypeName);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(677);
			_la = _input.LA(1);
			if ( !(((((_la - 36)) & ~0x3f) == 0 && ((1L << (_la - 36)) & ((1L << (T__35 - 36)) | (1L << (T__50 - 36)) | (1L << (T__51 - 36)) | (1L << (T__52 - 36)) | (1L << (T__53 - 36)) | (1L << (Int - 36)) | (1L << (Uint - 36)) | (1L << (Byte - 36)) | (1L << (Fixed - 36)) | (1L << (Ufixed - 36)))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpressionContext extends ParserRuleContext {
		public TypeNameContext typeName() {
			return getRuleContext(TypeNameContext.class,0);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public ForAllExpressionContext forAllExpression() {
			return getRuleContext(ForAllExpressionContext.class,0);
		}
		public SumExpressionContext sumExpression() {
			return getRuleContext(SumExpressionContext.class,0);
		}
		public PrimaryExpressionContext primaryExpression() {
			return getRuleContext(PrimaryExpressionContext.class,0);
		}
		public FunctionCallArgumentsContext functionCallArguments() {
			return getRuleContext(FunctionCallArgumentsContext.class,0);
		}
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public ExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expression; }
	}

	public final ExpressionContext expression() throws RecognitionException {
		return expression(0);
	}

	private ExpressionContext expression(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExpressionContext _localctx = new ExpressionContext(_ctx, _parentState);
		ExpressionContext _prevctx = _localctx;
		int _startState = 114;
		enterRecursionRule(_localctx, 114, RULE_expression, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(699);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,70,_ctx) ) {
			case 1:
				{
				setState(680);
				match(T__56);
				setState(681);
				typeName(0);
				}
				break;
			case 2:
				{
				setState(682);
				match(T__22);
				setState(683);
				expression(0);
				setState(684);
				match(T__23);
				}
				break;
			case 3:
				{
				setState(686);
				_la = _input.LA(1);
				if ( !(_la==T__54 || _la==T__55) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(687);
				expression(21);
				}
				break;
			case 4:
				{
				setState(688);
				_la = _input.LA(1);
				if ( !(_la==T__57 || _la==T__58) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(689);
				expression(20);
				}
				break;
			case 5:
				{
				setState(690);
				_la = _input.LA(1);
				if ( !(_la==T__59 || _la==T__60) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(691);
				expression(19);
				}
				break;
			case 6:
				{
				setState(692);
				match(T__61);
				setState(693);
				expression(18);
				}
				break;
			case 7:
				{
				setState(694);
				match(T__3);
				setState(695);
				expression(17);
				}
				break;
			case 8:
				{
				setState(696);
				forAllExpression();
				}
				break;
			case 9:
				{
				setState(697);
				sumExpression();
				}
				break;
			case 10:
				{
				setState(698);
				primaryExpression();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(760);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,72,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(758);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,71,_ctx) ) {
					case 1:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(701);
						if (!(precpred(_ctx, 16))) throw new FailedPredicateException(this, "precpred(_ctx, 16)");
						setState(702);
						match(T__62);
						setState(703);
						expression(17);
						}
						break;
					case 2:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(704);
						if (!(precpred(_ctx, 15))) throw new FailedPredicateException(this, "precpred(_ctx, 15)");
						setState(705);
						_la = _input.LA(1);
						if ( !(((((_la - 16)) & ~0x3f) == 0 && ((1L << (_la - 16)) & ((1L << (T__15 - 16)) | (1L << (T__63 - 16)) | (1L << (T__64 - 16)))) != 0)) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(706);
						expression(16);
						}
						break;
					case 3:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(707);
						if (!(precpred(_ctx, 14))) throw new FailedPredicateException(this, "precpred(_ctx, 14)");
						setState(708);
						_la = _input.LA(1);
						if ( !(_la==T__57 || _la==T__58) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(709);
						expression(15);
						}
						break;
					case 4:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(710);
						if (!(precpred(_ctx, 13))) throw new FailedPredicateException(this, "precpred(_ctx, 13)");
						setState(711);
						_la = _input.LA(1);
						if ( !(_la==T__65 || _la==T__66) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(712);
						expression(14);
						}
						break;
					case 5:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(713);
						if (!(precpred(_ctx, 12))) throw new FailedPredicateException(this, "precpred(_ctx, 12)");
						setState(714);
						match(T__67);
						setState(715);
						expression(13);
						}
						break;
					case 6:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(716);
						if (!(precpred(_ctx, 11))) throw new FailedPredicateException(this, "precpred(_ctx, 11)");
						setState(717);
						match(T__2);
						setState(718);
						expression(12);
						}
						break;
					case 7:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(719);
						if (!(precpred(_ctx, 10))) throw new FailedPredicateException(this, "precpred(_ctx, 10)");
						setState(720);
						match(T__68);
						setState(721);
						expression(11);
						}
						break;
					case 8:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(722);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						setState(723);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__4) | (1L << T__5) | (1L << T__6) | (1L << T__7))) != 0)) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(724);
						expression(10);
						}
						break;
					case 9:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(725);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						setState(726);
						_la = _input.LA(1);
						if ( !(_la==T__69 || _la==T__70) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(727);
						expression(9);
						}
						break;
					case 10:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(728);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						setState(729);
						match(T__71);
						setState(730);
						expression(8);
						}
						break;
					case 11:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(731);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						setState(732);
						match(T__72);
						setState(733);
						expression(7);
						}
						break;
					case 12:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(734);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(735);
						match(T__73);
						setState(736);
						expression(0);
						setState(737);
						match(T__74);
						setState(738);
						expression(6);
						}
						break;
					case 13:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(740);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(741);
						_la = _input.LA(1);
						if ( !(_la==T__8 || ((((_la - 76)) & ~0x3f) == 0 && ((1L << (_la - 76)) & ((1L << (T__75 - 76)) | (1L << (T__76 - 76)) | (1L << (T__77 - 76)) | (1L << (T__78 - 76)) | (1L << (T__79 - 76)) | (1L << (T__80 - 76)) | (1L << (T__81 - 76)) | (1L << (T__82 - 76)) | (1L << (T__83 - 76)) | (1L << (T__84 - 76)))) != 0)) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(742);
						expression(5);
						}
						break;
					case 14:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(743);
						if (!(precpred(_ctx, 27))) throw new FailedPredicateException(this, "precpred(_ctx, 27)");
						setState(744);
						_la = _input.LA(1);
						if ( !(_la==T__54 || _la==T__55) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						}
						break;
					case 15:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(745);
						if (!(precpred(_ctx, 25))) throw new FailedPredicateException(this, "precpred(_ctx, 25)");
						setState(746);
						match(T__33);
						setState(747);
						expression(0);
						setState(748);
						match(T__34);
						}
						break;
					case 16:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(750);
						if (!(precpred(_ctx, 24))) throw new FailedPredicateException(this, "precpred(_ctx, 24)");
						setState(751);
						match(T__22);
						setState(752);
						functionCallArguments();
						setState(753);
						match(T__23);
						}
						break;
					case 17:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(755);
						if (!(precpred(_ctx, 23))) throw new FailedPredicateException(this, "precpred(_ctx, 23)");
						setState(756);
						match(T__36);
						setState(757);
						identifier();
						}
						break;
					}
					} 
				}
				setState(762);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,72,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class ForAllExpressionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public ForAllExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_forAllExpression; }
	}

	public final ForAllExpressionContext forAllExpression() throws RecognitionException {
		ForAllExpressionContext _localctx = new ForAllExpressionContext(_ctx, getState());
		enterRule(_localctx, 116, RULE_forAllExpression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(763);
			match(T__85);
			setState(764);
			identifier();
			setState(765);
			match(T__17);
			setState(766);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SumExpressionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public SumExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sumExpression; }
	}

	public final SumExpressionContext sumExpression() throws RecognitionException {
		SumExpressionContext _localctx = new SumExpressionContext(_ctx, getState());
		enterRule(_localctx, 118, RULE_sumExpression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(768);
			match(T__86);
			setState(769);
			identifier();
			setState(770);
			match(T__17);
			setState(771);
			expression(0);
			setState(772);
			match(T__17);
			setState(773);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PrimaryExpressionContext extends ParserRuleContext {
		public TerminalNode BooleanLiteral() { return getToken(SolidityParser.BooleanLiteral, 0); }
		public NumberLiteralContext numberLiteral() {
			return getRuleContext(NumberLiteralContext.class,0);
		}
		public TerminalNode HexLiteral() { return getToken(SolidityParser.HexLiteral, 0); }
		public TerminalNode StringLiteral() { return getToken(SolidityParser.StringLiteral, 0); }
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public TupleExpressionContext tupleExpression() {
			return getRuleContext(TupleExpressionContext.class,0);
		}
		public ElementaryTypeNameExpressionContext elementaryTypeNameExpression() {
			return getRuleContext(ElementaryTypeNameExpressionContext.class,0);
		}
		public PrimaryExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_primaryExpression; }
	}

	public final PrimaryExpressionContext primaryExpression() throws RecognitionException {
		PrimaryExpressionContext _localctx = new PrimaryExpressionContext(_ctx, getState());
		enterRule(_localctx, 120, RULE_primaryExpression);
		try {
			setState(782);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case BooleanLiteral:
				enterOuterAlt(_localctx, 1);
				{
				setState(775);
				match(BooleanLiteral);
				}
				break;
			case DecimalNumber:
			case HexNumber:
				enterOuterAlt(_localctx, 2);
				{
				setState(776);
				numberLiteral();
				}
				break;
			case HexLiteral:
				enterOuterAlt(_localctx, 3);
				{
				setState(777);
				match(HexLiteral);
				}
				break;
			case StringLiteral:
				enterOuterAlt(_localctx, 4);
				{
				setState(778);
				match(StringLiteral);
				}
				break;
			case T__16:
			case Identifier:
				enterOuterAlt(_localctx, 5);
				{
				setState(779);
				identifier();
				}
				break;
			case T__22:
			case T__33:
				enterOuterAlt(_localctx, 6);
				{
				setState(780);
				tupleExpression();
				}
				break;
			case T__35:
			case T__50:
			case T__51:
			case T__52:
			case T__53:
			case Int:
			case Uint:
			case Byte:
			case Fixed:
			case Ufixed:
				enterOuterAlt(_localctx, 7);
				{
				setState(781);
				elementaryTypeNameExpression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpressionListContext extends ParserRuleContext {
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public ExpressionListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expressionList; }
	}

	public final ExpressionListContext expressionList() throws RecognitionException {
		ExpressionListContext _localctx = new ExpressionListContext(_ctx, getState());
		enterRule(_localctx, 122, RULE_expressionList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(784);
			expression(0);
			setState(789);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__17) {
				{
				{
				setState(785);
				match(T__17);
				setState(786);
				expression(0);
				}
				}
				setState(791);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NameValueListContext extends ParserRuleContext {
		public List<NameValueContext> nameValue() {
			return getRuleContexts(NameValueContext.class);
		}
		public NameValueContext nameValue(int i) {
			return getRuleContext(NameValueContext.class,i);
		}
		public NameValueListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_nameValueList; }
	}

	public final NameValueListContext nameValueList() throws RecognitionException {
		NameValueListContext _localctx = new NameValueListContext(_ctx, getState());
		enterRule(_localctx, 124, RULE_nameValueList);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(792);
			nameValue();
			setState(797);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,75,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(793);
					match(T__17);
					setState(794);
					nameValue();
					}
					} 
				}
				setState(799);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,75,_ctx);
			}
			setState(801);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__17) {
				{
				setState(800);
				match(T__17);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NameValueContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public NameValueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_nameValue; }
	}

	public final NameValueContext nameValue() throws RecognitionException {
		NameValueContext _localctx = new NameValueContext(_ctx, getState());
		enterRule(_localctx, 126, RULE_nameValue);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(803);
			identifier();
			setState(804);
			match(T__74);
			setState(805);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionCallArgumentsContext extends ParserRuleContext {
		public NameValueListContext nameValueList() {
			return getRuleContext(NameValueListContext.class,0);
		}
		public ExpressionListContext expressionList() {
			return getRuleContext(ExpressionListContext.class,0);
		}
		public FunctionCallArgumentsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionCallArguments; }
	}

	public final FunctionCallArgumentsContext functionCallArguments() throws RecognitionException {
		FunctionCallArgumentsContext _localctx = new FunctionCallArgumentsContext(_ctx, getState());
		enterRule(_localctx, 128, RULE_functionCallArguments);
		int _la;
		try {
			setState(815);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__11:
				enterOuterAlt(_localctx, 1);
				{
				setState(807);
				match(T__11);
				setState(809);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__16 || _la==Identifier) {
					{
					setState(808);
					nameValueList();
					}
				}

				setState(811);
				match(T__12);
				}
				break;
			case T__3:
			case T__16:
			case T__22:
			case T__23:
			case T__33:
			case T__35:
			case T__50:
			case T__51:
			case T__52:
			case T__53:
			case T__54:
			case T__55:
			case T__56:
			case T__57:
			case T__58:
			case T__59:
			case T__60:
			case T__61:
			case T__85:
			case T__86:
			case Int:
			case Uint:
			case Byte:
			case Fixed:
			case Ufixed:
			case BooleanLiteral:
			case DecimalNumber:
			case HexNumber:
			case HexLiteral:
			case Identifier:
			case StringLiteral:
				enterOuterAlt(_localctx, 2);
				{
				setState(813);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
					{
					setState(812);
					expressionList();
					}
				}

				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionCallContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public FunctionCallArgumentsContext functionCallArguments() {
			return getRuleContext(FunctionCallArgumentsContext.class,0);
		}
		public FunctionCallContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionCall; }
	}

	public final FunctionCallContext functionCall() throws RecognitionException {
		FunctionCallContext _localctx = new FunctionCallContext(_ctx, getState());
		enterRule(_localctx, 130, RULE_functionCall);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(817);
			expression(0);
			setState(818);
			match(T__22);
			setState(819);
			functionCallArguments();
			setState(820);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyBlockContext extends ParserRuleContext {
		public List<AssemblyItemContext> assemblyItem() {
			return getRuleContexts(AssemblyItemContext.class);
		}
		public AssemblyItemContext assemblyItem(int i) {
			return getRuleContext(AssemblyItemContext.class,i);
		}
		public AssemblyBlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyBlock; }
	}

	public final AssemblyBlockContext assemblyBlock() throws RecognitionException {
		AssemblyBlockContext _localctx = new AssemblyBlockContext(_ctx, getState());
		enterRule(_localctx, 132, RULE_assemblyBlock);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(822);
			match(T__11);
			setState(826);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__11) | (1L << T__16) | (1L << T__22) | (1L << T__25) | (1L << T__29) | (1L << T__35) | (1L << T__42) | (1L << T__45) | (1L << T__47) | (1L << T__53))) != 0) || ((((_la - 88)) & ~0x3f) == 0 && ((1L << (_la - 88)) & ((1L << (T__87 - 88)) | (1L << (T__89 - 88)) | (1L << (T__90 - 88)) | (1L << (DecimalNumber - 88)) | (1L << (HexNumber - 88)) | (1L << (HexLiteral - 88)) | (1L << (BreakKeyword - 88)) | (1L << (ContinueKeyword - 88)) | (1L << (Identifier - 88)) | (1L << (StringLiteral - 88)))) != 0)) {
				{
				{
				setState(823);
				assemblyItem();
				}
				}
				setState(828);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(829);
			match(T__12);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyItemContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public AssemblyBlockContext assemblyBlock() {
			return getRuleContext(AssemblyBlockContext.class,0);
		}
		public AssemblyExpressionContext assemblyExpression() {
			return getRuleContext(AssemblyExpressionContext.class,0);
		}
		public AssemblyLocalDefinitionContext assemblyLocalDefinition() {
			return getRuleContext(AssemblyLocalDefinitionContext.class,0);
		}
		public AssemblyAssignmentContext assemblyAssignment() {
			return getRuleContext(AssemblyAssignmentContext.class,0);
		}
		public AssemblyStackAssignmentContext assemblyStackAssignment() {
			return getRuleContext(AssemblyStackAssignmentContext.class,0);
		}
		public LabelDefinitionContext labelDefinition() {
			return getRuleContext(LabelDefinitionContext.class,0);
		}
		public AssemblySwitchContext assemblySwitch() {
			return getRuleContext(AssemblySwitchContext.class,0);
		}
		public AssemblyFunctionDefinitionContext assemblyFunctionDefinition() {
			return getRuleContext(AssemblyFunctionDefinitionContext.class,0);
		}
		public AssemblyForContext assemblyFor() {
			return getRuleContext(AssemblyForContext.class,0);
		}
		public AssemblyIfContext assemblyIf() {
			return getRuleContext(AssemblyIfContext.class,0);
		}
		public TerminalNode BreakKeyword() { return getToken(SolidityParser.BreakKeyword, 0); }
		public TerminalNode ContinueKeyword() { return getToken(SolidityParser.ContinueKeyword, 0); }
		public SubAssemblyContext subAssembly() {
			return getRuleContext(SubAssemblyContext.class,0);
		}
		public NumberLiteralContext numberLiteral() {
			return getRuleContext(NumberLiteralContext.class,0);
		}
		public TerminalNode StringLiteral() { return getToken(SolidityParser.StringLiteral, 0); }
		public TerminalNode HexLiteral() { return getToken(SolidityParser.HexLiteral, 0); }
		public AssemblyItemContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyItem; }
	}

	public final AssemblyItemContext assemblyItem() throws RecognitionException {
		AssemblyItemContext _localctx = new AssemblyItemContext(_ctx, getState());
		enterRule(_localctx, 134, RULE_assemblyItem);
		try {
			setState(848);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,81,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(831);
				identifier();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(832);
				assemblyBlock();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(833);
				assemblyExpression();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(834);
				assemblyLocalDefinition();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(835);
				assemblyAssignment();
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(836);
				assemblyStackAssignment();
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(837);
				labelDefinition();
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(838);
				assemblySwitch();
				}
				break;
			case 9:
				enterOuterAlt(_localctx, 9);
				{
				setState(839);
				assemblyFunctionDefinition();
				}
				break;
			case 10:
				enterOuterAlt(_localctx, 10);
				{
				setState(840);
				assemblyFor();
				}
				break;
			case 11:
				enterOuterAlt(_localctx, 11);
				{
				setState(841);
				assemblyIf();
				}
				break;
			case 12:
				enterOuterAlt(_localctx, 12);
				{
				setState(842);
				match(BreakKeyword);
				}
				break;
			case 13:
				enterOuterAlt(_localctx, 13);
				{
				setState(843);
				match(ContinueKeyword);
				}
				break;
			case 14:
				enterOuterAlt(_localctx, 14);
				{
				setState(844);
				subAssembly();
				}
				break;
			case 15:
				enterOuterAlt(_localctx, 15);
				{
				setState(845);
				numberLiteral();
				}
				break;
			case 16:
				enterOuterAlt(_localctx, 16);
				{
				setState(846);
				match(StringLiteral);
				}
				break;
			case 17:
				enterOuterAlt(_localctx, 17);
				{
				setState(847);
				match(HexLiteral);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyExpressionContext extends ParserRuleContext {
		public AssemblyCallContext assemblyCall() {
			return getRuleContext(AssemblyCallContext.class,0);
		}
		public AssemblyLiteralContext assemblyLiteral() {
			return getRuleContext(AssemblyLiteralContext.class,0);
		}
		public AssemblyExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyExpression; }
	}

	public final AssemblyExpressionContext assemblyExpression() throws RecognitionException {
		AssemblyExpressionContext _localctx = new AssemblyExpressionContext(_ctx, getState());
		enterRule(_localctx, 136, RULE_assemblyExpression);
		try {
			setState(852);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__16:
			case T__35:
			case T__47:
			case T__53:
			case Identifier:
				enterOuterAlt(_localctx, 1);
				{
				setState(850);
				assemblyCall();
				}
				break;
			case DecimalNumber:
			case HexNumber:
			case HexLiteral:
			case StringLiteral:
				enterOuterAlt(_localctx, 2);
				{
				setState(851);
				assemblyLiteral();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyCallContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public List<AssemblyExpressionContext> assemblyExpression() {
			return getRuleContexts(AssemblyExpressionContext.class);
		}
		public AssemblyExpressionContext assemblyExpression(int i) {
			return getRuleContext(AssemblyExpressionContext.class,i);
		}
		public AssemblyCallContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyCall; }
	}

	public final AssemblyCallContext assemblyCall() throws RecognitionException {
		AssemblyCallContext _localctx = new AssemblyCallContext(_ctx, getState());
		enterRule(_localctx, 138, RULE_assemblyCall);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(858);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__47:
				{
				setState(854);
				match(T__47);
				}
				break;
			case T__35:
				{
				setState(855);
				match(T__35);
				}
				break;
			case T__53:
				{
				setState(856);
				match(T__53);
				}
				break;
			case T__16:
			case Identifier:
				{
				setState(857);
				identifier();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(872);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,86,_ctx) ) {
			case 1:
				{
				setState(860);
				match(T__22);
				setState(862);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__35) | (1L << T__47) | (1L << T__53))) != 0) || ((((_la - 102)) & ~0x3f) == 0 && ((1L << (_la - 102)) & ((1L << (DecimalNumber - 102)) | (1L << (HexNumber - 102)) | (1L << (HexLiteral - 102)) | (1L << (Identifier - 102)) | (1L << (StringLiteral - 102)))) != 0)) {
					{
					setState(861);
					assemblyExpression();
					}
				}

				setState(868);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(864);
					match(T__17);
					setState(865);
					assemblyExpression();
					}
					}
					setState(870);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(871);
				match(T__23);
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyLocalDefinitionContext extends ParserRuleContext {
		public AssemblyIdentifierOrListContext assemblyIdentifierOrList() {
			return getRuleContext(AssemblyIdentifierOrListContext.class,0);
		}
		public AssemblyExpressionContext assemblyExpression() {
			return getRuleContext(AssemblyExpressionContext.class,0);
		}
		public AssemblyLocalDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyLocalDefinition; }
	}

	public final AssemblyLocalDefinitionContext assemblyLocalDefinition() throws RecognitionException {
		AssemblyLocalDefinitionContext _localctx = new AssemblyLocalDefinitionContext(_ctx, getState());
		enterRule(_localctx, 140, RULE_assemblyLocalDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(874);
			match(T__87);
			setState(875);
			assemblyIdentifierOrList();
			setState(878);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__88) {
				{
				setState(876);
				match(T__88);
				setState(877);
				assemblyExpression();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyAssignmentContext extends ParserRuleContext {
		public AssemblyIdentifierOrListContext assemblyIdentifierOrList() {
			return getRuleContext(AssemblyIdentifierOrListContext.class,0);
		}
		public AssemblyExpressionContext assemblyExpression() {
			return getRuleContext(AssemblyExpressionContext.class,0);
		}
		public AssemblyAssignmentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyAssignment; }
	}

	public final AssemblyAssignmentContext assemblyAssignment() throws RecognitionException {
		AssemblyAssignmentContext _localctx = new AssemblyAssignmentContext(_ctx, getState());
		enterRule(_localctx, 142, RULE_assemblyAssignment);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(880);
			assemblyIdentifierOrList();
			setState(881);
			match(T__88);
			setState(882);
			assemblyExpression();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyIdentifierOrListContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public AssemblyIdentifierListContext assemblyIdentifierList() {
			return getRuleContext(AssemblyIdentifierListContext.class,0);
		}
		public AssemblyIdentifierOrListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyIdentifierOrList; }
	}

	public final AssemblyIdentifierOrListContext assemblyIdentifierOrList() throws RecognitionException {
		AssemblyIdentifierOrListContext _localctx = new AssemblyIdentifierOrListContext(_ctx, getState());
		enterRule(_localctx, 144, RULE_assemblyIdentifierOrList);
		try {
			setState(889);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__16:
			case Identifier:
				enterOuterAlt(_localctx, 1);
				{
				setState(884);
				identifier();
				}
				break;
			case T__22:
				enterOuterAlt(_localctx, 2);
				{
				setState(885);
				match(T__22);
				setState(886);
				assemblyIdentifierList();
				setState(887);
				match(T__23);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyIdentifierListContext extends ParserRuleContext {
		public List<IdentifierContext> identifier() {
			return getRuleContexts(IdentifierContext.class);
		}
		public IdentifierContext identifier(int i) {
			return getRuleContext(IdentifierContext.class,i);
		}
		public AssemblyIdentifierListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyIdentifierList; }
	}

	public final AssemblyIdentifierListContext assemblyIdentifierList() throws RecognitionException {
		AssemblyIdentifierListContext _localctx = new AssemblyIdentifierListContext(_ctx, getState());
		enterRule(_localctx, 146, RULE_assemblyIdentifierList);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(891);
			identifier();
			setState(896);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__17) {
				{
				{
				setState(892);
				match(T__17);
				setState(893);
				identifier();
				}
				}
				setState(898);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyStackAssignmentContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public AssemblyStackAssignmentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyStackAssignment; }
	}

	public final AssemblyStackAssignmentContext assemblyStackAssignment() throws RecognitionException {
		AssemblyStackAssignmentContext _localctx = new AssemblyStackAssignmentContext(_ctx, getState());
		enterRule(_localctx, 148, RULE_assemblyStackAssignment);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(899);
			match(T__89);
			setState(900);
			identifier();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class LabelDefinitionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public LabelDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_labelDefinition; }
	}

	public final LabelDefinitionContext labelDefinition() throws RecognitionException {
		LabelDefinitionContext _localctx = new LabelDefinitionContext(_ctx, getState());
		enterRule(_localctx, 150, RULE_labelDefinition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(902);
			identifier();
			setState(903);
			match(T__74);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblySwitchContext extends ParserRuleContext {
		public AssemblyExpressionContext assemblyExpression() {
			return getRuleContext(AssemblyExpressionContext.class,0);
		}
		public List<AssemblyCaseContext> assemblyCase() {
			return getRuleContexts(AssemblyCaseContext.class);
		}
		public AssemblyCaseContext assemblyCase(int i) {
			return getRuleContext(AssemblyCaseContext.class,i);
		}
		public AssemblySwitchContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblySwitch; }
	}

	public final AssemblySwitchContext assemblySwitch() throws RecognitionException {
		AssemblySwitchContext _localctx = new AssemblySwitchContext(_ctx, getState());
		enterRule(_localctx, 152, RULE_assemblySwitch);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(905);
			match(T__90);
			setState(906);
			assemblyExpression();
			setState(910);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__91 || _la==T__92) {
				{
				{
				setState(907);
				assemblyCase();
				}
				}
				setState(912);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyCaseContext extends ParserRuleContext {
		public AssemblyLiteralContext assemblyLiteral() {
			return getRuleContext(AssemblyLiteralContext.class,0);
		}
		public AssemblyBlockContext assemblyBlock() {
			return getRuleContext(AssemblyBlockContext.class,0);
		}
		public AssemblyCaseContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyCase; }
	}

	public final AssemblyCaseContext assemblyCase() throws RecognitionException {
		AssemblyCaseContext _localctx = new AssemblyCaseContext(_ctx, getState());
		enterRule(_localctx, 154, RULE_assemblyCase);
		try {
			setState(919);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__91:
				enterOuterAlt(_localctx, 1);
				{
				setState(913);
				match(T__91);
				setState(914);
				assemblyLiteral();
				setState(915);
				assemblyBlock();
				}
				break;
			case T__92:
				enterOuterAlt(_localctx, 2);
				{
				setState(917);
				match(T__92);
				setState(918);
				assemblyBlock();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyFunctionDefinitionContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public AssemblyBlockContext assemblyBlock() {
			return getRuleContext(AssemblyBlockContext.class,0);
		}
		public AssemblyIdentifierListContext assemblyIdentifierList() {
			return getRuleContext(AssemblyIdentifierListContext.class,0);
		}
		public AssemblyFunctionReturnsContext assemblyFunctionReturns() {
			return getRuleContext(AssemblyFunctionReturnsContext.class,0);
		}
		public AssemblyFunctionDefinitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyFunctionDefinition; }
	}

	public final AssemblyFunctionDefinitionContext assemblyFunctionDefinition() throws RecognitionException {
		AssemblyFunctionDefinitionContext _localctx = new AssemblyFunctionDefinitionContext(_ctx, getState());
		enterRule(_localctx, 156, RULE_assemblyFunctionDefinition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(921);
			match(T__29);
			setState(922);
			identifier();
			setState(923);
			match(T__22);
			setState(925);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__16 || _la==Identifier) {
				{
				setState(924);
				assemblyIdentifierList();
				}
			}

			setState(927);
			match(T__23);
			setState(929);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__93) {
				{
				setState(928);
				assemblyFunctionReturns();
				}
			}

			setState(931);
			assemblyBlock();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyFunctionReturnsContext extends ParserRuleContext {
		public AssemblyIdentifierListContext assemblyIdentifierList() {
			return getRuleContext(AssemblyIdentifierListContext.class,0);
		}
		public AssemblyFunctionReturnsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyFunctionReturns; }
	}

	public final AssemblyFunctionReturnsContext assemblyFunctionReturns() throws RecognitionException {
		AssemblyFunctionReturnsContext _localctx = new AssemblyFunctionReturnsContext(_ctx, getState());
		enterRule(_localctx, 158, RULE_assemblyFunctionReturns);
		try {
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(933);
			match(T__93);
			setState(934);
			assemblyIdentifierList();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyForContext extends ParserRuleContext {
		public List<AssemblyExpressionContext> assemblyExpression() {
			return getRuleContexts(AssemblyExpressionContext.class);
		}
		public AssemblyExpressionContext assemblyExpression(int i) {
			return getRuleContext(AssemblyExpressionContext.class,i);
		}
		public List<AssemblyBlockContext> assemblyBlock() {
			return getRuleContexts(AssemblyBlockContext.class);
		}
		public AssemblyBlockContext assemblyBlock(int i) {
			return getRuleContext(AssemblyBlockContext.class,i);
		}
		public AssemblyForContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyFor; }
	}

	public final AssemblyForContext assemblyFor() throws RecognitionException {
		AssemblyForContext _localctx = new AssemblyForContext(_ctx, getState());
		enterRule(_localctx, 160, RULE_assemblyFor);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(936);
			match(T__25);
			setState(939);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__11:
				{
				setState(937);
				assemblyBlock();
				}
				break;
			case T__16:
			case T__35:
			case T__47:
			case T__53:
			case DecimalNumber:
			case HexNumber:
			case HexLiteral:
			case Identifier:
			case StringLiteral:
				{
				setState(938);
				assemblyExpression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(941);
			assemblyExpression();
			setState(944);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__11:
				{
				setState(942);
				assemblyBlock();
				}
				break;
			case T__16:
			case T__35:
			case T__47:
			case T__53:
			case DecimalNumber:
			case HexNumber:
			case HexLiteral:
			case Identifier:
			case StringLiteral:
				{
				setState(943);
				assemblyExpression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(946);
			assemblyBlock();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyIfContext extends ParserRuleContext {
		public AssemblyExpressionContext assemblyExpression() {
			return getRuleContext(AssemblyExpressionContext.class,0);
		}
		public AssemblyBlockContext assemblyBlock() {
			return getRuleContext(AssemblyBlockContext.class,0);
		}
		public AssemblyIfContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyIf; }
	}

	public final AssemblyIfContext assemblyIf() throws RecognitionException {
		AssemblyIfContext _localctx = new AssemblyIfContext(_ctx, getState());
		enterRule(_localctx, 162, RULE_assemblyIf);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(948);
			match(T__42);
			setState(949);
			assemblyExpression();
			setState(950);
			assemblyBlock();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssemblyLiteralContext extends ParserRuleContext {
		public TerminalNode StringLiteral() { return getToken(SolidityParser.StringLiteral, 0); }
		public TerminalNode DecimalNumber() { return getToken(SolidityParser.DecimalNumber, 0); }
		public TerminalNode HexNumber() { return getToken(SolidityParser.HexNumber, 0); }
		public TerminalNode HexLiteral() { return getToken(SolidityParser.HexLiteral, 0); }
		public AssemblyLiteralContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assemblyLiteral; }
	}

	public final AssemblyLiteralContext assemblyLiteral() throws RecognitionException {
		AssemblyLiteralContext _localctx = new AssemblyLiteralContext(_ctx, getState());
		enterRule(_localctx, 164, RULE_assemblyLiteral);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(952);
			_la = _input.LA(1);
			if ( !(((((_la - 102)) & ~0x3f) == 0 && ((1L << (_la - 102)) & ((1L << (DecimalNumber - 102)) | (1L << (HexNumber - 102)) | (1L << (HexLiteral - 102)) | (1L << (StringLiteral - 102)))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SubAssemblyContext extends ParserRuleContext {
		public IdentifierContext identifier() {
			return getRuleContext(IdentifierContext.class,0);
		}
		public AssemblyBlockContext assemblyBlock() {
			return getRuleContext(AssemblyBlockContext.class,0);
		}
		public SubAssemblyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_subAssembly; }
	}

	public final SubAssemblyContext subAssembly() throws RecognitionException {
		SubAssemblyContext _localctx = new SubAssemblyContext(_ctx, getState());
		enterRule(_localctx, 166, RULE_subAssembly);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(954);
			match(T__45);
			setState(955);
			identifier();
			setState(956);
			assemblyBlock();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TupleExpressionContext extends ParserRuleContext {
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TupleExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_tupleExpression; }
	}

	public final TupleExpressionContext tupleExpression() throws RecognitionException {
		TupleExpressionContext _localctx = new TupleExpressionContext(_ctx, getState());
		enterRule(_localctx, 168, RULE_tupleExpression);
		int _la;
		try {
			setState(984);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__22:
				enterOuterAlt(_localctx, 1);
				{
				setState(958);
				match(T__22);
				{
				setState(960);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
					{
					setState(959);
					expression(0);
					}
				}

				setState(968);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__17) {
					{
					{
					setState(962);
					match(T__17);
					setState(964);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
						{
						setState(963);
						expression(0);
						}
					}

					}
					}
					setState(970);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
				setState(971);
				match(T__23);
				}
				break;
			case T__33:
				enterOuterAlt(_localctx, 2);
				{
				setState(972);
				match(T__33);
				setState(981);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__16) | (1L << T__22) | (1L << T__33) | (1L << T__35) | (1L << T__50) | (1L << T__51) | (1L << T__52) | (1L << T__53) | (1L << T__54) | (1L << T__55) | (1L << T__56) | (1L << T__57) | (1L << T__58) | (1L << T__59) | (1L << T__60) | (1L << T__61))) != 0) || ((((_la - 86)) & ~0x3f) == 0 && ((1L << (_la - 86)) & ((1L << (T__85 - 86)) | (1L << (T__86 - 86)) | (1L << (Int - 86)) | (1L << (Uint - 86)) | (1L << (Byte - 86)) | (1L << (Fixed - 86)) | (1L << (Ufixed - 86)) | (1L << (BooleanLiteral - 86)) | (1L << (DecimalNumber - 86)) | (1L << (HexNumber - 86)) | (1L << (HexLiteral - 86)) | (1L << (Identifier - 86)) | (1L << (StringLiteral - 86)))) != 0)) {
					{
					setState(973);
					expression(0);
					setState(978);
					_errHandler.sync(this);
					_la = _input.LA(1);
					while (_la==T__17) {
						{
						{
						setState(974);
						match(T__17);
						setState(975);
						expression(0);
						}
						}
						setState(980);
						_errHandler.sync(this);
						_la = _input.LA(1);
					}
					}
				}

				setState(983);
				match(T__34);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ElementaryTypeNameExpressionContext extends ParserRuleContext {
		public ElementaryTypeNameContext elementaryTypeName() {
			return getRuleContext(ElementaryTypeNameContext.class,0);
		}
		public ElementaryTypeNameExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elementaryTypeNameExpression; }
	}

	public final ElementaryTypeNameExpressionContext elementaryTypeNameExpression() throws RecognitionException {
		ElementaryTypeNameExpressionContext _localctx = new ElementaryTypeNameExpressionContext(_ctx, getState());
		enterRule(_localctx, 170, RULE_elementaryTypeNameExpression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(986);
			elementaryTypeName();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NumberLiteralContext extends ParserRuleContext {
		public TerminalNode DecimalNumber() { return getToken(SolidityParser.DecimalNumber, 0); }
		public TerminalNode HexNumber() { return getToken(SolidityParser.HexNumber, 0); }
		public TerminalNode NumberUnit() { return getToken(SolidityParser.NumberUnit, 0); }
		public NumberLiteralContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_numberLiteral; }
	}

	public final NumberLiteralContext numberLiteral() throws RecognitionException {
		NumberLiteralContext _localctx = new NumberLiteralContext(_ctx, getState());
		enterRule(_localctx, 172, RULE_numberLiteral);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(988);
			_la = _input.LA(1);
			if ( !(_la==DecimalNumber || _la==HexNumber) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(990);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,102,_ctx) ) {
			case 1:
				{
				setState(989);
				match(NumberUnit);
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IdentifierContext extends ParserRuleContext {
		public TerminalNode Identifier() { return getToken(SolidityParser.Identifier, 0); }
		public IdentifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_identifier; }
	}

	public final IdentifierContext identifier() throws RecognitionException {
		IdentifierContext _localctx = new IdentifierContext(_ctx, getState());
		enterRule(_localctx, 174, RULE_identifier);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(992);
			_la = _input.LA(1);
			if ( !(_la==T__16 || _la==Identifier) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 33:
			return typeName_sempred((TypeNameContext)_localctx, predIndex);
		case 57:
			return expression_sempred((ExpressionContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean typeName_sempred(TypeNameContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 3);
		}
		return true;
	}
	private boolean expression_sempred(ExpressionContext _localctx, int predIndex) {
		switch (predIndex) {
		case 1:
			return precpred(_ctx, 16);
		case 2:
			return precpred(_ctx, 15);
		case 3:
			return precpred(_ctx, 14);
		case 4:
			return precpred(_ctx, 13);
		case 5:
			return precpred(_ctx, 12);
		case 6:
			return precpred(_ctx, 11);
		case 7:
			return precpred(_ctx, 10);
		case 8:
			return precpred(_ctx, 9);
		case 9:
			return precpred(_ctx, 8);
		case 10:
			return precpred(_ctx, 7);
		case 11:
			return precpred(_ctx, 6);
		case 12:
			return precpred(_ctx, 5);
		case 13:
			return precpred(_ctx, 4);
		case 14:
			return precpred(_ctx, 27);
		case 15:
			return precpred(_ctx, 25);
		case 16:
			return precpred(_ctx, 24);
		case 17:
			return precpred(_ctx, 23);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3}\u03e5\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&\t&\4\'\t\'\4(\t(\4)\t)\4*\t*\4+\t+\4"+
		",\t,\4-\t-\4.\t.\4/\t/\4\60\t\60\4\61\t\61\4\62\t\62\4\63\t\63\4\64\t"+
		"\64\4\65\t\65\4\66\t\66\4\67\t\67\48\t8\49\t9\4:\t:\4;\t;\4<\t<\4=\t="+
		"\4>\t>\4?\t?\4@\t@\4A\tA\4B\tB\4C\tC\4D\tD\4E\tE\4F\tF\4G\tG\4H\tH\4I"+
		"\tI\4J\tJ\4K\tK\4L\tL\4M\tM\4N\tN\4O\tO\4P\tP\4Q\tQ\4R\tR\4S\tS\4T\tT"+
		"\4U\tU\4V\tV\4W\tW\4X\tX\4Y\tY\3\2\3\2\3\2\3\2\7\2\u00b7\n\2\f\2\16\2"+
		"\u00ba\13\2\3\2\3\2\3\3\3\3\3\3\3\3\3\3\3\4\3\4\3\5\3\5\5\5\u00c7\n\5"+
		"\3\6\3\6\5\6\u00cb\n\6\3\7\3\7\3\b\5\b\u00d0\n\b\3\b\3\b\3\t\3\t\3\t\5"+
		"\t\u00d7\n\t\3\n\3\n\3\n\3\n\7\n\u00dd\n\n\f\n\16\n\u00e0\13\n\3\n\3\n"+
		"\3\n\3\n\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\f\5\f\u00ee\n\f\3\f\3\f\3\f"+
		"\3\f\5\f\u00f4\n\f\3\f\3\f\5\f\u00f8\n\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3"+
		"\f\7\f\u0102\n\f\f\f\16\f\u0105\13\f\3\f\3\f\3\f\3\f\3\f\5\f\u010c\n\f"+
		"\3\r\3\r\3\r\3\r\3\r\3\r\7\r\u0114\n\r\f\r\16\r\u0117\13\r\5\r\u0119\n"+
		"\r\3\r\3\r\7\r\u011d\n\r\f\r\16\r\u0120\13\r\3\r\3\r\3\16\3\16\3\16\3"+
		"\16\3\16\7\16\u0129\n\16\f\16\16\16\u012c\13\16\3\16\3\16\5\16\u0130\n"+
		"\16\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u013a\n\17\3\20\3\20"+
		"\7\20\u013e\n\20\f\20\16\20\u0141\13\20\3\20\3\20\3\20\5\20\u0146\n\20"+
		"\3\20\3\20\3\21\3\21\3\21\3\21\3\21\5\21\u014f\n\21\3\21\3\21\3\22\3\22"+
		"\3\22\3\22\3\22\3\22\3\22\3\22\7\22\u015b\n\22\f\22\16\22\u015e\13\22"+
		"\5\22\u0160\n\22\3\22\3\22\3\23\3\23\3\23\3\23\3\23\3\24\3\24\3\24\5\24"+
		"\u016c\n\24\3\24\3\24\3\25\3\25\3\25\5\25\u0173\n\25\3\25\5\25\u0176\n"+
		"\25\3\26\3\26\5\26\u017a\n\26\3\26\3\26\3\26\5\26\u017f\n\26\3\26\3\26"+
		"\5\26\u0183\n\26\3\27\3\27\3\27\3\30\3\30\3\30\3\30\3\30\3\30\7\30\u018e"+
		"\n\30\f\30\16\30\u0191\13\30\3\31\3\31\3\31\3\31\5\31\u0197\n\31\3\31"+
		"\3\31\3\32\3\32\3\33\3\33\3\33\3\33\5\33\u01a1\n\33\3\33\3\33\7\33\u01a5"+
		"\n\33\f\33\16\33\u01a8\13\33\3\33\3\33\3\34\3\34\3\34\3\34\7\34\u01b0"+
		"\n\34\f\34\16\34\u01b3\13\34\5\34\u01b5\n\34\3\34\3\34\3\35\3\35\5\35"+
		"\u01bb\n\35\3\35\5\35\u01be\n\35\3\36\3\36\3\36\3\36\7\36\u01c4\n\36\f"+
		"\36\16\36\u01c7\13\36\5\36\u01c9\n\36\3\36\3\36\3\37\3\37\5\37\u01cf\n"+
		"\37\3\37\5\37\u01d2\n\37\3 \3 \3 \3 \7 \u01d8\n \f \16 \u01db\13 \5 \u01dd"+
		"\n \3 \3 \3!\3!\5!\u01e3\n!\3\"\3\"\5\"\u01e7\n\"\3\"\3\"\3#\3#\3#\3#"+
		"\3#\3#\3#\5#\u01f2\n#\3#\3#\3#\5#\u01f7\n#\3#\7#\u01fa\n#\f#\16#\u01fd"+
		"\13#\3$\3$\3$\7$\u0202\n$\f$\16$\u0205\13$\3%\3%\3%\3%\3%\3%\3%\3&\3&"+
		"\3&\3&\3&\7&\u0213\n&\f&\16&\u0216\13&\3&\3&\5&\u021a\n&\3\'\3\'\3(\3"+
		"(\3)\3)\7)\u0222\n)\f)\16)\u0225\13)\3)\3)\3*\3*\3*\3*\3*\3*\3*\3*\3*"+
		"\3*\3*\3*\5*\u0235\n*\3+\3+\3+\3,\3,\3,\3,\3,\3,\3,\5,\u0241\n,\3-\3-"+
		"\3-\3-\3-\3-\3.\3.\5.\u024b\n.\3/\3/\3/\3/\5/\u0251\n/\3/\5/\u0254\n/"+
		"\3/\3/\5/\u0258\n/\3/\3/\3/\3\60\3\60\5\60\u025f\n\60\3\60\3\60\3\61\3"+
		"\61\3\61\3\61\3\61\3\61\3\61\3\61\3\62\3\62\3\62\3\63\3\63\3\63\3\64\3"+
		"\64\5\64\u0273\n\64\3\64\3\64\3\65\3\65\3\65\3\66\3\66\3\66\3\66\3\67"+
		"\3\67\3\67\3\67\3\67\3\67\3\67\5\67\u0285\n\67\3\67\3\67\5\67\u0289\n"+
		"\67\3\67\3\67\38\58\u028e\n8\38\38\58\u0292\n8\78\u0294\n8\f8\168\u0297"+
		"\138\39\39\59\u029b\n9\39\79\u029e\n9\f9\169\u02a1\139\39\59\u02a4\n9"+
		"\39\39\3:\3:\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;"+
		"\3;\5;\u02be\n;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;"+
		"\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;"+
		"\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\3;\7;\u02f9\n;\f;\16;\u02fc"+
		"\13;\3<\3<\3<\3<\3<\3=\3=\3=\3=\3=\3=\3=\3>\3>\3>\3>\3>\3>\3>\5>\u0311"+
		"\n>\3?\3?\3?\7?\u0316\n?\f?\16?\u0319\13?\3@\3@\3@\7@\u031e\n@\f@\16@"+
		"\u0321\13@\3@\5@\u0324\n@\3A\3A\3A\3A\3B\3B\5B\u032c\nB\3B\3B\5B\u0330"+
		"\nB\5B\u0332\nB\3C\3C\3C\3C\3C\3D\3D\7D\u033b\nD\fD\16D\u033e\13D\3D\3"+
		"D\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\3E\5E\u0353\nE\3F\3"+
		"F\5F\u0357\nF\3G\3G\3G\3G\5G\u035d\nG\3G\3G\5G\u0361\nG\3G\3G\7G\u0365"+
		"\nG\fG\16G\u0368\13G\3G\5G\u036b\nG\3H\3H\3H\3H\5H\u0371\nH\3I\3I\3I\3"+
		"I\3J\3J\3J\3J\3J\5J\u037c\nJ\3K\3K\3K\7K\u0381\nK\fK\16K\u0384\13K\3L"+
		"\3L\3L\3M\3M\3M\3N\3N\3N\7N\u038f\nN\fN\16N\u0392\13N\3O\3O\3O\3O\3O\3"+
		"O\5O\u039a\nO\3P\3P\3P\3P\5P\u03a0\nP\3P\3P\5P\u03a4\nP\3P\3P\3Q\3Q\3"+
		"Q\3R\3R\3R\5R\u03ae\nR\3R\3R\3R\5R\u03b3\nR\3R\3R\3S\3S\3S\3S\3T\3T\3"+
		"U\3U\3U\3U\3V\3V\5V\u03c3\nV\3V\3V\5V\u03c7\nV\7V\u03c9\nV\fV\16V\u03cc"+
		"\13V\3V\3V\3V\3V\3V\7V\u03d3\nV\fV\16V\u03d6\13V\5V\u03d8\nV\3V\5V\u03db"+
		"\nV\3W\3W\3X\3X\5X\u03e1\nX\3Y\3Y\3Y\2\4DtZ\2\4\6\b\n\f\16\20\22\24\26"+
		"\30\32\34\36 \"$&(*,.\60\62\64\668:<>@BDFHJLNPRTVXZ\\^`bdfhjlnprtvxz|"+
		"~\u0080\u0082\u0084\u0086\u0088\u008a\u008c\u008e\u0090\u0092\u0094\u0096"+
		"\u0098\u009a\u009c\u009e\u00a0\u00a2\u00a4\u00a6\u00a8\u00aa\u00ac\u00ae"+
		"\u00b0\2\23\3\2\5\13\3\2\25\27\5\2oossuv\3\2*,\5\2oottwx\5\2&&\658ae\3"+
		"\29:\3\2<=\3\2>?\4\2\22\22BC\3\2DE\3\2\7\n\3\2HI\4\2\13\13NW\5\2hikkz"+
		"z\3\2hi\4\2\23\23yy\2\u043c\2\u00b8\3\2\2\2\4\u00bd\3\2\2\2\6\u00c2\3"+
		"\2\2\2\b\u00c6\3\2\2\2\n\u00c8\3\2\2\2\f\u00cc\3\2\2\2\16\u00cf\3\2\2"+
		"\2\20\u00d3\3\2\2\2\22\u00d8\3\2\2\2\24\u00e5\3\2\2\2\26\u010b\3\2\2\2"+
		"\30\u010d\3\2\2\2\32\u0123\3\2\2\2\34\u0139\3\2\2\2\36\u013b\3\2\2\2 "+
		"\u0149\3\2\2\2\"\u0152\3\2\2\2$\u0163\3\2\2\2&\u0168\3\2\2\2(\u016f\3"+
		"\2\2\2*\u0177\3\2\2\2,\u0184\3\2\2\2.\u018f\3\2\2\2\60\u0192\3\2\2\2\62"+
		"\u019a\3\2\2\2\64\u019c\3\2\2\2\66\u01ab\3\2\2\28\u01b8\3\2\2\2:\u01bf"+
		"\3\2\2\2<\u01cc\3\2\2\2>\u01d3\3\2\2\2@\u01e0\3\2\2\2B\u01e4\3\2\2\2D"+
		"\u01f1\3\2\2\2F\u01fe\3\2\2\2H\u0206\3\2\2\2J\u020d\3\2\2\2L\u021b\3\2"+
		"\2\2N\u021d\3\2\2\2P\u021f\3\2\2\2R\u0234\3\2\2\2T\u0236\3\2\2\2V\u0239"+
		"\3\2\2\2X\u0242\3\2\2\2Z\u024a\3\2\2\2\\\u024c\3\2\2\2^\u025c\3\2\2\2"+
		"`\u0262\3\2\2\2b\u026a\3\2\2\2d\u026d\3\2\2\2f\u0270\3\2\2\2h\u0276\3"+
		"\2\2\2j\u0279\3\2\2\2l\u0284\3\2\2\2n\u028d\3\2\2\2p\u0298\3\2\2\2r\u02a7"+
		"\3\2\2\2t\u02bd\3\2\2\2v\u02fd\3\2\2\2x\u0302\3\2\2\2z\u0310\3\2\2\2|"+
		"\u0312\3\2\2\2~\u031a\3\2\2\2\u0080\u0325\3\2\2\2\u0082\u0331\3\2\2\2"+
		"\u0084\u0333\3\2\2\2\u0086\u0338\3\2\2\2\u0088\u0352\3\2\2\2\u008a\u0356"+
		"\3\2\2\2\u008c\u035c\3\2\2\2\u008e\u036c\3\2\2\2\u0090\u0372\3\2\2\2\u0092"+
		"\u037b\3\2\2\2\u0094\u037d\3\2\2\2\u0096\u0385\3\2\2\2\u0098\u0388\3\2"+
		"\2\2\u009a\u038b\3\2\2\2\u009c\u0399\3\2\2\2\u009e\u039b\3\2\2\2\u00a0"+
		"\u03a7\3\2\2\2\u00a2\u03aa\3\2\2\2\u00a4\u03b6\3\2\2\2\u00a6\u03ba\3\2"+
		"\2\2\u00a8\u03bc\3\2\2\2\u00aa\u03da\3\2\2\2\u00ac\u03dc\3\2\2\2\u00ae"+
		"\u03de\3\2\2\2\u00b0\u03e2\3\2\2\2\u00b2\u00b7\5\4\3\2\u00b3\u00b7\5\26"+
		"\f\2\u00b4\u00b7\5\30\r\2\u00b5\u00b7\5\22\n\2\u00b6\u00b2\3\2\2\2\u00b6"+
		"\u00b3\3\2\2\2\u00b6\u00b4\3\2\2\2\u00b6\u00b5\3\2\2\2\u00b7\u00ba\3\2"+
		"\2\2\u00b8\u00b6\3\2\2\2\u00b8\u00b9\3\2\2\2\u00b9\u00bb\3\2\2\2\u00ba"+
		"\u00b8\3\2\2\2\u00bb\u00bc\7\2\2\3\u00bc\3\3\2\2\2\u00bd\u00be\7\3\2\2"+
		"\u00be\u00bf\5\6\4\2\u00bf\u00c0\5\b\5\2\u00c0\u00c1\7\4\2\2\u00c1\5\3"+
		"\2\2\2\u00c2\u00c3\5\u00b0Y\2\u00c3\7\3\2\2\2\u00c4\u00c7\5\n\6\2\u00c5"+
		"\u00c7\5t;\2\u00c6\u00c4\3\2\2\2\u00c6\u00c5\3\2\2\2\u00c7\t\3\2\2\2\u00c8"+
		"\u00ca\5\16\b\2\u00c9\u00cb\5\16\b\2\u00ca\u00c9\3\2\2\2\u00ca\u00cb\3"+
		"\2\2\2\u00cb\13\3\2\2\2\u00cc\u00cd\t\2\2\2\u00cd\r\3\2\2\2\u00ce\u00d0"+
		"\5\f\7\2\u00cf\u00ce\3\2\2\2\u00cf\u00d0\3\2\2\2\u00d0\u00d1\3\2\2\2\u00d1"+
		"\u00d2\7f\2\2\u00d2\17\3\2\2\2\u00d3\u00d6\5\u00b0Y\2\u00d4\u00d5\7\f"+
		"\2\2\u00d5\u00d7\5\u00b0Y\2\u00d6\u00d4\3\2\2\2\u00d6\u00d7\3\2\2\2\u00d7"+
		"\21\3\2\2\2\u00d8\u00d9\7\r\2\2\u00d9\u00da\7y\2\2\u00da\u00de\7\16\2"+
		"\2\u00db\u00dd\5\34\17\2\u00dc\u00db\3\2\2\2\u00dd\u00e0\3\2\2\2\u00de"+
		"\u00dc\3\2\2\2\u00de\u00df\3\2\2\2\u00df\u00e1\3\2\2\2\u00e0\u00de\3\2"+
		"\2\2\u00e1\u00e2\5\24\13\2\u00e2\u00e3\7\17\2\2\u00e3\u00e4\7\2\2\3\u00e4"+
		"\23\3\2\2\2\u00e5\u00e6\7\20\2\2\u00e6\u00e7\5t;\2\u00e7\u00e8\7\4\2\2"+
		"\u00e8\25\3\2\2\2\u00e9\u00ea\7\21\2\2\u00ea\u00ed\7z\2\2\u00eb\u00ec"+
		"\7\f\2\2\u00ec\u00ee\5\u00b0Y\2\u00ed\u00eb\3\2\2\2\u00ed\u00ee\3\2\2"+
		"\2\u00ee\u00ef\3\2\2\2\u00ef\u010c\7\4\2\2\u00f0\u00f3\7\21\2\2\u00f1"+
		"\u00f4\7\22\2\2\u00f2\u00f4\5\u00b0Y\2\u00f3\u00f1\3\2\2\2\u00f3\u00f2"+
		"\3\2\2\2\u00f4\u00f7\3\2\2\2\u00f5\u00f6\7\f\2\2\u00f6\u00f8\5\u00b0Y"+
		"\2\u00f7\u00f5\3\2\2\2\u00f7\u00f8\3\2\2\2\u00f8\u00f9\3\2\2\2\u00f9\u00fa"+
		"\7\23\2\2\u00fa\u00fb\7z\2\2\u00fb\u010c\7\4\2\2\u00fc\u00fd\7\21\2\2"+
		"\u00fd\u00fe\7\16\2\2\u00fe\u0103\5\20\t\2\u00ff\u0100\7\24\2\2\u0100"+
		"\u0102\5\20\t\2\u0101\u00ff\3\2\2\2\u0102\u0105\3\2\2\2\u0103\u0101\3"+
		"\2\2\2\u0103\u0104\3\2\2\2\u0104\u0106\3\2\2\2\u0105\u0103\3\2\2\2\u0106"+
		"\u0107\7\17\2\2\u0107\u0108\7\23\2\2\u0108\u0109\7z\2\2\u0109\u010a\7"+
		"\4\2\2\u010a\u010c\3\2\2\2\u010b\u00e9\3\2\2\2\u010b\u00f0\3\2\2\2\u010b"+
		"\u00fc\3\2\2\2\u010c\27\3\2\2\2\u010d\u010e\t\3\2\2\u010e\u0118\5\u00b0"+
		"Y\2\u010f\u0110\7\30\2\2\u0110\u0115\5\32\16\2\u0111\u0112\7\24\2\2\u0112"+
		"\u0114\5\32\16\2\u0113\u0111\3\2\2\2\u0114\u0117\3\2\2\2\u0115\u0113\3"+
		"\2\2\2\u0115\u0116\3\2\2\2\u0116\u0119\3\2\2\2\u0117\u0115\3\2\2\2\u0118"+
		"\u010f\3\2\2\2\u0118\u0119\3\2\2\2\u0119\u011a\3\2\2\2\u011a\u011e\7\16"+
		"\2\2\u011b\u011d\5\34\17\2\u011c\u011b\3\2\2\2\u011d\u0120\3\2\2\2\u011e"+
		"\u011c\3\2\2\2\u011e\u011f\3\2\2\2\u011f\u0121\3\2\2\2\u0120\u011e\3\2"+
		"\2\2\u0121\u0122\7\17\2\2\u0122\31\3\2\2\2\u0123\u012f\5F$\2\u0124\u0125"+
		"\7\31\2\2\u0125\u012a\5t;\2\u0126\u0127\7\24\2\2\u0127\u0129\5t;\2\u0128"+
		"\u0126\3\2\2\2\u0129\u012c\3\2\2\2\u012a\u0128\3\2\2\2\u012a\u012b\3\2"+
		"\2\2\u012b\u012d\3\2\2\2\u012c\u012a\3\2\2\2\u012d\u012e\7\32\2\2\u012e"+
		"\u0130\3\2\2\2\u012f\u0124\3\2\2\2\u012f\u0130\3\2\2\2\u0130\33\3\2\2"+
		"\2\u0131\u013a\5\36\20\2\u0132\u013a\5 \21\2\u0133\u013a\5\"\22\2\u0134"+
		"\u013a\5$\23\2\u0135\u013a\5&\24\2\u0136\u013a\5*\26\2\u0137\u013a\5\60"+
		"\31\2\u0138\u013a\5\64\33\2\u0139\u0131\3\2\2\2\u0139\u0132\3\2\2\2\u0139"+
		"\u0133\3\2\2\2\u0139\u0134\3\2\2\2\u0139\u0135\3\2\2\2\u0139\u0136\3\2"+
		"\2\2\u0139\u0137\3\2\2\2\u0139\u0138\3\2\2\2\u013a\35\3\2\2\2\u013b\u013f"+
		"\5D#\2\u013c\u013e\t\4\2\2\u013d\u013c\3\2\2\2\u013e\u0141\3\2\2\2\u013f"+
		"\u013d\3\2\2\2\u013f\u0140\3\2\2\2\u0140\u0142\3\2\2\2\u0141\u013f\3\2"+
		"\2\2\u0142\u0145\5\u00b0Y\2\u0143\u0144\7\13\2\2\u0144\u0146\5t;\2\u0145"+
		"\u0143\3\2\2\2\u0145\u0146\3\2\2\2\u0146\u0147\3\2\2\2\u0147\u0148\7\4"+
		"\2\2\u0148\37\3\2\2\2\u0149\u014a\7\33\2\2\u014a\u014b\5\u00b0Y\2\u014b"+
		"\u014e\7\34\2\2\u014c\u014f\7\22\2\2\u014d\u014f\5D#\2\u014e\u014c\3\2"+
		"\2\2\u014e\u014d\3\2\2\2\u014f\u0150\3\2\2\2\u0150\u0151\7\4\2\2\u0151"+
		"!\3\2\2\2\u0152\u0153\7\35\2\2\u0153\u0154\5\u00b0Y\2\u0154\u015f\7\16"+
		"\2\2\u0155\u0156\5B\"\2\u0156\u015c\7\4\2\2\u0157\u0158\5B\"\2\u0158\u0159"+
		"\7\4\2\2\u0159\u015b\3\2\2\2\u015a\u0157\3\2\2\2\u015b\u015e\3\2\2\2\u015c"+
		"\u015a\3\2\2\2\u015c\u015d\3\2\2\2\u015d\u0160\3\2\2\2\u015e\u015c\3\2"+
		"\2\2\u015f\u0155\3\2\2\2\u015f\u0160\3\2\2\2\u0160\u0161\3\2\2\2\u0161"+
		"\u0162\7\17\2\2\u0162#\3\2\2\2\u0163\u0164\7\36\2\2\u0164\u0165\5\66\34"+
		"\2\u0165\u0166\5.\30\2\u0166\u0167\5P)\2\u0167%\3\2\2\2\u0168\u0169\7"+
		"\37\2\2\u0169\u016b\5\u00b0Y\2\u016a\u016c\5\66\34\2\u016b\u016a\3\2\2"+
		"\2\u016b\u016c\3\2\2\2\u016c\u016d\3\2\2\2\u016d\u016e\5P)\2\u016e\'\3"+
		"\2\2\2\u016f\u0175\5\u00b0Y\2\u0170\u0172\7\31\2\2\u0171\u0173\5|?\2\u0172"+
		"\u0171\3\2\2\2\u0172\u0173\3\2\2\2\u0173\u0174\3\2\2\2\u0174\u0176\7\32"+
		"\2\2\u0175\u0170\3\2\2\2\u0175\u0176\3\2\2\2\u0176)\3\2\2\2\u0177\u0179"+
		"\7 \2\2\u0178\u017a\5\u00b0Y\2\u0179\u0178\3\2\2\2\u0179\u017a\3\2\2\2"+
		"\u017a\u017b\3\2\2\2\u017b\u017c\5\66\34\2\u017c\u017e\5.\30\2\u017d\u017f"+
		"\5,\27\2\u017e\u017d\3\2\2\2\u017e\u017f\3\2\2\2\u017f\u0182\3\2\2\2\u0180"+
		"\u0183\7\4\2\2\u0181\u0183\5P)\2\u0182\u0180\3\2\2\2\u0182\u0181\3\2\2"+
		"\2\u0183+\3\2\2\2\u0184\u0185\7!\2\2\u0185\u0186\5\66\34\2\u0186-\3\2"+
		"\2\2\u0187\u018e\5(\25\2\u0188\u018e\5N(\2\u0189\u018e\7q\2\2\u018a\u018e"+
		"\7v\2\2\u018b\u018e\7s\2\2\u018c\u018e\7u\2\2\u018d\u0187\3\2\2\2\u018d"+
		"\u0188\3\2\2\2\u018d\u0189\3\2\2\2\u018d\u018a\3\2\2\2\u018d\u018b\3\2"+
		"\2\2\u018d\u018c\3\2\2\2\u018e\u0191\3\2\2\2\u018f\u018d\3\2\2\2\u018f"+
		"\u0190\3\2\2\2\u0190/\3\2\2\2\u0191\u018f\3\2\2\2\u0192\u0193\7\"\2\2"+
		"\u0193\u0194\5\u00b0Y\2\u0194\u0196\5:\36\2\u0195\u0197\7m\2\2\u0196\u0195"+
		"\3\2\2\2\u0196\u0197\3\2\2\2\u0197\u0198\3\2\2\2\u0198\u0199\7\4\2\2\u0199"+
		"\61\3\2\2\2\u019a\u019b\5\u00b0Y\2\u019b\63\3\2\2\2\u019c\u019d\7#\2\2"+
		"\u019d\u019e\5\u00b0Y\2\u019e\u01a0\7\16\2\2\u019f\u01a1\5\62\32\2\u01a0"+
		"\u019f\3\2\2\2\u01a0\u01a1\3\2\2\2\u01a1\u01a6\3\2\2\2\u01a2\u01a3\7\24"+
		"\2\2\u01a3\u01a5\5\62\32\2\u01a4\u01a2\3\2\2\2\u01a5\u01a8\3\2\2\2\u01a6"+
		"\u01a4\3\2\2\2\u01a6\u01a7\3\2\2\2\u01a7\u01a9\3\2\2\2\u01a8\u01a6\3\2"+
		"\2\2\u01a9\u01aa\7\17\2\2\u01aa\65\3\2\2\2\u01ab\u01b4\7\31\2\2\u01ac"+
		"\u01b1\58\35\2\u01ad\u01ae\7\24\2\2\u01ae\u01b0\58\35\2\u01af\u01ad\3"+
		"\2\2\2\u01b0\u01b3\3\2\2\2\u01b1\u01af\3\2\2\2\u01b1\u01b2\3\2\2\2\u01b2"+
		"\u01b5\3\2\2\2\u01b3\u01b1\3\2\2\2\u01b4\u01ac\3\2\2\2\u01b4\u01b5\3\2"+
		"\2\2\u01b5\u01b6\3\2\2\2\u01b6\u01b7\7\32\2\2\u01b7\67\3\2\2\2\u01b8\u01ba"+
		"\5D#\2\u01b9\u01bb\5L\'\2\u01ba\u01b9\3\2\2\2\u01ba\u01bb\3\2\2\2\u01bb"+
		"\u01bd\3\2\2\2\u01bc\u01be\5\u00b0Y\2\u01bd\u01bc\3\2\2\2\u01bd\u01be"+
		"\3\2\2\2\u01be9\3\2\2\2\u01bf\u01c8\7\31\2\2\u01c0\u01c5\5<\37\2\u01c1"+
		"\u01c2\7\24\2\2\u01c2\u01c4\5<\37\2\u01c3\u01c1\3\2\2\2\u01c4\u01c7\3"+
		"\2\2\2\u01c5\u01c3\3\2\2\2\u01c5\u01c6\3\2\2\2\u01c6\u01c9\3\2\2\2\u01c7"+
		"\u01c5\3\2\2\2\u01c8\u01c0\3\2\2\2\u01c8\u01c9\3\2\2\2\u01c9\u01ca\3\2"+
		"\2\2\u01ca\u01cb\7\32\2\2\u01cb;\3\2\2\2\u01cc\u01ce\5D#\2\u01cd\u01cf"+
		"\7r\2\2\u01ce\u01cd\3\2\2\2\u01ce\u01cf\3\2\2\2\u01cf\u01d1\3\2\2\2\u01d0"+
		"\u01d2\5\u00b0Y\2\u01d1\u01d0\3\2\2\2\u01d1\u01d2\3\2\2\2\u01d2=\3\2\2"+
		"\2\u01d3\u01dc\7\31\2\2\u01d4\u01d9\5@!\2\u01d5\u01d6\7\24\2\2\u01d6\u01d8"+
		"\5@!\2\u01d7\u01d5\3\2\2\2\u01d8\u01db\3\2\2\2\u01d9\u01d7\3\2\2\2\u01d9"+
		"\u01da\3\2\2\2\u01da\u01dd\3\2\2\2\u01db\u01d9\3\2\2\2\u01dc\u01d4\3\2"+
		"\2\2\u01dc\u01dd\3\2\2\2\u01dd\u01de\3\2\2\2\u01de\u01df\7\32\2\2\u01df"+
		"?\3\2\2\2\u01e0\u01e2\5D#\2\u01e1\u01e3\5L\'\2\u01e2\u01e1\3\2\2\2\u01e2"+
		"\u01e3\3\2\2\2\u01e3A\3\2\2\2\u01e4\u01e6\5D#\2\u01e5\u01e7\5L\'\2\u01e6"+
		"\u01e5\3\2\2\2\u01e6\u01e7\3\2\2\2\u01e7\u01e8\3\2\2\2\u01e8\u01e9\5\u00b0"+
		"Y\2\u01e9C\3\2\2\2\u01ea\u01eb\b#\1\2\u01eb\u01f2\5r:\2\u01ec\u01f2\5"+
		"F$\2\u01ed\u01f2\5H%\2\u01ee\u01f2\5J&\2\u01ef\u01f0\7&\2\2\u01f0\u01f2"+
		"\7t\2\2\u01f1\u01ea\3\2\2\2\u01f1\u01ec\3\2\2\2\u01f1\u01ed\3\2\2\2\u01f1"+
		"\u01ee\3\2\2\2\u01f1\u01ef\3\2\2\2\u01f2\u01fb\3\2\2\2\u01f3\u01f4\f\5"+
		"\2\2\u01f4\u01f6\7$\2\2\u01f5\u01f7\5t;\2\u01f6\u01f5\3\2\2\2\u01f6\u01f7"+
		"\3\2\2\2\u01f7\u01f8\3\2\2\2\u01f8\u01fa\7%\2\2\u01f9\u01f3\3\2\2\2\u01fa"+
		"\u01fd\3\2\2\2\u01fb\u01f9\3\2\2\2\u01fb\u01fc\3\2\2\2\u01fcE\3\2\2\2"+
		"\u01fd\u01fb\3\2\2\2\u01fe\u0203\5\u00b0Y\2\u01ff\u0200\7\'\2\2\u0200"+
		"\u0202\5\u00b0Y\2\u0201\u01ff\3\2\2\2\u0202\u0205\3\2\2\2\u0203\u0201"+
		"\3\2\2\2\u0203\u0204\3\2\2\2\u0204G\3\2\2\2\u0205\u0203\3\2\2\2\u0206"+
		"\u0207\7(\2\2\u0207\u0208\7\31\2\2\u0208\u0209\5r:\2\u0209\u020a\7)\2"+
		"\2\u020a\u020b\5D#\2\u020b\u020c\7\32\2\2\u020cI\3\2\2\2\u020d\u020e\7"+
		" \2\2\u020e\u0214\5> \2\u020f\u0213\7s\2\2\u0210\u0213\7q\2\2\u0211\u0213"+
		"\5N(\2\u0212\u020f\3\2\2\2\u0212\u0210\3\2\2\2\u0212\u0211\3\2\2\2\u0213"+
		"\u0216\3\2\2\2\u0214\u0212\3\2\2\2\u0214\u0215\3\2\2\2\u0215\u0219\3\2"+
		"\2\2\u0216\u0214\3\2\2\2\u0217\u0218\7!\2\2\u0218\u021a\5> \2\u0219\u0217"+
		"\3\2\2\2\u0219\u021a\3\2\2\2\u021aK\3\2\2\2\u021b\u021c\t\5\2\2\u021c"+
		"M\3\2\2\2\u021d\u021e\t\6\2\2\u021eO\3\2\2\2\u021f\u0223\7\16\2\2\u0220"+
		"\u0222\5R*\2\u0221\u0220\3\2\2\2\u0222\u0225\3\2\2\2\u0223\u0221\3\2\2"+
		"\2\u0223\u0224\3\2\2\2\u0224\u0226\3\2\2\2\u0225\u0223\3\2\2\2\u0226\u0227"+
		"\7\17\2\2\u0227Q\3\2\2\2\u0228\u0235\5V,\2\u0229\u0235\5X-\2\u022a\u0235"+
		"\5\\/\2\u022b\u0235\5P)\2\u022c\u0235\5^\60\2\u022d\u0235\5`\61\2\u022e"+
		"\u0235\5b\62\2\u022f\u0235\5d\63\2\u0230\u0235\5f\64\2\u0231\u0235\5h"+
		"\65\2\u0232\u0235\5j\66\2\u0233\u0235\5Z.\2\u0234\u0228\3\2\2\2\u0234"+
		"\u0229\3\2\2\2\u0234\u022a\3\2\2\2\u0234\u022b\3\2\2\2\u0234\u022c\3\2"+
		"\2\2\u0234\u022d\3\2\2\2\u0234\u022e\3\2\2\2\u0234\u022f\3\2\2\2\u0234"+
		"\u0230\3\2\2\2\u0234\u0231\3\2\2\2\u0234\u0232\3\2\2\2\u0234\u0233\3\2"+
		"\2\2\u0235S\3\2\2\2\u0236\u0237\5t;\2\u0237\u0238\7\4\2\2\u0238U\3\2\2"+
		"\2\u0239\u023a\7-\2\2\u023a\u023b\7\31\2\2\u023b\u023c\5t;\2\u023c\u023d"+
		"\7\32\2\2\u023d\u0240\5R*\2\u023e\u023f\7.\2\2\u023f\u0241\5R*\2\u0240"+
		"\u023e\3\2\2\2\u0240\u0241\3\2\2\2\u0241W\3\2\2\2\u0242\u0243\7/\2\2\u0243"+
		"\u0244\7\31\2\2\u0244\u0245\5t;\2\u0245\u0246\7\32\2\2\u0246\u0247\5R"+
		"*\2\u0247Y\3\2\2\2\u0248\u024b\5l\67\2\u0249\u024b\5T+\2\u024a\u0248\3"+
		"\2\2\2\u024a\u0249\3\2\2\2\u024b[\3\2\2\2\u024c\u024d\7\34\2\2\u024d\u0250"+
		"\7\31\2\2\u024e\u0251\5Z.\2\u024f\u0251\7\4\2\2\u0250\u024e\3\2\2\2\u0250"+
		"\u024f\3\2\2\2\u0251\u0253\3\2\2\2\u0252\u0254\5t;\2\u0253\u0252\3\2\2"+
		"\2\u0253\u0254\3\2\2\2\u0254\u0255\3\2\2\2\u0255\u0257\7\4\2\2\u0256\u0258"+
		"\5t;\2\u0257\u0256\3\2\2\2\u0257\u0258\3\2\2\2\u0258\u0259\3\2\2\2\u0259"+
		"\u025a\7\32\2\2\u025a\u025b\5R*\2\u025b]\3\2\2\2\u025c\u025e\7\60\2\2"+
		"\u025d\u025f\7z\2\2\u025e\u025d\3\2\2\2\u025e\u025f\3\2\2\2\u025f\u0260"+
		"\3\2\2\2\u0260\u0261\5\u0086D\2\u0261_\3\2\2\2\u0262\u0263\7\61\2\2\u0263"+
		"\u0264\5R*\2\u0264\u0265\7/\2\2\u0265\u0266\7\31\2\2\u0266\u0267\5t;\2"+
		"\u0267\u0268\7\32\2\2\u0268\u0269\7\4\2\2\u0269a\3\2\2\2\u026a\u026b\7"+
		"p\2\2\u026b\u026c\7\4\2\2\u026cc\3\2\2\2\u026d\u026e\7n\2\2\u026e\u026f"+
		"\7\4\2\2\u026fe\3\2\2\2\u0270\u0272\7\62\2\2\u0271\u0273\5t;\2\u0272\u0271"+
		"\3\2\2\2\u0272\u0273\3\2\2\2\u0273\u0274\3\2\2\2\u0274\u0275\7\4\2\2\u0275"+
		"g\3\2\2\2\u0276\u0277\7\63\2\2\u0277\u0278\7\4\2\2\u0278i\3\2\2\2\u0279"+
		"\u027a\7\64\2\2\u027a\u027b\5\u0084C\2\u027b\u027c\7\4\2\2\u027ck\3\2"+
		"\2\2\u027d\u027e\7\65\2\2\u027e\u0285\5p9\2\u027f\u0285\5B\"\2\u0280\u0281"+
		"\7\31\2\2\u0281\u0282\5n8\2\u0282\u0283\7\32\2\2\u0283\u0285\3\2\2\2\u0284"+
		"\u027d\3\2\2\2\u0284\u027f\3\2\2\2\u0284\u0280\3\2\2\2\u0285\u0288\3\2"+
		"\2\2\u0286\u0287\7\13\2\2\u0287\u0289\5t;\2\u0288\u0286\3\2\2\2\u0288"+
		"\u0289\3\2\2\2\u0289\u028a\3\2\2\2\u028a\u028b\7\4\2\2\u028bm\3\2\2\2"+
		"\u028c\u028e\5B\"\2\u028d\u028c\3\2\2\2\u028d\u028e\3\2\2\2\u028e\u0295"+
		"\3\2\2\2\u028f\u0291\7\24\2\2\u0290\u0292\5B\"\2\u0291\u0290\3\2\2\2\u0291"+
		"\u0292\3\2\2\2\u0292\u0294\3\2\2\2\u0293\u028f\3\2\2\2\u0294\u0297\3\2"+
		"\2\2\u0295\u0293\3\2\2\2\u0295\u0296\3\2\2\2\u0296o\3\2\2\2\u0297\u0295"+
		"\3\2\2\2\u0298\u029f\7\31\2\2\u0299\u029b\5\u00b0Y\2\u029a\u0299\3\2\2"+
		"\2\u029a\u029b\3\2\2\2\u029b\u029c\3\2\2\2\u029c\u029e\7\24\2\2\u029d"+
		"\u029a\3\2\2\2\u029e\u02a1\3\2\2\2\u029f\u029d\3\2\2\2\u029f\u02a0\3\2"+
		"\2\2\u02a0\u02a3\3\2\2\2\u02a1\u029f\3\2\2\2\u02a2\u02a4\5\u00b0Y\2\u02a3"+
		"\u02a2\3\2\2\2\u02a3\u02a4\3\2\2\2\u02a4\u02a5\3\2\2\2\u02a5\u02a6\7\32"+
		"\2\2\u02a6q\3\2\2\2\u02a7\u02a8\t\7\2\2\u02a8s\3\2\2\2\u02a9\u02aa\b;"+
		"\1\2\u02aa\u02ab\7;\2\2\u02ab\u02be\5D#\2\u02ac\u02ad\7\31\2\2\u02ad\u02ae"+
		"\5t;\2\u02ae\u02af\7\32\2\2\u02af\u02be\3\2\2\2\u02b0\u02b1\t\b\2\2\u02b1"+
		"\u02be\5t;\27\u02b2\u02b3\t\t\2\2\u02b3\u02be\5t;\26\u02b4\u02b5\t\n\2"+
		"\2\u02b5\u02be\5t;\25\u02b6\u02b7\7@\2\2\u02b7\u02be\5t;\24\u02b8\u02b9"+
		"\7\6\2\2\u02b9\u02be\5t;\23\u02ba\u02be\5v<\2\u02bb\u02be\5x=\2\u02bc"+
		"\u02be\5z>\2\u02bd\u02a9\3\2\2\2\u02bd\u02ac\3\2\2\2\u02bd\u02b0\3\2\2"+
		"\2\u02bd\u02b2\3\2\2\2\u02bd\u02b4\3\2\2\2\u02bd\u02b6\3\2\2\2\u02bd\u02b8"+
		"\3\2\2\2\u02bd\u02ba\3\2\2\2\u02bd\u02bb\3\2\2\2\u02bd\u02bc\3\2\2\2\u02be"+
		"\u02fa\3\2\2\2\u02bf\u02c0\f\22\2\2\u02c0\u02c1\7A\2\2\u02c1\u02f9\5t"+
		";\23\u02c2\u02c3\f\21\2\2\u02c3\u02c4\t\13\2\2\u02c4\u02f9\5t;\22\u02c5"+
		"\u02c6\f\20\2\2\u02c6\u02c7\t\t\2\2\u02c7\u02f9\5t;\21\u02c8\u02c9\f\17"+
		"\2\2\u02c9\u02ca\t\f\2\2\u02ca\u02f9\5t;\20\u02cb\u02cc\f\16\2\2\u02cc"+
		"\u02cd\7F\2\2\u02cd\u02f9\5t;\17\u02ce\u02cf\f\r\2\2\u02cf\u02d0\7\5\2"+
		"\2\u02d0\u02f9\5t;\16\u02d1\u02d2\f\f\2\2\u02d2\u02d3\7G\2\2\u02d3\u02f9"+
		"\5t;\r\u02d4\u02d5\f\13\2\2\u02d5\u02d6\t\r\2\2\u02d6\u02f9\5t;\f\u02d7"+
		"\u02d8\f\n\2\2\u02d8\u02d9\t\16\2\2\u02d9\u02f9\5t;\13\u02da\u02db\f\t"+
		"\2\2\u02db\u02dc\7J\2\2\u02dc\u02f9\5t;\n\u02dd\u02de\f\b\2\2\u02de\u02df"+
		"\7K\2\2\u02df\u02f9\5t;\t\u02e0\u02e1\f\7\2\2\u02e1\u02e2\7L\2\2\u02e2"+
		"\u02e3\5t;\2\u02e3\u02e4\7M\2\2\u02e4\u02e5\5t;\b\u02e5\u02f9\3\2\2\2"+
		"\u02e6\u02e7\f\6\2\2\u02e7\u02e8\t\17\2\2\u02e8\u02f9\5t;\7\u02e9\u02ea"+
		"\f\35\2\2\u02ea\u02f9\t\b\2\2\u02eb\u02ec\f\33\2\2\u02ec\u02ed\7$\2\2"+
		"\u02ed\u02ee\5t;\2\u02ee\u02ef\7%\2\2\u02ef\u02f9\3\2\2\2\u02f0\u02f1"+
		"\f\32\2\2\u02f1\u02f2\7\31\2\2\u02f2\u02f3\5\u0082B\2\u02f3\u02f4\7\32"+
		"\2\2\u02f4\u02f9\3\2\2\2\u02f5\u02f6\f\31\2\2\u02f6\u02f7\7\'\2\2\u02f7"+
		"\u02f9\5\u00b0Y\2\u02f8\u02bf\3\2\2\2\u02f8\u02c2\3\2\2\2\u02f8\u02c5"+
		"\3\2\2\2\u02f8\u02c8\3\2\2\2\u02f8\u02cb\3\2\2\2\u02f8\u02ce\3\2\2\2\u02f8"+
		"\u02d1\3\2\2\2\u02f8\u02d4\3\2\2\2\u02f8\u02d7\3\2\2\2\u02f8\u02da\3\2"+
		"\2\2\u02f8\u02dd\3\2\2\2\u02f8\u02e0\3\2\2\2\u02f8\u02e6\3\2\2\2\u02f8"+
		"\u02e9\3\2\2\2\u02f8\u02eb\3\2\2\2\u02f8\u02f0\3\2\2\2\u02f8\u02f5\3\2"+
		"\2\2\u02f9\u02fc\3\2\2\2\u02fa\u02f8\3\2\2\2\u02fa\u02fb\3\2\2\2\u02fb"+
		"u\3\2\2\2\u02fc\u02fa\3\2\2\2\u02fd\u02fe\7X\2\2\u02fe\u02ff\5\u00b0Y"+
		"\2\u02ff\u0300\7\24\2\2\u0300\u0301\5t;\2\u0301w\3\2\2\2\u0302\u0303\7"+
		"Y\2\2\u0303\u0304\5\u00b0Y\2\u0304\u0305\7\24\2\2\u0305\u0306\5t;\2\u0306"+
		"\u0307\7\24\2\2\u0307\u0308\5t;\2\u0308y\3\2\2\2\u0309\u0311\7g\2\2\u030a"+
		"\u0311\5\u00aeX\2\u030b\u0311\7k\2\2\u030c\u0311\7z\2\2\u030d\u0311\5"+
		"\u00b0Y\2\u030e\u0311\5\u00aaV\2\u030f\u0311\5\u00acW\2\u0310\u0309\3"+
		"\2\2\2\u0310\u030a\3\2\2\2\u0310\u030b\3\2\2\2\u0310\u030c\3\2\2\2\u0310"+
		"\u030d\3\2\2\2\u0310\u030e\3\2\2\2\u0310\u030f\3\2\2\2\u0311{\3\2\2\2"+
		"\u0312\u0317\5t;\2\u0313\u0314\7\24\2\2\u0314\u0316\5t;\2\u0315\u0313"+
		"\3\2\2\2\u0316\u0319\3\2\2\2\u0317\u0315\3\2\2\2\u0317\u0318\3\2\2\2\u0318"+
		"}\3\2\2\2\u0319\u0317\3\2\2\2\u031a\u031f\5\u0080A\2\u031b\u031c\7\24"+
		"\2\2\u031c\u031e\5\u0080A\2\u031d\u031b\3\2\2\2\u031e\u0321\3\2\2\2\u031f"+
		"\u031d\3\2\2\2\u031f\u0320\3\2\2\2\u0320\u0323\3\2\2\2\u0321\u031f\3\2"+
		"\2\2\u0322\u0324\7\24\2\2\u0323\u0322\3\2\2\2\u0323\u0324\3\2\2\2\u0324"+
		"\177\3\2\2\2\u0325\u0326\5\u00b0Y\2\u0326\u0327\7M\2\2\u0327\u0328\5t"+
		";\2\u0328\u0081\3\2\2\2\u0329\u032b\7\16\2\2\u032a\u032c\5~@\2\u032b\u032a"+
		"\3\2\2\2\u032b\u032c\3\2\2\2\u032c\u032d\3\2\2\2\u032d\u0332\7\17\2\2"+
		"\u032e\u0330\5|?\2\u032f\u032e\3\2\2\2\u032f\u0330\3\2\2\2\u0330\u0332"+
		"\3\2\2\2\u0331\u0329\3\2\2\2\u0331\u032f\3\2\2\2\u0332\u0083\3\2\2\2\u0333"+
		"\u0334\5t;\2\u0334\u0335\7\31\2\2\u0335\u0336\5\u0082B\2\u0336\u0337\7"+
		"\32\2\2\u0337\u0085\3\2\2\2\u0338\u033c\7\16\2\2\u0339\u033b\5\u0088E"+
		"\2\u033a\u0339\3\2\2\2\u033b\u033e\3\2\2\2\u033c\u033a\3\2\2\2\u033c\u033d"+
		"\3\2\2\2\u033d\u033f\3\2\2\2\u033e\u033c\3\2\2\2\u033f\u0340\7\17\2\2"+
		"\u0340\u0087\3\2\2\2\u0341\u0353\5\u00b0Y\2\u0342\u0353\5\u0086D\2\u0343"+
		"\u0353\5\u008aF\2\u0344\u0353\5\u008eH\2\u0345\u0353\5\u0090I\2\u0346"+
		"\u0353\5\u0096L\2\u0347\u0353\5\u0098M\2\u0348\u0353\5\u009aN\2\u0349"+
		"\u0353\5\u009eP\2\u034a\u0353\5\u00a2R\2\u034b\u0353\5\u00a4S\2\u034c"+
		"\u0353\7n\2\2\u034d\u0353\7p\2\2\u034e\u0353\5\u00a8U\2\u034f\u0353\5"+
		"\u00aeX\2\u0350\u0353\7z\2\2\u0351\u0353\7k\2\2\u0352\u0341\3\2\2\2\u0352"+
		"\u0342\3\2\2\2\u0352\u0343\3\2\2\2\u0352\u0344\3\2\2\2\u0352\u0345\3\2"+
		"\2\2\u0352\u0346\3\2\2\2\u0352\u0347\3\2\2\2\u0352\u0348\3\2\2\2\u0352"+
		"\u0349\3\2\2\2\u0352\u034a\3\2\2\2\u0352\u034b\3\2\2\2\u0352\u034c\3\2"+
		"\2\2\u0352\u034d\3\2\2\2\u0352\u034e\3\2\2\2\u0352\u034f\3\2\2\2\u0352"+
		"\u0350\3\2\2\2\u0352\u0351\3\2\2\2\u0353\u0089\3\2\2\2\u0354\u0357\5\u008c"+
		"G\2\u0355\u0357\5\u00a6T\2\u0356\u0354\3\2\2\2\u0356\u0355\3\2\2\2\u0357"+
		"\u008b\3\2\2\2\u0358\u035d\7\62\2\2\u0359\u035d\7&\2\2\u035a\u035d\78"+
		"\2\2\u035b\u035d\5\u00b0Y\2\u035c\u0358\3\2\2\2\u035c\u0359\3\2\2\2\u035c"+
		"\u035a\3\2\2\2\u035c\u035b\3\2\2\2\u035d\u036a\3\2\2\2\u035e\u0360\7\31"+
		"\2\2\u035f\u0361\5\u008aF\2\u0360\u035f\3\2\2\2\u0360\u0361\3\2\2\2\u0361"+
		"\u0366\3\2\2\2\u0362\u0363\7\24\2\2\u0363\u0365\5\u008aF\2\u0364\u0362"+
		"\3\2\2\2\u0365\u0368\3\2\2\2\u0366\u0364\3\2\2\2\u0366\u0367\3\2\2\2\u0367"+
		"\u0369\3\2\2\2\u0368\u0366\3\2\2\2\u0369\u036b\7\32\2\2\u036a\u035e\3"+
		"\2\2\2\u036a\u036b\3\2\2\2\u036b\u008d\3\2\2\2\u036c\u036d\7Z\2\2\u036d"+
		"\u0370\5\u0092J\2\u036e\u036f\7[\2\2\u036f\u0371\5\u008aF\2\u0370\u036e"+
		"\3\2\2\2\u0370\u0371\3\2\2\2\u0371\u008f\3\2\2\2\u0372\u0373\5\u0092J"+
		"\2\u0373\u0374\7[\2\2\u0374\u0375\5\u008aF\2\u0375\u0091\3\2\2\2\u0376"+
		"\u037c\5\u00b0Y\2\u0377\u0378\7\31\2\2\u0378\u0379\5\u0094K\2\u0379\u037a"+
		"\7\32\2\2\u037a\u037c\3\2\2\2\u037b\u0376\3\2\2\2\u037b\u0377\3\2\2\2"+
		"\u037c\u0093\3\2\2\2\u037d\u0382\5\u00b0Y\2\u037e\u037f\7\24\2\2\u037f"+
		"\u0381\5\u00b0Y\2\u0380\u037e\3\2\2\2\u0381\u0384\3\2\2\2\u0382\u0380"+
		"\3\2\2\2\u0382\u0383\3\2\2\2\u0383\u0095\3\2\2\2\u0384\u0382\3\2\2\2\u0385"+
		"\u0386\7\\\2\2\u0386\u0387\5\u00b0Y\2\u0387\u0097\3\2\2\2\u0388\u0389"+
		"\5\u00b0Y\2\u0389\u038a\7M\2\2\u038a\u0099\3\2\2\2\u038b\u038c\7]\2\2"+
		"\u038c\u0390\5\u008aF\2\u038d\u038f\5\u009cO\2\u038e\u038d\3\2\2\2\u038f"+
		"\u0392\3\2\2\2\u0390\u038e\3\2\2\2\u0390\u0391\3\2\2\2\u0391\u009b\3\2"+
		"\2\2\u0392\u0390\3\2\2\2\u0393\u0394\7^\2\2\u0394\u0395\5\u00a6T\2\u0395"+
		"\u0396\5\u0086D\2\u0396\u039a\3\2\2\2\u0397\u0398\7_\2\2\u0398\u039a\5"+
		"\u0086D\2\u0399\u0393\3\2\2\2\u0399\u0397\3\2\2\2\u039a\u009d\3\2\2\2"+
		"\u039b\u039c\7 \2\2\u039c\u039d\5\u00b0Y\2\u039d\u039f\7\31\2\2\u039e"+
		"\u03a0\5\u0094K\2\u039f\u039e\3\2\2\2\u039f\u03a0\3\2\2\2\u03a0\u03a1"+
		"\3\2\2\2\u03a1\u03a3\7\32\2\2\u03a2\u03a4\5\u00a0Q\2\u03a3\u03a2\3\2\2"+
		"\2\u03a3\u03a4\3\2\2\2\u03a4\u03a5\3\2\2\2\u03a5\u03a6\5\u0086D\2\u03a6"+
		"\u009f\3\2\2\2\u03a7\u03a8\7`\2\2\u03a8\u03a9\5\u0094K\2\u03a9\u00a1\3"+
		"\2\2\2\u03aa\u03ad\7\34\2\2\u03ab\u03ae\5\u0086D\2\u03ac\u03ae\5\u008a"+
		"F\2\u03ad\u03ab\3\2\2\2\u03ad\u03ac\3\2\2\2\u03ae\u03af\3\2\2\2\u03af"+
		"\u03b2\5\u008aF\2\u03b0\u03b3\5\u0086D\2\u03b1\u03b3\5\u008aF\2\u03b2"+
		"\u03b0\3\2\2\2\u03b2\u03b1\3\2\2\2\u03b3\u03b4\3\2\2\2\u03b4\u03b5\5\u0086"+
		"D\2\u03b5\u00a3\3\2\2\2\u03b6\u03b7\7-\2\2\u03b7\u03b8\5\u008aF\2\u03b8"+
		"\u03b9\5\u0086D\2\u03b9\u00a5\3\2\2\2\u03ba\u03bb\t\20\2\2\u03bb\u00a7"+
		"\3\2\2\2\u03bc\u03bd\7\60\2\2\u03bd\u03be\5\u00b0Y\2\u03be\u03bf\5\u0086"+
		"D\2\u03bf\u00a9\3\2\2\2\u03c0\u03c2\7\31\2\2\u03c1\u03c3\5t;\2\u03c2\u03c1"+
		"\3\2\2\2\u03c2\u03c3\3\2\2\2\u03c3\u03ca\3\2\2\2\u03c4\u03c6\7\24\2\2"+
		"\u03c5\u03c7\5t;\2\u03c6\u03c5\3\2\2\2\u03c6\u03c7\3\2\2\2\u03c7\u03c9"+
		"\3\2\2\2\u03c8\u03c4\3\2\2\2\u03c9\u03cc\3\2\2\2\u03ca\u03c8\3\2\2\2\u03ca"+
		"\u03cb\3\2\2\2\u03cb\u03cd\3\2\2\2\u03cc\u03ca\3\2\2\2\u03cd\u03db\7\32"+
		"\2\2\u03ce\u03d7\7$\2\2\u03cf\u03d4\5t;\2\u03d0\u03d1\7\24\2\2\u03d1\u03d3"+
		"\5t;\2\u03d2\u03d0\3\2\2\2\u03d3\u03d6\3\2\2\2\u03d4\u03d2\3\2\2\2\u03d4"+
		"\u03d5\3\2\2\2\u03d5\u03d8\3\2\2\2\u03d6\u03d4\3\2\2\2\u03d7\u03cf\3\2"+
		"\2\2\u03d7\u03d8\3\2\2\2\u03d8\u03d9\3\2\2\2\u03d9\u03db\7%\2\2\u03da"+
		"\u03c0\3\2\2\2\u03da\u03ce\3\2\2\2\u03db\u00ab\3\2\2\2\u03dc\u03dd\5r"+
		":\2\u03dd\u00ad\3\2\2\2\u03de\u03e0\t\21\2\2\u03df\u03e1\7j\2\2\u03e0"+
		"\u03df\3\2\2\2\u03e0\u03e1\3\2\2\2\u03e1\u00af\3\2\2\2\u03e2\u03e3\t\22"+
		"\2\2\u03e3\u00b1\3\2\2\2i\u00b6\u00b8\u00c6\u00ca\u00cf\u00d6\u00de\u00ed"+
		"\u00f3\u00f7\u0103\u010b\u0115\u0118\u011e\u012a\u012f\u0139\u013f\u0145"+
		"\u014e\u015c\u015f\u016b\u0172\u0175\u0179\u017e\u0182\u018d\u018f\u0196"+
		"\u01a0\u01a6\u01b1\u01b4\u01ba\u01bd\u01c5\u01c8\u01ce\u01d1\u01d9\u01dc"+
		"\u01e2\u01e6\u01f1\u01f6\u01fb\u0203\u0212\u0214\u0219\u0223\u0234\u0240"+
		"\u024a\u0250\u0253\u0257\u025e\u0272\u0284\u0288\u028d\u0291\u0295\u029a"+
		"\u029f\u02a3\u02bd\u02f8\u02fa\u0310\u0317\u031f\u0323\u032b\u032f\u0331"+
		"\u033c\u0352\u0356\u035c\u0360\u0366\u036a\u0370\u037b\u0382\u0390\u0399"+
		"\u039f\u03a3\u03ad\u03b2\u03c2\u03c6\u03ca\u03d4\u03d7\u03da\u03e0";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}