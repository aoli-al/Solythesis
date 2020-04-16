pragma solidity ^0.5.0;
contract Ownable {
address private _owner;
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
constructor () internal {
_owner = msg.sender;
emit OwnershipTransferred(address(0), _owner);
}

function owner () public view returns (address) {
{
return _owner;
}

}

modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }
function isOwner () public view returns (bool) {
{
return msg.sender == _owner;
}

}

function renounceOwnership () onlyOwner public {
emit OwnershipTransferred(_owner, address(0));
_owner = address(0);
}

function transferOwnership (address newOwner) onlyOwner public {
_transferOwnership(newOwner);
}

function _transferOwnership (address newOwner) internal {
require(newOwner != address(0), "Ownable: new owner is the zero address");
emit OwnershipTransferred(_owner, newOwner);
_owner = newOwner;
}

}
library Roles {
struct Role {
        mapping (address => bool) bearer;
    }
function add (Role storage role, address account) internal {
require(! has(role, account), "Roles: account already has role");
role.bearer[account] = true;
}

function remove (Role storage role, address account) internal {
require(has(role, account), "Roles: account does not have role");
role.bearer[account] = false;
}

function has (Role storage role, address account) internal view returns (bool) {
require(account != address(0), "Roles: account is the zero address");
{
return role.bearer[account];
}

}

}
contract MinterRole {
using Roles for Roles.Role;
event MinterAdded(address indexed account);
event MinterRemoved(address indexed account);
Roles.Role private _minters;
constructor () internal {
_addMinter(msg.sender);
}

modifier onlyMinter() {
        require(isMinter(msg.sender), "MinterRole: caller does not have the Minter role");
        _;
    }
function isMinter (address account) public view returns (bool) {
{
return _minters.has(account);
}

}

function addMinter (address account) onlyMinter public {
_addMinter(account);
}

function renounceMinter () public {
_removeMinter(msg.sender);
}

function _addMinter (address account) internal {
_minters.add(account);
emit MinterAdded(account);
}

function _removeMinter (address account) internal {
_minters.remove(account);
emit MinterRemoved(account);
}

}
interface IERC165 {
function supportsInterface (bytes4 interfaceId) external view returns (bool);
}
contract IERC721 is IERC165 {
event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
uint256[] internal _allTokens;
function balanceOf (address owner) public view returns (uint256 balance);
function ownerOf (uint256 tokenId) public view returns (address owner);
function safeTransferFrom (address from, address to, uint256 tokenId) public;
function transferFrom (address from, address to, uint256 tokenId) public;
function approve (address to, uint256 tokenId) public;
function getApproved (uint256 tokenId) public view returns (address operator);
function setApprovalForAll (address operator, bool _approved) public;
function isApprovedForAll (address owner, address operator) public view returns (bool);
function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory data) public;
}
contract IERC721Enumerable is IERC721 {
function totalSupply () public view returns (uint256);
function tokenOfOwnerByIndex (address owner, uint256 index) public view returns (uint256 tokenId);
function tokenByIndex (uint256 index) public view returns (uint256);
}
contract ERC165 is IERC165 {
bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;
mapping (bytes4=>bool) private _supportedInterfaces;
constructor () internal {
_registerInterface(_INTERFACE_ID_ERC165);
}

function supportsInterface (bytes4 interfaceId) external view returns (bool) {
{
return _supportedInterfaces[interfaceId];
}

}

function _registerInterface (bytes4 interfaceId) internal {
require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
_supportedInterfaces[interfaceId] = true;
}

}
contract IERC721Receiver {
function onERC721Received (address operator, address from, uint256 tokenId, bytes memory data) public returns (bytes4);
}
library SafeMath {
function add (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a + b;
require(c >= a, "SafeMath: addition overflow");
{
return c;
}

}

function sub (uint256 a, uint256 b) internal pure returns (uint256) {
require(b <= a, "SafeMath: subtraction overflow");
uint256 c = a - b;
{
return c;
}

}

function mul (uint256 a, uint256 b) internal pure returns (uint256) {
if (a == 0) {
{
return 0;
}

}

uint256 c = a * b;
require(c / a == b, "SafeMath: multiplication overflow");
{
return c;
}

}

function div (uint256 a, uint256 b) internal pure returns (uint256) {
require(b > 0, "SafeMath: division by zero");
uint256 c = a / b;
{
return c;
}

}

function mod (uint256 a, uint256 b) internal pure returns (uint256) {
require(b != 0, "SafeMath: modulo by zero");
{
return a % b;
}

}

}
library Address {
function isContract (address account) internal view returns (bool) {
uint256 size;
assembly {
size := extcodesize(account)
}

{
return size > 0;
}

}

}
contract ERC721 is ERC165, IERC721 {
uint256 memoryStart_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_128;
using SafeMath for uint256;
using Address for address;
bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
mapping (uint256=>address) internal _tokenOwner;
mapping (uint256=>address) internal _tokenApprovals;
mapping (address=>uint256) internal _ownedTokensCount;
mapping (address=>mapping (address=>bool)) private _operatorApprovals;
bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
constructor () public {
_registerInterface(_INTERFACE_ID_ERC721);
}

function balanceOf (address owner) public view returns (uint256) {
require(owner != address(0));
{
return _ownedTokensCount[owner];
}

}

function ownerOf (uint256 tokenId) public view returns (address) {
address owner = _tokenOwner[tokenId];
require(owner != address(0));
{
return owner;
}

}

function approve (address to, uint256 tokenId) public {
address owner = ownerOf(tokenId);
require(to != owner);
require(msg.sender == owner || isApprovedForAll(owner, msg.sender));
_tokenApprovals[tokenId] = to;
emit Approval(owner, to, tokenId);
}

function getApproved (uint256 tokenId) public view returns (address) {
require(_exists(tokenId));
{
return _tokenApprovals[tokenId];
}

}

function setApprovalForAll (address to, bool approved) public {
require(to != msg.sender);
_operatorApprovals[msg.sender][to] = approved;
emit ApprovalForAll(msg.sender, to, approved);
}

function isApprovedForAll (address owner, address operator) public view returns (bool) {
{
return _operatorApprovals[owner][operator];
}

}

function transferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_132;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_132 := mload(0x40)
mstore(0x40, add(tmp_132, 640))
sstore(memoryStart_0_slot, tmp_132)
mstore(add(tmp_132, 0), 0)
}

}

