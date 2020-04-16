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
uint256 tmp_30;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_30 := mload(0x40)
mstore(0x40, add(tmp_30, 0))
sstore(memoryStart_0_slot, tmp_30)
}

}

totalSupply = 300000000 * 10 ** uint(decimals);
{
if (true) {
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}

}
balances[msg.sender] = totalSupply;{
if (true) {
sum_balance += balances[msg.sender];
assert(sum_balance >= balances[msg.sender]);
}

}

if (entry_1 == 1) {
assert(totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transfer (address _to, uint256 _value) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_31;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_31 := mload(0x40)
mstore(0x40, add(tmp_31, 0))
sstore(memoryStart_0_slot, tmp_31)
}

}

require(_to != address(0));
require(_value <= balances[msg.sender]);
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
uint256 tmp_32;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_32 := mload(0x40)
mstore(0x40, add(tmp_32, 0))
sstore(memoryStart_0_slot, tmp_32)
}

}

require(_to != address(0));
require(_value <= balances[_from]);
require(_value <= allowed[_from][msg.sender]);
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
