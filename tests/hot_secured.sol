pragma solidity ^0.5.0;
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
contract HoloToken is Ownable {
uint256 depth_0;
uint256 sum_balance;
string public constant name = "HoloToken";
string public constant symbol = "HOT";
uint8 public constant decimals = 18;
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
event Mint(address indexed to, uint256 amount);
event MintingFinished();
event Burn(uint256 amount);
uint256 public totalSupply;
using SafeMath for uint256;
mapping (address=>uint256) public balances;
constructor () public {
uint256 tmp_sum_balance_15 = sum_balance;
totalSupply = 300000000 * 10 ** uint(decimals);
{
uint256 opt_16 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_15 >= opt_16);
tmp_sum_balance_15 -= opt_16;
}

}

opt_16 = totalSupply;
{
if (true) {
tmp_sum_balance_15 += opt_16;
assert(tmp_sum_balance_15 >= opt_16);
}

}

balances[msg.sender] = opt_16;
}

assert(totalSupply == tmp_sum_balance_15);
sum_balance = tmp_sum_balance_15;
}

function transfer (address _to, uint256 _value) public returns (bool) {
uint256 tmp_sum_balance_17 = sum_balance;
require(_to != address(0));
require(_value <= balances[msg.sender]);
{
uint256 opt_18 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_17 >= opt_18);
tmp_sum_balance_17 -= opt_18;
}

}

opt_18 = opt_18.sub(_value);
{
if (true) {
tmp_sum_balance_17 += opt_18;
assert(tmp_sum_balance_17 >= opt_18);
}

}

balances[msg.sender] = opt_18;
}

{
uint256 opt_19 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_17 >= opt_19);
tmp_sum_balance_17 -= opt_19;
}

}

opt_19 = opt_19.add(_value);
{
if (true) {
tmp_sum_balance_17 += opt_19;
assert(tmp_sum_balance_17 >= opt_19);
}

}

balances[_to] = opt_19;
}

emit Transfer(msg.sender, _to, _value);
{
assert(totalSupply == tmp_sum_balance_17);
sum_balance = tmp_sum_balance_17;
return true;
}

assert(totalSupply == tmp_sum_balance_17);
sum_balance = tmp_sum_balance_17;
}

function balanceOf (address _owner) public view returns (uint256 balance) {
{
return balances[_owner];
}

}

mapping (address=>mapping (address=>uint256)) public allowed;
function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 tmp_sum_balance_20 = sum_balance;
require(_to != address(0));
require(_value <= balances[_from]);
require(_value <= allowed[_from][msg.sender]);
{
uint256 opt_21 = balances[_from];
{
if (true) {
assert(tmp_sum_balance_20 >= opt_21);
tmp_sum_balance_20 -= opt_21;
}

}

opt_21 = opt_21.sub(_value);
{
if (true) {
tmp_sum_balance_20 += opt_21;
assert(tmp_sum_balance_20 >= opt_21);
}

}

balances[_from] = opt_21;
}

{
uint256 opt_22 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_20 >= opt_22);
tmp_sum_balance_20 -= opt_22;
}

}

opt_22 = opt_22.add(_value);
{
if (true) {
tmp_sum_balance_20 += opt_22;
assert(tmp_sum_balance_20 >= opt_22);
}

}

balances[_to] = opt_22;
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
assert(totalSupply == tmp_sum_balance_20);
sum_balance = tmp_sum_balance_20;
return true;
}

assert(totalSupply == tmp_sum_balance_20);
sum_balance = tmp_sum_balance_20;
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
