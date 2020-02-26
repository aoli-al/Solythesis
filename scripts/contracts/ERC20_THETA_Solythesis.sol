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
uint256 tmp_sum_balance_22 = sum_balance;
require(balances[msg.sender] >= _value && _value > 0);
{
uint opt_23 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_22 >= opt_23);
tmp_sum_balance_22 -= opt_23;
}

}

opt_23 = opt_23.sub(_value);
{
if (true) {
tmp_sum_balance_22 += opt_23;
assert(tmp_sum_balance_22 >= opt_23);
}

}

balances[msg.sender] = opt_23;
}

{
uint opt_24 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_22 >= opt_24);
tmp_sum_balance_22 -= opt_24;
}

}

opt_24 = opt_24.add(_value);
{
if (true) {
tmp_sum_balance_22 += opt_24;
assert(tmp_sum_balance_22 >= opt_24);
}

}

balances[_to] = opt_24;
}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_22);
sum_balance = tmp_sum_balance_22;
return true;
}

assert(_totalSupply == tmp_sum_balance_22);
sum_balance = tmp_sum_balance_22;
}

function transferFrom (address _from, address _to, uint _value) public returns (bool success) {
uint256 tmp_sum_balance_25 = sum_balance;
require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
{
uint opt_26 = balances[_from];
{
if (true) {
assert(tmp_sum_balance_25 >= opt_26);
tmp_sum_balance_25 -= opt_26;
}

}

opt_26 = opt_26.sub(_value);
{
if (true) {
tmp_sum_balance_25 += opt_26;
assert(tmp_sum_balance_25 >= opt_26);
}

}

balances[_from] = opt_26;
}

{
uint opt_27 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_25 >= opt_27);
tmp_sum_balance_25 -= opt_27;
}

}

opt_27 = opt_27.add(_value);
{
if (true) {
tmp_sum_balance_25 += opt_27;
assert(tmp_sum_balance_25 >= opt_27);
}

}

balances[_to] = opt_27;
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_25);
sum_balance = tmp_sum_balance_25;
return true;
}

assert(_totalSupply == tmp_sum_balance_25);
sum_balance = tmp_sum_balance_25;
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
uint256 tmp_sum_balance_28 = sum_balance;
_totalSupply = 10000000000000000;
{
uint opt_29 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_28 >= opt_29);
tmp_sum_balance_28 -= opt_29;
}

}

opt_29 = _totalSupply;
{
if (true) {
tmp_sum_balance_28 += opt_29;
assert(tmp_sum_balance_28 >= opt_29);
}

}

balances[msg.sender] = opt_29;
}

assert(_totalSupply == tmp_sum_balance_28);
sum_balance = tmp_sum_balance_28;
}

function transfer (address _to, uint _value) public returns (bool success) {
uint256 tmp_sum_balance_30 = sum_balance;
require(balances[msg.sender] >= _value && _value > 0);
{
uint opt_31 = balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_30 >= opt_31);
tmp_sum_balance_30 -= opt_31;
}

}

opt_31 = opt_31.sub(_value);
{
if (true) {
tmp_sum_balance_30 += opt_31;
assert(tmp_sum_balance_30 >= opt_31);
}

}

balances[msg.sender] = opt_31;
}

{
uint opt_32 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_30 >= opt_32);
tmp_sum_balance_30 -= opt_32;
}

}

opt_32 = opt_32.add(_value);
{
if (true) {
tmp_sum_balance_30 += opt_32;
assert(tmp_sum_balance_30 >= opt_32);
}

}

balances[_to] = opt_32;
}

emit Transfer(msg.sender, _to, _value);
{
assert(_totalSupply == tmp_sum_balance_30);
sum_balance = tmp_sum_balance_30;
return true;
}

assert(_totalSupply == tmp_sum_balance_30);
sum_balance = tmp_sum_balance_30;
}

function transferFrom (address _from, address _to, uint _amount) can_transfer(_from, _to) public returns (bool success) {
{
return super.transferFrom(_from, _to, _amount);
}

}

function mint (address _owner, uint _amount) only_controller external returns (bool) {
uint256 tmp_sum_balance_33 = sum_balance;
_totalSupply = _totalSupply.add(_amount);
{
uint opt_34 = balances[_owner];
{
if (true) {
assert(tmp_sum_balance_33 >= opt_34);
tmp_sum_balance_33 -= opt_34;
}

}

opt_34 = opt_34.add(_amount);
{
if (true) {
tmp_sum_balance_33 += opt_34;
assert(tmp_sum_balance_33 >= opt_34);
}

}

balances[_owner] = opt_34;
}

emit Transfer(address(0), _owner, _amount);
{
sum_balance = tmp_sum_balance_33;
return true;
}

sum_balance = tmp_sum_balance_33;
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
