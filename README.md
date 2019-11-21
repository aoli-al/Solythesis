# Solythesis: Secure Smart Contract on the Fly

Solythesis is a novel runtime validation framework for Ethereum smart contracts that works as a source to source Solidity compiler and detects errors at runtime. Solythesis generates an instrumented smart contract from a set of invariants and rejects transactions that violate the invariants.

## Installation

### Dependencies
* node v12.12.0 (npm v6.11.3)
* TypeScript (tsc v3.7.2)

### Pre-requisites
Before you can build Solythesis, you must first install `surya` and `solidity-parser-antlr` and their dependencies. You can do this by navigating into the directory and run:
```
$ # ~/Solythesis/surya
$ # ~/Solythesis/solidity-parser-antlr
$ npm install 
```

You also need to run the following in the project folder:
```
$ # ~/Solythesis
$ npm install
$ npm run antlr4ts
$ npm run postinstall
```

## Running Solythesis
### Using VS Code
For VS Code, the repo has a `launch.json` that you can use to build the project and generate instrumented code. You can specify the file you want to instrument and the set of constraints in the `args:` parameter. For instance, to instrument the BEC contract:
```
"args": ["./tests/ERC20_BEC.sol", "./tests/ERC20_BEC_constraints.txt"]
```

You can go to the `Debug` tab on the left side of VS Code and launch the program. 

The instrumented contracts (naive instrumented: `Solythesis_baseline`, instrumented with no-optimizations: `Solythesis_no_optimization`, and instrumented with optimizations `Solythesis`) will be generated in the same directory as the original contract. 

### On the terminal

Run the pre-launch task:
```
tsc -p tsconfig.json
```

This will generate a `.js` file for the program. Then, you can run Solythesis to instrument any smart contract. For example, to instrument the BEC contract:
```
node lib/src/main.js ./tests/ERC20_BEC.sol ./tests/ERC20_BEC_constraints.txt
```
