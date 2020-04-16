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
uint256 memoryStart_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
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
uint256 entry_1 = 0;
uint256 tmp_5;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_5 := mload(0x40)
mstore(0x40, add(tmp_5, 0))
sstore(memoryStart_0_slot, tmp_5)
}

}

require(_to != address(0));
balances[msg.sender] = balances[msg.sender].sub(_value);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

balances[_to] = balances[_to].add(_value);if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

emit Transfer(msg.sender, _to, _value);
{
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_3 = 0; index_3 < a_store_2.length; index_3 += 1) {
sum_balance += balances[a_store_2[index_3]];
assert(sum_balance >= balances[a_store_2[index_3]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_4 = 0; index_4 < a_store_2.length; index_4 += 1) {
sum_balance += balances[a_store_2[index_4]];
assert(sum_balance >= balances[a_store_2[index_4]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_8;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_8 := mload(0x40)
mstore(0x40, add(tmp_8, 0))
sstore(memoryStart_0_slot, tmp_8)
}

}

require(_to != address(0));
require(_value <= allowed[_from][msg.sender]);
balances[_from] = balances[_from].sub(_value);if (! a_checker_1[_from]) {
a_store_2.push(_from);
a_checker_1[_from] = true;
}

balances[_to] = balances[_to].add(_value);if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_6 = 0; index_6 < a_store_2.length; index_6 += 1) {
sum_balance += balances[a_store_2[index_6]];
assert(sum_balance >= balances[a_store_2[index_6]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_7 = 0; index_7 < a_store_2.length; index_7 += 1) {
sum_balance += balances[a_store_2[index_7]];
assert(sum_balance >= balances[a_store_2[index_7]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

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
uint256 entry_1 = 0;
uint256 tmp_10;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_10 := mload(0x40)
mstore(0x40, add(tmp_10, 0))
sstore(memoryStart_0_slot, tmp_10)
}

}

totalSupply = 1000000000000000000000000;
balances[msg.sender] = totalSupply;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_9 = 0; index_9 < a_store_2.length; index_9 += 1) {
sum_balance += balances[a_store_2[index_9]];
assert(sum_balance >= balances[a_store_2[index_9]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

}
