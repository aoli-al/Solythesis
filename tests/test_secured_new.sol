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
    uint256 tmp_sum_balance_13 = sum_balance;
    require(_to != address(0));
    require(_value > 0 && _value <= balances[msg.sender]);
    {
      uint256 opt_14 = balances[msg.sender];
      {
        if (true) {
          assert(tmp_sum_balance_13 >= opt_14);
          tmp_sum_balance_13 -= opt_14;
        }

      }

      opt_14 = opt_14.sub(_value);
      {
        if (true) {
          tmp_sum_balance_13 += opt_14;
          assert(tmp_sum_balance_13 >= opt_14);
        }

      }

      balances[msg.sender] = opt_14;
    }

    {
      uint256 opt_15 = balances[_to];
      {
        if (true) {
          assert(tmp_sum_balance_13 >= opt_15);
          tmp_sum_balance_13 -= opt_15;
        }

      }

      opt_15 = opt_15.add(_value);
      {
        if (true) {
          tmp_sum_balance_13 += opt_15;
          assert(tmp_sum_balance_13 >= opt_15);
        }

      }

      balances[_to] = opt_15;
    }

    emit Transfer(msg.sender, _to, _value);
    {
      assert(totalSupply == tmp_sum_balance_13);
      sum_balance = tmp_sum_balance_13;
      return true;
    }

    assert(totalSupply == tmp_sum_balance_13);
    sum_balance = tmp_sum_balance_13;
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
    uint256 tmp_sum_balance_16 = sum_balance;
    require(_to != address(0));
    require(_value > 0 && _value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    {
      uint256 opt_17 = balances[_from];
      {
        if (true) {
          assert(tmp_sum_balance_16 >= opt_17);
          tmp_sum_balance_16 -= opt_17;
        }

      }

      opt_17 = opt_17.sub(_value);
      {
        if (true) {
          tmp_sum_balance_16 += opt_17;
          assert(tmp_sum_balance_16 >= opt_17);
        }

      }

      balances[_from] = opt_17;
    }

    {
      uint256 opt_18 = balances[_to];
      {
        if (true) {
          assert(tmp_sum_balance_16 >= opt_18);
          tmp_sum_balance_16 -= opt_18;
        }

      }

      opt_18 = opt_18.add(_value);
      {
        if (true) {
          tmp_sum_balance_16 += opt_18;
          assert(tmp_sum_balance_16 >= opt_18);
        }

      }

      balances[_to] = opt_18;
    }

    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    {
      assert(totalSupply == tmp_sum_balance_16);
      sum_balance = tmp_sum_balance_16;
      return true;
    }

    assert(totalSupply == tmp_sum_balance_16);
    sum_balance = tmp_sum_balance_16;
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
    uint256 tmp_sum_balance_19 = sum_balance;
    uint cnt = _receivers.length;
    uint256 amount = uint256(cnt) * _value;
    require(cnt > 0 && cnt <= 20);
    require(_value > 0 && balances[msg.sender] >= amount);
    {
      uint256 opt_20 = balances[msg.sender];
      {
        if (true) {
          assert(tmp_sum_balance_19 >= opt_20);
          tmp_sum_balance_19 -= opt_20;
        }

      }

      opt_20 = opt_20.sub(amount);
      {
        if (true) {
          tmp_sum_balance_19 += opt_20;
          assert(tmp_sum_balance_19 >= opt_20);
        }

      }

      balances[msg.sender] = opt_20;
    }

    for (uint i = 0; i < cnt; i++) {
      {
        uint256 opt_21 = balances[_receivers[i]];
        {
          if (true) {
            assert(tmp_sum_balance_19 >= opt_21);
            tmp_sum_balance_19 -= opt_21;
          }

        }

        opt_21 = opt_21.add(_value);
        {
          if (true) {
            tmp_sum_balance_19 += opt_21;
            assert(tmp_sum_balance_19 >= opt_21);
          }

        }

        balances[_receivers[i]] = opt_21;
      }

      emit Transfer(msg.sender, _receivers[i], _value);
    }

    {
      assert(totalSupply == tmp_sum_balance_19);
      sum_balance = tmp_sum_balance_19;
      return true;
    }

    assert(totalSupply == tmp_sum_balance_19);
    sum_balance = tmp_sum_balance_19;
  }

}
contract BecToken is PausableToken {
  string public name = "BeautyChain";
  string public symbol = "BEC";
  string public version = '1.0.0';
  uint8 public decimals = 18;
  constructor () public {
    uint256 tmp_sum_balance_22 = sum_balance;
    totalSupply = 7000000000 * (10**(uint256(decimals)));
    {
      uint256 opt_23 = balances[msg.sender];
      {
        if (true) {
          assert(tmp_sum_balance_22 >= opt_23);
          tmp_sum_balance_22 -= opt_23;
        }

      }

      opt_23 = totalSupply;
      {
        if (true) {
          tmp_sum_balance_22 += opt_23;
          assert(tmp_sum_balance_22 >= opt_23);
        }

      }

      balances[msg.sender] = opt_23;
    }

    sum_balance = tmp_sum_balance_22;
  }

  function () external payable {
    revert();
  }

}
