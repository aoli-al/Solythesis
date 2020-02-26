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
contract ERC20 {
uint256 public totalSupply;
function balanceOf (address who) public view returns (uint256);
function transfer (address to, uint256 value) public returns (bool);
function allowance (address owner, address spender) public view returns (uint256);
function transferFrom (address from, address to, uint256 value) public returns (bool);
function approve (address spender, uint256 value) public returns (bool);
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract StandardToken is ERC20 {
uint256 depth_0;
uint256 sum_balance;
using SafeMath for uint256;
mapping (address=>uint256) balances;
mapping (address=>mapping (address=>uint256)) allowed;
function balanceOf (address _owner) public view returns (uint256 balance) {
{
return balances[_owner];
}

}

function transfer (address _to, uint256 _value) public returns (bool) {
uint256 tmp_sum_balance_26 = sum_balance;
require(_to != address(0));
{
if (true) {
assert(tmp_sum_balance_26 >= balances[msg.sender]);
tmp_sum_balance_26 -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(_value);{
if (true) {
tmp_sum_balance_26 += balances[msg.sender];
assert(tmp_sum_balance_26 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balance_26 >= balances[_to]);
tmp_sum_balance_26 -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
tmp_sum_balance_26 += balances[_to];
assert(tmp_sum_balance_26 >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
assert(totalSupply == tmp_sum_balance_26);
sum_balance = tmp_sum_balance_26;
return true;
}

assert(totalSupply == tmp_sum_balance_26);
sum_balance = tmp_sum_balance_26;
}

function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 tmp_sum_balance_27 = sum_balance;
require(_to != address(0));
require(_value <= allowed[_from][msg.sender]);
{
if (true) {
assert(tmp_sum_balance_27 >= balances[_from]);
tmp_sum_balance_27 -= balances[_from];
}

}
balances[_from] = balances[_from].sub(_value);{
if (true) {
tmp_sum_balance_27 += balances[_from];
assert(tmp_sum_balance_27 >= balances[_from]);
}

}

{
if (true) {
assert(tmp_sum_balance_27 >= balances[_to]);
tmp_sum_balance_27 -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
tmp_sum_balance_27 += balances[_to];
assert(tmp_sum_balance_27 >= balances[_to]);
}

}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
assert(totalSupply == tmp_sum_balance_27);
sum_balance = tmp_sum_balance_27;
return true;
}

assert(totalSupply == tmp_sum_balance_27);
sum_balance = tmp_sum_balance_27;
}

function approve (address _spender, uint256 _value) public returns (bool) {
require((_value == 0) || (allowed[msg.sender][_spender] == 0));
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
contract MixinToken is StandardToken {
string public constant name = "Mixin";
string public constant symbol = "XIN";
uint8 public constant decimals = 18;
constructor () public {
uint256 tmp_sum_balance_28 = sum_balance;
totalSupply = 1000000000000000000000000;
{
if (true) {
assert(tmp_sum_balance_28 >= balances[msg.sender]);
tmp_sum_balance_28 -= balances[msg.sender];
}

}
balances[msg.sender] = totalSupply;{
if (true) {
tmp_sum_balance_28 += balances[msg.sender];
assert(tmp_sum_balance_28 >= balances[msg.sender]);
}

}

assert(totalSupply == tmp_sum_balance_28);
sum_balance = tmp_sum_balance_28;
}

}
