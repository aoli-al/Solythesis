pragma solidity ^0.5.0;
library SafeMath {
  function mul (uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    {
      return c;
    }

  }

  function div (uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a / b;
    {
      return c;
    }

  }

  function sub (uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    {
      return a - b;
    }

  }

  function add (uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    {
      return c;
    }

  }

}
contract ERC20Basic {
  uint256 public totalSupply;
  event Transfer(address indexed from, address indexed to, uint256 value);
}
contract BasicToken is ERC20Basic {
  uint256 depth_0;
  uint256 sum_balance;
  using SafeMath for uint256;
  mapping (address=>uint256) balances;
  function transfer (address _to, uint256 _value) public returns (bool) {
    depth_0 += 1;
    uint256 tmp_sum_balance_1 = sum_balance;
    require(_to != address(0));
    require(_value > 0 && _value <= balances[msg.sender]);
    {
      uint256 opt_2 = balances[msg.sender];
      {
        assert(tmp_sum_balance_1 >= opt_2);
        tmp_sum_balance_1 -= opt_2;
      }

      opt_2 = opt_2.sub(_value);
      {
        tmp_sum_balance_1 += opt_2;
        assert(tmp_sum_balance_1 >= opt_2);
      }

      balances[msg.sender] = opt_2;
    }

    {
      uint256 opt_3 = balances[_to];
      {
        assert(tmp_sum_balance_1 >= opt_3);
        tmp_sum_balance_1 -= opt_3;
      }

      opt_3 = opt_3.add(_value);
      {
        tmp_sum_balance_1 += opt_3;
        assert(tmp_sum_balance_1 >= opt_3);
      }

      balances[_to] = opt_3;
    }

    emit Transfer(msg.sender, _to, _value);
    {
      depth_0 -= 1;
      if (depth_0 == 0) {
        assert(totalSupply == tmp_sum_balance_1);
      }

      sum_balance = tmp_sum_balance_1;
      return true;
    }

    depth_0 -= 1;
    if (depth_0 == 0) {
      assert(totalSupply == tmp_sum_balance_1);
    }

    sum_balance = tmp_sum_balance_1;
  }

  function balanceOf (address _owner) public view returns (uint256 balance) {
    {
      return balances[_owner];
    }

  }

}
contract ERC20 is ERC20Basic {
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract StandardToken is ERC20, BasicToken {
  mapping (address=>mapping (address=>uint256)) internal allowed;
  function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
    depth_0 += 1;
    uint256 tmp_sum_balance_4 = sum_balance;
    require(_to != address(0));
    require(_value > 0 && _value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    {
      uint256 opt_5 = balances[_from];
      {
        assert(tmp_sum_balance_4 >= opt_5);
        tmp_sum_balance_4 -= opt_5;
      }

      opt_5 = opt_5.sub(_value);
      {
        tmp_sum_balance_4 += opt_5;
        assert(tmp_sum_balance_4 >= opt_5);
      }

      balances[_from] = opt_5;
    }

    {
      uint256 opt_6 = balances[_to];
      {
        assert(tmp_sum_balance_4 >= opt_6);
        tmp_sum_balance_4 -= opt_6;
      }

      opt_6 = opt_6.add(_value);
      {
        tmp_sum_balance_4 += opt_6;
        assert(tmp_sum_balance_4 >= opt_6);
      }

      balances[_to] = opt_6;
    }

    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    {
      depth_0 -= 1;
      if (depth_0 == 0) {
        assert(totalSupply == tmp_sum_balance_4);
      }

      sum_balance = tmp_sum_balance_4;
      return true;
    }

    depth_0 -= 1;
    if (depth_0 == 0) {
      assert(totalSupply == tmp_sum_balance_4);
    }

    sum_balance = tmp_sum_balance_4;
  }

  function approve (address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    {
      return true;
    }

  }

  function allowance (address _owner, address _spender) public view returns (uint256 remaining) {
    {
      return allowed[_owner][_spender];
    }

  }

}
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  constructor () public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
  function transferOwnership (address newOwner) onlyOwner public {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}
contract Pausable is Ownable {
  event Pause();
  event Unpause();
  bool public paused = false;
  modifier whenNotPaused() {
    require(!paused);
    _;
  }
  modifier whenPaused() {
    require(paused);
    _;
  }
  function pause () onlyOwner whenNotPaused public {
    paused = true;
    emit Pause();
  }

  function unpause () onlyOwner whenPaused public {
    paused = false;
    emit Unpause();
  }

}
contract PausableToken is StandardToken, Pausable {
  function transfer (address _to, uint256 _value) whenNotPaused public returns (bool) {
    {
      return super.transfer(_to, _value);
    }

  }

  function transferFrom (address _from, address _to, uint256 _value) whenNotPaused public returns (bool) {
    {
      return super.transferFrom(_from, _to, _value);
    }

  }

  function approve (address _spender, uint256 _value) whenNotPaused public returns (bool) {
    {
      return super.approve(_spender, _value);
    }

  }

  function batchTransfer (address[] memory _receivers, uint256 _value) whenNotPaused public returns (bool) {
    depth_0 += 1;
    uint256 tmp_sum_balance_7 = sum_balance;
    uint cnt = _receivers.length;
    uint256 amount = uint256(cnt) * _value;
    require(cnt > 0 && cnt <= 20);
    require(_value > 0 && balances[msg.sender] >= amount);
    {
      uint256 opt_8 = balances[msg.sender];
      {
        assert(tmp_sum_balance_7 >= opt_8);
        tmp_sum_balance_7 -= opt_8;
      }

      opt_8 = opt_8.sub(amount);
      {
        tmp_sum_balance_7 += opt_8;
        assert(tmp_sum_balance_7 >= opt_8);
      }

      balances[msg.sender] = opt_8;
    }

    for (uint i = 0; i < cnt; i++) {
      {
        uint256 opt_9 = balances[_receivers[i]];
        {
          assert(tmp_sum_balance_7 >= opt_9);
          tmp_sum_balance_7 -= opt_9;
        }

        opt_9 = opt_9.add(_value);
        {
          tmp_sum_balance_7 += opt_9;
          assert(tmp_sum_balance_7 >= opt_9);
        }

        balances[_receivers[i]] = opt_9;
      }

      emit Transfer(msg.sender, _receivers[i], _value);
    }

    {
      depth_0 -= 1;
      if (depth_0 == 0) {
        assert(totalSupply == tmp_sum_balance_7);
      }

      sum_balance = tmp_sum_balance_7;
      return true;
    }

    depth_0 -= 1;
    if (depth_0 == 0) {
      assert(totalSupply == tmp_sum_balance_7);
    }

    sum_balance = tmp_sum_balance_7;
  }

}
contract BecToken is PausableToken {
  string public name = "BeautyChain";
  string public symbol = "BEC";
  string public version = '1.0.0';
  uint8 public decimals = 18;
  constructor () public {
    depth_0 += 1;
    uint256 tmp_sum_balance_10 = sum_balance;
    totalSupply = 7000000000 * (10**(uint256(decimals)));
    {
      uint256 opt_11 = balances[msg.sender];
      {
        assert(tmp_sum_balance_10 >= opt_11);
        tmp_sum_balance_10 -= opt_11;
      }

      opt_11 = totalSupply;
      {
        tmp_sum_balance_10 += opt_11;
        assert(tmp_sum_balance_10 >= opt_11);
      }

      balances[msg.sender] = opt_11;
    }

    depth_0 -= 1;
    if (depth_0 == 0) {
      assert(totalSupply == tmp_sum_balance_10);
    }

    sum_balance = tmp_sum_balance_10;
  }

  function () external payable {
    revert();
  }
}
