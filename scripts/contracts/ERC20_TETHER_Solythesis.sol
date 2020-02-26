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
uint256 depth_0;
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
depth_0 += 1;
uint256 tmp_sum_balance_30 = sum_balance;
uint fee = (_value.mul(basisPointsRate)).div(10000);
if (fee > maximumFee) {
fee = maximumFee;
}

uint sendAmount = _value.sub(fee);
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

opt_32 = opt_32.add(sendAmount);
{
if (true) {
tmp_sum_balance_30 += opt_32;
assert(tmp_sum_balance_30 >= opt_32);
}

}

balances[_to] = opt_32;
}

if (fee > 0) {
{
uint opt_33 = balances[owner];
{
if (true) {
assert(tmp_sum_balance_30 >= opt_33);
tmp_sum_balance_30 -= opt_33;
}

}

opt_33 = opt_33.add(fee);
{
if (true) {
tmp_sum_balance_30 += opt_33;
assert(tmp_sum_balance_30 >= opt_33);
}

}

balances[owner] = opt_33;
}

emit Transfer(msg.sender, owner, fee);
}

emit Transfer(msg.sender, _to, sendAmount);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == tmp_sum_balance_30);
}

sum_balance = tmp_sum_balance_30;
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
depth_0 += 1;
uint256 tmp_sum_balance_34 = sum_balance;
uint fee = (_value.mul(basisPointsRate)).div(10000);
if (fee > maximumFee) {
fee = maximumFee;
}

if (allowed[_from][msg.sender] < MAX_UINT) {
allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
}

uint sendAmount = _value.sub(fee);
{
uint opt_35 = balances[_from];
{
if (true) {
assert(tmp_sum_balance_34 >= opt_35);
tmp_sum_balance_34 -= opt_35;
}

}

opt_35 = opt_35.sub(_value);
{
if (true) {
tmp_sum_balance_34 += opt_35;
assert(tmp_sum_balance_34 >= opt_35);
}

}

balances[_from] = opt_35;
}

{
uint opt_36 = balances[_to];
{
if (true) {
assert(tmp_sum_balance_34 >= opt_36);
tmp_sum_balance_34 -= opt_36;
}

}

opt_36 = opt_36.add(sendAmount);
{
if (true) {
tmp_sum_balance_34 += opt_36;
assert(tmp_sum_balance_34 >= opt_36);
}

}

balances[_to] = opt_36;
}

if (fee > 0) {
{
uint opt_37 = balances[owner];
{
if (true) {
assert(tmp_sum_balance_34 >= opt_37);
tmp_sum_balance_34 -= opt_37;
}

}

opt_37 = opt_37.add(fee);
{
if (true) {
tmp_sum_balance_34 += opt_37;
assert(tmp_sum_balance_34 >= opt_37);
}

}

balances[owner] = opt_37;
}

emit Transfer(_from, owner, fee);
}

emit Transfer(_from, _to, sendAmount);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == tmp_sum_balance_34);
}

sum_balance = tmp_sum_balance_34;
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
depth_0 += 1;
uint256 tmp_sum_balance_38 = sum_balance;
require(isBlackListed[_blackListedUser]);
uint dirtyFunds = balanceOf(_blackListedUser);
{
uint opt_39 = balances[_blackListedUser];
{
if (true) {
assert(tmp_sum_balance_38 >= opt_39);
tmp_sum_balance_38 -= opt_39;
}

}

opt_39 = 0;
{
if (true) {
tmp_sum_balance_38 += opt_39;
assert(tmp_sum_balance_38 >= opt_39);
}

}

balances[_blackListedUser] = opt_39;
}

_totalSupply -= dirtyFunds;
emit DestroyedBlackFunds(_blackListedUser, dirtyFunds);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == tmp_sum_balance_38);
}

sum_balance = tmp_sum_balance_38;
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
uint256 tmp_sum_balance_40 = sum_balance;
_totalSupply = _initialSupply;
name = _name;
symbol = _symbol;
decimals = _decimals;
{
uint opt_41 = balances[owner];
{
if (true) {
assert(tmp_sum_balance_40 >= opt_41);
tmp_sum_balance_40 -= opt_41;
}

}

opt_41 = _initialSupply;
{
if (true) {
tmp_sum_balance_40 += opt_41;
assert(tmp_sum_balance_40 >= opt_41);
}

}

balances[owner] = opt_41;
}

deprecated = false;
assert(_totalSupply == tmp_sum_balance_40);
sum_balance = tmp_sum_balance_40;
}

function transfer (address _to, uint _value) whenNotPaused public {
depth_0 += 1;
require(! isBlackListed[msg.sender]);
if (deprecated) {
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
}

return UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
}

}
 else {
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
}

return super.transfer(_to, _value);
}

}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
}

}

function transferFrom (address _from, address _to, uint _value) whenNotPaused public {
depth_0 += 1;
require(! isBlackListed[_from]);
if (deprecated) {
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
}

return UpgradedStandardToken(upgradedAddress).transferFromByLegacy(msg.sender, _from, _to, _value);
}

}
 else {
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
}

return super.transferFrom(_from, _to, _value);
}

}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
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
uint256 tmp_sum_balance_42 = sum_balance;
require(_totalSupply + amount > _totalSupply);
require(balances[owner] + amount > balances[owner]);
{
uint opt_43 = balances[owner];
{
if (true) {
assert(tmp_sum_balance_42 >= opt_43);
tmp_sum_balance_42 -= opt_43;
}

}

opt_43 += amount;
{
if (true) {
tmp_sum_balance_42 += opt_43;
assert(tmp_sum_balance_42 >= opt_43);
}

}

balances[owner] = opt_43;
}

_totalSupply += amount;
emit Issue(amount);
assert(_totalSupply == tmp_sum_balance_42);
sum_balance = tmp_sum_balance_42;
}

function redeem (uint amount) onlyOwner public {
uint256 tmp_sum_balance_44 = sum_balance;
require(_totalSupply >= amount);
require(balances[owner] >= amount);
_totalSupply -= amount;
{
uint opt_45 = balances[owner];
{
if (true) {
assert(tmp_sum_balance_44 >= opt_45);
tmp_sum_balance_44 -= opt_45;
}

}

opt_45 -= amount;
{
if (true) {
tmp_sum_balance_44 += opt_45;
assert(tmp_sum_balance_44 >= opt_45);
}

}

balances[owner] = opt_45;
}

emit Redeem(amount);
assert(_totalSupply == tmp_sum_balance_44);
sum_balance = tmp_sum_balance_44;
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
