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
uint256 sum_balance;
using SafeMath for uint;
string public symbol;
string public name;
uint8 public decimals;
uint _totalSupply;
mapping (address=>uint) balances;
mapping (address=>mapping (address=>uint)) allowed;
constructor () public {
uint256 tmp_sum_balance_33 = sum_balance;
symbol = "SXP";
name = "Swipe";
decimals = 18;
_totalSupply = 300000000 * 10 ** uint(decimals);
{
if (true) {
assert(tmp_sum_balance_33 >= balances[owner]);
tmp_sum_balance_33 -= balances[owner];
}

}
balances[owner] = _totalSupply;{
if (true) {
tmp_sum_balance_33 += balances[owner];
assert(tmp_sum_balance_33 >= balances[owner]);
}

}

emit Transfer(address(0), owner, _totalSupply);
sum_balance = tmp_sum_balance_33;
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
uint256 tmp_sum_balance_34 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_34 >= balances[msg.sender]);
tmp_sum_balance_34 -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(tokens);{
if (true) {
tmp_sum_balance_34 += balances[msg.sender];
assert(tmp_sum_balance_34 >= balances[msg.sender]);
}

}

{
if (true) {
assert(tmp_sum_balance_34 >= balances[to]);
tmp_sum_balance_34 -= balances[to];
}

}
balances[to] = balances[to].add(tokens);{
if (true) {
tmp_sum_balance_34 += balances[to];
assert(tmp_sum_balance_34 >= balances[to]);
}

}

emit Transfer(msg.sender, to, tokens);
{
assert(_totalSupply == tmp_sum_balance_34);
sum_balance = tmp_sum_balance_34;
return true;
}

assert(_totalSupply == tmp_sum_balance_34);
sum_balance = tmp_sum_balance_34;
}

function approve (address spender, uint tokens) validLock permissionCheck public returns (bool success) {
allowed[msg.sender][spender] = tokens;
emit Approval(msg.sender, spender, tokens);
{
return true;
}

}

function transferFrom (address from, address to, uint tokens) validLock permissionCheck public returns (bool success) {
uint256 tmp_sum_balance_35 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_35 >= balances[from]);
tmp_sum_balance_35 -= balances[from];
}

}
balances[from] = balances[from].sub(tokens);{
if (true) {
tmp_sum_balance_35 += balances[from];
assert(tmp_sum_balance_35 >= balances[from]);
}

}

allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
{
if (true) {
assert(tmp_sum_balance_35 >= balances[to]);
tmp_sum_balance_35 -= balances[to];
}

}
balances[to] = balances[to].add(tokens);{
if (true) {
tmp_sum_balance_35 += balances[to];
assert(tmp_sum_balance_35 >= balances[to]);
}

}

emit Transfer(from, to, tokens);
{
assert(_totalSupply == tmp_sum_balance_35);
sum_balance = tmp_sum_balance_35;
return true;
}

assert(_totalSupply == tmp_sum_balance_35);
sum_balance = tmp_sum_balance_35;
}

function allowance (address tokenOwner, address spender) public view returns (uint remaining) {
{
return allowed[tokenOwner][spender];
}

}

function burn (uint256 value) validLock permissionCheck public returns (bool success) {
depth_0 += 1;
uint256 tmp_sum_balance_36 = sum_balance;
require(msg.sender != address(0), "ERC20: burn from the zero address");
_totalSupply = _totalSupply.sub(value);
{
if (true) {
assert(tmp_sum_balance_36 >= balances[msg.sender]);
tmp_sum_balance_36 -= balances[msg.sender];
}

}
balances[msg.sender] = balances[msg.sender].sub(value);{
if (true) {
tmp_sum_balance_36 += balances[msg.sender];
assert(tmp_sum_balance_36 >= balances[msg.sender]);
}

}

emit Transfer(msg.sender, address(0), value);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == tmp_sum_balance_36);
}

sum_balance = tmp_sum_balance_36;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == tmp_sum_balance_36);
}

sum_balance = tmp_sum_balance_36;
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
uint256 tmp_sum_balance_37 = sum_balance;
require(account != address(0), "burn from the zero address");
require(balanceOf(account) >= amount, "insufficient balance");
uint feeAmount = amount.mul(2).div(10);
uint burnAmount = amount.sub(feeAmount);
_totalSupply = _totalSupply.sub(burnAmount);
{
if (true) {
assert(tmp_sum_balance_37 >= balances[account]);
tmp_sum_balance_37 -= balances[account];
}

}
balances[account] = balances[account].sub(amount);{
if (true) {
tmp_sum_balance_37 += balances[account];
assert(tmp_sum_balance_37 >= balances[account]);
}

}

{
if (true) {
assert(tmp_sum_balance_37 >= balances[feeAccount]);
tmp_sum_balance_37 -= balances[feeAccount];
}

}
balances[feeAccount] = balances[feeAccount].add(feeAmount);{
if (true) {
tmp_sum_balance_37 += balances[feeAccount];
assert(tmp_sum_balance_37 >= balances[feeAccount]);
}

}

emit Transfer(account, address(0), burnAmount);
emit Transfer(account, msg.sender, feeAmount);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == tmp_sum_balance_37);
}

sum_balance = tmp_sum_balance_37;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_totalSupply == tmp_sum_balance_37);
}

sum_balance = tmp_sum_balance_37;
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
