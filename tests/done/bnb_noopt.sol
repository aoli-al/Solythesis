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
uint256 tmp_sum_balanceOf_36 = sum_balanceOf;
{
if (true) {
assert(tmp_sum_balanceOf_36 >= balanceOf[msg.sender]);
tmp_sum_balanceOf_36 -= balanceOf[msg.sender];
}

}
balanceOf[msg.sender] = initialSupply;{
if (true) {
tmp_sum_balanceOf_36 += balanceOf[msg.sender];
assert(tmp_sum_balanceOf_36 >= balanceOf[msg.sender]);
}

}

totalSupply = initialSupply;
name = tokenName;
symbol = tokenSymbol;
decimals = decimalUnits;
owner = msg.sender;
sum_balanceOf = tmp_sum_balanceOf_36;
}

function transfer (address _to, uint256 _value) {
uint256 tmp_sum_balanceOf_37 = sum_balanceOf;
if (_to == 0x0) throw;
if (_value <= 0) throw;
if (balanceOf[msg.sender] < _value) throw;
if (balanceOf[_to] + _value < balanceOf[_to]) throw;
{
if (true) {
assert(tmp_sum_balanceOf_37 >= balanceOf[msg.sender]);
tmp_sum_balanceOf_37 -= balanceOf[msg.sender];
}

}
balanceOf[msg.sender] = SafeMath.safeSub(balanceOf[msg.sender], _value);{
if (true) {
tmp_sum_balanceOf_37 += balanceOf[msg.sender];
assert(tmp_sum_balanceOf_37 >= balanceOf[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balanceOf_37 >= balanceOf[_to]);
tmp_sum_balanceOf_37 -= balanceOf[_to];
}

}
balanceOf[_to] = SafeMath.safeAdd(balanceOf[_to], _value);{
if (true) {
tmp_sum_balanceOf_37 += balanceOf[_to];
assert(tmp_sum_balanceOf_37 >= balanceOf[_to]);
}

}

Transfer(msg.sender, _to, _value);
sum_balanceOf = tmp_sum_balanceOf_37;
}

function approve (address _spender, uint256 _value) returns (bool success) {
if (_value <= 0) throw;
allowance[msg.sender][_spender] = _value;
{
return true;
}

}

function transferFrom (address _from, address _to, uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_38 = sum_balanceOf;
if (_to == 0x0) throw;
if (_value <= 0) throw;
if (balanceOf[_from] < _value) throw;
if (balanceOf[_to] + _value < balanceOf[_to]) throw;
if (_value > allowance[_from][msg.sender]) throw;
{
if (true) {
assert(tmp_sum_balanceOf_38 >= balanceOf[_from]);
tmp_sum_balanceOf_38 -= balanceOf[_from];
}

}
balanceOf[_from] = SafeMath.safeSub(balanceOf[_from], _value);{
if (true) {
tmp_sum_balanceOf_38 += balanceOf[_from];
assert(tmp_sum_balanceOf_38 >= balanceOf[_from]);
}

}

{
if (true) {
assert(tmp_sum_balanceOf_38 >= balanceOf[_to]);
tmp_sum_balanceOf_38 -= balanceOf[_to];
}

}
balanceOf[_to] = SafeMath.safeAdd(balanceOf[_to], _value);{
if (true) {
tmp_sum_balanceOf_38 += balanceOf[_to];
assert(tmp_sum_balanceOf_38 >= balanceOf[_to]);
}

}

allowance[_from][msg.sender] = SafeMath.safeSub(allowance[_from][msg.sender], _value);
Transfer(_from, _to, _value);
{
sum_balanceOf = tmp_sum_balanceOf_38;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_38;
}

function burn (uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_39 = sum_balanceOf;
if (balanceOf[msg.sender] < _value) throw;
if (_value <= 0) throw;
{
if (true) {
assert(tmp_sum_balanceOf_39 >= balanceOf[msg.sender]);
tmp_sum_balanceOf_39 -= balanceOf[msg.sender];
}

}
balanceOf[msg.sender] = SafeMath.safeSub(balanceOf[msg.sender], _value);{
if (true) {
tmp_sum_balanceOf_39 += balanceOf[msg.sender];
assert(tmp_sum_balanceOf_39 >= balanceOf[msg.sender]);
}

}

totalSupply = SafeMath.safeSub(totalSupply, _value);
Burn(msg.sender, _value);
{
sum_balanceOf = tmp_sum_balanceOf_39;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_39;
}

function freeze (uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_40 = sum_balanceOf;
if (balanceOf[msg.sender] < _value) throw;
if (_value <= 0) throw;
{
if (true) {
assert(tmp_sum_balanceOf_40 >= balanceOf[msg.sender]);
tmp_sum_balanceOf_40 -= balanceOf[msg.sender];
}

}
balanceOf[msg.sender] = SafeMath.safeSub(balanceOf[msg.sender], _value);{
if (true) {
tmp_sum_balanceOf_40 += balanceOf[msg.sender];
assert(tmp_sum_balanceOf_40 >= balanceOf[msg.sender]);
}

}

freezeOf[msg.sender] = SafeMath.safeAdd(freezeOf[msg.sender], _value);
Freeze(msg.sender, _value);
{
sum_balanceOf = tmp_sum_balanceOf_40;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_40;
}

function unfreeze (uint256 _value) returns (bool success) {
uint256 tmp_sum_balanceOf_41 = sum_balanceOf;
if (freezeOf[msg.sender] < _value) throw;
if (_value <= 0) throw;
freezeOf[msg.sender] = SafeMath.safeSub(freezeOf[msg.sender], _value);
{
if (true) {
assert(tmp_sum_balanceOf_41 >= balanceOf[msg.sender]);
tmp_sum_balanceOf_41 -= balanceOf[msg.sender];
}

}
balanceOf[msg.sender] = SafeMath.safeAdd(balanceOf[msg.sender], _value);{
if (true) {
tmp_sum_balanceOf_41 += balanceOf[msg.sender];
assert(tmp_sum_balanceOf_41 >= balanceOf[msg.sender]);
}

}

Unfreeze(msg.sender, _value);
{
sum_balanceOf = tmp_sum_balanceOf_41;
return true;
}

sum_balanceOf = tmp_sum_balanceOf_41;
}

function withdrawEther (uint256 amount) {
if (msg.sender != owner) throw;
owner.transfer(amount);
}

function () payable {
}

}
