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
uint256 tmp_37;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_37 := mload(0x40)
mstore(0x40, add(tmp_37, 0))
sstore(memoryStart_0_slot, tmp_37)
}

}

if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_35 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_35);
sum_balance -= opt_35;
}

}

opt_35 -= _value;
{
if (true) {
sum_balance += opt_35;
assert(sum_balance >= opt_35);
}

}

balances[msg.sender] = opt_35;
}

{
uint opt_36 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_36);
sum_balance -= opt_36;
}

}

opt_36 += _value;
{
if (true) {
sum_balance += opt_36;
assert(sum_balance >= opt_36);
}

}

balances[_to] = opt_36;
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
uint256 tmp_40;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_40 := mload(0x40)
mstore(0x40, add(tmp_40, 0))
sstore(memoryStart_0_slot, tmp_40)
}

}

if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_38 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_38);
sum_balance -= opt_38;
}

}

opt_38 += _value;
{
if (true) {
sum_balance += opt_38;
assert(sum_balance >= opt_38);
}

}

balances[_to] = opt_38;
}

{
uint opt_39 = balances[_from];
{
if (true) {
assert(sum_balance >= opt_39);
sum_balance -= opt_39;
}

}

opt_39 -= _value;
{
if (true) {
sum_balance += opt_39;
assert(sum_balance >= opt_39);
}

}

balances[_from] = opt_39;
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
uint256 tmp_43;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_43 := mload(0x40)
mstore(0x40, add(tmp_43, 0))
sstore(memoryStart_0_slot, tmp_43)
}

}

uint allowance = allowed[_from][msg.sender];
if (balances[_from] >= _value && allowance >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_41 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_41);
sum_balance -= opt_41;
}

}

opt_41 += _value;
{
if (true) {
sum_balance += opt_41;
assert(sum_balance >= opt_41);
}

}

balances[_to] = opt_41;
}

{
uint opt_42 = balances[_from];
{
if (true) {
assert(sum_balance >= opt_42);
sum_balance -= opt_42;
}

}

opt_42 -= _value;
{
if (true) {
sum_balance += opt_42;
assert(sum_balance >= opt_42);
}

}

balances[_from] = opt_42;
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
uint256 tmp_45;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_45 := mload(0x40)
mstore(0x40, add(tmp_45, 0))
sstore(memoryStart_0_slot, tmp_45)
}

}

{
uint opt_44 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_44);
sum_balance -= opt_44;
}

}

opt_44 = _totalSupply;
{
if (true) {
sum_balance += opt_44;
assert(sum_balance >= opt_44);
}

}

balances[msg.sender] = opt_44;
}

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transfer (address _to, uint _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_48;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_48 := mload(0x40)
mstore(0x40, add(tmp_48, 0))
sstore(memoryStart_0_slot, tmp_48)
}

}

if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_46 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_46);
sum_balance -= opt_46;
}

}

opt_46 -= _value;
{
if (true) {
sum_balance += opt_46;
assert(sum_balance >= opt_46);
}

}

balances[msg.sender] = opt_46;
}

{
uint opt_47 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_47);
sum_balance -= opt_47;
}

}

opt_47 += _value;
{
if (true) {
sum_balance += opt_47;
assert(sum_balance >= opt_47);
}

}

balances[_to] = opt_47;
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
