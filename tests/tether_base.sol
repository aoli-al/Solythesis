pragma solidity ^0.5.0;
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
contract Ownable {
address public owner;
constructor () public {
owner = msg.sender;
}

modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
function transferOwnership (address newOwner) onlyOwner public {
if (newOwner != address(0)) {
owner = newOwner;
}

}

}
contract ERC20Basic {
uint public _totalSupply;
function totalSupply () public view returns (uint);
function balanceOf (address who) public view returns (uint);
function transfer (address to, uint value) public;
event Transfer(address indexed from, address indexed to, uint value);
}
contract ERC20 is ERC20Basic {
function allowance (address owner, address spender) public view returns (uint);
function transferFrom (address from, address to, uint value) public;
function approve (address spender, uint value) public;
event Approval(address indexed owner, address indexed spender, uint value);
}
contract BasicToken is Ownable, ERC20Basic {
uint256 memoryStart_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
uint256 sum_balance;
using SafeMath for uint;
mapping (address=>uint) public balances;
uint public basisPointsRate = 0;
uint public maximumFee = 0;
modifier onlyPayloadSize(uint size) {
        require(!(msg.data.length < size + 4));
        _;
    }
function transfer (address _to, uint _value) onlyPayloadSize(2 * 32) public {
uint256 entry_1 = 0;
uint256 tmp_4;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_4 := mload(0x40)
mstore(0x40, add(tmp_4, 0))
sstore(memoryStart_0_slot, tmp_4)
}

}

uint fee = (_value.mul(basisPointsRate)).div(10000);
if (fee > maximumFee) {
fee = maximumFee;
}

uint sendAmount = _value.sub(fee);
balances[msg.sender] = balances[msg.sender].sub(_value);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

balances[_to] = balances[_to].add(sendAmount);if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

if (fee > 0) {
balances[owner] = balances[owner].add(fee);if (! a_checker_1[owner]) {
a_store_2.push(owner);
a_checker_1[owner] = true;
}

emit Transfer(msg.sender, owner, fee);
}

emit Transfer(msg.sender, _to, sendAmount);
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

function balanceOf (address _owner) public view returns (uint balance) {
{
return balances[_owner];
}

}

}
contract StandardToken is BasicToken, ERC20 {
mapping (address=>mapping (address=>uint)) public allowed;
uint public constant MAX_UINT = 2 ** 256 - 1;
function transferFrom (address _from, address _to, uint _value) onlyPayloadSize(3 * 32) public {
uint256 entry_1 = 0;
uint256 tmp_6;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_6 := mload(0x40)
mstore(0x40, add(tmp_6, 0))
sstore(memoryStart_0_slot, tmp_6)
}

}

uint fee = (_value.mul(basisPointsRate)).div(10000);
if (fee > maximumFee) {
fee = maximumFee;
}

if (allowed[_from][msg.sender] < MAX_UINT) {
allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
}

uint sendAmount = _value.sub(fee);
balances[_from] = balances[_from].sub(_value);if (! a_checker_1[_from]) {
a_store_2.push(_from);
a_checker_1[_from] = true;
}

balances[_to] = balances[_to].add(sendAmount);if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

if (fee > 0) {
balances[owner] = balances[owner].add(fee);if (! a_checker_1[owner]) {
a_store_2.push(owner);
a_checker_1[owner] = true;
}

emit Transfer(_from, owner, fee);
}

emit Transfer(_from, _to, sendAmount);
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

function approve (address _spender, uint _value) onlyPayloadSize(2 * 32) public {
require(! ((_value != 0) && (allowed[msg.sender][_spender] != 0)));
allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
}

function allowance (address _owner, address _spender) public view returns (uint remaining) {
{
return allowed[_owner][_spender];
}

}

}
contract Pausable is Ownable {
event Pause();
event Unpause();
bool public paused = false;
modifier whenNotPaused() {
    require(!paused);
    _;
  }
modifier whenPaused() {
    require(paused);
    _;
  }
function pause () onlyOwner whenNotPaused public {
paused = true;
emit Pause();
}

function unpause () onlyOwner whenPaused public {
paused = false;
emit Unpause();
}

}
contract BlackList is Ownable, BasicToken {
function getBlackListStatus (address _maker) external view returns (bool) {
{
return isBlackListed[_maker];
}

}

function getOwner () external view returns (address) {
{
return owner;
}

}

mapping (address=>bool) public isBlackListed;
function addBlackList (address _evilUser) onlyOwner public {
isBlackListed[_evilUser] = true;
emit AddedBlackList(_evilUser);
}

function removeBlackList (address _clearedUser) onlyOwner public {
isBlackListed[_clearedUser] = false;
emit RemovedBlackList(_clearedUser);
}

function destroyBlackFunds (address _blackListedUser) onlyOwner public {
uint256 entry_1 = 0;
uint256 tmp_8;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_8 := mload(0x40)
mstore(0x40, add(tmp_8, 0))
sstore(memoryStart_0_slot, tmp_8)
}

}

require(isBlackListed[_blackListedUser]);
uint dirtyFunds = balanceOf(_blackListedUser);
balances[_blackListedUser] = 0;if (! a_checker_1[_blackListedUser]) {
a_store_2.push(_blackListedUser);
a_checker_1[_blackListedUser] = true;
}

_totalSupply -= dirtyFunds;
emit DestroyedBlackFunds(_blackListedUser, dirtyFunds);
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

