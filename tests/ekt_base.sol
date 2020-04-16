pragma solidity ^0.5.0;
contract SafeMath {
function safeMul (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a * b;
_assert(a == 0 || c / a == b);
{
return c;
}

}

function safeDiv (uint256 a, uint256 b) internal pure returns (uint256) {
_assert(b > 0);
uint256 c = a / b;
_assert(a == b * c + a % b);
{
return c;
}

}

function safeSub (uint256 a, uint256 b) internal pure returns (uint256) {
_assert(b <= a);
{
return a - b;
}

}

function safeAdd (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a + b;
_assert(c >= a && c >= b);
{
return c;
}

}

function _assert (bool assertion) internal pure {
if (! assertion) {
revert();
}

}

}
contract EKT is SafeMath {
uint256 memoryStart_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
uint256 sum_balance;
string public name = "EKT";
string public symbol = "EKT";
uint8 public constant decimals = 8;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) public _allowed;
uint256 public totalSupply = 10 * 100000000 * 100000000;
constructor () public {
uint256 entry_1 = 0;
uint256 tmp_4;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_4 := mload(0x40)
mstore(0x40, add(tmp_4, 0))
sstore(memoryStart_0_slot, tmp_4)
}

}

_balances[msg.sender] = totalSupply;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

emit Transfer(address(0x0), msg.sender, totalSupply);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_3 = 0; index_3 < a_store_2.length; index_3 += 1) {
sum_balance += _balances[a_store_2[index_3]];
assert(sum_balance >= _balances[a_store_2[index_3]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function balanceOf (address addr) public view returns (uint256) {
{
return _balances[addr];
}

}

function transfer (address _to, uint256 _value) public returns (bool) {
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

if (_to == address(0)) {
{
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_5 = 0; index_5 < a_store_2.length; index_5 += 1) {
sum_balance += _balances[a_store_2[index_5]];
assert(sum_balance >= _balances[a_store_2[index_5]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return burn(_value);
}

}
 else {
require(_balances[msg.sender] >= _value && _value > 0);
require(_balances[_to] + _value >= _balances[_to]);
_balances[msg.sender] = safeSub(_balances[msg.sender], _value);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

_balances[_to] = safeAdd(_balances[_to], _value);if (! a_checker_1[_to]) {
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

for (uint256 index_6 = 0; index_6 < a_store_2.length; index_6 += 1) {
sum_balance += _balances[a_store_2[index_6]];
assert(sum_balance >= _balances[a_store_2[index_6]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

}

if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_7 = 0; index_7 < a_store_2.length; index_7 += 1) {
sum_balance += _balances[a_store_2[index_7]];
assert(sum_balance >= _balances[a_store_2[index_7]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function burn (uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_11;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_11 := mload(0x40)
mstore(0x40, add(tmp_11, 0))
sstore(memoryStart_0_slot, tmp_11)
}

}

require(_balances[msg.sender] >= _value && _value > 0);
require(totalSupply >= _value);
_balances[msg.sender] = safeSub(_balances[msg.sender], _value);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

totalSupply = safeSub(totalSupply, _value);
emit Burn(msg.sender, _value);
{
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_9 = 0; index_9 < a_store_2.length; index_9 += 1) {
sum_balance += _balances[a_store_2[index_9]];
assert(sum_balance >= _balances[a_store_2[index_9]]);
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

for (uint256 index_10 = 0; index_10 < a_store_2.length; index_10 += 1) {
sum_balance += _balances[a_store_2[index_10]];
assert(sum_balance >= _balances[a_store_2[index_10]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_14;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_14 := mload(0x40)
mstore(0x40, add(tmp_14, 0))
sstore(memoryStart_0_slot, tmp_14)
}

}

require(_to != address(0));
require(_balances[_from] >= _value && _value > 0);
require(_balances[_to] + _value >= _balances[_to]);
require(_allowed[_from][msg.sender] >= _value);
_balances[_to] = safeAdd(_balances[_to], _value);if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

_balances[_from] = safeSub(_balances[_from], _value);if (! a_checker_1[_from]) {
a_store_2.push(_from);
a_checker_1[_from] = true;
}

_allowed[_from][msg.sender] = safeSub(_allowed[_from][msg.sender], _value);
emit Transfer(_from, _to, _value);
{
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_12 = 0; index_12 < a_store_2.length; index_12 += 1) {
sum_balance += _balances[a_store_2[index_12]];
assert(sum_balance >= _balances[a_store_2[index_12]]);
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

for (uint256 index_13 = 0; index_13 < a_store_2.length; index_13 += 1) {
sum_balance += _balances[a_store_2[index_13]];
assert(sum_balance >= _balances[a_store_2[index_13]]);
}

}

assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function approve (address spender, uint256 value) public returns (bool) {
require(spender != address(0));
_allowed[msg.sender][spender] = value;
emit Approval(msg.sender, spender, value);
{
return true;
}

}

function allowance (address _master, address _spender) public view returns (uint256) {
{
return _allowed[_master][_spender];
}

}

event Approval(address indexed _owner, address indexed _spender, uint256 _value);
event Transfer(address indexed _from, address indexed _to, uint256 value);
event Burn(address indexed _from, uint256 value);
}
