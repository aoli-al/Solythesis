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
contract RegularToken is Token {
uint256 depth_0;
uint256 sum_balanceOf;
function transfer (address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balanceOf_13 = sum_balanceOf;
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_14 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balanceOf_13 >= opt_14);
tmp_sum_balanceOf_13 -= opt_14;
}

}

opt_14 -= _value;
{
if (true) {
tmp_sum_balanceOf_13 += opt_14;
assert(tmp_sum_balanceOf_13 >= opt_14);
}

}

balances[msg.sender] = opt_14;
}

{
uint opt_15 = balances[_to];
{
if (true) {
assert(tmp_sum_balanceOf_13 >= opt_15);
tmp_sum_balanceOf_13 -= opt_15;
}

}

opt_15 += _value;
{
if (true) {
tmp_sum_balanceOf_13 += opt_15;
assert(tmp_sum_balanceOf_13 >= opt_15);
}

}

balances[_to] = opt_15;
}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balanceOf_13);
sum_balanceOf = tmp_sum_balanceOf_13;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balanceOf_13);
sum_balanceOf = tmp_sum_balanceOf_13;
return false;
}

}

assert(_totalSupply == tmp_sum_balanceOf_13);
sum_balanceOf = tmp_sum_balanceOf_13;
}

function transferFrom (address _from, address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balanceOf_16 = sum_balanceOf;
if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_17 = balances[_to];
{
if (true) {
assert(tmp_sum_balanceOf_16 >= opt_17);
tmp_sum_balanceOf_16 -= opt_17;
}

}

opt_17 += _value;
{
if (true) {
tmp_sum_balanceOf_16 += opt_17;
assert(tmp_sum_balanceOf_16 >= opt_17);
}

}

balances[_to] = opt_17;
}

{
uint opt_18 = balances[_from];
{
if (true) {
assert(tmp_sum_balanceOf_16 >= opt_18);
tmp_sum_balanceOf_16 -= opt_18;
}

}

opt_18 -= _value;
{
if (true) {
tmp_sum_balanceOf_16 += opt_18;
assert(tmp_sum_balanceOf_16 >= opt_18);
}

}

balances[_from] = opt_18;
}

allowed[_from][msg.sender] -= _value;
emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balanceOf_16);
sum_balanceOf = tmp_sum_balanceOf_16;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balanceOf_16);
sum_balanceOf = tmp_sum_balanceOf_16;
return false;
}

}

assert(_totalSupply == tmp_sum_balanceOf_16);
sum_balanceOf = tmp_sum_balanceOf_16;
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
contract UnboundedRegularToken is RegularToken {
uint constant MAX_UINT = 2 ** 256 - 1;
function transferFrom (address _from, address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balanceOf_19 = sum_balanceOf;
uint allowance = allowed[_from][msg.sender];
if (balances[_from] >= _value && allowance >= _value && balances[_to] + _value >= balances[_to]) {
{
uint opt_20 = balances[_to];
{
if (true) {
assert(tmp_sum_balanceOf_19 >= opt_20);
tmp_sum_balanceOf_19 -= opt_20;
}

}

opt_20 += _value;
{
if (true) {
tmp_sum_balanceOf_19 += opt_20;
assert(tmp_sum_balanceOf_19 >= opt_20);
}

}

balances[_to] = opt_20;
}

{
uint opt_21 = balances[_from];
{
if (true) {
assert(tmp_sum_balanceOf_19 >= opt_21);
tmp_sum_balanceOf_19 -= opt_21;
}

}

opt_21 -= _value;
{
if (true) {
tmp_sum_balanceOf_19 += opt_21;
assert(tmp_sum_balanceOf_19 >= opt_21);
}

}

balances[_from] = opt_21;
}

if (allowance < MAX_UINT) {
allowed[_from][msg.sender] -= _value;
}

emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balanceOf_19);
sum_balanceOf = tmp_sum_balanceOf_19;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balanceOf_19);
sum_balanceOf = tmp_sum_balanceOf_19;
return false;
}

}

assert(_totalSupply == tmp_sum_balanceOf_19);
sum_balanceOf = tmp_sum_balanceOf_19;
}

}
contract HBToken is UnboundedRegularToken {
uint public _totalSupply = 5 * 10 ** 26;
uint8 public constant decimals = 18;
string public constant name = "HuobiToken";
string public constant symbol = "HT";
constructor () public {
uint256 tmp_sum_balanceOf_22 = sum_balanceOf;
{
uint opt_23 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balanceOf_22 >= opt_23);
tmp_sum_balanceOf_22 -= opt_23;
}

}

opt_23 = _totalSupply;
{
if (true) {
tmp_sum_balanceOf_22 += opt_23;
assert(tmp_sum_balanceOf_22 >= opt_23);
}

}

balances[msg.sender] = opt_23;
}

emit Transfer(address(0), msg.sender, _totalSupply);
assert(_totalSupply == tmp_sum_balanceOf_22);
sum_balanceOf = tmp_sum_balanceOf_22;
}

}
