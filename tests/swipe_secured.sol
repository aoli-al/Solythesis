pragma solidity ^0.5.0;
library SafeMath {
function add (uint a, uint b) internal pure returns (uint c) {
c = a + b;
require(c >= a);
}

function sub (uint a, uint b) internal pure returns (uint c) {
require(b <= a);
c = a - b;
}

function mul (uint a, uint b) internal pure returns (uint c) {
c = a * b;
require(a == 0 || c / a == b);
}

function div (uint a, uint b) internal pure returns (uint c) {
require(b > 0);
c = a / b;
}

}
contract ERC20Interface {
function totalSupply () public view returns (uint);
function balanceOf (address tokenOwner) public view returns (uint balance);
function allowance (address tokenOwner, address spender) public view returns (uint remaining);
function transfer (address to, uint tokens) public returns (bool success);
function approve (address spender, uint tokens) public returns (bool success);
function transferFrom (address from, address to, uint tokens) public returns (bool success);
event Transfer(address indexed from, address indexed to, uint tokens);
event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
contract ApproveAndCallFallBack {
function receiveApproval (address from, uint256 tokens, address token, bytes memory data) public;
}
contract Owned {
address public owner;
event OwnershipTransferred(address indexed _from, address indexed _to);
constructor () public {
owner = msg.sender;
}

modifier onlyOwner {

        require(msg.sender == owner);

        _;

    }
function transferOwnership (address newOwner) onlyOwner public {
owner = newOwner;
emit OwnershipTransferred(owner, newOwner);
}

}
contract Tokenlock is Owned {
uint8 isLocked = 0;
event Freezed();
event UnFreezed();
modifier validLock {
        require(isLocked == 0);
        _;
    }
function freeze () onlyOwner public {
isLocked = 1;
emit Freezed();
}

function unfreeze () onlyOwner public {
isLocked = 0;
emit UnFreezed();
}

}
contract UserLock is Owned {
mapping (address=>bool) blacklist;
event LockUser(address indexed who);
event UnlockUser(address indexed who);
modifier permissionCheck {
        require(!blacklist[msg.sender]);
        _;
    }
function lockUser (address who) onlyOwner public {
blacklist[who] = true;
emit LockUser(who);
}

function unlockUser (address who) onlyOwner public {
blacklist[who] = false;
emit UnlockUser(who);
}

}
contract SwipeToken is ERC20Interface, Tokenlock, UserLock {
uint256 memoryStart_0;
uint256 sum_balance;
using SafeMath for uint;
string public symbol;
string public name;
uint8 public decimals;
uint _totalSupply;
mapping (address=>uint) balances;
mapping (address=>mapping (address=>uint)) allowed;
constructor () public {
symbol = "SXP";
name = "Swipe";
decimals = 18;
_totalSupply = 300000000 * 10 ** uint(decimals);
{
uint opt_27 = balances[owner];
{
if (true) {
assert(sum_balance >= opt_27);
sum_balance -= opt_27;
}

}

opt_27 = _totalSupply;
{
if (true) {
sum_balance += opt_27;
assert(sum_balance >= opt_27);
}

}

balances[owner] = opt_27;
}

emit Transfer(address(0), owner, _totalSupply);
}

function totalSupply () public view returns (uint) {
{
return _totalSupply.sub(balances[address(0)]);
}

}

function balanceOf (address tokenOwner) public view returns (uint balance) {
{
return balances[tokenOwner];
}

}

function transfer (address to, uint tokens) validLock permissionCheck public returns (bool success) {
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

{
uint opt_28 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_28);
sum_balance -= opt_28;
}

}

opt_28 = opt_28.sub(tokens);
{
if (true) {
sum_balance += opt_28;
assert(sum_balance >= opt_28);
}

}

balances[msg.sender] = opt_28;
}

{
uint opt_29 = balances[to];
{
if (true) {
assert(sum_balance >= opt_29);
sum_balance -= opt_29;
}

}

opt_29 = opt_29.add(tokens);
{
if (true) {
sum_balance += opt_29;
assert(sum_balance >= opt_29);
}

}

balances[to] = opt_29;
}