address[] memory a_129;
assembly {
a_129 := add(sload(memoryStart_0_slot), 0)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_130 = 0; index_130 < a_129.length; index_130 += 1) {
address tmp_131;
assembly {
tmp_131 := mload(add(a_129, mul(add(index_130, 1), 32)))
}

assert(_ownedTokensCount[tmp_131] == sum_ownersToken[tmp_131]);
}

memoryStart_0 = 0;
}

}

function fastTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_136;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_136 := mload(0x40)
mstore(0x40, add(tmp_136, 640))
sstore(memoryStart_0_slot, tmp_136)
mstore(add(tmp_136, 0), 0)
}

}

address[] memory a_133;
assembly {
a_133 := add(sload(memoryStart_0_slot), 0)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_fastTransferFrom(from, to, tokenId);
if (entry_1 == 1) {
for (uint256 index_134 = 0; index_134 < a_133.length; index_134 += 1) {
address tmp_135;
assembly {
tmp_135 := mload(add(a_133, mul(add(index_134, 1), 32)))
}

assert(_ownedTokensCount[tmp_135] == sum_ownersToken[tmp_135]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_140;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_140 := mload(0x40)
mstore(0x40, add(tmp_140, 640))
sstore(memoryStart_0_slot, tmp_140)
mstore(add(tmp_140, 0), 0)
}

}

address[] memory a_137;
assembly {
a_137 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_138 = 0; index_138 < a_137.length; index_138 += 1) {
address tmp_139;
assembly {
tmp_139 := mload(add(a_137, mul(add(index_138, 1), 32)))
}

assert(_ownedTokensCount[tmp_139] == sum_ownersToken[tmp_139]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
uint256 entry_1 = 0;
uint256 tmp_144;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_144 := mload(0x40)
mstore(0x40, add(tmp_144, 640))
sstore(memoryStart_0_slot, tmp_144)
mstore(add(tmp_144, 0), 0)
}

}

address[] memory a_141;
assembly {
a_141 := add(sload(memoryStart_0_slot), 0)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_142 = 0; index_142 < a_141.length; index_142 += 1) {
address tmp_143;
assembly {
tmp_143 := mload(add(a_141, mul(add(index_142, 1), 32)))
}

assert(_ownedTokensCount[tmp_143] == sum_ownersToken[tmp_143]);
}

memoryStart_0 = 0;
}

}

