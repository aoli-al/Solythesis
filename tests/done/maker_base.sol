pragma solidity ^0.5.0;
contract DSAuthority {
function canCall (
        address src, address dst, bytes4 sig
    ) public view returns (bool);
}
contract DSAuthEvents {
event LogSetAuthority (address indexed authority);
event LogSetOwner     (address indexed owner);
}
contract DSAuth is DSAuthEvents {
DSAuthority public authority;
address public owner;
constructor () public {
owner = msg.sender;
emit LogSetOwner(msg.sender);
}

function setOwner (address owner_) auth public {
owner = owner_;
emit LogSetOwner(owner);
}

function setAuthority (DSAuthority authority_) auth public {
authority = authority_;
emit LogSetAuthority(address(authority));
}

modifier auth {
        require(isAuthorized(msg.sender, msg.sig));
        _;
    }
function isAuthorized (address src, bytes4 sig) internal view returns (bool) {
if (src == address(this)) {
{
return true;
}

}
 else if (src == owner) {
{
return true;
}

}
 else if (authority == DSAuthority(0)) {
{
return false;
}

}
 else {
{
return authority.canCall(src, address(this), sig);
}

}

}

}
contract DSMath {
function add (uint x, uint y) internal pure returns (uint z) {
require((z = x + y) >= x);
}

function sub (uint x, uint y) internal pure returns (uint z) {
require((z = x - y) <= x);
}

function mul (uint x, uint y) internal pure returns (uint z) {
require(y == 0 || (z = x * y) / y == x);
}

function min (uint x, uint y) internal pure returns (uint z) {
{
return x <= y ? x : y;
}

}

function max (uint x, uint y) internal pure returns (uint z) {
{
return x >= y ? x : y;
}

}

function imin (int x, int y) internal pure returns (int z) {
{
return x <= y ? x : y;
}

}

function imax (int x, int y) internal pure returns (int z) {
{
return x >= y ? x : y;
}

}

uint constant WAD = 10 ** 18;
uint constant RAY = 10 ** 27;
function wmul (uint x, uint y) internal pure returns (uint z) {
z = add(mul(x, y), WAD / 2) / WAD;
}

function rmul (uint x, uint y) internal pure returns (uint z) {
z = add(mul(x, y), RAY / 2) / RAY;
}

function wdiv (uint x, uint y) internal pure returns (uint z) {
z = add(mul(x, WAD), y / 2) / y;
}

function rdiv (uint x, uint y) internal pure returns (uint z) {
z = add(mul(x, RAY), y / 2) / y;
}

function rpow (uint x, uint n) internal pure returns (uint z) {
z = n % 2 != 0 ? x : RAY;
for (n /= 2; n != 0; n /= 2) {
x = rmul(x, x);
if (n % 2 != 0) {
z = rmul(z, x);
}

}

}

}
contract DSNote {
event LogNote(
        bytes4   indexed  sig,
        address  indexed  guy,
        bytes32  indexed  foo,
        bytes32  indexed  bar,
        uint              wad,
        bytes             fax
    ) anonymous;
modifier note {
        bytes32 foo;
        bytes32 bar;

        assembly {
            foo := calldataload(4)
            bar := calldataload(36)
        }

        emit LogNote(msg.sig, msg.sender, foo, bar, msg.value, msg.data);

        _;
    }
}
contract DSThing is DSAuth, DSNote, DSMath {
}
contract DSStop is DSNote, DSAuth {
bool public stopped;
modifier stoppable {
        require(!stopped);
        _;
    }
function stop () auth note public payable {
stopped = true;
}

function start () auth note public payable {
stopped = false;
}

}
contract ERC20 {
function totalSupply () public view returns (uint supply);
function balanceOf ( address who ) public view returns (uint value);
function allowance ( address owner, address spender ) public view returns (uint _allowance);
function transfer ( address to, uint value) public returns (bool ok);
function transferFrom ( address from, address to, uint value) public returns (bool ok);
function approve ( address spender, uint value ) public returns (bool ok);
event Transfer( address indexed from, address indexed to, uint value);
event Approval( address indexed owner, address indexed spender, uint value);
}
contract DSTokenBase is ERC20, DSMath {
uint256 depth_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
uint256 sum_balance;
uint256 _supply;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) _approvals;
constructor (uint supply) public {
_balances[msg.sender] = supply;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

_supply = supply;
{
{
sum_balance = 0;
}

for (uint256 index_2 = 0; index_2 < a_store_2.length; index_2 += 1) {
sum_balance += _balances[a_store_2[index_2]];
assert(sum_balance >= _balances[a_store_2[index_2]]);
}

}

assert(_supply == sum_balance);
}

function totalSupply () public view returns (uint) {
{
return _supply;
}

}

function balanceOf (address src) public view returns (uint) {
{
return _balances[src];
}

}

function allowance (address src, address guy) public view returns (uint) {
{
return _approvals[src][guy];
}

}

function transfer (address dst, uint wad) public returns (bool) {
depth_0 += 1;
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_3 = 0; index_3 < a_store_2.length; index_3 += 1) {
sum_balance += _balances[a_store_2[index_3]];
assert(sum_balance >= _balances[a_store_2[index_3]]);
}

}

assert(_supply == sum_balance);
}

return transferFrom(msg.sender, dst, wad);
}

depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_4 = 0; index_4 < a_store_2.length; index_4 += 1) {
sum_balance += _balances[a_store_2[index_4]];
assert(sum_balance >= _balances[a_store_2[index_4]]);
}

}

assert(_supply == sum_balance);
}

}

