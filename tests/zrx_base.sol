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
uint256 depth_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
uint256 sum_balance;
function transfer (address _to, uint _value) public returns (bool) {
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
balances[msg.sender] -= _value;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

balances[_to] += _value;if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

emit Transfer(msg.sender, _to, _value);
{
{
{
sum_balance = 0;
}

for (uint256 index_2 = 0; index_2 < a_store_2.length; index_2 += 1) {
sum_balance += balances[a_store_2[index_2]];
assert(sum_balance >= balances[a_store_2[index_2]]);
}

}

assert(_totalSupply == sum_balance);
return true;
}

}
 else {
{
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
return false;
}

}

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
}

function transferFrom (address _from, address _to, uint _value) public returns (bool) {
if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
balances[_to] += _value;if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

balances[_from] -= _value;if (! a_checker_1[_from]) {
a_store_2.push(_from);
a_checker_1[_from] = true;
}

allowed[_from][msg.sender] -= _value;
emit Transfer(_from, _to, _value);
{
{
{
sum_balance = 0;
}

for (uint256 index_5 = 0; index_5 < a_store_2.length; index_5 += 1) {
sum_balance += balances[a_store_2[index_5]];
assert(sum_balance >= balances[a_store_2[index_5]]);
}

}

assert(_totalSupply == sum_balance);
return true;
}

}
 else {
{
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
return false;
}

}

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
uint allowance = allowed[_from][msg.sender];
if (balances[_from] >= _value && allowance >= _value && balances[_to] + _value >= balances[_to]) {
balances[_to] += _value;if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

balances[_from] -= _value;if (! a_checker_1[_from]) {
a_store_2.push(_from);
a_checker_1[_from] = true;
}

if (allowance < MAX_UINT) {
allowed[_from][msg.sender] -= _value;
}

emit Transfer(_from, _to, _value);
{
{
{
sum_balance = 0;
}

for (uint256 index_8 = 0; index_8 < a_store_2.length; index_8 += 1) {
sum_balance += balances[a_store_2[index_8]];
assert(sum_balance >= balances[a_store_2[index_8]]);
}

}

assert(_totalSupply == sum_balance);
return true;
}

}
 else {
{
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
return false;
}

}

{
{
sum_balance = 0;
}

for (uint256 index_10 = 0; index_10 < a_store_2.length; index_10 += 1) {
sum_balance += balances[a_store_2[index_10]];
assert(sum_balance >= balances[a_store_2[index_10]]);
}

}

assert(_totalSupply == sum_balance);
}

}
contract ZRXToken is UnlimitedAllowanceToken {
uint8 public constant decimals = 18;
uint public _totalSupply = 10 ** 27;
string public constant name = "0x Protocol Token";
string public constant symbol = "ZRX";
constructor () public {
balances[msg.sender] = _totalSupply;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

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
}

function transfer (address _to, uint _value) public returns (bool) {
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
balances[msg.sender] -= _value;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

balances[_to] += _value;if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

emit Transfer(msg.sender, _to, _value);
{
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
return true;
}

}
 else {
{
{
{
sum_balance = 0;
}

for (uint256 index_13 = 0; index_13 < a_store_2.length; index_13 += 1) {
sum_balance += balances[a_store_2[index_13]];
assert(sum_balance >= balances[a_store_2[index_13]]);
}

}

assert(_totalSupply == sum_balance);
return false;
}

}

{
{
sum_balance = 0;
}

for (uint256 index_14 = 0; index_14 < a_store_2.length; index_14 += 1) {
sum_balance += balances[a_store_2[index_14]];
assert(sum_balance >= balances[a_store_2[index_14]]);
}

}

assert(_totalSupply == sum_balance);
}

function balanceOf (address _owner) public view returns (uint) {
{
return balances[_owner];
}

}

}
