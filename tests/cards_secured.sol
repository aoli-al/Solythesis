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
uint256 a_addr_168;
using SafeMath for uint256;
using Address for address;
bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
mapping (uint256=>address) public _tokenOwner;
mapping (uint256=>address) private _tokenApprovals;
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
uint256 tmp_172;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_172 := mload(0x40)
mstore(0x40, add(tmp_172, 640))
sstore(memoryStart_0_slot, tmp_172)
mstore(add(tmp_172, 0), 0)
}

}

address[] memory a_169;
assembly {
a_169 := add(sload(memoryStart_0_slot), 0)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_170 = 0; index_170 < a_169.length; index_170 += 1) {
address tmp_171;
assembly {
tmp_171 := mload(add(a_169, mul(add(index_170, 1), 32)))
}

assert(_ownedTokensCount[tmp_171] == sum_ownersToken[tmp_171]);
}

memoryStart_0 = 0;
}

}

function fastTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_176;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_176 := mload(0x40)
mstore(0x40, add(tmp_176, 640))
sstore(memoryStart_0_slot, tmp_176)
mstore(add(tmp_176, 0), 0)
}

}

address[] memory a_173;
assembly {
a_173 := add(sload(memoryStart_0_slot), 0)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_fastTransferFrom(from, to, tokenId);
if (entry_1 == 1) {
for (uint256 index_174 = 0; index_174 < a_173.length; index_174 += 1) {
address tmp_175;
assembly {
tmp_175 := mload(add(a_173, mul(add(index_174, 1), 32)))
}

assert(_ownedTokensCount[tmp_175] == sum_ownersToken[tmp_175]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_180;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_180 := mload(0x40)
mstore(0x40, add(tmp_180, 640))
sstore(memoryStart_0_slot, tmp_180)
mstore(add(tmp_180, 0), 0)
}

}

address[] memory a_177;
assembly {
a_177 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_178 = 0; index_178 < a_177.length; index_178 += 1) {
address tmp_179;
assembly {
tmp_179 := mload(add(a_177, mul(add(index_178, 1), 32)))
}

assert(_ownedTokensCount[tmp_179] == sum_ownersToken[tmp_179]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
uint256 entry_1 = 0;
uint256 tmp_184;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_184 := mload(0x40)
mstore(0x40, add(tmp_184, 640))
sstore(memoryStart_0_slot, tmp_184)
mstore(add(tmp_184, 0), 0)
}

}

address[] memory a_181;
assembly {
a_181 := add(sload(memoryStart_0_slot), 0)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_182 = 0; index_182 < a_181.length; index_182 += 1) {
address tmp_183;
assembly {
tmp_183 := mload(add(a_181, mul(add(index_182, 1), 32)))
}

assert(_ownedTokensCount[tmp_183] == sum_ownersToken[tmp_183]);
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
address[] memory a_186;
assembly {
a_186 := add(sload(memoryStart_0_slot), 0)
}

require(to != address(0));
require(! _exists(tokenId));
{
address opt_185 = _tokenOwner[tokenId];
{
if (opt_185 == opt_185 && opt_185 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_185] >= 1);
{
address tmp_187 = opt_185;
assembly {
let tmp := add(mload(a_186), 1)
mstore(a_186, tmp)
mstore(add(a_186, mul(tmp, 32)), tmp_187)
}

}
sum_ownersToken[opt_185] -= 1;
}

}

opt_185 = to;
{
if (opt_185 == opt_185 && opt_185 != 0x0000000000000000000000000000000000000000) {
{
address tmp_188 = opt_185;
assembly {
let tmp := add(mload(a_186), 1)
mstore(a_186, tmp)
mstore(add(a_186, mul(tmp, 32)), tmp_188)
}

}
sum_ownersToken[opt_185] += 1;
assert(sum_ownersToken[opt_185] >= 1);
}

}

_tokenOwner[tokenId] = opt_185;
}

{
uint256 opt_190 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_190);
sum_tokenCount -= opt_190;
}

}