function _exists (uint256 tokenId) internal view returns (bool) {
address owner = _tokenOwner[tokenId];
{
return owner != address(0);
}

}

function _isApprovedOrOwner (address spender, uint256 tokenId) internal view returns (bool) {
address owner = ownerOf(tokenId);
{
return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
}

}

function _mint (address to, uint256 tokenId) internal {
address[] memory a_146;
assembly {
a_146 := add(sload(memoryStart_0_slot), 0)
}

require(to != address(0));
require(! _exists(tokenId));
{
address opt_145 = _tokenOwner[tokenId];
{
if (opt_145 == opt_145 && opt_145 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_145] >= 1);
{
address tmp_147 = opt_145;
assembly {
let tmp := add(mload(a_146), 1)
mstore(a_146, tmp)
mstore(add(a_146, mul(tmp, 32)), tmp_147)
}

}
sum_ownersToken[opt_145] -= 1;
}

}

opt_145 = to;
{
if (opt_145 == opt_145 && opt_145 != 0x0000000000000000000000000000000000000000) {
{
address tmp_148 = opt_145;
assembly {
let tmp := add(mload(a_146), 1)
mstore(a_146, tmp)
mstore(add(a_146, mul(tmp, 32)), tmp_148)
}

}
sum_ownersToken[opt_145] += 1;
assert(sum_ownersToken[opt_145] >= 1);
}

}

_tokenOwner[tokenId] = opt_145;
}

{
uint256 opt_150 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_150);
sum_tokenCount -= opt_150;
}

}

{
address tmp_149 = to;
assembly {
let tmp := add(mload(a_146), 1)
mstore(a_146, tmp)
mstore(add(a_146, mul(tmp, 32)), tmp_149)
}

}

opt_150 = opt_150.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_150;
assert(sum_tokenCount >= opt_150);
}

}

_ownedTokensCount[to] = opt_150;
}

emit Transfer(address(0), to, tokenId);
}

function _fastMint (address to, uint256 tokenId) internal {
address[] memory a_153;
assembly {
a_153 := add(sload(memoryStart_0_slot), 0)
}

if (_tokenOwner[tokenId] == address(0)) {
{
address opt_152 = _tokenOwner[tokenId];
{
if (opt_152 == opt_152 && opt_152 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_152] >= 1);
{
address tmp_154 = opt_152;
assembly {
let tmp := add(mload(a_153), 1)
mstore(a_153, tmp)
mstore(add(a_153, mul(tmp, 32)), tmp_154)
}

}
sum_ownersToken[opt_152] -= 1;
}

}

opt_152 = to;
{
if (opt_152 == opt_152 && opt_152 != 0x0000000000000000000000000000000000000000) {
{
address tmp_155 = opt_152;
assembly {
let tmp := add(mload(a_153), 1)
mstore(a_153, tmp)
mstore(add(a_153, mul(tmp, 32)), tmp_155)
}

}
sum_ownersToken[opt_152] += 1;
assert(sum_ownersToken[opt_152] >= 1);
}

}

_tokenOwner[tokenId] = opt_152;
}

}

emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_156;
assembly {
a_156 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_158 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_158);
sum_tokenCount -= opt_158;
}

}

{
address tmp_157 = owner;
assembly {
let tmp := add(mload(a_156), 1)
mstore(a_156, tmp)
mstore(add(a_156, mul(tmp, 32)), tmp_157)
}

}

opt_158 = opt_158.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_158;
assert(sum_tokenCount >= opt_158);
}

}

_ownedTokensCount[owner] = opt_158;
}

{
address opt_160 = _tokenOwner[tokenId];
{
if (opt_160 == opt_160 && opt_160 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_160] >= 1);
{
address tmp_161 = opt_160;
assembly {
let tmp := add(mload(a_156), 1)
mstore(a_156, tmp)
mstore(add(a_156, mul(tmp, 32)), tmp_161)
}

}
sum_ownersToken[opt_160] -= 1;
}

}

opt_160 = address(0);
{
if (opt_160 == opt_160 && opt_160 != 0x0000000000000000000000000000000000000000) {
{
address tmp_162 = opt_160;
assembly {
let tmp := add(mload(a_156), 1)
mstore(a_156, tmp)
mstore(add(a_156, mul(tmp, 32)), tmp_162)
}

}
sum_ownersToken[opt_160] += 1;
assert(sum_ownersToken[opt_160] >= 1);
}

}

_tokenOwner[tokenId] = opt_160;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_163;
assembly {
a_163 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_165 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_165);
sum_tokenCount -= opt_165;
}

}

{
address tmp_164 = from;
assembly {
let tmp := add(mload(a_163), 1)
mstore(a_163, tmp)
mstore(add(a_163, mul(tmp, 32)), tmp_164)
}

}

opt_165 = opt_165.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_165;
assert(sum_tokenCount >= opt_165);
}

}

_ownedTokensCount[from] = opt_165;
}

{
uint256 opt_168 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_168);
sum_tokenCount -= opt_168;
}

}

{
address tmp_167 = to;
assembly {
let tmp := add(mload(a_163), 1)
mstore(a_163, tmp)
mstore(add(a_163, mul(tmp, 32)), tmp_167)
}

}

opt_168 = opt_168.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_168;
assert(sum_tokenCount >= opt_168);
}

}

_ownedTokensCount[to] = opt_168;
}

{
address opt_170 = _tokenOwner[tokenId];
{
if (opt_170 == opt_170 && opt_170 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_170] >= 1);
{
address tmp_171 = opt_170;
assembly {
let tmp := add(mload(a_163), 1)
mstore(a_163, tmp)
mstore(add(a_163, mul(tmp, 32)), tmp_171)
}

}
sum_ownersToken[opt_170] -= 1;
}

}

opt_170 = to;
{
if (opt_170 == opt_170 && opt_170 != 0x0000000000000000000000000000000000000000) {
{
address tmp_172 = opt_170;
assembly {
let tmp := add(mload(a_163), 1)
mstore(a_163, tmp)
mstore(add(a_163, mul(tmp, 32)), tmp_172)
}

}
sum_ownersToken[opt_170] += 1;
assert(sum_ownersToken[opt_170] >= 1);
}

}

_tokenOwner[tokenId] = opt_170;
}

emit Transfer(from, to, tokenId);
}

function _fastTransferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_174;
assembly {
a_174 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == from);
_clearApproval(tokenId);
{
address opt_173 = _tokenOwner[tokenId];
{
if (opt_173 == opt_173 && opt_173 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_173] >= 1);
{
address tmp_175 = opt_173;
assembly {
let tmp := add(mload(a_174), 1)
mstore(a_174, tmp)
mstore(add(a_174, mul(tmp, 32)), tmp_175)
}

}
sum_ownersToken[opt_173] -= 1;
}

}

