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
uint256 tmp_55;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_55 := mload(0x40)
mstore(0x40, add(tmp_55, 0))
sstore(memoryStart_0_slot, tmp_55)
}

}

{
uint256 opt_54 = _balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_54);
sum_balance -= opt_54;
}

}

opt_54 = supply;
{
if (true) {
sum_balance += opt_54;
assert(sum_balance >= opt_54);
}

}

_balances[msg.sender] = opt_54;
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
uint256 tmp_56;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_56 := mload(0x40)
mstore(0x40, add(tmp_56, 0))
sstore(memoryStart_0_slot, tmp_56)
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
uint256 tmp_59;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_59 := mload(0x40)
mstore(0x40, add(tmp_59, 0))
sstore(memoryStart_0_slot, tmp_59)
}

}

if (src != msg.sender) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

{
uint256 opt_57 = _balances[src];
{
if (true) {
assert(sum_balance >= opt_57);
sum_balance -= opt_57;
}

}

opt_57 = sub(opt_57, wad);
{
if (true) {
sum_balance += opt_57;
assert(sum_balance >= opt_57);
}

}

_balances[src] = opt_57;
}

{
uint256 opt_58 = _balances[dst];
{
if (true) {
assert(sum_balance >= opt_58);
sum_balance -= opt_58;
}

}

opt_58 = add(opt_58, wad);
{
if (true) {
sum_balance += opt_58;
assert(sum_balance >= opt_58);
}

}

_balances[dst] = opt_58;
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
uint256 tmp_61;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_61 := mload(0x40)
mstore(0x40, add(tmp_61, 0))
sstore(memoryStart_0_slot, tmp_61)
}

}

_supply = 3000000000000;
{
uint256 opt_60 = _balances[msg.sender];
{
if (true) {
assert(sum_balance >= opt_60);
sum_balance -= opt_60;
}

}

opt_60 = _supply;
{
if (true) {
sum_balance += opt_60;
assert(sum_balance >= opt_60);
}

}

_balances[msg.sender] = opt_60;
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
uint256 tmp_62;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_62 := mload(0x40)
mstore(0x40, add(tmp_62, 0))
sstore(memoryStart_0_slot, tmp_62)
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
uint256 tmp_65;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_65 := mload(0x40)
mstore(0x40, add(tmp_65, 0))
sstore(memoryStart_0_slot, tmp_65)
}

}

if (src != msg.sender && _approvals[src][msg.sender] != uint(- 1)) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

{
uint256 opt_63 = _balances[src];
{
if (true) {
assert(sum_balance >= opt_63);
sum_balance -= opt_63;
}

}

opt_63 = sub(opt_63, wad);
{
if (true) {
sum_balance += opt_63;
assert(sum_balance >= opt_63);
}

}

_balances[src] = opt_63;
}

{
uint256 opt_64 = _balances[dst];
{
if (true) {
assert(sum_balance >= opt_64);
sum_balance -= opt_64;
}

}

opt_64 = add(opt_64, wad);
{
if (true) {
sum_balance += opt_64;
assert(sum_balance >= opt_64);
}

}

_balances[dst] = opt_64;
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
uint256 tmp_66;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_66 := mload(0x40)
mstore(0x40, add(tmp_66, 0))
sstore(memoryStart_0_slot, tmp_66)
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
uint256 tmp_67;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_67 := mload(0x40)
mstore(0x40, add(tmp_67, 0))
sstore(memoryStart_0_slot, tmp_67)
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
uint256 tmp_68;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_68 := mload(0x40)
mstore(0x40, add(tmp_68, 0))
sstore(memoryStart_0_slot, tmp_68)
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
uint256 tmp_69;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_69 := mload(0x40)
mstore(0x40, add(tmp_69, 0))
sstore(memoryStart_0_slot, tmp_69)
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
uint256 tmp_70;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_70 := mload(0x40)
mstore(0x40, add(tmp_70, 0))
sstore(memoryStart_0_slot, tmp_70)
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
uint256 tmp_72;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_72 := mload(0x40)
mstore(0x40, add(tmp_72, 0))
sstore(memoryStart_0_slot, tmp_72)
}

}

{
uint256 opt_71 = _balances[guy];
{
if (true) {
assert(sum_balance >= opt_71);
sum_balance -= opt_71;
}

}

opt_71 = add(opt_71, wad);
{
if (true) {
sum_balance += opt_71;
assert(sum_balance >= opt_71);
}

}

_balances[guy] = opt_71;
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
uint256 tmp_74;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_74 := mload(0x40)
mstore(0x40, add(tmp_74, 0))
sstore(memoryStart_0_slot, tmp_74)
}

}

if (guy != msg.sender && _approvals[guy][msg.sender] != uint(- 1)) {
_approvals[guy][msg.sender] = sub(_approvals[guy][msg.sender], wad);
}

{
uint256 opt_73 = _balances[guy];
{
if (true) {
assert(sum_balance >= opt_73);
sum_balance -= opt_73;
}

}

opt_73 = sub(opt_73, wad);
{
if (true) {
sum_balance += opt_73;
assert(sum_balance >= opt_73);
}

}

_balances[guy] = opt_73;
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
