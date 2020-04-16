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
uint256 tmp_44;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_44 := mload(0x40)
mstore(0x40, add(tmp_44, 0))
sstore(memoryStart_0_slot, tmp_44)
}

}

uint fee = (_value.mul(basisPointsRate)).div(10000);
if (fee > maximumFee) {
fee = maximumFee;
}

uint sendAmount = _value.sub(fee);
{
uint opt_41 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_41);
sum_balance -= opt_41;
}

}

opt_41 = opt_41.sub(_value);
{
if (true) {
sum_balance += opt_41;
assert(sum_balance >= opt_41);
}

}

balances[msg.sender] = opt_41;
}

{
uint opt_42 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_42);
sum_balance -= opt_42;
}

}

opt_42 = opt_42.add(sendAmount);
{
if (true) {
sum_balance += opt_42;
assert(sum_balance >= opt_42);
}

}

balances[_to] = opt_42;
}

if (fee > 0) {
{
uint opt_43 = balances[owner];
{
if (true) {
assert(sum_balance >= opt_43);
sum_balance -= opt_43;
}

}

opt_43 = opt_43.add(fee);
{
if (true) {
sum_balance += opt_43;
assert(sum_balance >= opt_43);
}

}

balances[owner] = opt_43;
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
uint256 tmp_48;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_48 := mload(0x40)
mstore(0x40, add(tmp_48, 0))
sstore(memoryStart_0_slot, tmp_48)
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
uint opt_45 = balances[_from];
{
if (true) {
assert(sum_balance >= opt_45);
sum_balance -= opt_45;
}

}

opt_45 = opt_45.sub(_value);
{
if (true) {
sum_balance += opt_45;
assert(sum_balance >= opt_45);
}

}

balances[_from] = opt_45;
}

{
uint opt_46 = balances[_to];
{
if (true) {
assert(sum_balance >= opt_46);
sum_balance -= opt_46;
}

}

opt_46 = opt_46.add(sendAmount);
{
if (true) {
sum_balance += opt_46;
assert(sum_balance >= opt_46);
}

}

balances[_to] = opt_46;
}

if (fee > 0) {
{
uint opt_47 = balances[owner];
{
if (true) {
assert(sum_balance >= opt_47);
sum_balance -= opt_47;
}

}

opt_47 = opt_47.add(fee);
{
if (true) {
sum_balance += opt_47;
assert(sum_balance >= opt_47);
}

}

balances[owner] = opt_47;
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
uint256 tmp_50;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_50 := mload(0x40)
mstore(0x40, add(tmp_50, 0))
sstore(memoryStart_0_slot, tmp_50)
}

}

require(isBlackListed[_blackListedUser]);
uint dirtyFunds = balanceOf(_blackListedUser);
{
uint opt_49 = balances[_blackListedUser];
{
if (true) {
assert(sum_balance >= opt_49);
sum_balance -= opt_49;
}

}

opt_49 = 0;
{
if (true) {
sum_balance += opt_49;
assert(sum_balance >= opt_49);
}

}

balances[_blackListedUser] = opt_49;
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
uint256 tmp_52;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_52 := mload(0x40)
mstore(0x40, add(tmp_52, 0))
sstore(memoryStart_0_slot, tmp_52)
}

}

_totalSupply = _initialSupply;
name = _name;
symbol = _symbol;
decimals = _decimals;
{
uint opt_51 = balances[owner];
{
if (true) {
assert(sum_balance >= opt_51);
sum_balance -= opt_51;
}

}

opt_51 = _initialSupply;
{
if (true) {
sum_balance += opt_51;
assert(sum_balance >= opt_51);
}

}

balances[owner] = opt_51;
}

deprecated = false;
if (entry_1 == 1) {
assert(_totalSupply == sum_balance);
memoryStart_0 = 0;
}

}

function transfer (address _to, uint _value) whenNotPaused public {
uint256 entry_1 = 0;
uint256 tmp_53;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_53 := mload(0x40)
mstore(0x40, add(tmp_53, 0))
sstore(memoryStart_0_slot, tmp_53)
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
uint256 tmp_54;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_54 := mload(0x40)
mstore(0x40, add(tmp_54, 0))
sstore(memoryStart_0_slot, tmp_54)
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
uint256 tmp_56;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_56 := mload(0x40)
mstore(0x40, add(tmp_56, 0))
sstore(memoryStart_0_slot, tmp_56)
}

}

require(_totalSupply + amount > _totalSupply);
require(balances[owner] + amount > balances[owner]);
{
uint opt_55 = balances[owner];
{
if (true) {
assert(sum_balance >= opt_55);
sum_balance -= opt_55;
}

}

opt_55 += amount;
{
if (true) {
sum_balance += opt_55;
assert(sum_balance >= opt_55);
}

}

balances[owner] = opt_55;
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
uint256 tmp_58;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_58 := mload(0x40)
mstore(0x40, add(tmp_58, 0))
sstore(memoryStart_0_slot, tmp_58)
}

}

require(_totalSupply >= amount);
require(balances[owner] >= amount);
_totalSupply -= amount;
{
uint opt_57 = balances[owner];
{
if (true) {
assert(sum_balance >= opt_57);
sum_balance -= opt_57;
}

}

opt_57 -= amount;
{
if (true) {
sum_balance += opt_57;
assert(sum_balance >= opt_57);
}

}

balances[owner] = opt_57;
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
