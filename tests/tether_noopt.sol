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
uint256 tmp_67;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_67 := mload(0x40)
mstore(0x40, add(tmp_67, 0))
sstore(memoryStart_0_slot, tmp_67)
}

}

uint fee = (_value.mul(basisPointsRate)).div(10000);
if (fee > maximumFee) {
fee = maximumFee;
}

uint sendAmount = _value.sub(fee);
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
balances[_to] = balances[_to].add(sendAmount);{
if (true) {
sum_balance += balances[_to];
assert(sum_balance >= balances[_to]);
}

}

if (fee > 0) {
{
if (true) {
assert(sum_balance >= balances[owner]);
sum_balance -= balances[owner];
}

}
balances[owner] = balances[owner].add(fee);{
if (true) {
sum_balance += balances[owner];
assert(sum_balance >= balances[owner]);
}

}

emit Transfer(msg.sender, owner, fee);
}

emit Transfer(msg.sender, _to, sendAmount);
if (entry_1 == 1) {
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
uint256 tmp_68;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_68 := mload(0x40)
mstore(0x40, add(tmp_68, 0))
sstore(memoryStart_0_slot, tmp_68)
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
balances[_to] = balances[_to].add(sendAmount);{
if (true) {
sum_balance += balances[_to];
assert(sum_balance >= balances[_to]);
}

}

if (fee > 0) {
{
if (true) {
assert(sum_balance >= balances[owner]);
sum_balance -= balances[owner];
}

}
balances[owner] = balances[owner].add(fee);{
if (true) {
sum_balance += balances[owner];
assert(sum_balance >= balances[owner]);
}

}

emit Transfer(_from, owner, fee);
}

emit Transfer(_from, _to, sendAmount);
if (entry_1 == 1) {
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
uint256 tmp_69;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_69 := mload(0x40)
mstore(0x40, add(tmp_69, 0))
sstore(memoryStart_0_slot, tmp_69)
}

}

require(isBlackListed[_blackListedUser]);
uint dirtyFunds = balanceOf(_blackListedUser);
{
if (true) {
assert(sum_balance >= balances[_blackListedUser]);
sum_balance -= balances[_blackListedUser];
}

}
balances[_blackListedUser] = 0;{
if (true) {
sum_balance += balances[_blackListedUser];
assert(sum_balance >= balances[_blackListedUser]);
}

}

_totalSupply -= dirtyFunds;
emit DestroyedBlackFunds(_blackListedUser, dirtyFunds);
if (entry_1 == 1) {
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
uint256 tmp_70;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_70 := mload(0x40)
mstore(0x40, add(tmp_70, 0))
sstore(memoryStart_0_slot, tmp_70)
}

}

_totalSupply = _initialSupply;
name = _name;
symbol = _symbol;
decimals = _decimals;
{
if (true) {
assert(sum_balance >= balances[owner]);
sum_balance -= balances[owner];
}

}
balances[owner] = _initialSupply;{
if (true) {
sum_balance += balances[owner];
assert(sum_balance >= balances[owner]);
}

}

deprecated = false;
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transfer (address _to, uint _value) whenNotPaused public {
uint256 entry_1 = 0;
uint256 tmp_71;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_71 := mload(0x40)
mstore(0x40, add(tmp_71, 0))
sstore(memoryStart_0_slot, tmp_71)
}

}

require(! isBlackListed[msg.sender]);
if (deprecated) {
{
UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
if (entry_1 == 1) {
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
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return ;
}

}

if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address _from, address _to, uint _value) whenNotPaused public {
uint256 entry_1 = 0;
uint256 tmp_72;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_72 := mload(0x40)
mstore(0x40, add(tmp_72, 0))
sstore(memoryStart_0_slot, tmp_72)
}

}

require(! isBlackListed[_from]);
if (deprecated) {
{
UpgradedStandardToken(upgradedAddress).transferFromByLegacy(msg.sender, _from, _to, _value);
if (entry_1 == 1) {
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
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

return ;
}

}

if (entry_1 == 1) {
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
uint256 tmp_73;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_73 := mload(0x40)
mstore(0x40, add(tmp_73, 0))
sstore(memoryStart_0_slot, tmp_73)
}

}

require(_totalSupply + amount > _totalSupply);
require(balances[owner] + amount > balances[owner]);
{
if (true) {
assert(sum_balance >= balances[owner]);
sum_balance -= balances[owner];
}

}
balances[owner] += amount;{
if (true) {
sum_balance += balances[owner];
assert(sum_balance >= balances[owner]);
}

}

_totalSupply += amount;
emit Issue(amount);
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function redeem (uint amount) onlyOwner public {
uint256 entry_1 = 0;
uint256 tmp_74;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_74 := mload(0x40)
mstore(0x40, add(tmp_74, 0))
sstore(memoryStart_0_slot, tmp_74)
}

}

require(_totalSupply >= amount);
require(balances[owner] >= amount);
_totalSupply -= amount;
{
if (true) {
assert(sum_balance >= balances[owner]);
sum_balance -= balances[owner];
}

}
balances[owner] -= amount;{
if (true) {
sum_balance += balances[owner];
assert(sum_balance >= balances[owner]);
}

}

emit Redeem(amount);
if (entry_1 == 1) {
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