emit Transfer(msg.sender, to, tokens);
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

function approve (address spender, uint tokens) validLock permissionCheck public returns (bool success) {
allowed[msg.sender][spender] = tokens;
emit Approval(msg.sender, spender, tokens);
{
return true;
}

}

function transferFrom (address from, address to, uint tokens) validLock permissionCheck public returns (bool success) {
uint256 entry_1 = 0;
uint256 tmp_33;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_33 := mload(0x40)
mstore(0x40, add(tmp_33, 0))
sstore(memoryStart_0_slot, tmp_33)
}

}

{
uint opt_31 = balances[from];
{
if (true) {
assert(sum_balance >= opt_31);
sum_balance -= opt_31;
}

}

opt_31 = opt_31.sub(tokens);
{
if (true) {
sum_balance += opt_31;
assert(sum_balance >= opt_31);
}

}

balances[from] = opt_31;
}

allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
{
uint opt_32 = balances[to];
{
if (true) {
assert(sum_balance >= opt_32);
sum_balance -= opt_32;
}

}

opt_32 = opt_32.add(tokens);
{
if (true) {
sum_balance += opt_32;
assert(sum_balance >= opt_32);
}

}

balances[to] = opt_32;
}

emit Transfer(from, to, tokens);
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

function allowance (address tokenOwner, address spender) public view returns (uint remaining) {
{
return allowed[tokenOwner][spender];
}

}

function burn (uint256 value) validLock permissionCheck public returns (bool success) {
uint256 entry_1 = 0;
uint256 tmp_35;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_35 := mload(0x40)
mstore(0x40, add(tmp_35, 0))
sstore(memoryStart_0_slot, tmp_35)
}

}

require(msg.sender != address(0), "ERC20: burn from the zero address");
_totalSupply = _totalSupply.sub(value);
{
uint opt_34 = balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_34);
sum_balance -= opt_34;
}

}

opt_34 = opt_34.sub(value);
{
if (true) {
sum_balance += opt_34;
assert(sum_balance >= opt_34);
}

}

balances[msg.sender] = opt_34;
}

emit Transfer(msg.sender, address(0), value);
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

function approveAndCall (address spender, uint tokens, bytes memory data) validLock permissionCheck public returns (bool success) {
allowed[msg.sender][spender] = tokens;
emit Approval(msg.sender, spender, tokens);
ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, address(this), data);
{
return true;
}

}

function burnForAllowance (address account, address feeAccount, uint256 amount) onlyOwner public returns (bool success) {
uint256 entry_1 = 0;
uint256 tmp_38;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_38 := mload(0x40)
mstore(0x40, add(tmp_38, 0))
sstore(memoryStart_0_slot, tmp_38)
}

}

require(account != address(0), "burn from the zero address");
require(balanceOf(account) >= amount, "insufficient balance");
uint feeAmount = amount.mul(2).div(10);
uint burnAmount = amount.sub(feeAmount);
_totalSupply = _totalSupply.sub(burnAmount);
{
uint opt_36 = balances[account];
{
if (true) {
assert(sum_balance >= opt_36);
sum_balance -= opt_36;
}

}

opt_36 = opt_36.sub(amount);
{
if (true) {
sum_balance += opt_36;
assert(sum_balance >= opt_36);
}

}

balances[account] = opt_36;
}

{
uint opt_37 = balances[feeAccount];
{
if (true) {
assert(sum_balance >= opt_37);
sum_balance -= opt_37;
}

}

opt_37 = opt_37.add(feeAmount);
{
if (true) {
sum_balance += opt_37;
assert(sum_balance >= opt_37);
}

}

balances[feeAccount] = opt_37;
}

emit Transfer(account, address(0), burnAmount);
emit Transfer(account, msg.sender, feeAmount);
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

function () external payable {
revert();
}

function transferAnyERC20Token (address tokenAddress, uint tokens) onlyOwner public returns (bool success) {
{
return ERC20Interface(tokenAddress).transfer(owner, tokens);
}

}

}
