pragma solidity ^0.4.16;
library SafeMath {
function mul (uint256 a, uint256 b) internal constant returns (uint256) {
uint256 c = a * b;
assert(a == 0 || c / a == b);
{
return c;
}

}

function div (uint256 a, uint256 b) internal constant returns (uint256) {
uint256 c = a / b;
{
return c;
}

}

function sub (uint256 a, uint256 b) internal constant returns (uint256) {
assert(b <= a);
{
return a - b;
}

}

function add (uint256 a, uint256 b) internal constant returns (uint256) {
uint256 c = a + b;
assert(c >= a);
{
return c;
}

}

}
contract ERC20Basic {
uint256 public totalSupply;
function balanceOf (address who) constant returns (uint256);
function transfer (address to, uint256 value) returns (bool);
event Transfer(address indexed from, address indexed to, uint256 value);
}
contract ERC20 is ERC20Basic {
function allowance (address owner, address spender) constant returns (uint256);
function transferFrom (address from, address to, uint256 value) returns (bool);
function approve (address spender, uint256 value) returns (bool);
event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract ERC677 is ERC20 {
function transferAndCall (address to, uint value, bytes data) returns (bool success);
event Transfer(address indexed from, address indexed to, uint value, bytes data);
}
contract ERC677Receiver {
function onTokenTransfer (address _sender, uint _value, bytes _data);
}
contract BasicToken is ERC20Basic {
uint256 depth_0;
uint256 sum_balance;
using SafeMath for uint256;
mapping (address=>uint256) balances;
function transfer (address _to, uint256 _value) returns (bool) {
uint256 tmp_sum_balance_21 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_21 >= balances[msg.sender]);
tmp_sum_balance_21 -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(_value);{
if (true) {
tmp_sum_balance_21 += balances[msg.sender];
assert(tmp_sum_balance_21 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balance_21 >= balances[_to]);
tmp_sum_balance_21 -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
tmp_sum_balance_21 += balances[_to];
assert(tmp_sum_balance_21 >= balances[_to]);
}

}

Transfer(msg.sender, _to, _value);
{
sum_balance = tmp_sum_balance_21;
return true;
}

sum_balance = tmp_sum_balance_21;
}

function balanceOf (address _owner) constant returns (uint256 balance) {
{
return balances[_owner];
}

}

}
contract StandardToken is ERC20, BasicToken {
mapping (address=>mapping (address=>uint256)) allowed;
function transferFrom (address _from, address _to, uint256 _value) returns (bool) {
uint256 tmp_sum_balance_22 = sum_balance;
var _allowance = allowed[_from][msg.sender];
{
if (true) {
assert(tmp_sum_balance_22 >= balances[_from]);
tmp_sum_balance_22 -= balances[_from];
}

}
balances[_from] = balances[_from].sub(_value);{
if (true) {
tmp_sum_balance_22 += balances[_from];
assert(tmp_sum_balance_22 >= balances[_from]);
}

}

{
if (true) {
assert(tmp_sum_balance_22 >= balances[_to]);
tmp_sum_balance_22 -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
tmp_sum_balance_22 += balances[_to];
assert(tmp_sum_balance_22 >= balances[_to]);
}

}

allowed[_from][msg.sender] = _allowance.sub(_value);
Transfer(_from, _to, _value);
{
sum_balance = tmp_sum_balance_22;
return true;
}

sum_balance = tmp_sum_balance_22;
}

function approve (address _spender, uint256 _value) returns (bool) {
allowed[msg.sender][_spender] = _value;
Approval(msg.sender, _spender, _value);
{
return true;
}

}

function allowance (address _owner, address _spender) constant returns (uint256 remaining) {
{
return allowed[_owner][_spender];
}

}

function increaseApproval (address _spender, uint _addedValue) returns (bool success) {
allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
{
return true;
}

}

function decreaseApproval (address _spender, uint _subtractedValue) returns (bool success) {
uint oldValue = allowed[msg.sender][_spender];
if (_subtractedValue > oldValue) {
allowed[msg.sender][_spender] = 0;
}
 else {
allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
}

Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
{
return true;
}

}

}
contract ERC677Token is ERC677 {
function transferAndCall (address _to, uint _value, bytes _data) public returns (bool success) {
super.transfer(_to, _value);
Transfer(msg.sender, _to, _value, _data);
if (isContract(_to)) {
contractFallback(_to, _value, _data);
}

{
return true;
}

}

function contractFallback (address _to, uint _value, bytes _data) private {
ERC677Receiver receiver = ERC677Receiver(_to);
receiver.onTokenTransfer(msg.sender, _value, _data);
}

function isContract (address _addr) private returns (bool hasCode) {
uint length;
assembly {
length := extcodesize(_addr)
}

{
return length > 0;
}

}

}
contract LinkToken is StandardToken, ERC677Token {
uint public constant totalSupply = 10 ** 27;
string public constant name = 'ChainLink Token';
uint8 public constant decimals = 18;
string public constant symbol = 'LINK';
constructor LinkToken () public {
uint256 tmp_sum_balance_23 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_23 >= balances[msg.sender]);
tmp_sum_balance_23 -= balances[msg.sender];
}

}
balances[msg.sender] = totalSupply;{
if (true) {
tmp_sum_balance_23 += balances[msg.sender];
assert(tmp_sum_balance_23 >= balances[msg.sender]);
}

}

assert(totalSupply == tmp_sum_balance_23);
sum_balance = tmp_sum_balance_23;
}

function transferAndCall (address _to, uint _value, bytes _data) validRecipient(_to) public returns (bool success) {
{
return super.transferAndCall(_to, _value, _data);
}

}

function transfer (address _to, uint _value) validRecipient(_to) public returns (bool success) {
{
return super.transfer(_to, _value);
}

}

function approve (address _spender, uint256 _value) validRecipient(_spender) public returns (bool) {
{
return super.approve(_spender,  _value);
}

}

function transferFrom (address _from, address _to, uint256 _value) validRecipient(_to) public returns (bool) {
depth_0 += 1;
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == sum_balance);
}

return super.transferFrom(_from, _to, _value);
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(totalSupply == sum_balance);
}

}

modifier validRecipient(address _recipient) {
    require(_recipient != address(0) && _recipient != address(this));
    _;
  }
}
