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
uint256 tmp_sum_balance_15 = sum_balance;
require(_to != address(0));
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

function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 tmp_sum_balance_18 = sum_balance;
require(_to != address(0));
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
uint256 tmp_sum_balance_21 = sum_balance;
totalSupply = 1000000000000000000000000;
{
uint256 opt_22 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_21 >= opt_22);
tmp_sum_balance_21 -= opt_22;
}

}

opt_22 = totalSupply;
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
