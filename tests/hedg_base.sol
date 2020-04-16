pragma solidity ^0.5.7;
contract DSMath {
function add (uint x, uint y) internal pure returns (uint z) {
require((z = x + y) >= x, "ds-math-add-overflow");
}

function sub (uint x, uint y) internal pure returns (uint z) {
require((z = x - y) <= x, "ds-math-sub-underflow");
}

function mul (uint x, uint y) internal pure returns (uint z) {
require(y == 0 || (z = x * y) / y == x, "ds-math-mul-overflow");
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
contract ERC20Events {
event Approval(address indexed src, address indexed guy, uint wad);
event Transfer(address indexed src, address indexed dst, uint wad);
}
contract ERC20 is ERC20Events {
function totalSupply () public view returns (uint);
function balanceOf (address guy) public view returns (uint);
function allowance (address src, address guy) public view returns (uint);
function approve (address guy, uint wad) public returns (bool);
function transfer (address dst, uint wad) public returns (bool);
function transferFrom (
        address src, address dst, uint wad
    ) public returns (bool);
}
contract DSTokenBase is ERC20, DSMath {
uint256 memoryStart_0;
mapping (address=>bool) a_checker_1;
address[] a_store_2;
uint256 sum_balance;
uint256 _supply;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) _approvals;
constructor (uint supply) public {
uint256 entry_1 = 0;
uint256 tmp_4;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_4 := mload(0x40)
mstore(0x40, add(tmp_4, 0))
sstore(memoryStart_0_slot, tmp_4)
}

}

_balances[msg.sender] = supply;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

_supply = supply;
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

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
uint256 entry_1 = 0;
uint256 tmp_7;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_7 := mload(0x40)
mstore(0x40, add(tmp_7, 0))
sstore(memoryStart_0_slot, tmp_7)
}

}

{
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

return transferFrom(msg.sender, dst, wad);
}

if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

function transferFrom (address src, address dst, uint wad) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_10;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_10 := mload(0x40)
mstore(0x40, add(tmp_10, 0))
sstore(memoryStart_0_slot, tmp_10)
}

}

if (src != msg.sender) {
require(_approvals[src][msg.sender] >= wad, "ds-token-insufficient-approval");
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

require(_balances[src] >= wad, "ds-token-insufficient-balance");
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
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
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
memoryStart_0 = 0;
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
contract HedgeTrade is DSTokenBase(0), DSStop {
mapping (address=>mapping (address=>bool)) _trusted;
bytes32 public symbol = "";
uint256 public decimals = 18;
constructor () public {
uint256 entry_1 = 0;
uint256 tmp_12;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_12 := mload(0x40)
mstore(0x40, add(tmp_12, 0))
sstore(memoryStart_0_slot, tmp_12)
}

}

_supply = 1000000000000000;
_balances[msg.sender] = _supply;if (! a_checker_1[msg.sender]) {
a_store_2.push(msg.sender);
a_checker_1[msg.sender] = true;
}

if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

event Trust(address indexed src, address indexed guy, bool wat);
event Mint(address indexed guy, uint wad);
event Burn(address indexed guy, uint wad);
function trusted (address src, address guy) public view returns (bool) {
{
return _trusted[src][guy];
}

}

function trust (address guy, bool wat) stoppable public {
_trusted[msg.sender][guy] = wat;
emit Trust(msg.sender, guy, wat);
}

function approve (address guy, uint wad) stoppable public returns (bool) {
{
return super.approve(guy, wad);
}

}

function transferFrom (address src, address dst, uint wad) stoppable public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_15;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_15 := mload(0x40)
mstore(0x40, add(tmp_15, 0))
sstore(memoryStart_0_slot, tmp_15)
}

}

if (src != msg.sender && ! _trusted[src][msg.sender]) {
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
if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
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
memoryStart_0 = 0;
}

}

function push (address dst, uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_17;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_17 := mload(0x40)
mstore(0x40, add(tmp_17, 0))
sstore(memoryStart_0_slot, tmp_17)
}

}

transferFrom(msg.sender, dst, wad);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_16 = 0; index_16 < a_store_2.length; index_16 += 1) {
sum_balance += _balances[a_store_2[index_16]];
assert(sum_balance >= _balances[a_store_2[index_16]]);
}

}

assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function pull (address src, uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_19;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_19 := mload(0x40)
mstore(0x40, add(tmp_19, 0))
sstore(memoryStart_0_slot, tmp_19)
}

}

transferFrom(src, msg.sender, wad);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_18 = 0; index_18 < a_store_2.length; index_18 += 1) {
sum_balance += _balances[a_store_2[index_18]];
assert(sum_balance >= _balances[a_store_2[index_18]]);
}

}

assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function move (address src, address dst, uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_21;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_21 := mload(0x40)
mstore(0x40, add(tmp_21, 0))
sstore(memoryStart_0_slot, tmp_21)
}

}

transferFrom(src, dst, wad);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_20 = 0; index_20 < a_store_2.length; index_20 += 1) {
sum_balance += _balances[a_store_2[index_20]];
assert(sum_balance >= _balances[a_store_2[index_20]]);
}

}

assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function mint (uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_23;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_23 := mload(0x40)
mstore(0x40, add(tmp_23, 0))
sstore(memoryStart_0_slot, tmp_23)
}

}

mint(msg.sender, wad);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_22 = 0; index_22 < a_store_2.length; index_22 += 1) {
sum_balance += _balances[a_store_2[index_22]];
assert(sum_balance >= _balances[a_store_2[index_22]]);
}

}

assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function burn (uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_25;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_25 := mload(0x40)
mstore(0x40, add(tmp_25, 0))
sstore(memoryStart_0_slot, tmp_25)
}

}

burn(msg.sender, wad);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_24 = 0; index_24 < a_store_2.length; index_24 += 1) {
sum_balance += _balances[a_store_2[index_24]];
assert(sum_balance >= _balances[a_store_2[index_24]]);
}

}

assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function mint (address guy, uint wad) auth stoppable public {
uint256 entry_1 = 0;
uint256 tmp_27;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_27 := mload(0x40)
mstore(0x40, add(tmp_27, 0))
sstore(memoryStart_0_slot, tmp_27)
}

}

_balances[guy] = add(_balances[guy], wad);if (! a_checker_1[guy]) {
a_store_2.push(guy);
a_checker_1[guy] = true;
}

_supply = add(_supply, wad);
emit Mint(guy, wad);
emit Transfer(address(0), guy, wad);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_26 = 0; index_26 < a_store_2.length; index_26 += 1) {
sum_balance += _balances[a_store_2[index_26]];
assert(sum_balance >= _balances[a_store_2[index_26]]);
}

}

assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function burn (address guy, uint wad) auth stoppable public {
uint256 entry_1 = 0;
uint256 tmp_29;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_29 := mload(0x40)
mstore(0x40, add(tmp_29, 0))
sstore(memoryStart_0_slot, tmp_29)
}

}

_balances[guy] = sub(_balances[guy], wad);if (! a_checker_1[guy]) {
a_store_2.push(guy);
a_checker_1[guy] = true;
}

_supply = sub(_supply, wad);
emit Burn(guy, wad);
emit Transfer(guy, address(0), wad);
if (entry_1 == 1) {
{
{
sum_balance = 0;
}

for (uint256 index_28 = 0; index_28 < a_store_2.length; index_28 += 1) {
sum_balance += _balances[a_store_2[index_28]];
assert(sum_balance >= _balances[a_store_2[index_28]]);
}

}

assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

bytes32 public name = "";
function setName (bytes32 name_) auth public {
name = name_;
}

}
