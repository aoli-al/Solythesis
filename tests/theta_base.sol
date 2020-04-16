pragma solidity ^0.5.0;
library SafeMath {
function mul (uint a, uint b) internal pure returns (uint) {
if (a == 0) {
{
return 0;
}

}

uint c = a * b;
assert(c / a == b);
{
return c;
}

}

function div (uint a, uint b) internal pure returns (uint) {
uint c = a / b;
{
return c;
}

}

function sub (uint a, uint b) internal pure returns (uint) {
assert(b <= a);
{
return a - b;
}

}

function add (uint a, uint b) internal pure returns (uint) {
uint c = a + b;
assert(c >= a);
{
return c;
}

}

}
contract ERC20 {
function totalSupply () public view returns (uint supply);
function balanceOf (address _owner) public view returns (uint balance);
function transfer (address _to, uint _value) public returns (bool success);
function transferFrom (address _from, address _to, uint _value) public returns (bool success);
function approve (address _spender, uint _value) public returns (bool success);
function allowance (address _owner, address _spender) public view returns (uint remaining);
event Transfer(address indexed _from, address indexed _to, uint _value);
event Approval(address indexed _owner, address indexed _spender, uint _value);
}
contract StandardToken is ERC20 {
uint256 memoryStart_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
uint256 sum_balance;
using SafeMath for uint;
uint public _totalSupply;
mapping (address=>uint) balances;
mapping (address=>mapping (address=>uint)) allowed;
function totalSupply () public view returns (uint) {
{
return _totalSupply;
}

}

function balanceOf (address _owner) public view returns (uint balance) {
{
return balances[_owner];
}

}

function transfer (address _to, uint _value) public returns (bool success) {
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

require(balances[msg.sender] >= _value && _value > 0);
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

assert(_totalSupply == sum_balance);
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

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint _value) public returns (bool success) {
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

require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
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

assert(_totalSupply == sum_balance);
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

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function approve (address _spender, uint _value) public returns (bool success) {
if ((_value != 0) && (allowed[msg.sender][_spender] != 0)) {
revert();
}

allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
{
return true;
}

}

function allowance (address _owner, address _spender) public view returns (uint remaining) {
{
return allowed[_owner][_spender];
}

}

}
contract Controlled {
address public controller;
constructor () public {
controller = msg.sender;
}

function changeController (address _newController) only_controller public {
controller = _newController;
}

function getController () public view returns (address) {
{
return controller;
}

}

modifier only_controller { 
        require(msg.sender == controller);
        _; 
    }
}
contract ThetaToken is StandardToken, Controlled {
using SafeMath for uint;
string public constant name = "Theta Token";
string public constant symbol = "THETA";
uint8 public constant decimals = 18;
mapping (address=>bool) internal precirculated;
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

_totalSupply = 10000000000000000;
balances[msg.sender] = _totalSupply;if (! a_checker_1[msg.sender]) {
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

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transfer (address _to, uint _value) public returns (bool success) {
uint256 entry_1 = 0;
uint256 tmp_13;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_13 := mload(0x40)
mstore(0x40, add(tmp_13, 0))
sstore(memoryStart_0_slot, tmp_13)
}

}

require(balances[msg.sender] >= _value && _value > 0);
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

for (uint256 index_11 = 0; index_11 < a_store_2.length; index_11 += 1) {
sum_balance += balances[a_store_2[index_11]];
assert(sum_balance >= balances[a_store_2[index_11]]);
}

}

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_12 = 0; index_12 < a_store_2.length; index_12 += 1) {
sum_balance += balances[a_store_2[index_12]];
assert(sum_balance >= balances[a_store_2[index_12]]);
}

}

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint _amount) can_transfer(_from, _to) public returns (bool success) {
{
return super.transferFrom(_from, _to, _amount);
}

}

function mint (address _owner, uint _amount) only_controller external returns (bool) {
_totalSupply = _totalSupply.add(_amount);
balances[_owner] = balances[_owner].add(_amount);if (! a_checker_1[_owner]) {
a_store_2.push(_owner);
a_checker_1[_owner] = true;
}

emit Transfer(address(0), _owner, _amount);
{
return true;
}

}

function allowPrecirculation (address _addr) only_controller public {
precirculated[_addr] = true;
}

function disallowPrecirculation (address _addr) only_controller public {
precirculated[_addr] = false;
}

function isPrecirculationAllowed (address _addr) public view returns(bool) {
{
return precirculated[_addr];
}

}

modifier can_transfer(address _from, address _to) {
        require((isPrecirculationAllowed(_from) && isPrecirculationAllowed(_to)));
        _;
    }
}
