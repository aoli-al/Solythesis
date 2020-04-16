# Solythesis: Securing Smart Contract with Runtime Validation

Solythesis is a novel runtime validation framework for Ethereum smart contracts that works as a source to source Solidity compiler and detects errors at runtime. Solythesis generates an instrumented smart contract from a set of invariants and rejects transactions that violate the invariants.

To run Solythesis compiler, you need to provide the smart contract source file and the constraint.
You can find our preset constraints and benchmark contracts in `./contracts` folder.


For example, to generate secured contract for BEC token, you pass the source code of BEC token as the first parameter and the constraint of ERC20 standard as second parameter.

```
node lib/src/main.js ./contracts/ERC20_BEC.sol ./contracts/ERC20_BEC_constraints.txt
```

Solythesis will generate two solidity source programs in the same folder as ERC20_BEC.sol:

- `ERC20_BEC_Solythesis_baseline.sol`: the secured smart contract using baseline instrumentation technique.
- `ERC20_BEC_Solythesis.sol`: the secured smart contract using delta update.


[![asciicast](https://asciinema.org/a/mHimX89JzZ0Cz7hGAhULFa4gH.svg)](https://asciinema.org/a/mHimX89JzZ0Cz7hGAhULFa4gH)