{
address tmp_189 = to;
assembly {
let tmp := add(mload(a_186), 1)
mstore(a_186, tmp)
mstore(add(a_186, mul(tmp, 32)), tmp_189)
}

}

opt_190 = opt_190.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_190;
assert(sum_tokenCount >= opt_190);
}

}

_ownedTokensCount[to] = opt_190;
}

emit Transfer(address(0), to, tokenId);
}

function _fastMint (address to, uint256 tokenId) internal {
address[] memory a_193;
assembly {
a_193 := add(sload(memoryStart_0_slot), 0)
}

if (_tokenOwner[tokenId] == address(0)) {
{
address opt_192 = _tokenOwner[tokenId];
{
if (opt_192 == opt_192 && opt_192 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_192] >= 1);
{
address tmp_194 = opt_192;
assembly {
let tmp := add(mload(a_193), 1)
mstore(a_193, tmp)
mstore(add(a_193, mul(tmp, 32)), tmp_194)
}

}
sum_ownersToken[opt_192] -= 1;
}

}

opt_192 = to;
{
if (opt_192 == opt_192 && opt_192 != 0x0000000000000000000000000000000000000000) {
{
address tmp_195 = opt_192;
assembly {
let tmp := add(mload(a_193), 1)
mstore(a_193, tmp)
mstore(add(a_193, mul(tmp, 32)), tmp_195)
}

}
sum_ownersToken[opt_192] += 1;
assert(sum_ownersToken[opt_192] >= 1);
}

}

_tokenOwner[tokenId] = opt_192;
}

}

emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_196;
assembly {
a_196 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_198 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_198);
sum_tokenCount -= opt_198;
}

}

{
address tmp_197 = owner;
assembly {
let tmp := add(mload(a_196), 1)
mstore(a_196, tmp)
mstore(add(a_196, mul(tmp, 32)), tmp_197)
}

}

opt_198 = opt_198.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_198;
assert(sum_tokenCount >= opt_198);
}

}

_ownedTokensCount[owner] = opt_198;
}

{
address opt_200 = _tokenOwner[tokenId];
{
if (opt_200 == opt_200 && opt_200 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_200] >= 1);
{
address tmp_201 = opt_200;
assembly {
let tmp := add(mload(a_196), 1)
mstore(a_196, tmp)
mstore(add(a_196, mul(tmp, 32)), tmp_201)
}

}
sum_ownersToken[opt_200] -= 1;
}

}

opt_200 = address(0);
{
if (opt_200 == opt_200 && opt_200 != 0x0000000000000000000000000000000000000000) {
{
address tmp_202 = opt_200;
assembly {
let tmp := add(mload(a_196), 1)
mstore(a_196, tmp)
mstore(add(a_196, mul(tmp, 32)), tmp_202)
}

}
sum_ownersToken[opt_200] += 1;
assert(sum_ownersToken[opt_200] >= 1);
}

}

_tokenOwner[tokenId] = opt_200;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_203;
assembly {
a_203 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_205 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_205);
sum_tokenCount -= opt_205;
}

}

{
address tmp_204 = from;
assembly {
let tmp := add(mload(a_203), 1)
mstore(a_203, tmp)
mstore(add(a_203, mul(tmp, 32)), tmp_204)
}

}

opt_205 = opt_205.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_205;
assert(sum_tokenCount >= opt_205);
}

}

_ownedTokensCount[from] = opt_205;
}

{
uint256 opt_208 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_208);
sum_tokenCount -= opt_208;
}

}

{
address tmp_207 = to;
assembly {
let tmp := add(mload(a_203), 1)
mstore(a_203, tmp)
mstore(add(a_203, mul(tmp, 32)), tmp_207)
}

}

opt_208 = opt_208.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_208;
assert(sum_tokenCount >= opt_208);
}

}

_ownedTokensCount[to] = opt_208;
}

{
address opt_210 = _tokenOwner[tokenId];
{
if (opt_210 == opt_210 && opt_210 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_210] >= 1);
{
address tmp_211 = opt_210;
assembly {
let tmp := add(mload(a_203), 1)
mstore(a_203, tmp)
mstore(add(a_203, mul(tmp, 32)), tmp_211)
}

}
sum_ownersToken[opt_210] -= 1;
}

}

