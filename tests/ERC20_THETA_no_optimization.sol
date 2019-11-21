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
uint256 depth_0;
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
uint256 tmp_sum_balance_40 = sum_balance;
require(balances[msg.sender] >= _value && _value > 0);
{
if (true) {
assert(tmp_sum_balance_40 >= balances[msg.sender]);
tmp_sum_balance_40 -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(_value);{
if (true) {
tmp_sum_balance_40 += balances[msg.sender];
assert(tmp_sum_balance_40 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balance_40 >= balances[_to]);
tmp_sum_balance_40 -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
tmp_sum_balance_40 += balances[_to];
assert(tmp_sum_balance_40 >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_40);
sum_balance = tmp_sum_balance_40;
return true;
}

assert(_totalSupply == tmp_sum_balance_40);
sum_balance = tmp_sum_balance_40;
}

function transferFrom (address _from, address _to, uint _value) public returns (bool success) {
uint256 tmp_sum_balance_41 = sum_balance;
require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
{
if (true) {
assert(tmp_sum_balance_41 >= balances[_from]);
tmp_sum_balance_41 -= balances[_from];
}

}
balances[_from] = balances[_from].sub(_value);{
if (true) {
tmp_sum_balance_41 += balances[_from];
assert(tmp_sum_balance_41 >= balances[_from]);
}

}

{
if (true) {
assert(tmp_sum_balance_41 >= balances[_to]);
tmp_sum_balance_41 -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
tmp_sum_balance_41 += balances[_to];
assert(tmp_sum_balance_41 >= balances[_to]);
}

}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_41);
sum_balance = tmp_sum_balance_41;
return true;
}

assert(_totalSupply == tmp_sum_balance_41);
sum_balance = tmp_sum_balance_41;
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
uint256 tmp_sum_balance_42 = sum_balance;
_totalSupply = 10000000000000000;
{
if (true) {
assert(tmp_sum_balance_42 >= balances[msg.sender]);
tmp_sum_balance_42 -= balances[msg.sender];
}

}
balances[msg.sender] = _totalSupply;{
if (true) {
tmp_sum_balance_42 += balances[msg.sender];
assert(tmp_sum_balance_42 >= balances[msg.sender]);
}

}

assert(_totalSupply == tmp_sum_balance_42);
sum_balance = tmp_sum_balance_42;
}

function transfer (address _to, uint _value) public returns (bool success) {
uint256 tmp_sum_balance_43 = sum_balance;
require(balances[msg.sender] >= _value && _value > 0);
{
if (true) {
assert(tmp_sum_balance_43 >= balances[msg.sender]);
tmp_sum_balance_43 -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(_value);{
if (true) {
tmp_sum_balance_43 += balances[msg.sender];
assert(tmp_sum_balance_43 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balance_43 >= balances[_to]);
tmp_sum_balance_43 -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
tmp_sum_balance_43 += balances[_to];
assert(tmp_sum_balance_43 >= balances[_to]);
}

}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_43);
sum_balance = tmp_sum_balance_43;
return true;
}

assert(_totalSupply == tmp_sum_balance_43);
sum_balance = tmp_sum_balance_43;
}

function transferFrom (address _from, address _to, uint _amount) can_transfer(_from, _to) public returns (bool success) {
{
return super.transferFrom(_from, _to, _amount);
}

}

function mint (address _owner, uint _amount) only_controller external returns (bool) {
uint256 tmp_sum_balance_44 = sum_balance;
_totalSupply = _totalSupply.add(_amount);
{
if (true) {
assert(tmp_sum_balance_44 >= balances[_owner]);
tmp_sum_balance_44 -= balances[_owner];
}

}
balances[_owner] = balances[_owner].add(_amount);{
if (true) {
tmp_sum_balance_44 += balances[_owner];
assert(tmp_sum_balance_44 >= balances[_owner]);
}

}

emit Transfer(address(0), _owner, _amount);
{
sum_balance = tmp_sum_balance_44;
return true;
}

sum_balance = tmp_sum_balance_44;
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