opt_173 = to;
{
if (opt_173 == opt_173 && opt_173 != 0x0000000000000000000000000000000000000000) {
{
address tmp_176 = opt_173;
assembly {
let tmp := add(mload(a_174), 1)
mstore(a_174, tmp)
mstore(add(a_174, mul(tmp, 32)), tmp_176)
}

}
sum_ownersToken[opt_173] += 1;
assert(sum_ownersToken[opt_173] >= 1);
}

}

_tokenOwner[tokenId] = opt_173;
}

emit Transfer(from, to, tokenId);
}

function _checkOnERC721Received (address from, address to, uint256 tokenId, bytes memory _data) internal returns (bool) {
if (! to.isContract()) {
{
return true;
}

}

bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
{
return (retval == _ERC721_RECEIVED);
}

}

function _clearApproval (uint256 tokenId) private {
if (_tokenApprovals[tokenId] != address(0)) {
_tokenApprovals[tokenId] = address(0);
}

}

}
contract ERC721Enumerable is ERC165, ERC721, IERC721Enumerable {
mapping (address=>uint256[]) internal _ownedTokens;
mapping (uint256=>uint256) internal _ownedTokensIndex;
mapping (uint256=>uint256) internal _allTokensIndex;
bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
constructor () public {
_registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
}

function tokenOfOwnerByIndex (address owner, uint256 index) public view returns (uint256) {
require(index < balanceOf(owner));
{
return _ownedTokens[owner][index];
}

}

function totalSupply () public view returns (uint256) {
{
return _allTokens.length;
}

}

function tokenByIndex (uint256 index) public view returns (uint256) {
require(index < totalSupply());
{
return _allTokens[index];
}

}

function _transferFrom (address from, address to, uint256 tokenId) internal {
super._transferFrom(from, to, tokenId);
_removeTokenFromOwnerEnumeration(from, tokenId);
_addTokenToOwnerEnumeration(to, tokenId);
}

function _fastTransferFrom (address from, address to, uint256 tokenId) internal {
super._fastTransferFrom(from, to, tokenId);
_removeTokenFromOwnerEnumeration(from, tokenId);
_addTokenToOwnerEnumeration(to, tokenId);
}

function _mint (address to, uint256 tokenId) internal {
super._mint(to, tokenId);
_addTokenToOwnerEnumeration(to, tokenId);
_addTokenToAllTokensEnumeration(tokenId);
}

function _fastMint (address to, uint256 tokenId) internal {
super._fastMint(to, tokenId);
_addTokenToOwnerEnumeration(to, tokenId);
_addTokenToAllTokensEnumeration(tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
super._burn(owner, tokenId);
_removeTokenFromOwnerEnumeration(owner, tokenId);
_ownedTokensIndex[tokenId] = 0;
_removeTokenFromAllTokensEnumeration(tokenId);
}

function _tokensOfOwner (address owner) internal view returns (uint256[] storage) {
{
return _ownedTokens[owner];
}

}

function _addTokenToOwnerEnumeration (address to, uint256 tokenId) private {
_ownedTokensIndex[tokenId] = _ownedTokens[to].length;
_ownedTokens[to].push(tokenId);
}

function _addTokenToAllTokensEnumeration (uint256 tokenId) private {
_allTokensIndex[tokenId] = _allTokens.length;
_allTokens.push(tokenId);
}

function _removeTokenFromOwnerEnumeration (address from, uint256 tokenId) private {
uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
uint256 tokenIndex = _ownedTokensIndex[tokenId];
if (tokenIndex != lastTokenIndex) {
uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];
_ownedTokens[from][tokenIndex] = lastTokenId;
_ownedTokensIndex[lastTokenId] = tokenIndex;
}

_ownedTokens[from].length --;
}

function _removeTokenFromAllTokensEnumeration (uint256 tokenId) private {
uint256 lastTokenIndex = _allTokens.length.sub(1);
uint256 tokenIndex = _allTokensIndex[tokenId];
uint256 lastTokenId = _allTokens[lastTokenIndex];
_allTokens[tokenIndex] = lastTokenId;
_allTokensIndex[lastTokenId] = tokenIndex;
_allTokens.length --;
_allTokensIndex[tokenId] = 0;
}

}
contract OwnableDelegateProxy {
}
contract ProxyRegistry {
mapping (address=>OwnableDelegateProxy) public proxies;
}
contract CryptoCardsERC721Batched is ERC721Enumerable {
string internal _tokenName;
string internal _tokenSymbol;
string internal _baseTokenURI;
address internal _proxyRegistryAddress;
bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
event BatchTransfer(address from, address to, uint256[] tokenIds);
constructor (string memory name, string memory symbol, string memory uri) public {
_registerInterface(_INTERFACE_ID_ERC721_METADATA);
_tokenName = name;
_tokenSymbol = symbol;
_baseTokenURI = uri;
}

function getVersion () public pure returns (string memory) {
{
return "v2.2.1";
}

}

function name () external view returns (string memory) {
{
return _tokenName;
}

}

function symbol () external view returns (string memory) {
{
return _tokenSymbol;
}

}

function tokenURI (uint256 tokenId) public view returns (string memory) {
require(_exists(tokenId), "Token doesn't exist");
{
return string(abi.encodePacked(
                _baseTokenURI,
                uint2str(tokenId),
                ".json"
            ));
}

}

function exists (uint256 tokenId) public view returns (bool) {
{
return _exists(tokenId);
}

}

function batchTransferFrom (address from, address to, uint256[] memory tokenIds) public {
uint256 entry_1 = 0;
uint256 tmp_186;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_186 := mload(0x40)
mstore(0x40, add(tmp_186, 640))
sstore(memoryStart_0_slot, tmp_186)
mstore(add(tmp_186, 0), 0)
}

}