opt_210 = to;
{
if (opt_210 == opt_210 && opt_210 != 0x0000000000000000000000000000000000000000) {
{
address tmp_212 = opt_210;
assembly {
let tmp := add(mload(a_203), 1)
mstore(a_203, tmp)
mstore(add(a_203, mul(tmp, 32)), tmp_212)
}

}
sum_ownersToken[opt_210] += 1;
assert(sum_ownersToken[opt_210] >= 1);
}

}

_tokenOwner[tokenId] = opt_210;
}

emit Transfer(from, to, tokenId);
}

function _fastTransferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_214;
assembly {
a_214 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == from);
_clearApproval(tokenId);
{
address opt_213 = _tokenOwner[tokenId];
{
if (opt_213 == opt_213 && opt_213 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_213] >= 1);
{
address tmp_215 = opt_213;
assembly {
let tmp := add(mload(a_214), 1)
mstore(a_214, tmp)
mstore(add(a_214, mul(tmp, 32)), tmp_215)
}

}
sum_ownersToken[opt_213] -= 1;
}

}

opt_213 = to;
{
if (opt_213 == opt_213 && opt_213 != 0x0000000000000000000000000000000000000000) {
{
address tmp_216 = opt_213;
assembly {
let tmp := add(mload(a_214), 1)
mstore(a_214, tmp)
mstore(add(a_214, mul(tmp, 32)), tmp_216)
}

}
sum_ownersToken[opt_213] += 1;
assert(sum_ownersToken[opt_213] >= 1);
}

}

_tokenOwner[tokenId] = opt_213;
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
mapping (address=>uint256[]) private _ownedTokens;
mapping (uint256=>uint256) private _ownedTokensIndex;
mapping (uint256=>uint256) private _allTokensIndex;
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
uint256 tmp_226;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_226 := mload(0x40)
mstore(0x40, add(tmp_226, 640))
sstore(memoryStart_0_slot, tmp_226)
mstore(add(tmp_226, 0), 0)
}

}

address[] memory a_217;
assembly {
a_217 := add(sload(memoryStart_0_slot), 0)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastTransferFrom(from, to, tokenIds[i]);
}

{
uint256 opt_219 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_219);
sum_tokenCount -= opt_219;
}

}

{
address tmp_218 = from;
assembly {
let tmp := add(mload(a_217), 1)
mstore(a_217, tmp)
mstore(add(a_217, mul(tmp, 32)), tmp_218)
}

}

opt_219 = opt_219.sub(tokenIds.length);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_219;
assert(sum_tokenCount >= opt_219);
}

}

_ownedTokensCount[from] = opt_219;
}

{
uint256 opt_222 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_222);
sum_tokenCount -= opt_222;
}

}

{
address tmp_221 = to;
assembly {
let tmp := add(mload(a_217), 1)
mstore(a_217, tmp)
mstore(add(a_217, mul(tmp, 32)), tmp_221)
}

}

opt_222 = opt_222.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_222;
assert(sum_tokenCount >= opt_222);
}

}

_ownedTokensCount[to] = opt_222;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_224 = 0; index_224 < a_217.length; index_224 += 1) {
address tmp_225;
assembly {
tmp_225 := mload(add(a_217, mul(add(index_224, 1), 32)))
}

assert(_ownedTokensCount[tmp_225] == sum_ownersToken[tmp_225]);
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
address[] memory a_227;
assembly {
a_227 := add(sload(memoryStart_0_slot), 0)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastMint(to, tokenIds[i]);
}

{
uint256 opt_229 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_229);
sum_tokenCount -= opt_229;
}

}

{
address tmp_228 = to;
assembly {
let tmp := add(mload(a_227), 1)
mstore(a_227, tmp)
mstore(add(a_227, mul(tmp, 32)), tmp_228)
}

}

opt_229 = opt_229.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_229;
assert(sum_tokenCount >= opt_229);
}

}

