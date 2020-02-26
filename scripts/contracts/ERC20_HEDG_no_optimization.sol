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
uint256 depth_0;
uint256 sum_balance;
uint256 _supply;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) _approvals;
constructor (uint supply) public {
uint256 tmp_sum_balance_51 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_51 >= _balances[msg.sender]);
tmp_sum_balance_51 -= _balances[msg.sender];
}

}
_balances[msg.sender] = supply;{
if (true) {
tmp_sum_balance_51 += _balances[msg.sender];
assert(tmp_sum_balance_51 >= _balances[msg.sender]);
}

}

_supply = supply;
assert(_supply == tmp_sum_balance_51);
sum_balance = tmp_sum_balance_51;
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
assert(_supply == sum_balance);
}

return transferFrom(msg.sender, dst, wad);
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == sum_balance);
}

}

function transferFrom (address src, address dst, uint wad) public returns (bool) {
depth_0 += 1;
uint256 tmp_sum_balance_52 = sum_balance;
if (src != msg.sender) {
require(_approvals[src][msg.sender] >= wad, "ds-token-insufficient-approval");
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

require(_balances[src] >= wad, "ds-token-insufficient-balance");
{
if (true) {
assert(tmp_sum_balance_52 >= _balances[src]);
tmp_sum_balance_52 -= _balances[src];
}

}
_balances[src] = sub(_balances[src], wad);{
if (true) {
tmp_sum_balance_52 += _balances[src];
assert(tmp_sum_balance_52 >= _balances[src]);
}

}

{
if (true) {
assert(tmp_sum_balance_52 >= _balances[dst]);
tmp_sum_balance_52 -= _balances[dst];
}

}
_balances[dst] = add(_balances[dst], wad);{
if (true) {
tmp_sum_balance_52 += _balances[dst];
assert(tmp_sum_balance_52 >= _balances[dst]);
}

}

emit Transfer(src, dst, wad);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_52);
}

sum_balance = tmp_sum_balance_52;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_52);
}

sum_balance = tmp_sum_balance_52;
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
uint256 tmp_sum_balance_53 = sum_balance;
_supply = 1000000000000000;
{
if (true) {
assert(tmp_sum_balance_53 >= _balances[msg.sender]);
tmp_sum_balance_53 -= _balances[msg.sender];
}

}
_balances[msg.sender] = _supply;{
if (true) {
tmp_sum_balance_53 += _balances[msg.sender];
assert(tmp_sum_balance_53 >= _balances[msg.sender]);
}

}

assert(_supply == tmp_sum_balance_53);
sum_balance = tmp_sum_balance_53;
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
depth_0 += 1;
uint256 tmp_sum_balance_54 = sum_balance;
if (src != msg.sender && ! _trusted[src][msg.sender]) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

{
if (true) {
assert(tmp_sum_balance_54 >= _balances[src]);
tmp_sum_balance_54 -= _balances[src];
}

}
_balances[src] = sub(_balances[src], wad);{
if (true) {
tmp_sum_balance_54 += _balances[src];
assert(tmp_sum_balance_54 >= _balances[src]);
}

}

{
if (true) {
assert(tmp_sum_balance_54 >= _balances[dst]);
tmp_sum_balance_54 -= _balances[dst];
}

}
_balances[dst] = add(_balances[dst], wad);{
if (true) {
tmp_sum_balance_54 += _balances[dst];
assert(tmp_sum_balance_54 >= _balances[dst]);
}

}

emit Transfer(src, dst, wad);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_54);
}

sum_balance = tmp_sum_balance_54;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_54);
}

sum_balance = tmp_sum_balance_54;
}

function push (address dst, uint wad) public {
depth_0 += 1;
transferFrom(msg.sender, dst, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == sum_balance);
}

}

function pull (address src, uint wad) public {
depth_0 += 1;
transferFrom(src, msg.sender, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == sum_balance);
}

}

function move (address src, address dst, uint wad) public {
depth_0 += 1;
transferFrom(src, dst, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == sum_balance);
}

}

function mint (uint wad) public {
depth_0 += 1;
mint(msg.sender, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == sum_balance);
}

}

function burn (uint wad) public {
depth_0 += 1;
burn(msg.sender, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == sum_balance);
}

}

function mint (address guy, uint wad) auth stoppable public {
depth_0 += 1;
uint256 tmp_sum_balance_55 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_55 >= _balances[guy]);
tmp_sum_balance_55 -= _balances[guy];
}

}
_balances[guy] = add(_balances[guy], wad);{
if (true) {
tmp_sum_balance_55 += _balances[guy];
assert(tmp_sum_balance_55 >= _balances[guy]);
}

}

_supply = add(_supply, wad);
emit Mint(guy, wad);
emit Transfer(address(0), guy, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_55);
}

sum_balance = tmp_sum_balance_55;
}

function burn (address guy, uint wad) auth stoppable public {
depth_0 += 1;
uint256 tmp_sum_balance_56 = sum_balance;
{
if (true) {
assert(tmp_sum_balance_56 >= _balances[guy]);
tmp_sum_balance_56 -= _balances[guy];
}

}
_balances[guy] = sub(_balances[guy], wad);{
if (true) {
tmp_sum_balance_56 += _balances[guy];
assert(tmp_sum_balance_56 >= _balances[guy]);
}

}

_supply = sub(_supply, wad);
emit Burn(guy, wad);
emit Transfer(guy, address(0), wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_56);
}

sum_balance = tmp_sum_balance_56;
}

bytes32 public name = "";
function setName (bytes32 name_) auth public {
name = name_;
}

}
