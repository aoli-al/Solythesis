pragma solidity ^0.5.0;
contract SafeMath {
uint256 sum_0;
function safeAdd (uint256 x, uint256 y) internal pure returns(uint256) {
uint256 z = x + y;
assert((z >= x) && (z >= y));
{
return z;
}
{
}
}
function safeSubtract (uint256 x, uint256 y) internal pure returns(uint256) {
assert(x >= y);
uint256 z = x - y;
{
return z;
}
{
}
}
function safeMult (uint256 x, uint256 y) internal pure returns(uint256) {
uint256 z = x * y;
assert((x == 0) || (z/x == y));
{
return z;
}
{
}
}
}
contract StandardToken is SafeMath {
uint256 sum_0;
uint256 public totalSupply;
event Transfer(address indexed _from, address indexed _to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);
function transfer (address _to, uint256 _value) public returns (bool success) {
  uint256 tmp = totalSupply;
  for (uint256 i = 0; i < 200; i++) {
    tmp = i;
  }
  totalSupply = tmp;
  // if (balances[msg.sender] >= _value && _value > 0) {
  // {
  // {
  // uint256 tmp_1 = balances[msg.sender];
  // sum_0 -= balances[msg.sender];
  // balances[msg.sender] -= _value;
  // sum_0 += balances[msg.sender];
  // balances[msg.sender] = tmp_1;
  // }
  // balances[msg.sender] -= _value;
  // }
  // {
  // {
  // uint256 tmp_2 = balances[_to];
  // sum_0 -= balances[_to];
  // balances[_to] += _value;
  // sum_0 += balances[_to];
  // balances[_to] = tmp_2;
  // }
  // balances[_to] += _value;
  // }
  // emit Transfer(msg.sender, _to, _value);
  // {
  // assert(totalSupply == sum_0);
  // return true;
  // }
  // } else {
  // {
  // assert(totalSupply == sum_0);
  // return false;
  // }
  // }
  // {
  // assert(totalSupply == sum_0);
  // }
}
function transferFrom (address _from, address _to, uint256 _value) public returns (bool success) {
if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
{
{
uint256 tmp_3 = balances[_to];
sum_0 -= balances[_to];
balances[_to] += _value;
sum_0 += balances[_to];
balances[_to] = tmp_3;
}
balances[_to] += _value;
}
{
{
uint256 tmp_4 = balances[_from];
sum_0 -= balances[_from];
balances[_from] -= _value;
sum_0 += balances[_from];
balances[_from] = tmp_4;
}
balances[_from] -= _value;
}
allowed[_from][msg.sender] -= _value;
emit Transfer(_from, _to, _value);
{
assert(totalSupply == sum_0);
return true;
}
} else {
{
assert(totalSupply == sum_0);
return false;
}
}
{
assert(totalSupply == sum_0);
}
}
function balanceOf (address _owner) public view returns (uint256 balance) {
{
return balances[_owner];
}
{
}
}
function approve (address _spender, uint256 _value) public returns (bool success) {
allowed[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
{
return true;
}
{
}
}
function allowance (address _owner, address _spender) public view returns (uint256 remaining) {
{
return allowed[_owner][_spender];
}
{
}
}
mapping (address=>uint256) balances;
mapping (address=>mapping (address=>uint256)) allowed;
string public constant name = "Basic Attention Token";
string public constant symbol = "BAT";
uint256 public constant decimals = 18;
string public version = "1.0";
address public ethFundDeposit;
address public batFundDeposit;
bool public isFinalized;
uint256 public fundingStartBlock;
uint256 public fundingEndBlock;
uint256 public constant batFund = 500 * (10**6) * 10 ** decimals;
uint256 public constant tokenExchangeRate = 6400;
uint256 public constant tokenCreationCap = 1500 * (10**6) * 10 ** decimals;
uint256 public constant tokenCreationMin = 675 * (10**6) * 10 ** decimals;
event LogRefund(address indexed _to, uint256 _value);
event CreateBAT(address indexed _to, uint256 _value);
constructor (
        address _ethFundDeposit,
        address _batFundDeposit,
        uint256 _fundingStartBlock,
        uint256 _fundingEndBlock) public {
isFinalized = false;
ethFundDeposit = _ethFundDeposit;
batFundDeposit = _batFundDeposit;
fundingStartBlock = _fundingStartBlock;
fundingEndBlock = _fundingEndBlock;
totalSupply = batFund;
{
{
uint256 tmp_5 = balances[batFundDeposit];
sum_0 -= balances[batFundDeposit];
balances[batFundDeposit] = batFund;
sum_0 += balances[batFundDeposit];
balances[batFundDeposit] = tmp_5;
}
balances[batFundDeposit] = batFund;
}
emit CreateBAT(batFundDeposit, batFund);
{
assert(totalSupply == sum_0);
}
}
function createTokens () external payable {
if (isFinalized) revert();
if (block.number < fundingStartBlock) revert();
if (block.number > fundingEndBlock) revert();
if (msg.value == 0) revert();
uint256 tokens = safeMult(msg.value, tokenExchangeRate);
uint256 checkedSupply = safeAdd(totalSupply, tokens);
if (tokenCreationCap < checkedSupply) revert();
totalSupply = checkedSupply;
{
{
uint256 tmp_6 = balances[msg.sender];
sum_0 -= balances[msg.sender];
balances[msg.sender] += tokens;
sum_0 += balances[msg.sender];
balances[msg.sender] = tmp_6;
}
balances[msg.sender] += tokens;
}
emit CreateBAT(msg.sender, tokens);
{
assert(totalSupply == sum_0);
}
}
}