_ownedTokensCount[to] = opt_229;
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
contract CryptoCardsCardToken is CryptoCardsERC721Batched, MinterRole, Ownable {
uint internal constant ETH_DIV = 1000000;
uint internal constant ETH_MAX = 4194304;
mapping (uint=>bool) internal _printedTokens;
uint internal _wrappedEtherDemand;
event CardsCombined(address indexed owner, uint tokenA, uint tokenB, uint newTokenId, bytes16 uuid);
event CardPrinted(address indexed owner, uint tokenId, uint wrappedEther, bytes16 uuid);
event CardMelted(address indexed owner, uint tokenId, uint wrappedEther, uint wrappedGum, bytes16 uuid);
event WrappedEtherDeposit(uint amount);
constructor () CryptoCardsERC721Batched("Crypto-Cards - Cards", "CARDS", "https://crypto-cards.io/card-info/") public {
}

function getYear (uint tokenId) public pure returns (uint64) {
{
return _readBits(tokenId, 0, 4);
}

}

function getGeneration (uint tokenId) public pure returns (uint64) {
{
return _readBits(tokenId, 4, 6);
}

}

function getRank (uint tokenId) public pure returns (uint64) {
{
return _readBits(tokenId, 10, 10);
}

}

function getIssue (uint tokenId) public pure returns (uint64) {
{
return _readBits(tokenId, 20, 12);
}

}

function getTypeIndicators (uint tokenId) public pure returns (uint64, uint64, uint64) {
uint64 y = getYear(tokenId);
uint64 g = getGeneration(tokenId);
uint64 r = getRank(tokenId);
{
return (y, g, r);
}

}

function getWrappedGum (uint tokenId) public pure returns (uint64) {
{
return _readBits(tokenId, 32, 10);
}

}

function getWrappedEther (uint tokenId) public pure returns (uint) {
{
return _convertToEther(_getWrappedEtherRaw(tokenId));
}

}

function isTokenPrinted (uint tokenId) public view returns (bool) {
{
return _printedTokens[tokenId];
}

}

function canCombine (uint tokenA, uint tokenB) public view returns (bool) {
if (isTokenPrinted(tokenA) || isTokenPrinted(tokenB)) {
{
return false;
}

}

if (getGeneration(tokenA) < 1) {
{
return false;
}

}

uint32 typeA = uint32(_readBits(tokenA, 0, 20));
uint32 typeB = uint32(_readBits(tokenB, 0, 20));
{
return (typeA == typeB);
}

}

function mint (address to, uint tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_234;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_234 := mload(0x40)
mstore(0x40, add(tmp_234, 640))
sstore(memoryStart_0_slot, tmp_234)
mstore(add(tmp_234, 0), 0)
}

}

address[] memory a_231;
assembly {
a_231 := add(sload(memoryStart_0_slot), 0)
}

_mint(to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_232 = 0; index_232 < a_231.length; index_232 += 1) {
address tmp_233;
assembly {
tmp_233 := mload(add(a_231, mul(add(index_232, 1), 32)))
}

assert(_ownedTokensCount[tmp_233] == sum_ownersToken[tmp_233]);
}

memoryStart_0 = 0;
}

}

function mintCardsFromPack (address to, uint[] memory tokenIds) onlyMinter public {
uint256 entry_1 = 0;
uint256 tmp_238;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_238 := mload(0x40)
mstore(0x40, add(tmp_238, 640))
sstore(memoryStart_0_slot, tmp_238)
mstore(add(tmp_238, 0), 0)
}

}

address[] memory a_235;
assembly {
a_235 := add(sload(memoryStart_0_slot), 0)
}

_mintBatch(to, tokenIds);
uint totalWrappedEth;
for (uint i = 0; i < tokenIds.length; i ++) {
totalWrappedEth = totalWrappedEth + getWrappedEther(tokenIds[i]);
}

if (totalWrappedEth > 0) {
_wrappedEtherDemand = _wrappedEtherDemand + totalWrappedEth;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_236 = 0; index_236 < a_235.length; index_236 += 1) {
address tmp_237;
assembly {
tmp_237 := mload(add(a_235, mul(add(index_236, 1), 32)))
}

assert(_ownedTokensCount[tmp_237] == sum_ownersToken[tmp_237]);
}

