pragma solidity ^0.5.0;
contract Ownable {
address public owner;
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
constructor () public {
owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
function transferOwnership (address newOwner) onlyOwner public {
require(newOwner != address(0));
emit OwnershipTransferred(owner, newOwner);
owner = newOwner;
}

}
library SafeMath {
function mul (uint256 a, uint256 b) internal pure returns (uint256) {
if (a == 0) {
{
return 0;
}

}

uint256 c = a * b;
assert(c / a == b);
{
return c;
}

}

function div (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a / b;
{
return c;
}

}

function sub (uint256 a, uint256 b) internal pure returns (uint256) {
assert(b <= a);
{
return a - b;
}

}

function add (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a + b;
assert(c >= a);
{
return c;
}

}

}
contract HoloToken is Ownable {
uint256 memoryStart_0;
uint256 sum_balance;
string public constant name = "HoloToken";
string public constant symbol = "HOT";
uint8 public constant decimals = 18;
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
event Mint(address indexed to, uint256 amount);
event MintingFinished();
event Burn(uint256 amount);
uint256 public totalSupply;
using SafeMath for uint256;
mapping (address=>uint256) public balances;
constructor () public {
uint256 entry_1 = 0;
uint256 tmp_20;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_20 := mload(0x40)
mstore(0x40, add(tmp_20, 0))
sstore(memoryStart_0_slot, tmp_20)
}

}

totalSupply = 300000000 * 10 ** uint(decimals);
{
uint256 opt_19 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_19);
sum_balance -= opt_19;
}

}

opt_19 = totalSupply;
{
if (true) {
sum_balance += opt_19;
assert(sum_balance >= opt_19);
}

}

balances[msg.sender] = opt_19;
}

if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transfer (address _to, uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_23;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_23 := mload(0x40)
mstore(0x40, add(tmp_23, 0))
sstore(memoryStart_0_slot, tmp_23)
}

}

require(_to != address(0));
require(_value <= balances[msg.sender]);
{
uint256 opt_21 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_21);
sum_balance -= opt_21;
}

}

opt_21 = opt_21.sub(_value);
{
if (true) {
sum_balance += opt_21;
assert(sum_balance >= opt_21);
}

}

balances[msg.sender] = opt_21;
}

{
uint256 opt_22 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_22);
sum_balance -= opt_22;
}

}

opt_22 = opt_22.add(_value);
{
if (true) {
sum_balance += opt_22;
assert(sum_balance >= opt_22);
}

}

balances[_to] = opt_22;
}

emit Transfer(msg.sender, _to, _value);
{
if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function balanceOf (address _owner) public view returns (uint256 balance) {
{
return balances[_owner];
}

}

mapping (address=>mapping (address=>uint256)) public allowed;
function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_26;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_26 := mload(0x40)
mstore(0x40, add(tmp_26, 0))
sstore(memoryStart_0_slot, tmp_26)
}

}

require(_to != address(0));
require(_value <= balances[_from]);
require(_value <= allowed[_from][msg.sender]);
{
uint256 opt_24 = balances[_from];
{
if (true) {
assert(sum_balance >= opt_24);
sum_balance -= opt_24;
}

}

opt_24 = opt_24.sub(_value);
{
if (true) {
sum_balance += opt_24;
assert(sum_balance >= opt_24);
}

}

balances[_from] = opt_24;
}

{
uint256 opt_25 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_25);
sum_balance -= opt_25;
}

}

opt_25 = opt_25.add(_value);
{
if (true) {
sum_balance += opt_25;
assert(sum_balance >= opt_25);
}

}

balances[_to] = opt_25;
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
{
if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function approve (address _spender, uint256 _value) public returns (bool) {
allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
{
return true;
}

}

function allowance (address _owner, address _spender) public view returns (uint256) {
{
return allowed[_owner][_spender];
}

}

function increaseApproval (address _spender, uint _addedValue) public returns (bool) {
allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
{
return true;
}

}

function decreaseApproval (address _spender, uint _subtractedValue) public returns (bool) {
uint oldValue = allowed[msg.sender][_spender];
if (_subtractedValue > oldValue) {
allowed[msg.sender][_spender] = 0;
}
 else {
allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
}

emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
{
return true;
}

}

}
