/**
 * Source Code first verified at https://etherscan.io on Friday, February 9, 2018
 (UTC) */

pragma solidity ^0.5.0;

contract BecToken {
  uint256 a;
  constructor() public {
  }
  function transfer(address balance, uint256 value) public {
    uint256 tmp = a;
    for (uint256 i = 0; i < 500; i++) {
      tmp = i;
    }
    a = tmp;
  }
}