memoryStart_0 = 0;
}

}

function migrateCards (address to, uint[] memory tokenIds) onlyMinter public {
uint256 entry_1 = 0;
uint256 tmp_242;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_242 := mload(0x40)
mstore(0x40, add(tmp_242, 640))
sstore(memoryStart_0_slot, tmp_242)
mstore(add(tmp_242, 0), 0)
}

}

address[] memory a_239;
assembly {
a_239 := add(sload(memoryStart_0_slot), 0)
}

_mintBatch(to, tokenIds);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_240 = 0; index_240 < a_239.length; index_240 += 1) {
address tmp_241;
assembly {
tmp_241 := mload(add(a_239, mul(add(index_240, 1), 32)))
}

assert(_ownedTokensCount[tmp_241] == sum_ownersToken[tmp_241]);
}

memoryStart_0 = 0;
}

}

function printFor (address owner, uint tokenId, bytes16 uuid) onlyMinter public {
require(owner == ownerOf(tokenId), "User does not own this Card");
_printToken(owner, tokenId, uuid);
}

function combineFor (address owner, uint tokenA, uint tokenB, uint newIssue, bytes16 uuid) onlyMinter public returns (uint) {
uint256 entry_1 = 0;
uint256 tmp_248;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_248 := mload(0x40)
mstore(0x40, add(tmp_248, 640))
sstore(memoryStart_0_slot, tmp_248)
mstore(add(tmp_248, 0), 0)
}

}

address[] memory a_243;
assembly {
a_243 := add(sload(memoryStart_0_slot), 0)
}

require(owner == ownerOf(tokenA), "User does not own this Card");
{
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_244 = 0; index_244 < a_243.length; index_244 += 1) {
address tmp_245;
assembly {
tmp_245 := mload(add(a_243, mul(add(index_244, 1), 32)))
}

assert(_ownedTokensCount[tmp_245] == sum_ownersToken[tmp_245]);
}

memoryStart_0 = 0;
}

return _combineTokens(tokenA, tokenB, newIssue, uuid);
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_246 = 0; index_246 < a_243.length; index_246 += 1) {
address tmp_247;
assembly {
tmp_247 := mload(add(a_243, mul(add(index_246, 1), 32)))
}

assert(_ownedTokensCount[tmp_247] == sum_ownersToken[tmp_247]);
}

memoryStart_0 = 0;
}

}

function meltFor (address owner, uint tokenId, bytes16 uuid) onlyMinter public returns (uint) {
require(owner == ownerOf(tokenId), "User does not own this Card");
{
return _meltToken(tokenId, uuid);
}

}

function tokenTransfer (address from, address to, uint tokenId) onlyMinter public {
uint256 entry_1 = 0;
uint256 tmp_252;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_252 := mload(0x40)
mstore(0x40, add(tmp_252, 640))
sstore(memoryStart_0_slot, tmp_252)
mstore(add(tmp_252, 0), 0)
}

}

address[] memory a_249;
assembly {
a_249 := add(sload(memoryStart_0_slot), 0)
}

_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_250 = 0; index_250 < a_249.length; index_250 += 1) {
address tmp_251;
assembly {
tmp_251 := mload(add(a_249, mul(add(index_250, 1), 32)))
}

assert(_ownedTokensCount[tmp_251] == sum_ownersToken[tmp_251]);
}

memoryStart_0 = 0;
}

}

function setBaseTokenURI (string memory uri) onlyOwner public {
_baseTokenURI = uri;
}

function setProxyRegistryAddress (address proxy) onlyOwner public {
_setProxyRegistryAddress(proxy);
}

function depositWrappedEther (uint amount) onlyOwner public payable {
require(amount == msg.value, "Specified amount does not match actual amount received");
emit WrappedEtherDeposit(amount);
}

function getWrappedEtherDemand () onlyOwner public view returns (uint) {
{
return _wrappedEtherDemand;
}

}

