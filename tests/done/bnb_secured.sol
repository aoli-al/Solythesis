pragma solidity ^0.4.8;
contract SafeMath {
function safeMul (uint256 a, uint256 b) internal returns (uint256) {
uint256 c = a * b;
assert(a == 0 || c / a == b);
{
return c;
}

}

function safeDiv (uint256 a, uint256 b) internal returns (uint256) {
assert(b > 0);
uint256 c = a / b;
assert(a == b * c + a % b);
{
return c;
}

}

function safeSub (uint256 a, uint256 b) internal returns (uint256) {
assert(b <= a);
{
return a - b;
}

}

function safeAdd (uint256 a, uint256 b) internal returns (uint256) {
uint256 c = a + b;
assert(c >= a && c >= b);
{
return c;
}

}

function assert (bool assertion) internal {
if (! assertion) {
throw;
}

}

}
contract BNB is SafeMath {
uint256 depth_0;
uint256 sum_balanceOf;
string public name;
string public symbol;
uint8 public decimals;
uint256 public totalSupply;
address public owner;
mapping (address=>uint256) public balanceOf;
mapping (address=>uint256) public freezeOf;
mapping (address=>mapping (address=>uint256)) public allowance;
event Transfer(address indexed from, address indexed to, uint256 value);
event Burn(address indexed from, uint256 value);
event Freeze(address indexed from, uint256 value);
event Unfreeze(address indexed from, uint256 value);
constructor BNB (
        uint256 initialSupply,
        string tokenName,
        uint8 decimalUnits,
        string tokenSymbol
        ) {
uint256 tmp_sum_balanceOf_16 = sum_balanceOf;
{
uint256 opt_17 = balanceOf[msg.sender];
{
if (true) {
assert(tmp_sum_balanceOf_16 >= opt_17);
tmp_sum_balanceOf_16 -= opt_17;
}

}

opt_17 = initialSupply;
{
if (true) {
tmp_sum_balanceOf_16 += opt_17;
assert(tmp_sum_balanceOf_16 >= opt_17);
}

}

balanceOf[msg.sender] = opt_17;
}

totalSupply = initialSupply;
name = tokenName;
symbol = tokenSymbol;
decimals = decimalUnits;
owner = msg.sender;
sum_balanceOf = tmp_sum_balanceOf_16;
}

function transfer (address _to, uint256 _value) {
uint256 tmp_sum_balanceOf_18 = sum_balanceOf;
if (_to == 0x0) throw;
if (_value <= 0) throw;
if (balanceOf[msg.sender] < _value) throw;
if (balanceOf[_to] + _value < balanceOf[_to]) throw;
{
uint256 opt_19 = balanceOf[msg.sender];
{
if (true) {
assert(tmp_sum_balanceOf_18 >= opt_19);
tmp_sum_balanceOf_18 -= opt_19;
}

}

opt_19 = SafeMath.safeSub(opt_19, _value);
{
if (true) {
tmp_sum_balanceOf_18 += opt_19;
assert(tmp_sum_balanceOf_18 >= opt_19);
}

}

balanceOf[msg.sender] = opt_19;
}

{
uint256 opt_20 = balanceOf[_to];
{
if (true) {
assert(tmp_sum_balanceOf_18 >= opt_20);
tmp_sum_balanceOf_18 -= opt_20;
}

}

opt_20 = SafeMath.safeAdd(opt_20, _value);
{
if (true) {
tmp_sum_balanceOf_18 += opt_20;
assert(tmp_sum_balanceOf_18 >= opt_20);
}

}

balanceOf[_to] = opt_20;
}

Transfer(msg.sender, _to, _value);
sum_balanceOf = tmp_sum_balanceOf_18;
}

function approve (address _spender, uint256 _value) returns (bool success) {
if (_value <= 0) throw;
allowance[msg.sender][_spender] = _value;
{
return true;
}

}

function transferFrom (address _from, address _to, uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_21 = sum_balanceOf;
if (_to == 0x0) throw;
if (_value <= 0) throw;
if (balanceOf[_from] < _value) throw;
if (balanceOf[_to] + _value < balanceOf[_to]) throw;
if (_value > allowance[_from][msg.sender]) throw;
{
uint256 opt_22 = balanceOf[_from];
{
if (true) {
assert(tmp_sum_balanceOf_21 >= opt_22);
tmp_sum_balanceOf_21 -= opt_22;
}

}

opt_22 = SafeMath.safeSub(opt_22, _value);
{
if (true) {
tmp_sum_balanceOf_21 += opt_22;
assert(tmp_sum_balanceOf_21 >= opt_22);
}

}

balanceOf[_from] = opt_22;
}

{
uint256 opt_23 = balanceOf[_to];
{
if (true) {
assert(tmp_sum_balanceOf_21 >= opt_23);
tmp_sum_balanceOf_21 -= opt_23;
}

}

opt_23 = SafeMath.safeAdd(opt_23, _value);
{
if (true) {
tmp_sum_balanceOf_21 += opt_23;
assert(tmp_sum_balanceOf_21 >= opt_23);
}

}

balanceOf[_to] = opt_23;
}

allowance[_from][msg.sender] = SafeMath.safeSub(allowance[_from][msg.sender], _value);
Transfer(_from, _to, _value);
{
sum_balanceOf = tmp_sum_balanceOf_21;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_21;
}

function burn (uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_24 = sum_balanceOf;
if (balanceOf[msg.sender] < _value) throw;
if (_value <= 0) throw;
{
uint256 opt_25 = balanceOf[msg.sender];
{
if (true) {
assert(tmp_sum_balanceOf_24 >= opt_25);
tmp_sum_balanceOf_24 -= opt_25;
}

}

opt_25 = SafeMath.safeSub(opt_25, _value);
{
if (true) {
tmp_sum_balanceOf_24 += opt_25;
assert(tmp_sum_balanceOf_24 >= opt_25);
}

}

balanceOf[msg.sender] = opt_25;
}

totalSupply = SafeMath.safeSub(totalSupply, _value);
Burn(msg.sender, _value);
{
sum_balanceOf = tmp_sum_balanceOf_24;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_24;
}

function freeze (uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_26 = sum_balanceOf;
if (balanceOf[msg.sender] < _value) throw;
if (_value <= 0) throw;
{
uint256 opt_27 = balanceOf[msg.sender];
{
if (true) {
assert(tmp_sum_balanceOf_26 >= opt_27);
tmp_sum_balanceOf_26 -= opt_27;
}

}

opt_27 = SafeMath.safeSub(opt_27, _value);
{
if (true) {
tmp_sum_balanceOf_26 += opt_27;
assert(tmp_sum_balanceOf_26 >= opt_27);
}

}

balanceOf[msg.sender] = opt_27;
}

freezeOf[msg.sender] = SafeMath.safeAdd(freezeOf[msg.sender], _value);
Freeze(msg.sender, _value);
{
sum_balanceOf = tmp_sum_balanceOf_26;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_26;
}

function unfreeze (uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_28 = sum_balanceOf;
if (freezeOf[msg.sender] < _value) throw;
if (_value <= 0) throw;
freezeOf[msg.sender] = SafeMath.safeSub(freezeOf[msg.sender], _value);
{
uint256 opt_29 = balanceOf[msg.sender];
{
if (true) {
assert(tmp_sum_balanceOf_28 >= opt_29);
tmp_sum_balanceOf_28 -= opt_29;
}

}

opt_29 = SafeMath.safeAdd(opt_29, _value);
{
if (true) {
tmp_sum_balanceOf_28 += opt_29;
assert(tmp_sum_balanceOf_28 >= opt_29);
}

}

balanceOf[msg.sender] = opt_29;
}

Unfreeze(msg.sender, _value);
{
sum_balanceOf = tmp_sum_balanceOf_28;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_28;
}

function withdrawEther (uint256 amount) {
if (msg.sender != owner) throw;
owner.transfer(amount);
}

function () payable {
}

}