address[] memory a_177;
assembly {
a_177 := add(sload(memoryStart_0_slot), 0)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastTransferFrom(from, to, tokenIds[i]);
}

{
uint256 opt_179 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_179);
sum_tokenCount -= opt_179;
}

}

{
address tmp_178 = from;
assembly {
let tmp := add(mload(a_177), 1)
mstore(a_177, tmp)
mstore(add(a_177, mul(tmp, 32)), tmp_178)
}

}

opt_179 = opt_179.sub(tokenIds.length);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_179;
assert(sum_tokenCount >= opt_179);
}

}

_ownedTokensCount[from] = opt_179;
}

{
uint256 opt_182 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_182);
sum_tokenCount -= opt_182;
}

}

{
address tmp_181 = to;
assembly {
let tmp := add(mload(a_177), 1)
mstore(a_177, tmp)
mstore(add(a_177, mul(tmp, 32)), tmp_181)
}

}

opt_182 = opt_182.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_182;
assert(sum_tokenCount >= opt_182);
}

}

_ownedTokensCount[to] = opt_182;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_184 = 0; index_184 < a_177.length; index_184 += 1) {
address tmp_185;
assembly {
tmp_185 := mload(add(a_177, mul(add(index_184, 1), 32)))
}

assert(_ownedTokensCount[tmp_185] == sum_ownersToken[tmp_185]);
}

memoryStart_0 = 0;
}

}

function isApprovedForAll (address owner, address operator) public view returns (bool) {
ProxyRegistry proxyRegistry = ProxyRegistry(_proxyRegistryAddress);
if (address(proxyRegistry.proxies(owner)) == operator) {
{
return true;
}

}

{
return super.isApprovedForAll(owner, operator);
}

}

function _setProxyRegistryAddress (address proxy) internal {
_proxyRegistryAddress = proxy;
}