function _combineTokens (uint tokenA, uint tokenB, uint newIssue, bytes16 uuid) private returns (uint) {
address owner = ownerOf(tokenA);
require(owner == ownerOf(tokenB), "User does not own both Cards");
require(canCombine(tokenA, tokenB), "Cards are not compatible");
uint newTokenId = _generateCombinedToken(tokenA, tokenB, newIssue);
_mint(owner, newTokenId);
_burn(owner, tokenA);
_burn(owner, tokenB);
emit CardsCombined(owner, tokenA, tokenB, newTokenId, uuid);
{
return newTokenId;
}

}

function _printToken (address owner, uint tokenId, bytes16 uuid) private {
require(! isTokenPrinted(tokenId), "Card has already been printed");
uint wrappedEth = getWrappedEther(tokenId);
_printedTokens[tokenId] = true;
_payoutEther(owner, wrappedEth);
emit CardPrinted(owner, tokenId, wrappedEth, uuid);
}

function _meltToken (uint tokenId, bytes16 uuid) private returns (uint) {
require(! isTokenPrinted(tokenId), "Cannot melt printed Cards");
address owner = ownerOf(tokenId);
uint wrappedGum = getWrappedGum(tokenId);
uint wrappedEth = getWrappedEther(tokenId);
_burn(owner, tokenId);
_payoutEther(owner, wrappedEth);
emit CardMelted(owner, tokenId, wrappedEth, wrappedGum, uuid);
{
return wrappedGum;
}

}

function _payoutEther (address owner, uint256 ethAmount) private returns (uint) {
address ownerWallet = address(uint160(owner));
require(ethAmount <= address(this).balance, "Not enough funds to pay out wrapped ether, please try again later.");
_wrappedEtherDemand = _wrappedEtherDemand - ethAmount;
{
return ethAmount;
}

}

function _generateCombinedToken (uint tokenA, uint tokenB, uint newIssue) private returns (uint) {
uint64 y = getYear(tokenA);
uint64 g = getGeneration(tokenA) - 1;
uint64 r = getRank(tokenA);
uint64 eth = _getCombinedEtherRaw(tokenA, tokenB);
uint64[6] memory bits = [
            y, g, r, uint64(newIssue),
            getWrappedGum(tokenA) + getWrappedGum(tokenB),
            eth
        ];
{
return _generateTokenId(bits);
}

}

function _getCombinedEtherRaw (uint tokenA, uint tokenB) private returns (uint64) {
uint64 eA = _getWrappedEtherRaw(tokenA);
uint64 eB = _getWrappedEtherRaw(tokenB);
uint combined = uint(eA + eB);
if (combined > ETH_MAX) {
uint overage = _convertToEther(combined - ETH_MAX);
_payoutEther(ownerOf(tokenA), overage);
combined = ETH_MAX;
}

{
return uint64(combined);
}

}

function _getWrappedEtherRaw (uint tokenId) private pure returns (uint64) {
{
return _readBits(tokenId, 42, 22);
}

}

function _convertToEther (uint rawValue) private pure returns (uint) {
{
return rawValue * (1 ether) / ETH_DIV;
}

}

function _generateTokenId (uint64[6] memory bits) private pure returns (uint) {
{
return uint(bits[0] | (bits[1] << 4) | (bits[2] << 10) | (bits[3] << 20) | (bits[4] << 32) | (bits[5] << 42));
}

}

function _readBits (uint num, uint from, uint len) private pure returns (uint64) {
uint mask = ((1 << len) - 1) << from;
{
return uint64((num & mask) >> from);
}

}

function transfer (address _to, uint256 _tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_256;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_256 := mload(0x40)
mstore(0x40, add(tmp_256, 640))
sstore(memoryStart_0_slot, tmp_256)
mstore(add(tmp_256, 0), 0)
}

}

address[] memory a_253;
assembly {
a_253 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(msg.sender, _to, _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_254 = 0; index_254 < a_253.length; index_254 += 1) {
address tmp_255;
assembly {
tmp_255 := mload(add(a_253, mul(add(index_254, 1), 32)))
}

assert(_ownedTokensCount[tmp_255] == sum_ownersToken[tmp_255]);
}

memoryStart_0 = 0;
}

}

}
