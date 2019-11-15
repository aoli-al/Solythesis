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
uint256 depth_0;
uint256 sum_balance;
uint256 _supply;
mapping (address=>uint256) _balances;
mapping (address=>mapping (address=>uint256)) _approvals;
constructor (uint supply) public {
uint256 tmp_sum_balance_33 = sum_balance;
{
uint256 opt_34 = _balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_33 >= opt_34);
tmp_sum_balance_33 -= opt_34;
}

}

opt_34 = supply;
{
if (true) {
tmp_sum_balance_33 += opt_34;
assert(tmp_sum_balance_33 >= opt_34);
}

}

_balances[msg.sender] = opt_34;
}

_supply = supply;
assert(_supply == tmp_sum_balance_33);
sum_balance = tmp_sum_balance_33;
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
uint256 tmp_sum_balance_35 = sum_balance;
if (src != msg.sender) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

{
uint256 opt_36 = _balances[src];
{
if (true) {
assert(tmp_sum_balance_35 >= opt_36);
tmp_sum_balance_35 -= opt_36;
}

}

opt_36 = sub(opt_36, wad);
{
if (true) {
tmp_sum_balance_35 += opt_36;
assert(tmp_sum_balance_35 >= opt_36);
}

}

_balances[src] = opt_36;
}

{
uint256 opt_37 = _balances[dst];
{
if (true) {
assert(tmp_sum_balance_35 >= opt_37);
tmp_sum_balance_35 -= opt_37;
}

}

opt_37 = add(opt_37, wad);
{
if (true) {
tmp_sum_balance_35 += opt_37;
assert(tmp_sum_balance_35 >= opt_37);
}

}

_balances[dst] = opt_37;
}

emit Transfer(src, dst, wad);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_35);
}

sum_balance = tmp_sum_balance_35;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_35);
}

sum_balance = tmp_sum_balance_35;
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
uint256 tmp_sum_balance_38 = sum_balance;
_supply = 3000000000000;
{
uint256 opt_39 = _balances[msg.sender];
{
if (true) {
assert(tmp_sum_balance_38 >= opt_39);
tmp_sum_balance_38 -= opt_39;
}

}

opt_39 = _supply;
{
if (true) {
tmp_sum_balance_38 += opt_39;
assert(tmp_sum_balance_38 >= opt_39);
}

}

_balances[msg.sender] = opt_39;
}

assert(_supply == tmp_sum_balance_38);
sum_balance = tmp_sum_balance_38;
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

function transferFrom (address src, address dst, uint wad) stoppable public returns (bool) {
depth_0 += 1;
uint256 tmp_sum_balance_40 = sum_balance;
if (src != msg.sender && _approvals[src][msg.sender] != uint(- 1)) {
_approvals[src][msg.sender] = sub(_approvals[src][msg.sender], wad);
}

{
uint256 opt_41 = _balances[src];
{
if (true) {
assert(tmp_sum_balance_40 >= opt_41);
tmp_sum_balance_40 -= opt_41;
}

}

opt_41 = sub(opt_41, wad);
{
if (true) {
tmp_sum_balance_40 += opt_41;
assert(tmp_sum_balance_40 >= opt_41);
}

}

_balances[src] = opt_41;
}

{
uint256 opt_42 = _balances[dst];
{
if (true) {
assert(tmp_sum_balance_40 >= opt_42);
tmp_sum_balance_40 -= opt_42;
}

}

opt_42 = add(opt_42, wad);
{
if (true) {
tmp_sum_balance_40 += opt_42;
assert(tmp_sum_balance_40 >= opt_42);
}

}

_balances[dst] = opt_42;
}

emit Transfer(src, dst, wad);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_40);
}

sum_balance = tmp_sum_balance_40;
return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_40);
}

sum_balance = tmp_sum_balance_40;
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
uint256 tmp_sum_balance_43 = sum_balance;
{
uint256 opt_44 = _balances[guy];
{
if (true) {
assert(tmp_sum_balance_43 >= opt_44);
tmp_sum_balance_43 -= opt_44;
}

}

opt_44 = add(opt_44, wad);
{
if (true) {
tmp_sum_balance_43 += opt_44;
assert(tmp_sum_balance_43 >= opt_44);
}

}

_balances[guy] = opt_44;
}

_supply = add(_supply, wad);
emit Mint(guy, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_43);
}

sum_balance = tmp_sum_balance_43;
}

function burn (address guy, uint wad) auth stoppable public {
depth_0 += 1;
uint256 tmp_sum_balance_45 = sum_balance;
if (guy != msg.sender && _approvals[guy][msg.sender] != uint(- 1)) {
_approvals[guy][msg.sender] = sub(_approvals[guy][msg.sender], wad);
}

{
uint256 opt_46 = _balances[guy];
{
if (true) {
assert(tmp_sum_balance_45 >= opt_46);
tmp_sum_balance_45 -= opt_46;
}

}

opt_46 = sub(opt_46, wad);
{
if (true) {
tmp_sum_balance_45 += opt_46;
assert(tmp_sum_balance_45 >= opt_46);
}

}

_balances[guy] = opt_46;
}

_supply = sub(_supply, wad);
emit Burn(guy, wad);
depth_0 -= 1;
if (depth_0 == 0) {
assert(_supply == tmp_sum_balance_45);
}

sum_balance = tmp_sum_balance_45;
}

bytes32 public name = "";
function setName (bytes32 name_) auth public {
name = name_;
}

}