function _mintBatch (address to, uint256[] memory tokenIds) internal {
address[] memory a_187;
assembly {
a_187 := add(sload(memoryStart_0_slot), 0)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastMint(to, tokenIds[i]);
}

{
uint256 opt_189 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_189);
sum_tokenCount -= opt_189;
}

}

{
address tmp_188 = to;
assembly {
let tmp := add(mload(a_187), 1)
mstore(a_187, tmp)
mstore(add(a_187, mul(tmp, 32)), tmp_188)
}

}

opt_189 = opt_189.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_189;
assert(sum_tokenCount >= opt_189);
}

}

_ownedTokensCount[to] = opt_189;
}

}

function uint2str (uint _i) private pure returns (string memory _uintAsString) {
if (_i == 0) {
{
return "0";
}

}

uint j = _i;
uint len;
while (j != 0) {
            len++;
            j /= 10;
        }
bytes memory bstr = new bytes(len);
uint k = len - 1;
while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
{
return string(bstr);
}

}

}
contract CryptoCardsPackToken is CryptoCardsERC721Batched, MinterRole, Ownable {
uint256 internal _totalMintedPacks;
mapping (uint256=>string) internal _packData;
constructor () CryptoCardsERC721Batched("Crypto-Cards Packs", "PACKS", "https://crypto-cards.io/pack-info/") public {
}

function packDataById (uint256 tokenId) public view returns (string memory) {
require(_exists(tokenId), "Invalid tokenId supplied");
{
return _packData[tokenId];
}

}

function totalMintedPacks () public view returns (uint256) {
{
return _totalMintedPacks;
}

}

function mintPack (address to, uint256 tokenId) onlyMinter public returns (uint256) {
uint256 entry_1 = 0;
uint256 tmp_196;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_196 := mload(0x40)
mstore(0x40, add(tmp_196, 640))
sstore(memoryStart_0_slot, tmp_196)
mstore(add(tmp_196, 0), 0)
}

}

address[] memory a_191;
assembly {
a_191 := add(sload(memoryStart_0_slot), 0)
}

_totalMintedPacks = _totalMintedPacks + 1;
_mint(to, tokenId);
_packData[tokenId] = "tokenId";
{
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_192 = 0; index_192 < a_191.length; index_192 += 1) {
address tmp_193;
assembly {
tmp_193 := mload(add(a_191, mul(add(index_192, 1), 32)))
}

assert(_ownedTokensCount[tmp_193] == sum_ownersToken[tmp_193]);
}

memoryStart_0 = 0;
}

return tokenId;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_194 = 0; index_194 < a_191.length; index_194 += 1) {
address tmp_195;
assembly {
tmp_195 := mload(add(a_191, mul(add(index_194, 1), 32)))
}

assert(_ownedTokensCount[tmp_195] == sum_ownersToken[tmp_195]);
}

memoryStart_0 = 0;
}

}

function burnPack (address from, uint256 tokenId) onlyMinter public {
_burn(from, tokenId);
_packData[tokenId] = "";
}

function tokenTransfer (address from, address to, uint256 tokenId) onlyMinter public {
uint256 entry_1 = 0;
uint256 tmp_200;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_200 := mload(0x40)
mstore(0x40, add(tmp_200, 640))
sstore(memoryStart_0_slot, tmp_200)
mstore(add(tmp_200, 0), 0)
}

}

address[] memory a_197;
assembly {
a_197 := add(sload(memoryStart_0_slot), 0)
}

_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_198 = 0; index_198 < a_197.length; index_198 += 1) {
address tmp_199;
assembly {
tmp_199 := mload(add(a_197, mul(add(index_198, 1), 32)))
}

assert(_ownedTokensCount[tmp_199] == sum_ownersToken[tmp_199]);
}

memoryStart_0 = 0;
}

}

function setProxyRegistryAddress (address proxy) onlyOwner public {
_setProxyRegistryAddress(proxy);
}

}
