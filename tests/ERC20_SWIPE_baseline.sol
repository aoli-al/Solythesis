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
uint256 depth_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
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
balances[owner] = _totalSupply;if (! a_checker_1[owner]) {
a_store_2.push(owner);
a_checker_1[owner] = true;
}

emit Transfer(address(0), owner, _totalSupply);
}

function totalSupply () public view returns (uint) {
depth_0 += 1;
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
}

return _totalSupply.sub(balances[address(0)]);
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == sum_balance);
}

}

function balanceOf (address tokenOwner) public view returns (uint balance) {
{
return balances[tokenOwner];
}

}

function transfer (address to, uint tokens) validLock permissionCheck public returns (bool success) {
balances[msg.sender] = balances[msg.sender].sub(tokens);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

balances[to] = balances[to].add(tokens);if (! a_checker_1[to]) {
a_store_2.push(to);
a_checker_1[to] = true;
}

emit Transfer(msg.sender, to, tokens);
{
{
{
sum_balance = 0;
}

for (uint256 index_2 = 0; index_2 < a_store_2.length; index_2 += 1) {
sum_balance += balances[a_store_2[index_2]];
assert(sum_balance >= balances[a_store_2[index_2]]);
}

}

assert(_totalSupply == sum_balance);
return true;
}

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
}

function approve (address spender, uint tokens) validLock permissionCheck public returns (bool success) {
allowed[msg.sender][spender] = tokens;
emit Approval(msg.sender, spender, tokens);
{
return true;
}

}

function transferFrom (address from, address to, uint tokens) validLock permissionCheck public returns (bool success) {
balances[from] = balances[from].sub(tokens);if (! a_checker_1[from]) {
a_store_2.push(from);
a_checker_1[from] = true;
}

allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
balances[to] = balances[to].add(tokens);if (! a_checker_1[to]) {
a_store_2.push(to);
a_checker_1[to] = true;
}

emit Transfer(from, to, tokens);
{
{
{
sum_balance = 0;
}

for (uint256 index_4 = 0; index_4 < a_store_2.length; index_4 += 1) {
sum_balance += balances[a_store_2[index_4]];
assert(sum_balance >= balances[a_store_2[index_4]]);
}

}

assert(_totalSupply == sum_balance);
return true;
}

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
}

function allowance (address tokenOwner, address spender) public view returns (uint remaining) {
{
return allowed[tokenOwner][spender];
}

}

function burn (uint256 value) validLock permissionCheck public returns (bool success) {
depth_0 += 1;
require(msg.sender != address(0), "ERC20: burn from the zero address");
_totalSupply = _totalSupply.sub(value);
balances[msg.sender] = balances[msg.sender].sub(value);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

emit Transfer(msg.sender, address(0), value);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_6 = 0; index_6 < a_store_2.length; index_6 += 1) {
sum_balance += balances[a_store_2[index_6]];
assert(sum_balance >= balances[a_store_2[index_6]]);
}

}

assert(_totalSupply == sum_balance);
}

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
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
depth_0 += 1;
require(account != address(0), "burn from the zero address");
require(balanceOf(account) >= amount, "insufficient balance");
uint feeAmount = amount.mul(2).div(10);
uint burnAmount = amount.sub(feeAmount);
_totalSupply = _totalSupply.sub(burnAmount);
balances[account] = balances[account].sub(amount);if (! a_checker_1[account]) {
a_store_2.push(account);
a_checker_1[account] = true;
}

balances[feeAccount] = balances[feeAccount].add(feeAmount);if (! a_checker_1[feeAccount]) {
a_store_2.push(feeAccount);
a_checker_1[feeAccount] = true;
}

emit Transfer(account, address(0), burnAmount);
emit Transfer(account, msg.sender, feeAmount);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_8 = 0; index_8 < a_store_2.length; index_8 += 1) {
sum_balance += balances[a_store_2[index_8]];
assert(sum_balance >= balances[a_store_2[index_8]]);
}

}

assert(_totalSupply == sum_balance);
}

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
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