event DestroyedBlackFunds(address _blackListedUser, uint _balance);
event AddedBlackList(address _user);
event RemovedBlackList(address _user);
}
contract UpgradedStandardToken is StandardToken {
function transferByLegacy (address from, address to, uint value) public;
function transferFromByLegacy (address sender, address from, address spender, uint value) public;
function approveByLegacy (address from, address spender, uint value) public;
}
contract TetherToken is Pausable, StandardToken, BlackList {
string public name;
string public symbol;
uint public decimals;
address public upgradedAddress;
bool public deprecated;
constructor (uint _initialSupply, string memory _name, string memory _symbol, uint _decimals) public {
uint256 entry_1 = 0;
uint256 tmp_10;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_10 := mload(0x40)
mstore(0x40, add(tmp_10, 0))
sstore(memoryStart_0_slot, tmp_10)
}

}

_totalSupply = _initialSupply;
name = _name;
symbol = _symbol;
decimals = _decimals;
balances[owner] = _initialSupply;if (! a_checker_1[owner]) {
a_store_2.push(owner);
a_checker_1[owner] = true;
}

deprecated = false;
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

function transfer (address _to, uint _value) whenNotPaused public {
uint256 entry_1 = 0;
uint256 tmp_14;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_14 := mload(0x40)
mstore(0x40, add(tmp_14, 0))
sstore(memoryStart_0_slot, tmp_14)
}

}

require(! isBlackListed[msg.sender]);
if (deprecated) {
{
UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

return ;
}

}
 else {
{
super.transfer(_to, _value);
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

return ;
}

}

if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint _value) whenNotPaused public {
uint256 entry_1 = 0;
uint256 tmp_18;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_18 := mload(0x40)
mstore(0x40, add(tmp_18, 0))
sstore(memoryStart_0_slot, tmp_18)
}

}

require(! isBlackListed[_from]);
if (deprecated) {
{
UpgradedStandardToken(upgradedAddress).transferFromByLegacy(msg.sender, _from, _to, _value);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_15 = 0; index_15 < a_store_2.length; index_15 += 1) {
sum_balance += balances[a_store_2[index_15]];
assert(sum_balance >= balances[a_store_2[index_15]]);
}

}

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return ;
}

}
 else {
{
super.transferFrom(_from, _to, _value);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_16 = 0; index_16 < a_store_2.length; index_16 += 1) {
sum_balance += balances[a_store_2[index_16]];
assert(sum_balance >= balances[a_store_2[index_16]]);
}

}

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return ;
}

}

if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_17 = 0; index_17 < a_store_2.length; index_17 += 1) {
sum_balance += balances[a_store_2[index_17]];
assert(sum_balance >= balances[a_store_2[index_17]]);
}

}

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function balanceOf (address who) public view returns (uint) {
if (deprecated) {
{
return UpgradedStandardToken(upgradedAddress).balanceOf(who);
}

}
 else {
{
return super.balanceOf(who);
}

}

}

function approve (address _spender, uint _value) onlyPayloadSize(2 * 32) public {
if (deprecated) {
{
return UpgradedStandardToken(upgradedAddress).approveByLegacy(msg.sender, _spender, _value);
}

}
 else {
{
return super.approve(_spender, _value);
}

}

}

function allowance (address _owner, address _spender) public view returns (uint remaining) {
if (deprecated) {
{
return StandardToken(upgradedAddress).allowance(_owner, _spender);
}

}
 else {
{
return super.allowance(_owner, _spender);
}

}

}

function deprecate (address _upgradedAddress) onlyOwner public {
deprecated = true;
upgradedAddress = _upgradedAddress;
emit Deprecate(_upgradedAddress);
}

function totalSupply () public view returns (uint) {
if (deprecated) {
{
return StandardToken(upgradedAddress).totalSupply();
}

}
 else {
{
return _totalSupply;
}

}

}

function issue (uint amount) onlyOwner public {
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

require(_totalSupply + amount > _totalSupply);
require(balances[owner] + amount > balances[owner]);
balances[owner] += amount;if (! a_checker_1[owner]) {
a_store_2.push(owner);
a_checker_1[owner] = true;
}

_totalSupply += amount;
emit Issue(amount);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_19 = 0; index_19 < a_store_2.length; index_19 += 1) {
sum_balance += balances[a_store_2[index_19]];
assert(sum_balance >= balances[a_store_2[index_19]]);
}

}

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function redeem (uint amount) onlyOwner public {
uint256 entry_1 = 0;
uint256 tmp_22;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_22 := mload(0x40)
mstore(0x40, add(tmp_22, 0))
sstore(memoryStart_0_slot, tmp_22)
}

}

require(_totalSupply >= amount);
require(balances[owner] >= amount);
_totalSupply -= amount;
balances[owner] -= amount;if (! a_checker_1[owner]) {
a_store_2.push(owner);
a_checker_1[owner] = true;
}

emit Redeem(amount);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_21 = 0; index_21 < a_store_2.length; index_21 += 1) {
sum_balance += balances[a_store_2[index_21]];
assert(sum_balance >= balances[a_store_2[index_21]]);
}

}

assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function setParams (uint newBasisPoints, uint newMaxFee) onlyOwner public {
require(newBasisPoints < 20);
require(newMaxFee < 50);
basisPointsRate = newBasisPoints;
maximumFee = newMaxFee.mul(10 ** decimals);
emit Params(basisPointsRate, maximumFee);
}

event Issue(uint amount);
event Redeem(uint amount);
event Deprecate(address newAddress);
event Params(uint feeBasisPoints, uint maxFee);
}
