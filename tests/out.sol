pragma solidity ^0.5.0;
library SafeMath {
function mul (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a * b;
assert(a == 0 || c / a == b);
return c;
}
function div (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a / b;
return c;
}
function sub (uint256 a, uint256 b) internal pure returns (uint256) {
assert(b <= a);
return a - b;
}
function add (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a + b;
assert(c >= a);
return c;
}
}
contract PausableToken {
uint256 sum_balance;
using SafeMath for uint256;
uint256 public totalSupply;
mapping (address=>uint256) balances;
mapping (address=>mapping (address=>uint256)) internal allowed;
function batchTransfer (address[] memory _receivers, uint256 _value) public returns (bool) {
uint cnt = _receivers.length;
uint256 amount = uint256(cnt) * _value;
require(cnt > 0 && cnt <= 20);
require(_value > 0 && balances[msg.sender] >= amount);
{
{
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}
balances[msg.sender] = balances[msg.sender].sub(amount);
{
sum_balance += balances[msg.sender];
assert(sum_balance >= balances[msg.sender]);
}
}
for (uint i = 0; i < cnt; i++) {
{
{
assert(sum_balance >= balances[_receivers[i]]);
sum_balance -= balances[_receivers[i]];
}
balances[_receivers[i]] = balances[_receivers[i]].add(_value);
{
sum_balance += balances[_receivers[i]];
assert(sum_balance >= balances[_receivers[i]]);
}
}
}
return true;
{
assert(totalSupply == sum_balance);
}
}
}
contract BecToken is PausableToken {
string public name = "BeautyChain";
string public symbol = "BEC";
string public version = '1.0.0';
uint8 public decimals = 18;
constructor () public {
totalSupply = 7000000000 * (10**(uint256(decimals)));
{
{
assert(sum_balance >= balances[msg.sender]);
sum_balance -= balances[msg.sender];
}
balances[msg.sender] = totalSupply;
{
sum_balance += balances[msg.sender];
assert(sum_balance >= balances[msg.sender]);
}
}
{
assert(totalSupply == sum_balance);
}
}
}
