pragma solidity ^0.5.0;
library SafeMath {
  function mul (uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
  function div (uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a / b;
    return c;
  }
  function sub (uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
  function add (uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}
contract PausableToken {
  using SafeMath for uint256;
  uint256 sum_balance;
  uint256 public totalSupply;
  mapping (address=>uint256) balances;
  mapping (address=>mapping (address=>uint256)) internal allowed;
  function batchTransfer (address[] memory _receivers, uint256 _value) public returns (bool) {
    uint cnt = _receivers.length;
    uint256 amount = uint256(cnt) * _value;
    uint256 sss = sum_balance;
    require(cnt > 0 && cnt <= 20);
    uint256 current = balances[msg.sender];
    require(_value > 0 && current >= amount);
    {
      {
        assert(sss >= current);
        sss -= current;
      }
      current = current.sub(amount);
      {
        sss += current;
        assert(sss >= current);
      }
    }
    balances[msg.sender] = current;
    for (uint i = 0; i < cnt; i++) {
      current = balances[_receivers[i]];
      {
        {
          assert(sss >= current);
          sss -= current;
        }
        current = current.add(_value);
        {
          sss += current;
          assert(sss >= current);
        }
      }
      balances[_receivers[i]] = current;
    }
    {
      sum_balance = sss;
      assert(totalSupply == sss);
      return true;
    }
    {
      sum_balance = sss;
      assert(totalSupply == sss);
    }
  }
}
contract BecToken is PausableToken {
  string public name = "BeautyChain";
  string public symbol = "BEC";
  string public version = '1.0.0';
  uint8 public decimals = 18;
  constructor () public {
    uint8 decimals = 3;
    totalSupply = 7000000000 * (10**(uint256(decimals)));
    {
      {
        assert(sum_balance >= balances[msg.sender]);
        sum_balance -= balances[msg.sender];
      }
      balances[msg.sender] = totalSupply;
      {
        sum_balance += balances[msg.sender];
        assert(sum_balance >= balances[msg.sender]);
      }
    }
    {
      assert(totalSupply == sum_balance);
    }
  }
}
