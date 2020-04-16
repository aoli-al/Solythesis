pragma solidity ^0.5.0;
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
uint256 sum_balance;
uint256 _supply;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) _approvals;
constructor (uint supply) public {
uint256 entry_1 = 0;
uint256 tmp_88;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_88 := mload(0x40)
mstore(0x40, add(tmp_88, 0))
sstore(memoryStart_0_slot, tmp_88)
}

}

{
if (true) {
assert(sum_balance >= _balances[msg.sender]);
sum_balance -= _balances[msg.sender];
}

}
_balances[msg.sender] = supply;{
if (true) {
sum_balance += _balances[msg.sender];
assert(sum_balance >= _balances[msg.sender]);
}

}

_supply = supply;
if (entry_1 == 1) {
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
uint256 tmp_89;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_89 := mload(0x40)
mstore(0x40, add(tmp_89, 0))
sstore(memoryStart_0_slot, tmp_89)
}

}

{
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

return transferFrom(msg.sender, dst, wad);
}

if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address src, address dst, uint wad) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_90;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_90 := mload(0x40)
mstore(0x40, add(tmp_90, 0))
sstore(memoryStart_0_slot, tmp_90)
}

}

if (src != msg.sender) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

{
if (true) {
assert(sum_balance >= _balances[src]);
sum_balance -= _balances[src];
}

}
_balances[src] = sub(_balances[src], wad);{
if (true) {
sum_balance += _balances[src];
assert(sum_balance >= _balances[src]);
}

}

{
if (true) {
assert(sum_balance >= _balances[dst]);
sum_balance -= _balances[dst];
}

}
_balances[dst] = add(_balances[dst], wad);{
if (true) {
sum_balance += _balances[dst];
assert(sum_balance >= _balances[dst]);
}

}

emit Transfer(src, dst, wad);
{
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
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
contract DSToken is DSTokenBase(0), DSStop {
bytes32 public symbol = '';
uint256 public decimals = 18;
constructor () public {
uint256 entry_1 = 0;
uint256 tmp_91;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_91 := mload(0x40)
mstore(0x40, add(tmp_91, 0))
sstore(memoryStart_0_slot, tmp_91)
}

}

_supply = 3000000000000;
{
if (true) {
assert(sum_balance >= _balances[msg.sender]);
sum_balance -= _balances[msg.sender];
}

}
_balances[msg.sender] = _supply;{
if (true) {
sum_balance += _balances[msg.sender];
assert(sum_balance >= _balances[msg.sender]);
}

}

if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

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

function transfer (address dst, uint wad) public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_92;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_92 := mload(0x40)
mstore(0x40, add(tmp_92, 0))
sstore(memoryStart_0_slot, tmp_92)
}

}

{
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

return transferFrom(msg.sender, dst, wad);
}

if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function transferFrom (address src, address dst, uint wad) stoppable public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_93;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_93 := mload(0x40)
mstore(0x40, add(tmp_93, 0))
sstore(memoryStart_0_slot, tmp_93)
}

}

if (src != msg.sender && _approvals[src][msg.sender] != uint(- 1)) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

{
if (true) {
assert(sum_balance >= _balances[src]);
sum_balance -= _balances[src];
}

}
_balances[src] = sub(_balances[src], wad);{
if (true) {
sum_balance += _balances[src];
assert(sum_balance >= _balances[src]);
}

}

{
if (true) {
assert(sum_balance >= _balances[dst]);
sum_balance -= _balances[dst];
}

}
_balances[dst] = add(_balances[dst], wad);{
if (true) {
sum_balance += _balances[dst];
assert(sum_balance >= _balances[dst]);
}

}

emit Transfer(src, dst, wad);
{
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

return true;
}

if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function push (address dst, uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_94;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_94 := mload(0x40)
mstore(0x40, add(tmp_94, 0))
sstore(memoryStart_0_slot, tmp_94)
}

}

transferFrom(msg.sender, dst, wad);
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function pull (address src, uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_95;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_95 := mload(0x40)
mstore(0x40, add(tmp_95, 0))
sstore(memoryStart_0_slot, tmp_95)
}

}

transferFrom(src, msg.sender, wad);
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function move (address src, address dst, uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_96;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_96 := mload(0x40)
mstore(0x40, add(tmp_96, 0))
sstore(memoryStart_0_slot, tmp_96)
}

}

transferFrom(src, dst, wad);
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function mint (uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_97;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_97 := mload(0x40)
mstore(0x40, add(tmp_97, 0))
sstore(memoryStart_0_slot, tmp_97)
}

}

mint(msg.sender, wad);
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function burn (uint wad) public {
uint256 entry_1 = 0;
uint256 tmp_98;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_98 := mload(0x40)
mstore(0x40, add(tmp_98, 0))
sstore(memoryStart_0_slot, tmp_98)
}

}

burn(msg.sender, wad);
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function mint (address guy, uint wad) auth stoppable public {
uint256 entry_1 = 0;
uint256 tmp_99;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_99 := mload(0x40)
mstore(0x40, add(tmp_99, 0))
sstore(memoryStart_0_slot, tmp_99)
}

}

{
if (true) {
assert(sum_balance >= _balances[guy]);
sum_balance -= _balances[guy];
}

}
_balances[guy] = add(_balances[guy], wad);{
if (true) {
sum_balance += _balances[guy];
assert(sum_balance >= _balances[guy]);
}

}

_supply = add(_supply, wad);
emit Mint(guy, wad);
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

function burn (address guy, uint wad) auth stoppable public {
uint256 entry_1 = 0;
uint256 tmp_100;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_100 := mload(0x40)
mstore(0x40, add(tmp_100, 0))
sstore(memoryStart_0_slot, tmp_100)
}

}

if (guy != msg.sender && _approvals[guy][msg.sender] != uint(- 1)) {
_approvals[guy][msg.sender] = sub(_approvals[guy][msg.sender], wad);
}

{
if (true) {
assert(sum_balance >= _balances[guy]);
sum_balance -= _balances[guy];
}

}
_balances[guy] = sub(_balances[guy], wad);{
if (true) {
sum_balance += _balances[guy];
assert(sum_balance >= _balances[guy]);
}

}

_supply = sub(_supply, wad);
emit Burn(guy, wad);
if (entry_1 == 1) {
assert(_supply == sum_balance);
memoryStart_0 = 0;
}

}

bytes32 public name = "";
function setName (bytes32 name_) auth public {
name = name_;
}

}
