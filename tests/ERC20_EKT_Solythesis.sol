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
uint256 depth_0;
uint256 sum_balance;
string public name = "EKT";
string public symbol = "EKT";
uint8 public constant decimals = 8;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) public _allowed;
uint256 public totalSupply = 10 * 100000000 * 100000000;
constructor () public {
uint256 tmp_sum_balance_19 = sum_balance;
{
uint256 opt_20 = _balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_19 >= opt_20);
tmp_sum_balance_19 -= opt_20;
}

}

opt_20 = totalSupply;
{
if (true) {
tmp_sum_balance_19 += opt_20;
assert(tmp_sum_balance_19 >= opt_20);
}

}

_balances[msg.sender] = opt_20;
}

emit Transfer(address(0x0), msg.sender, totalSupply);
assert(totalSupply == tmp_sum_balance_19);
sum_balance = tmp_sum_balance_19;
}

function balanceOf (address addr) public view returns (uint256) {
{
return _balances[addr];
}

}

function transfer (address _to, uint256 _value) public returns (bool) {
depth_0 += 1;
if (_to == address(0)) {
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == sum_balance);
}

return burn(_value);
}

}
 else {
require(_balances[msg.sender] >= _value && _value > 0);
require(_balances[_to] + _value >= _balances[_to]);
{
uint256 opt_21 = _balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_21);
sum_balance -= opt_21;
}

}

opt_21 = safeSub(opt_21, _value);
{
if (true) {
sum_balance += opt_21;
assert(sum_balance >= opt_21);
}

}

_balances[msg.sender] = opt_21;
}

{
uint256 opt_22 = _balances[_to];
{
if (true) {
assert(sum_balance >= opt_22);
sum_balance -= opt_22;
}

}

opt_22 = safeAdd(opt_22, _value);
{
if (true) {
sum_balance += opt_22;
assert(sum_balance >= opt_22);
}

}

_balances[_to] = opt_22;
}

emit Transfer(msg.sender, _to, _value);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == sum_balance);
}

return true;
}

}

depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == sum_balance);
}

}

function burn (uint256 _value) public returns (bool) {
depth_0 += 1;
uint256 tmp_sum_balance_23 = sum_balance;
require(_balances[msg.sender] >= _value && _value > 0);
require(totalSupply >= _value);
{
uint256 opt_24 = _balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_23 >= opt_24);
tmp_sum_balance_23 -= opt_24;
}

}

opt_24 = safeSub(opt_24, _value);
{
if (true) {
tmp_sum_balance_23 += opt_24;
assert(tmp_sum_balance_23 >= opt_24);
}

}

_balances[msg.sender] = opt_24;
}

totalSupply = safeSub(totalSupply, _value);
emit Burn(msg.sender, _value);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == tmp_sum_balance_23);
}

sum_balance = tmp_sum_balance_23;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == tmp_sum_balance_23);
}

sum_balance = tmp_sum_balance_23;
}

function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
depth_0 += 1;
uint256 tmp_sum_balance_25 = sum_balance;
require(_to != address(0));
require(_balances[_from] >= _value && _value > 0);
require(_balances[_to] + _value >= _balances[_to]);
require(_allowed[_from][msg.sender] >= _value);
{
uint256 opt_26 = _balances[_to];
{
if (true) {
assert(tmp_sum_balance_25 >= opt_26);
tmp_sum_balance_25 -= opt_26;
}

}

opt_26 = safeAdd(opt_26, _value);
{
if (true) {
tmp_sum_balance_25 += opt_26;
assert(tmp_sum_balance_25 >= opt_26);
}

}

_balances[_to] = opt_26;
}

{
uint256 opt_27 = _balances[_from];
{
if (true) {
assert(tmp_sum_balance_25 >= opt_27);
tmp_sum_balance_25 -= opt_27;
}

}

opt_27 = safeSub(opt_27, _value);
{
if (true) {
tmp_sum_balance_25 += opt_27;
assert(tmp_sum_balance_25 >= opt_27);
}

}

_balances[_from] = opt_27;
}

_allowed[_from][msg.sender] = safeSub(_allowed[_from][msg.sender], _value);
emit Transfer(_from, _to, _value);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == tmp_sum_balance_25);
}

sum_balance = tmp_sum_balance_25;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == tmp_sum_balance_25);
}

sum_balance = tmp_sum_balance_25;
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
