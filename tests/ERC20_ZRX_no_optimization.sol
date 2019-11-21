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
uint256 sum_balance;
function transfer (address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balance_48 = sum_balance;
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(tmp_sum_balance_48 >= balances[msg.sender]);
tmp_sum_balance_48 -= balances[msg.sender];
}

}
balances[msg.sender] -= _value;{
if (true) {
tmp_sum_balance_48 += balances[msg.sender];
assert(tmp_sum_balance_48 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balance_48 >= balances[_to]);
tmp_sum_balance_48 -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
tmp_sum_balance_48 += balances[_to];
assert(tmp_sum_balance_48 >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_48);
sum_balance = tmp_sum_balance_48;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_48);
sum_balance = tmp_sum_balance_48;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_48);
sum_balance = tmp_sum_balance_48;
}

function transferFrom (address _from, address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balance_49 = sum_balance;
if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(tmp_sum_balance_49 >= balances[_to]);
tmp_sum_balance_49 -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
tmp_sum_balance_49 += balances[_to];
assert(tmp_sum_balance_49 >= balances[_to]);
}

}

{
if (true) {
assert(tmp_sum_balance_49 >= balances[_from]);
tmp_sum_balance_49 -= balances[_from];
}

}
balances[_from] -= _value;{
if (true) {
tmp_sum_balance_49 += balances[_from];
assert(tmp_sum_balance_49 >= balances[_from]);
}

}

allowed[_from][msg.sender] -= _value;
emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_49);
sum_balance = tmp_sum_balance_49;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_49);
sum_balance = tmp_sum_balance_49;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_49);
sum_balance = tmp_sum_balance_49;
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
uint256 tmp_sum_balance_50 = sum_balance;
uint allowance = allowed[_from][msg.sender];
if (balances[_from] >= _value && allowance >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(tmp_sum_balance_50 >= balances[_to]);
tmp_sum_balance_50 -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
tmp_sum_balance_50 += balances[_to];
assert(tmp_sum_balance_50 >= balances[_to]);
}

}

{
if (true) {
assert(tmp_sum_balance_50 >= balances[_from]);
tmp_sum_balance_50 -= balances[_from];
}

}
balances[_from] -= _value;{
if (true) {
tmp_sum_balance_50 += balances[_from];
assert(tmp_sum_balance_50 >= balances[_from]);
}

}

if (allowance < MAX_UINT) {
allowed[_from][msg.sender] -= _value;
}

emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_50);
sum_balance = tmp_sum_balance_50;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_50);
sum_balance = tmp_sum_balance_50;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_50);
sum_balance = tmp_sum_balance_50;
}

}
contract ZRXToken is UnlimitedAllowanceToken {
uint8 public constant decimals = 18;
uint public _totalSupply = 10 ** 27;
string public constant name = "0x Protocol Token";
string public constant symbol = "ZRX";
constructor () public {
uint256 tmp_sum_balance_51 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_51 >= balances[msg.sender]);
tmp_sum_balance_51 -= balances[msg.sender];
}

}
balances[msg.sender] = _totalSupply;{
if (true) {
tmp_sum_balance_51 += balances[msg.sender];
assert(tmp_sum_balance_51 >= balances[msg.sender]);
}

}

assert(_totalSupply == tmp_sum_balance_51);
sum_balance = tmp_sum_balance_51;
}

function transfer (address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balance_52 = sum_balance;
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(tmp_sum_balance_52 >= balances[msg.sender]);
tmp_sum_balance_52 -= balances[msg.sender];
}

}
balances[msg.sender] -= _value;{
if (true) {
tmp_sum_balance_52 += balances[msg.sender];
assert(tmp_sum_balance_52 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balance_52 >= balances[_to]);
tmp_sum_balance_52 -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
tmp_sum_balance_52 += balances[_to];
assert(tmp_sum_balance_52 >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_52);
sum_balance = tmp_sum_balance_52;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_52);
sum_balance = tmp_sum_balance_52;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_52);
sum_balance = tmp_sum_balance_52;
}

function balanceOf (address _owner) public view returns (uint) {
{
return balances[_owner];
}

}

}
