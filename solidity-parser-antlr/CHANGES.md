### 0.4.4

 * Add misisng `storageLocation` to variables in VariableDeclarationStatement.
 * Return `null` for `arguments` instead of `[]` when `ModifierInvocation`
   contains no arguments and no parentheses to distinguish the two cases.
 * Improve TypeScript type definitions.

### 0.4.3

 * Improve TypeScript type definitions, thanks @Leeleo3x and @yxliang01.

### 0.4.2

 * Fix parsing of assembly function definitions with no args or return args.

### 0.4.1

 * Fix parsing of for loops with missing initial and condition statements.

### 0.4.0

 * Correctly handle non-existent tuple components. Thanks @maxsam4
 * Accept calldata as identifier

### 0.3.3

 * Add support for `address payable` typename.

### 0.3.2

 * Fix parsing of hex numbers with uppercase X.

### 0.3.1

 * Fix parsing of zero-component tuples.

### 0.3.0

 * Use `components` for all `TupleExpression` nodes. Earlier versions
   incorrectly stored tuple components under the `elements` key.
 * Fix parsing of decimal literals without integer part.
