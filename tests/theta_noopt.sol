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
uint256 tmp_42;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_42 := mload(0x40)
mstore(0x40, add(tmp_42, 0))
sstore(memoryStart_0_slot, tmp_42)
}

}

require(balances[msg.sender] >= _value && _value > 0);
{
if (true) {
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(_value);{
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
balances[_to] = balances[_to].add(_value);{
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

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint _value) public returns (bool success) {
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

require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
{
if (true) {
assert(sum_balance >= balances[_from]);
sum_balance -= balances[_from];
}

}
balances[_from] = balances[_from].sub(_value);{
if (true) {
sum_balance += balances[_from];
assert(sum_balance >= balances[_from]);
}

}

{
if (true) {
assert(sum_balance >= balances[_to]);
sum_balance -= balances[_to];
}

}
balances[_to] = balances[_to].add(_value);{
if (true) {
sum_balance += balances[_to];
assert(sum_balance >= balances[_to]);
}

}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
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
uint256 tmp_44;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_44 := mload(0x40)
mstore(0x40, add(tmp_44, 0))
sstore(memoryStart_0_slot, tmp_44)
}

}

_totalSupply = 10000000000000000;
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

function transfer (address _to, uint _value) public returns (bool success) {
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

require(balances[msg.sender] >= _value && _value > 0);
{
if (true) {
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(_value);{
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
balances[_to] = balances[_to].add(_value);{
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

if (entry_1 == 1) {
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
{
if (true) {
assert(sum_balance >= balances[_owner]);
sum_balance -= balances[_owner];
}

}
balances[_owner] = balances[_owner].add(_amount);{
if (true) {
sum_balance += balances[_owner];
assert(sum_balance >= balances[_owner]);
}

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
