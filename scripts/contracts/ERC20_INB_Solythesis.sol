pragma solidity ^0.5.0;
library SafeMath {
function mul (uint256 a, uint256 b) internal pure returns (uint256) {
if (a == 0) {
{
return 0;
}

}

uint256 c = a * b;
assert(c / a == b);
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
contract ERC20Basic {
uint256 public totalSupply;
function balanceOf (address who) public view returns (uint256);
function transfer (address to, uint256 value) public returns (bool);
event Transfer(address indexed from, address indexed to, uint256 value);
}
contract ERC20 is ERC20Basic {
function allowance (address owner, address spender) public view returns (uint256);
function transferFrom (address from, address to, uint256 value) public returns (bool);
function approve (address spender, uint256 value) public returns (bool);
event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract BasicToken is ERC20Basic {
uint256 depth_0;
uint256 sum_balance;
using SafeMath for uint256;
mapping (address=>uint256) balances;
function transfer (address _to, uint256 _value) public returns (bool) {
uint256 tmp_sum_balance_15 = sum_balance;
require(_to != address(0));
require(_value <= balances[msg.sender]);
{
uint256 opt_16 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_15 >= opt_16);
tmp_sum_balance_15 -= opt_16;
}

}

opt_16 = opt_16.sub(_value);
{
if (true) {
tmp_sum_balance_15 += opt_16;
assert(tmp_sum_balance_15 >= opt_16);
}

}

balances[msg.sender] = opt_16;
}

{
uint256 opt_17 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_15 >= opt_17);
tmp_sum_balance_15 -= opt_17;
}

}

opt_17 = opt_17.add(_value);
{
if (true) {
tmp_sum_balance_15 += opt_17;
assert(tmp_sum_balance_15 >= opt_17);
}

}

balances[_to] = opt_17;
}

emit Transfer(msg.sender, _to, _value);
{
assert(totalSupply == tmp_sum_balance_15);
sum_balance = tmp_sum_balance_15;
return true;
}

assert(totalSupply == tmp_sum_balance_15);
sum_balance = tmp_sum_balance_15;
}

function balanceOf (address _owner) public view returns (uint256 balance) {
{
return balances[_owner];
}

}

}
contract StandardToken is ERC20, BasicToken {
mapping (address=>mapping (address=>uint256)) internal allowed;
function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 tmp_sum_balance_18 = sum_balance;
require(_to != address(0));
require(_value <= balances[_from]);
require(_value <= allowed[_from][msg.sender]);
{
uint256 opt_19 = balances[_from];
{
if (true) {
assert(tmp_sum_balance_18 >= opt_19);
tmp_sum_balance_18 -= opt_19;
}

}

opt_19 = opt_19.sub(_value);
{
if (true) {
tmp_sum_balance_18 += opt_19;
assert(tmp_sum_balance_18 >= opt_19);
}

}

balances[_from] = opt_19;
}

{
uint256 opt_20 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_18 >= opt_20);
tmp_sum_balance_18 -= opt_20;
}

}

opt_20 = opt_20.add(_value);
{
if (true) {
tmp_sum_balance_18 += opt_20;
assert(tmp_sum_balance_18 >= opt_20);
}

}

balances[_to] = opt_20;
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
assert(totalSupply == tmp_sum_balance_18);
sum_balance = tmp_sum_balance_18;
return true;
}

assert(totalSupply == tmp_sum_balance_18);
sum_balance = tmp_sum_balance_18;
}

function approve (address _spender, uint256 _value) public returns (bool) {
allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
{
return true;
}

}

function allowance (address _owner, address _spender) public view returns (uint256) {
{
return allowed[_owner][_spender];
}

}

function increaseApproval (address _spender, uint _addedValue) public returns (bool) {
allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
{
return true;
}

}

function decreaseApproval (address _spender, uint _subtractedValue) public returns (bool) {
uint oldValue = allowed[msg.sender][_spender];
if (_subtractedValue > oldValue) {
allowed[msg.sender][_spender] = 0;
}
 else {
allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
}

emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
{
return true;
}

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

function increaseApproval (address _spender, uint _addedValue) whenNotPaused public returns (bool success) {
{
return super.increaseApproval(_spender, _addedValue);
}

}

function decreaseApproval (address _spender, uint _subtractedValue) whenNotPaused public returns (bool success) {
{
return super.decreaseApproval(_spender, _subtractedValue);
}

}

}
contract InsightChainToken is PausableToken {
string public name = "Insight Chain";
string public symbol = "INB";
uint public decimals = 18;
uint public INITIAL_SUPPLY = 10000000000000000000000000000;
constructor () public {
uint256 tmp_sum_balance_21 = sum_balance;
totalSupply = INITIAL_SUPPLY;
{
uint256 opt_22 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_21 >= opt_22);
tmp_sum_balance_21 -= opt_22;
}

}

opt_22 = INITIAL_SUPPLY;
{
if (true) {
tmp_sum_balance_21 += opt_22;
assert(tmp_sum_balance_21 >= opt_22);
}

}

balances[msg.sender] = opt_22;
}

assert(totalSupply == tmp_sum_balance_21);
sum_balance = tmp_sum_balance_21;
}

}
