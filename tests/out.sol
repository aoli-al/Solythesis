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
contract ERC20Basic {
  uint256 public totalSupply;
  event Transfer(address indexed from, address indexed to, uint256 value);
}
contract BasicToken is ERC20Basic {
  uint256 sum_0;
  using SafeMath for uint256;
  mapping (address=>uint256) balances;
  function transfer (address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value > 0 && _value <= balances[msg.sender]);
    {
      sum_0 -= balances[msg.sender];
      balances[msg.sender] = balances[msg.sender].sub(_value);
      sum_0 += balances[msg.sender];
    }
    {
      sum_0 -= balances[_to];
      balances[_to] = balances[_to].add(_value);
      sum_0 += balances[_to];
    }
    emit Transfer(msg.sender, _to, _value);
    {
      assert(totalSupply == sum_0);
      return true;
    }
    {
      assert(totalSupply == sum_0);
    }
  }
  function balanceOf (address _owner) public view returns (uint256 balance) {
    {
      return balances[_owner];
    }
    {
    }
  }
}
contract ERC20 is ERC20Basic {
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract StandardToken is ERC20, BasicToken {
  mapping (address=>mapping (address=>uint256)) internal allowed;
  function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value > 0 && _value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    {
      sum_0 -= balances[_from];
      balances[_from] = balances[_from].sub(_value);
      sum_0 += balances[_from];
    }
    {
      sum_0 -= balances[_to];
      balances[_to] = balances[_to].add(_value);
      sum_0 += balances[_to];
    }
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    {
      assert(totalSupply == sum_0);
      return true;
    }
    {
      assert(totalSupply == sum_0);
    }
  }
  function approve (address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    {
      return true;
    }
    {
    }
  }
  function allowance (address _owner, address _spender) public view returns (uint256 remaining) {
    {
      return allowed[_owner][_spender];
    }
    {
    }
  }
}
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  constructor () public {
    owner = msg.sender;
    {
    }
  }
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
  function transferOwnership (address newOwner) onlyOwner public {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
    {
    }
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
    {
    }
  }
  function unpause () onlyOwner whenPaused public {
    paused = false;
    emit Unpause();
    {
    }
  }
}
contract PausableToken is StandardToken, Pausable {
  function transfer (address _to, uint256 _value) whenNotPaused public returns (bool) {
    {
      return super.transfer(_to, _value);
    }
    {
    }
  }
  function transferFrom (address _from, address _to, uint256 _value) whenNotPaused public returns (bool) {
    {
      return super.transferFrom(_from, _to, _value);
    }
    {
    }
  }
  function approve (address _spender, uint256 _value) whenNotPaused public returns (bool) {
    {
      return super.approve(_spender, _value);
    }
    {
    }
  }
  function batchTransfer (address[] memory _receivers, uint256 _value) whenNotPaused public returns (bool) {
    uint cnt = _receivers.length;
    uint256 amount = uint256(cnt) * _value;
    require(cnt > 0 && cnt <= 20);
    require(_value > 0 && balances[msg.sender] >= amount);
    {
      sum_0 -= balances[msg.sender];
      balances[msg.sender] = balances[msg.sender].sub(amount);
      sum_0 += balances[msg.sender];
    }
    for (uint i = 0; i < cnt; i++) {
      {
        sum_0 -= balances[_receivers[i]];
        balances[_receivers[i]] = balances[_receivers[i]].add(_value);
        sum_0 += balances[_receivers[i]];
      }
      emit Transfer(msg.sender, _receivers[i], _value);
    }
    {
      assert(totalSupply == sum_0);
      return true;
    }
    {
      assert(totalSupply == sum_0);
    }
  }
}
contract BecToken is PausableToken {
  string public name = "BeautyChain";
  string public symbol = "BEC";
  string public version = '1.0.0';
  uint8 public decimals = 18;
  constructor () public {
    totalSupply = 7000000000 * (10**(uint256(decimals)));
    {
      sum_0 -= balances[msg.sender];
      balances[msg.sender] = totalSupply;
      sum_0 += balances[msg.sender];
    }
    {
      assert(totalSupply == sum_0);
    }
  }
  function init () public {
    totalSupply = 7000000000 * (10**(uint256(decimals)));
    {
      sum_0 -= balances[msg.sender];
      balances[msg.sender] = totalSupply;
      sum_0 += balances[msg.sender];
    }
    {
      assert(totalSupply == sum_0);
    }
  }
}
