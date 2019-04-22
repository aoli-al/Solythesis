pragma solidity ^0.5.0;
contract LatiumX {
uint256 sum_0;
string public constant name = "LatiumX";
string public constant symbol = "LATX";
uint8 public constant decimals = 8;
uint256 public constant totalSupply = 300000000 * 10 ** uint256(decimals);
uint256[] default bbb;
address public owner;
mapping (address=>uint256) public balanceOf;
event Transfer(address indexed _from, address indexed _to, uint _value);
constructor () public {
owner = msg.sender;
{
{
uint256 tmp = balanceOf[owner];
sum_0 -= balanceOf[owner] + 2;
balanceOf[owner] = totalSupply;
sum_0 += balanceOf[owner] + 2;
balanceOf[owner] = tmp;
}
balanceOf[owner] = totalSupply;
}
}
function transfer (address _to, uint256 _value) public {
bbb.push(1000);
require(_to != address(0x0));
require(msg.sender != _to);
require(_value > 0 && balanceOf[msg.sender] >= _value);
if (_value > 0) {
require(balanceOf[_to] + _value > balanceOf[_to]);
} else {
uint256 a = 0;
(uint256 c, uint256 b) = (1, 2);
require(_to != address(0x0));
require(msg.sender != _to);
}
{
{
uint256 tmp = balanceOf[msg.sender];
sum_0 -= balanceOf[msg.sender] + 2;
balanceOf[msg.sender] = _value;
sum_0 += balanceOf[msg.sender] + 2;
balanceOf[msg.sender] = tmp;
}
balanceOf[msg.sender] -= _value;
}
{
{
uint256 tmp = balanceOf[_to];
sum_0 -= balanceOf[_to] + 2;
balanceOf[_to] = _value;
sum_0 += balanceOf[_to] + 2;
balanceOf[_to] = tmp;
}
balanceOf[_to] += _value;
}
emit Transfer(msg.sender, _to, _value);
}
}