function transferFrom (address src, address dst, uint wad) public returns (bool) {
depth_0 += 1;
if (src != msg.sender) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

_balances[src] = sub(_balances[src], wad);if (! a_checker_1[src]) {
a_store_2.push(src);
a_checker_1[src] = true;
}

_balances[dst] = add(_balances[dst], wad);if (! a_checker_1[dst]) {
a_store_2.push(dst);
a_checker_1[dst] = true;
}

emit Transfer(src, dst, wad);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_5 = 0; index_5 < a_store_2.length; index_5 += 1) {
sum_balance += _balances[a_store_2[index_5]];
assert(sum_balance >= _balances[a_store_2[index_5]]);
}

}

assert(_supply == sum_balance);
}

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_6 = 0; index_6 < a_store_2.length; index_6 += 1) {
sum_balance += _balances[a_store_2[index_6]];
assert(sum_balance >= _balances[a_store_2[index_6]]);
}

}

assert(_supply == sum_balance);
}

}

function approve (address guy, uint wad) public returns (bool) {
_approvals[msg.sender][guy] = wad;
emit Approval(msg.sender, guy, wad);
{
return true;
}

}

}
contract DSToken is DSTokenBase(0), DSStop {
string public symbol;
uint256 public decimals = 18;
constructor (string memory symbol_) public {
symbol = symbol_;
}

event Mint(address indexed guy, uint wad);
event Burn(address indexed guy, uint wad);
function approve (address guy) stoppable public returns (bool) {
{
return super.approve(guy, uint(-1));
}

}

function approve (address guy, uint wad) stoppable public returns (bool) {
{
return super.approve(guy, wad);
}

}

function transferFrom (address src, address dst, uint wad) stoppable public returns (bool) {
depth_0 += 1;
if (src != msg.sender && _approvals[src][msg.sender] != uint(- 1)) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

_balances[src] = sub(_balances[src], wad);if (! a_checker_1[src]) {
a_store_2.push(src);
a_checker_1[src] = true;
}

_balances[dst] = add(_balances[dst], wad);if (! a_checker_1[dst]) {
a_store_2.push(dst);
a_checker_1[dst] = true;
}

emit Transfer(src, dst, wad);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_7 = 0; index_7 < a_store_2.length; index_7 += 1) {
sum_balance += _balances[a_store_2[index_7]];
assert(sum_balance >= _balances[a_store_2[index_7]]);
}

}

assert(_supply == sum_balance);
}

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_8 = 0; index_8 < a_store_2.length; index_8 += 1) {
sum_balance += _balances[a_store_2[index_8]];
assert(sum_balance >= _balances[a_store_2[index_8]]);
}

}

assert(_supply == sum_balance);
}

}

function push (address dst, uint wad) public {
depth_0 += 1;
transferFrom(msg.sender, dst, wad);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_9 = 0; index_9 < a_store_2.length; index_9 += 1) {
sum_balance += _balances[a_store_2[index_9]];
assert(sum_balance >= _balances[a_store_2[index_9]]);
}

}

assert(_supply == sum_balance);
}

}

function pull (address src, uint wad) public {
depth_0 += 1;
transferFrom(src, msg.sender, wad);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_10 = 0; index_10 < a_store_2.length; index_10 += 1) {
sum_balance += _balances[a_store_2[index_10]];
assert(sum_balance >= _balances[a_store_2[index_10]]);
}

}

assert(_supply == sum_balance);
}

}

function move (address src, address dst, uint wad) public {
depth_0 += 1;
transferFrom(src, dst, wad);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_11 = 0; index_11 < a_store_2.length; index_11 += 1) {
sum_balance += _balances[a_store_2[index_11]];
assert(sum_balance >= _balances[a_store_2[index_11]]);
}

}

assert(_supply == sum_balance);
}

}

function mint (uint wad) public {
depth_0 += 1;
mint(msg.sender, wad);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_12 = 0; index_12 < a_store_2.length; index_12 += 1) {
sum_balance += _balances[a_store_2[index_12]];
assert(sum_balance >= _balances[a_store_2[index_12]]);
}

}

assert(_supply == sum_balance);
}

}

function burn (uint wad) public {
depth_0 += 1;
burn(msg.sender, wad);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_13 = 0; index_13 < a_store_2.length; index_13 += 1) {
sum_balance += _balances[a_store_2[index_13]];
assert(sum_balance >= _balances[a_store_2[index_13]]);
}

}

assert(_supply == sum_balance);
}

}

function mint (address guy, uint wad) auth stoppable public {
depth_0 += 1;
_balances[guy] = add(_balances[guy], wad);if (! a_checker_1[guy]) {
a_store_2.push(guy);
a_checker_1[guy] = true;
}

_supply = add(_supply, wad);
emit Mint(guy, wad);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_14 = 0; index_14 < a_store_2.length; index_14 += 1) {
sum_balance += _balances[a_store_2[index_14]];
assert(sum_balance >= _balances[a_store_2[index_14]]);
}

}

assert(_supply == sum_balance);
}

}

function burn (address guy, uint wad) auth stoppable public {
depth_0 += 1;
if (guy != msg.sender && _approvals[guy][msg.sender] != uint(- 1)) {
_approvals[guy][msg.sender] = sub(_approvals[guy][msg.sender], wad);
}

_balances[guy] = sub(_balances[guy], wad);if (! a_checker_1[guy]) {
a_store_2.push(guy);
a_checker_1[guy] = true;
}

_supply = sub(_supply, wad);
emit Burn(guy, wad);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_balance = 0;
}

for (uint256 index_15 = 0; index_15 < a_store_2.length; index_15 += 1) {
sum_balance += _balances[a_store_2[index_15]];
assert(sum_balance >= _balances[a_store_2[index_15]]);
}

}

assert(_supply == sum_balance);
}

}

bytes32 public name = "";
function setName (bytes32 name_) auth public {
name = name_;
}

}
