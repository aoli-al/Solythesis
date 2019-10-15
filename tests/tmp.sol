pragma solidity ^0.5.0;

contract test {
  mapping (uint256 => uint256) a;
  mapping (uint256 => uint256) b;
  function vote (uint issueId, uint option) public returns (bool success) {
    a[3] = 5;


    b[2] = 6;
    return false;
  }
}