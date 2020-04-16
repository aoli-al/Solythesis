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
uint256 tmp_21;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_21 := mload(0x40)
mstore(0x40, add(tmp_21, 0))
sstore(memoryStart_0_slot, tmp_21)
}

}

require(_to != address(0));
{
uint256 opt_19 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_19);
sum_balance -= opt_19;
}

}

opt_19 = opt_19.sub(_value);
{
if (true) {
sum_balance += opt_19;
assert(sum_balance >= opt_19);
}

}

balances[msg.sender] = opt_19;
}

{
uint256 opt_20 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_20);
sum_balance -= opt_20;
}

}

opt_20 = opt_20.add(_value);
{
if (true) {
sum_balance += opt_20;
assert(sum_balance >= opt_20);
}

}

balances[_to] = opt_20;
}

emit Transfer(msg.sender, _to, _value);
{
if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_24;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_24 := mload(0x40)
mstore(0x40, add(tmp_24, 0))
sstore(memoryStart_0_slot, tmp_24)
}

}

require(_to != address(0));
require(_value <= allowed[_from][msg.sender]);
{
uint256 opt_22 = balances[_from];
{
if (true) {
assert(sum_balance >= opt_22);
sum_balance -= opt_22;
}

}

opt_22 = opt_22.sub(_value);
{
if (true) {
sum_balance += opt_22;
assert(sum_balance >= opt_22);
}

}

balances[_from] = opt_22;
}

{
uint256 opt_23 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_23);
sum_balance -= opt_23;
}

}

opt_23 = opt_23.add(_value);
{
if (true) {
sum_balance += opt_23;
assert(sum_balance >= opt_23);
}

}

balances[_to] = opt_23;
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
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
uint256 tmp_26;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_26 := mload(0x40)
mstore(0x40, add(tmp_26, 0))
sstore(memoryStart_0_slot, tmp_26)
}

}

totalSupply = 1000000000000000000000000;
{
uint256 opt_25 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_25);
sum_balance -= opt_25;
}

}

opt_25 = totalSupply;
{
if (true) {
sum_balance += opt_25;
assert(sum_balance >= opt_25);
}

}

balances[msg.sender] = opt_25;
}

if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

}
