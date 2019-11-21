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
assert(tmp_sum_balance_13 >= balances[msg.sender]);
tmp_sum_balance_13 -= balances[msg.sender];
}
balances[msg.sender] = balances[msg.sender].sub(_value);{
tmp_sum_balance_13 += balances[msg.sender];
assert(tmp_sum_balance_13 >= balances[msg.sender]);
}

{
assert(tmp_sum_balance_13 >= balances[_to]);
tmp_sum_balance_13 -= balances[_to];
}
balances[_to] = balances[_to].add(_value);{
tmp_sum_balance_13 += balances[_to];
assert(tmp_sum_balance_13 >= balances[_to]);
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
uint256 tmp_sum_balance_14 = sum_balance;
require(_to != address(0));
require(_value > 0 && _value <= balances[_from]);
require(_value <= allowed[_from][msg.sender]);
{
assert(tmp_sum_balance_14 >= balances[_from]);
tmp_sum_balance_14 -= balances[_from];
}
balances[_from] = balances[_from].sub(_value);{
tmp_sum_balance_14 += balances[_from];
assert(tmp_sum_balance_14 >= balances[_from]);
}

{
assert(tmp_sum_balance_14 >= balances[_to]);
tmp_sum_balance_14 -= balances[_to];
}
balances[_to] = balances[_to].add(_value);{
tmp_sum_balance_14 += balances[_to];
assert(tmp_sum_balance_14 >= balances[_to]);
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
assert(totalSupply == tmp_sum_balance_14);
sum_balance = tmp_sum_balance_14;
return true;
}

assert(totalSupply == tmp_sum_balance_14);
sum_balance = tmp_sum_balance_14;
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
uint256 tmp_sum_balance_15 = sum_balance;
uint cnt = _receivers.length;
uint256 amount = uint256(cnt) * _value;
require(cnt > 0 && cnt <= 20);
require(_value > 0 && balances[msg.sender] >= amount);
{
assert(tmp_sum_balance_15 >= balances[msg.sender]);
tmp_sum_balance_15 -= balances[msg.sender];
}
balances[msg.sender] = balances[msg.sender].sub(amount);{
tmp_sum_balance_15 += balances[msg.sender];
assert(tmp_sum_balance_15 >= balances[msg.sender]);
}

for (uint i = 0; i < cnt; i++) {
{
assert(tmp_sum_balance_15 >= balances[_receivers[i]]);
tmp_sum_balance_15 -= balances[_receivers[i]];
}
balances[_receivers[i]] = balances[_receivers[i]].add(_value);{
tmp_sum_balance_15 += balances[_receivers[i]];
assert(tmp_sum_balance_15 >= balances[_receivers[i]]);
}

emit Transfer(msg.sender, _receivers[i], _value);
}

{
assert(totalSupply == tmp_sum_balance_15);
sum_balance = tmp_sum_balance_15;
return true;
}

assert(totalSupply == tmp_sum_balance_15);
sum_balance = tmp_sum_balance_15;
}

}
contract BecToken is PausableToken {
string public name = "BeautyChain";
string public symbol = "BEC";
string public version = '1.0.0';
uint8 public decimals = 18;
constructor () public {
uint256 tmp_sum_balance_16 = sum_balance;
totalSupply = 7000000000 * (10**(uint256(decimals)));
{
assert(tmp_sum_balance_16 >= balances[msg.sender]);
tmp_sum_balance_16 -= balances[msg.sender];
}
balances[msg.sender] = totalSupply;{
tmp_sum_balance_16 += balances[msg.sender];
assert(tmp_sum_balance_16 >= balances[msg.sender]);
}

sum_balance = tmp_sum_balance_16;
}

function () external payable {
revert();
}

}
