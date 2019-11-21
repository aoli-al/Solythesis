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
uint256 tmp_sum_balance_29 = sum_balance;
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_30 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_29 >= opt_30);
tmp_sum_balance_29 -= opt_30;
}

}

opt_30 -= _value;
{
if (true) {
tmp_sum_balance_29 += opt_30;
assert(tmp_sum_balance_29 >= opt_30);
}

}

balances[msg.sender] = opt_30;
}

{
uint opt_31 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_29 >= opt_31);
tmp_sum_balance_29 -= opt_31;
}

}

opt_31 += _value;
{
if (true) {
tmp_sum_balance_29 += opt_31;
assert(tmp_sum_balance_29 >= opt_31);
}

}

balances[_to] = opt_31;
}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_29);
sum_balance = tmp_sum_balance_29;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_29);
sum_balance = tmp_sum_balance_29;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_29);
sum_balance = tmp_sum_balance_29;
}

function transferFrom (address _from, address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balance_32 = sum_balance;
if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_33 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_32 >= opt_33);
tmp_sum_balance_32 -= opt_33;
}

}

opt_33 += _value;
{
if (true) {
tmp_sum_balance_32 += opt_33;
assert(tmp_sum_balance_32 >= opt_33);
}

}

balances[_to] = opt_33;
}

{
uint opt_34 = balances[_from];
{
if (true) {
assert(tmp_sum_balance_32 >= opt_34);
tmp_sum_balance_32 -= opt_34;
}

}

opt_34 -= _value;
{
if (true) {
tmp_sum_balance_32 += opt_34;
assert(tmp_sum_balance_32 >= opt_34);
}

}

balances[_from] = opt_34;
}

allowed[_from][msg.sender] -= _value;
emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_32);
sum_balance = tmp_sum_balance_32;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_32);
sum_balance = tmp_sum_balance_32;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_32);
sum_balance = tmp_sum_balance_32;
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
uint256 tmp_sum_balance_35 = sum_balance;
uint allowance = allowed[_from][msg.sender];
if (balances[_from] >= _value && allowance >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_36 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_35 >= opt_36);
tmp_sum_balance_35 -= opt_36;
}

}

opt_36 += _value;
{
if (true) {
tmp_sum_balance_35 += opt_36;
assert(tmp_sum_balance_35 >= opt_36);
}

}

balances[_to] = opt_36;
}

{
uint opt_37 = balances[_from];
{
if (true) {
assert(tmp_sum_balance_35 >= opt_37);
tmp_sum_balance_35 -= opt_37;
}

}

opt_37 -= _value;
{
if (true) {
tmp_sum_balance_35 += opt_37;
assert(tmp_sum_balance_35 >= opt_37);
}

}

balances[_from] = opt_37;
}

if (allowance < MAX_UINT) {
allowed[_from][msg.sender] -= _value;
}

emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_35);
sum_balance = tmp_sum_balance_35;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_35);
sum_balance = tmp_sum_balance_35;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_35);
sum_balance = tmp_sum_balance_35;
}

}
contract ZRXToken is UnlimitedAllowanceToken {
uint8 public constant decimals = 18;
uint public _totalSupply = 10 ** 27;
string public constant name = "0x Protocol Token";
string public constant symbol = "ZRX";
constructor () public {
uint256 tmp_sum_balance_38 = sum_balance;
{
uint opt_39 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_38 >= opt_39);
tmp_sum_balance_38 -= opt_39;
}

}

opt_39 = _totalSupply;
{
if (true) {
tmp_sum_balance_38 += opt_39;
assert(tmp_sum_balance_38 >= opt_39);
}

}

balances[msg.sender] = opt_39;
}

assert(_totalSupply == tmp_sum_balance_38);
sum_balance = tmp_sum_balance_38;
}

function transfer (address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balance_40 = sum_balance;
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_41 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_40 >= opt_41);
tmp_sum_balance_40 -= opt_41;
}

}

opt_41 -= _value;
{
if (true) {
tmp_sum_balance_40 += opt_41;
assert(tmp_sum_balance_40 >= opt_41);
}

}

balances[msg.sender] = opt_41;
}

{
uint opt_42 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_40 >= opt_42);
tmp_sum_balance_40 -= opt_42;
}

}

opt_42 += _value;
{
if (true) {
tmp_sum_balance_40 += opt_42;
assert(tmp_sum_balance_40 >= opt_42);
}

}

balances[_to] = opt_42;
}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_40);
sum_balance = tmp_sum_balance_40;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balance_40);
sum_balance = tmp_sum_balance_40;
return false;
}

}

assert(_totalSupply == tmp_sum_balance_40);
sum_balance = tmp_sum_balance_40;
}

function balanceOf (address _owner) public view returns (uint) {
{
return balances[_owner];
}

}

}
