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
uint256 sum_balance;
string public name = "EKT";
string public symbol = "EKT";
uint8 public constant decimals = 8;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) public _allowed;
uint256 public totalSupply = 10 * 100000000 * 100000000;
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

{
uint256 opt_25 = _balances[msg.sender];
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

_balances[msg.sender] = opt_25;
}

emit Transfer(address(0x0), msg.sender, totalSupply);
if (entry_1 == 1) {
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
uint256 tmp_29;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_29 := mload(0x40)
mstore(0x40, add(tmp_29, 0))
sstore(memoryStart_0_slot, tmp_29)
}

}

if (_to == address(0)) {
{
if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return burn(_value);
}

}
 else {
require(_balances[msg.sender] >= _value && _value > 0);
require(_balances[_to] + _value >= _balances[_to]);
{
uint256 opt_27 = _balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_27);
sum_balance -= opt_27;
}

}

opt_27 = safeSub(opt_27, _value);
{
if (true) {
sum_balance += opt_27;
assert(sum_balance >= opt_27);
}

}

_balances[msg.sender] = opt_27;
}

{
uint256 opt_28 = _balances[_to];
{
if (true) {
assert(sum_balance >= opt_28);
sum_balance -= opt_28;
}

}

opt_28 = safeAdd(opt_28, _value);
{
if (true) {
sum_balance += opt_28;
assert(sum_balance >= opt_28);
}

}

_balances[_to] = opt_28;
}

emit Transfer(msg.sender, _to, _value);
{
if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

}

if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function burn (uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_31;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_31 := mload(0x40)
mstore(0x40, add(tmp_31, 0))
sstore(memoryStart_0_slot, tmp_31)
}

}

require(_balances[msg.sender] >= _value && _value > 0);
require(totalSupply >= _value);
{
uint256 opt_30 = _balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_30);
sum_balance -= opt_30;
}

}

opt_30 = safeSub(opt_30, _value);
{
if (true) {
sum_balance += opt_30;
assert(sum_balance >= opt_30);
}

}

_balances[msg.sender] = opt_30;
}

totalSupply = safeSub(totalSupply, _value);
emit Burn(msg.sender, _value);
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
uint256 tmp_34;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_34 := mload(0x40)
mstore(0x40, add(tmp_34, 0))
sstore(memoryStart_0_slot, tmp_34)
}

}

require(_to != address(0));
require(_balances[_from] >= _value && _value > 0);
require(_balances[_to] + _value >= _balances[_to]);
require(_allowed[_from][msg.sender] >= _value);
{
uint256 opt_32 = _balances[_to];
{
if (true) {
assert(sum_balance >= opt_32);
sum_balance -= opt_32;
}

}

opt_32 = safeAdd(opt_32, _value);
{
if (true) {
sum_balance += opt_32;
assert(sum_balance >= opt_32);
}

}

_balances[_to] = opt_32;
}

{
uint256 opt_33 = _balances[_from];
{
if (true) {
assert(sum_balance >= opt_33);
sum_balance -= opt_33;
}

}

opt_33 = safeSub(opt_33, _value);
{
if (true) {
sum_balance += opt_33;
assert(sum_balance >= opt_33);
}

}

_balances[_from] = opt_33;
}

_allowed[_from][msg.sender] = safeSub(_allowed[_from][msg.sender], _value);
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
