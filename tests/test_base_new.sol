pragma solidity ^0.5.0;
library SafeMath {
function mul (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a * b;
assert(a == 0 || c / a == b);
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
contract ERC20Basic {
uint256 public totalSupply;
event Transfer(address indexed from, address indexed to, uint256 value);
}
contract BasicToken is ERC20Basic {
uint256 depth_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
uint256 sum_balance;
using SafeMath for uint256;
mapping (address=>uint256) balances;
function transfer (address _to, uint256 _value) public returns (bool) {
require(_to != address(0));
require(_value > 0 && _value <= balances[msg.sender]);
balances[msg.sender] = balances[msg.sender].sub(_value);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

balances[_to] = balances[_to].add(_value);if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

emit Transfer(msg.sender, _to, _value);
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

assert(totalSupply == sum_balance);
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

assert(totalSupply == sum_balance);
}

function balanceOf (address _owner) public view returns (uint256 balance) {
{
return balances[_owner];
}

}

}
contract ERC20 is ERC20Basic {
event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract StandardToken is ERC20, BasicToken {
mapping (address=>mapping (address=>uint256)) internal allowed;
function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
require(_to != address(0));
require(_value > 0 && _value <= balances[_from]);
require(_value <= allowed[_from][msg.sender]);
balances[_from] = balances[_from].sub(_value);if (! a_checker_1[_from]) {
a_store_2.push(_from);
a_checker_1[_from] = true;
}

balances[_to] = balances[_to].add(_value);if (! a_checker_1[_to]) {
a_store_2.push(_to);
a_checker_1[_to] = true;
}

allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
emit Transfer(_from, _to, _value);
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

assert(totalSupply == sum_balance);
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

assert(totalSupply == sum_balance);
}

function approve (address _spender, uint256 _value) public returns (bool) {
allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
{
return true;
}

}

function allowance (address _owner, address _spender) public view returns (uint256 remaining) {
{
return allowed[_owner][_spender];
}

}

}
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
contract PausableToken is StandardToken, Pausable {
function transfer (address _to, uint256 _value) whenNotPaused public returns (bool) {
{
return super.transfer(_to, _value);
}

}

function transferFrom (address _from, address _to, uint256 _value) whenNotPaused public returns (bool) {
{
return super.transferFrom(_from, _to, _value);
}

}

function approve (address _spender, uint256 _value) whenNotPaused public returns (bool) {
{
return super.approve(_spender, _value);
}

}

function batchTransfer (address[] memory _receivers, uint256 _value) whenNotPaused public returns (bool) {
uint cnt = _receivers.length;
uint256 amount = uint256(cnt) * _value;
require(cnt > 0 && cnt <= 20);
require(_value > 0 && balances[msg.sender] >= amount);
balances[msg.sender] = balances[msg.sender].sub(amount);if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

for (uint i = 0; i < cnt; i ++) {
balances[_receivers[i]] = balances[_receivers[i]].add(_value);if (! a_checker_1[_receivers[i]]) {
a_store_2.push(_receivers[i]);
a_checker_1[_receivers[i]] = true;
}

emit Transfer(msg.sender, _receivers[i], _value);
}

{
{
{
sum_balance = 0;
}

for (uint256 index_6 = 0; index_6 < a_store_2.length; index_6 += 1) {
sum_balance += balances[a_store_2[index_6]];
assert(sum_balance >= balances[a_store_2[index_6]]);
}

}

assert(totalSupply == sum_balance);
return true;
}

{
{
sum_balance = 0;
}

for (uint256 index_7 = 0; index_7 < a_store_2.length; index_7 += 1) {
sum_balance += balances[a_store_2[index_7]];
assert(sum_balance >= balances[a_store_2[index_7]]);
}

}

assert(totalSupply == sum_balance);
}

}
contract BecToken is PausableToken {
string public name = "BeautyChain";
string public symbol = "BEC";
string public version = '1.0.0';
uint8 public decimals = 18;
constructor () public {
totalSupply = 7000000000 * (10**(uint256(decimals)));
balances[msg.sender] = totalSupply;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

}

function () external payable {
revert();
}

}
