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
uint256 tmp_sum_balanceOf_28 = sum_balanceOf;
if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(tmp_sum_balanceOf_28 >= balances[msg.sender]);
tmp_sum_balanceOf_28 -= balances[msg.sender];
}

}
balances[msg.sender] -= _value;{
if (true) {
tmp_sum_balanceOf_28 += balances[msg.sender];
assert(tmp_sum_balanceOf_28 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balanceOf_28 >= balances[_to]);
tmp_sum_balanceOf_28 -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
tmp_sum_balanceOf_28 += balances[_to];
assert(tmp_sum_balanceOf_28 >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balanceOf_28);
sum_balanceOf = tmp_sum_balanceOf_28;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balanceOf_28);
sum_balanceOf = tmp_sum_balanceOf_28;
return false;
}

}

assert(_totalSupply == tmp_sum_balanceOf_28);
sum_balanceOf = tmp_sum_balanceOf_28;
}

function transferFrom (address _from, address _to, uint _value) public returns (bool) {
uint256 tmp_sum_balanceOf_29 = sum_balanceOf;
if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(tmp_sum_balanceOf_29 >= balances[_to]);
tmp_sum_balanceOf_29 -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
tmp_sum_balanceOf_29 += balances[_to];
assert(tmp_sum_balanceOf_29 >= balances[_to]);
}

}

{
if (true) {
assert(tmp_sum_balanceOf_29 >= balances[_from]);
tmp_sum_balanceOf_29 -= balances[_from];
}

}
balances[_from] -= _value;{
if (true) {
tmp_sum_balanceOf_29 += balances[_from];
assert(tmp_sum_balanceOf_29 >= balances[_from]);
}

}

allowed[_from][msg.sender] -= _value;
emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balanceOf_29);
sum_balanceOf = tmp_sum_balanceOf_29;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balanceOf_29);
sum_balanceOf = tmp_sum_balanceOf_29;
return false;
}

}

assert(_totalSupply == tmp_sum_balanceOf_29);
sum_balanceOf = tmp_sum_balanceOf_29;
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
uint256 tmp_sum_balanceOf_30 = sum_balanceOf;
uint allowance = allowed[_from][msg.sender];
if (balances[_from] >= _value && allowance >= _value && balances[_to] + _value >= balances[_to]) {
{
if (true) {
assert(tmp_sum_balanceOf_30 >= balances[_to]);
tmp_sum_balanceOf_30 -= balances[_to];
}

}
balances[_to] += _value;{
if (true) {
tmp_sum_balanceOf_30 += balances[_to];
assert(tmp_sum_balanceOf_30 >= balances[_to]);
}

}

{
if (true) {
assert(tmp_sum_balanceOf_30 >= balances[_from]);
tmp_sum_balanceOf_30 -= balances[_from];
}

}
balances[_from] -= _value;{
if (true) {
tmp_sum_balanceOf_30 += balances[_from];
assert(tmp_sum_balanceOf_30 >= balances[_from]);
}

}

if (allowance < MAX_UINT) {
allowed[_from][msg.sender] -= _value;
}

emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balanceOf_30);
sum_balanceOf = tmp_sum_balanceOf_30;
return true;
}

}
 else {
{
assert(_totalSupply == tmp_sum_balanceOf_30);
sum_balanceOf = tmp_sum_balanceOf_30;
return false;
}

}

assert(_totalSupply == tmp_sum_balanceOf_30);
sum_balanceOf = tmp_sum_balanceOf_30;
}

}
contract HBToken is UnboundedRegularToken {
uint public _totalSupply = 5 * 10 ** 26;
uint8 public constant decimals = 18;
string public constant name = "HuobiToken";
string public constant symbol = "HT";
constructor () public {
uint256 tmp_sum_balanceOf_31 = sum_balanceOf;
{
if (true) {
assert(tmp_sum_balanceOf_31 >= balances[msg.sender]);
tmp_sum_balanceOf_31 -= balances[msg.sender];
}

}
balances[msg.sender] = _totalSupply;{
if (true) {
tmp_sum_balanceOf_31 += balances[msg.sender];
assert(tmp_sum_balanceOf_31 >= balances[msg.sender]);
}

}

emit Transfer(address(0), msg.sender, _totalSupply);
assert(_totalSupply == tmp_sum_balanceOf_31);
sum_balanceOf = tmp_sum_balanceOf_31;
}

}
