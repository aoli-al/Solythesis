pragma solidity ^0.5.0;

contract BecToken {
  mapping (uint256 => uint256) a;

  uint256 x;

  function test(uint256 t) public returns (uint256) {
    x = a[t];
    // a[t] -= t;
    // a[a[t]] = 2;
    // return a[t];
    a[t] = 30;
    return x;
  }
}
