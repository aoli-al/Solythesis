pragma solidity ^0.5.0;
contract Token {
function totalSupply () public view returns (uint supply) {
}

function balanceOf (address _owner) public view returns (uint balance) {
}

function transfer (address _to, uint _value) public returns (bool success) {
}

function transferFrom (address _from, address _to, uint _value) public returns (bool success) {
}

function approve (address _spender, uint _value) public returns (bool success) {
}

function allowance (address _owner, address _spender) public view returns (uint remaining) {
}

event Transfer(address indexed _from, address indexed _to, uint _value);
event Approval(address indexed _owner, address indexed _spender, uint _value);
}
contract StandardToken is Token {
uint256 memoryStart_0;
uint256 sum_balance;
function transfer (address _to, uint _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_54;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_54 := mload(0x40)
mstore(0x40, add(tmp_54, 0))
sstore(memoryStart_0_slot, tmp_54)
}

}

if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}

}
balances[msg.sender] -= _value;{
if (true) {
sum_balance += balances[msg.sender];
assert(sum_balance >= balances[msg.sender]);
}

}

{
if (true) {
assert(sum_balance >= balances[_to]);
sum_balance -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
sum_balance += balances[_to];
assert(sum_balance >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

}
 else {
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return false;
}

}

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_55;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_55 := mload(0x40)
mstore(0x40, add(tmp_55, 0))
sstore(memoryStart_0_slot, tmp_55)
}

}

if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(sum_balance >= balances[_to]);
sum_balance -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
sum_balance += balances[_to];
assert(sum_balance >= balances[_to]);
}

}

{
if (true) {
assert(sum_balance >= balances[_from]);
sum_balance -= balances[_from];
}

}
balances[_from] -= _value;{
if (true) {
sum_balance += balances[_from];
assert(sum_balance >= balances[_from]);
}

}

allowed[_from][msg.sender] -= _value;
emit Transfer(_from, _to, _value);
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

}
 else {
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return false;
}

}

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function balanceOf (address _owner) public view returns (uint) {
{
return balances[_owner];
}

}

function approve (address _spender, uint _value) public returns (bool) {
allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
{
return true;
}

}

function allowance (address _owner, address _spender) public view returns (uint) {
{
return allowed[_owner][_spender];
}

}

mapping (address=>uint) balances;
mapping (address=>mapping (address=>uint)) allowed;
uint public _totalSupply;
}
contract UnlimitedAllowanceToken is StandardToken {
uint constant MAX_UINT = 2 ** 256 - 1;
function transferFrom (address _from, address _to, uint _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_56;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_56 := mload(0x40)
mstore(0x40, add(tmp_56, 0))
sstore(memoryStart_0_slot, tmp_56)
}

}

uint allowance = allowed[_from][msg.sender];
if (balances[_from] >= _value && allowance >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(sum_balance >= balances[_to]);
sum_balance -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
sum_balance += balances[_to];
assert(sum_balance >= balances[_to]);
}

}

{
if (true) {
assert(sum_balance >= balances[_from]);
sum_balance -= balances[_from];
}

}
balances[_from] -= _value;{
if (true) {
sum_balance += balances[_from];
assert(sum_balance >= balances[_from]);
}

}

if (allowance < MAX_UINT) {
allowed[_from][msg.sender] -= _value;
}

emit Transfer(_from, _to, _value);
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

}
 else {
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return false;
}

}

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

}
contract ZRXToken is UnlimitedAllowanceToken {
uint8 public constant decimals = 18;
uint public _totalSupply = 10 ** 27;
string public constant name = "0x Protocol Token";
string public constant symbol = "ZRX";
constructor () public {
uint256 entry_1 = 0;
uint256 tmp_57;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_57 := mload(0x40)
mstore(0x40, add(tmp_57, 0))
sstore(memoryStart_0_slot, tmp_57)
}

}

{
if (true) {
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}

}
balances[msg.sender] = _totalSupply;{
if (true) {
sum_balance += balances[msg.sender];
assert(sum_balance >= balances[msg.sender]);
}

}

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transfer (address _to, uint _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_58;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_58 := mload(0x40)
mstore(0x40, add(tmp_58, 0))
sstore(memoryStart_0_slot, tmp_58)
}

}

if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}

}
balances[msg.sender] -= _value;{
if (true) {
sum_balance += balances[msg.sender];
assert(sum_balance >= balances[msg.sender]);
}

}

{
if (true) {
assert(sum_balance >= balances[_to]);
sum_balance -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
sum_balance += balances[_to];
assert(sum_balance >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

}
 else {
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return false;
}

}

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function balanceOf (address _owner) public view returns (uint) {
{
return balances[_owner];
}

}

}
