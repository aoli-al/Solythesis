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
mapping (address=>bool) a_checker_3;
address[] a_store_4;
uint256 sum_tokenCount;
mapping (uint256=>bool) a_checker_7;
uint256[] a_store_8;
mapping (address=>bool) b_checker_5;
address[] b_store_6;
mapping (address=>uint256) sum_ownersToken;
mapping (address=>bool) a_checker_9;
address[] a_store_10;
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
uint256 tmp_9;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_9 := mload(0x40)
mstore(0x40, add(tmp_9, 0))
sstore(memoryStart_0_slot, tmp_9)
}

}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_3 = 0; index_3 < a_store_4.length; index_3 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_3]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_3]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_4 = 0; index_4 < b_store_6.length; index_4 += 1) {
sum_ownersToken[b_store_6[index_4]] = 0;
}

for (uint256 index_5 = 0; index_5 < a_store_8.length; index_5 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_5]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_5]]] >= 1);
}

}

for (uint256 index_8 = 0; index_8 < a_store_10.length; index_8 += 1) {
assert(_ownedTokensCount[a_store_10[index_8]] == sum_ownersToken[a_store_10[index_8]]);
}

memoryStart_0 = 0;
}

}

function fastTransferFrom (address from, address to, uint256 tokenId) public {
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

require(_isApprovedOrOwner(msg.sender, tokenId));
_fastTransferFrom(from, to, tokenId);
if (entry_1 == 1) {
{
for (uint256 index_10 = 0; index_10 < b_store_6.length; index_10 += 1) {
sum_ownersToken[b_store_6[index_10]] = 0;
}

for (uint256 index_11 = 0; index_11 < a_store_8.length; index_11 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_11]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_11]]] >= 1);
}

}

for (uint256 index_14 = 0; index_14 < a_store_10.length; index_14 += 1) {
assert(_ownedTokensCount[a_store_10[index_14]] == sum_ownersToken[a_store_10[index_14]]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_22;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_22 := mload(0x40)
mstore(0x40, add(tmp_22, 0))
sstore(memoryStart_0_slot, tmp_22)
}

}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_16 = 0; index_16 < a_store_4.length; index_16 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_16]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_16]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_17 = 0; index_17 < b_store_6.length; index_17 += 1) {
sum_ownersToken[b_store_6[index_17]] = 0;
}

for (uint256 index_18 = 0; index_18 < a_store_8.length; index_18 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_18]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_18]]] >= 1);
}

}

for (uint256 index_21 = 0; index_21 < a_store_10.length; index_21 += 1) {
assert(_ownedTokensCount[a_store_10[index_21]] == sum_ownersToken[a_store_10[index_21]]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
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

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_23 = 0; index_23 < a_store_4.length; index_23 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_23]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_23]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_24 = 0; index_24 < b_store_6.length; index_24 += 1) {
sum_ownersToken[b_store_6[index_24]] = 0;
}

for (uint256 index_25 = 0; index_25 < a_store_8.length; index_25 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_25]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_25]]] >= 1);
}

}

for (uint256 index_28 = 0; index_28 < a_store_10.length; index_28 += 1) {
assert(_ownedTokensCount[a_store_10[index_28]] == sum_ownersToken[a_store_10[index_28]]);
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
require(to != address(0));
require(! _exists(tokenId));
_tokenOwner[tokenId] = to;if (! a_checker_7[tokenId]) {
a_store_8.push(tokenId);
a_checker_7[tokenId] = true;
}
if (! b_checker_5[_tokenOwner[tokenId]]) {
b_store_6.push(_tokenOwner[tokenId]);
b_checker_5[_tokenOwner[tokenId]] = true;
}

_ownedTokensCount[to] = _ownedTokensCount[to].add(1);if (! a_checker_3[to]) {
a_store_4.push(to);
a_checker_3[to] = true;
}
if (! a_checker_9[to]) {
a_store_10.push(to);
a_checker_9[to] = true;
}

emit Transfer(address(0), to, tokenId);
}

function _fastMint (address to, uint256 tokenId) internal {
if (_tokenOwner[tokenId] == address(0)) {
_tokenOwner[tokenId] = to;if (! a_checker_7[tokenId]) {
a_store_8.push(tokenId);
a_checker_7[tokenId] = true;
}
if (! b_checker_5[_tokenOwner[tokenId]]) {
b_store_6.push(_tokenOwner[tokenId]);
b_checker_5[_tokenOwner[tokenId]] = true;
}

}

emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
_ownedTokensCount[owner] = _ownedTokensCount[owner].sub(1);if (! a_checker_3[owner]) {
a_store_4.push(owner);
a_checker_3[owner] = true;
}
if (! a_checker_9[owner]) {
a_store_10.push(owner);
a_checker_9[owner] = true;
}

_tokenOwner[tokenId] = address(0);if (! a_checker_7[tokenId]) {
a_store_8.push(tokenId);
a_checker_7[tokenId] = true;
}
if (! b_checker_5[_tokenOwner[tokenId]]) {
b_store_6.push(_tokenOwner[tokenId]);
b_checker_5[_tokenOwner[tokenId]] = true;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
_ownedTokensCount[from] = _ownedTokensCount[from].sub(1);if (! a_checker_3[from]) {
a_store_4.push(from);
a_checker_3[from] = true;
}
if (! a_checker_9[from]) {
a_store_10.push(from);
a_checker_9[from] = true;
}

_ownedTokensCount[to] = _ownedTokensCount[to].add(1);if (! a_checker_3[to]) {
a_store_4.push(to);
a_checker_3[to] = true;
}
if (! a_checker_9[to]) {
a_store_10.push(to);
a_checker_9[to] = true;
}

_tokenOwner[tokenId] = to;if (! a_checker_7[tokenId]) {
a_store_8.push(tokenId);
a_checker_7[tokenId] = true;
}
if (! b_checker_5[_tokenOwner[tokenId]]) {
b_store_6.push(_tokenOwner[tokenId]);
b_checker_5[_tokenOwner[tokenId]] = true;
}

emit Transfer(from, to, tokenId);
}

function _fastTransferFrom (address from, address to, uint256 tokenId) internal {
require(ownerOf(tokenId) == from);
_clearApproval(tokenId);
_tokenOwner[tokenId] = to;if (! a_checker_7[tokenId]) {
a_store_8.push(tokenId);
a_checker_7[tokenId] = true;
}
if (! b_checker_5[_tokenOwner[tokenId]]) {
b_store_6.push(_tokenOwner[tokenId]);
b_checker_5[_tokenOwner[tokenId]] = true;
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
uint256 tmp_36;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_36 := mload(0x40)
mstore(0x40, add(tmp_36, 0))
sstore(memoryStart_0_slot, tmp_36)
}

}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastTransferFrom(from, to, tokenIds[i]);
}

_ownedTokensCount[from] = _ownedTokensCount[from].sub(tokenIds.length);if (! a_checker_3[from]) {
a_store_4.push(from);
a_checker_3[from] = true;
}
if (! a_checker_9[from]) {
a_store_10.push(from);
a_checker_9[from] = true;
}

_ownedTokensCount[to] = _ownedTokensCount[to].add(tokenIds.length);if (! a_checker_3[to]) {
a_store_4.push(to);
a_checker_3[to] = true;
}
if (! a_checker_9[to]) {
a_store_10.push(to);
a_checker_9[to] = true;
}

if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_30 = 0; index_30 < a_store_4.length; index_30 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_30]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_30]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_31 = 0; index_31 < b_store_6.length; index_31 += 1) {
sum_ownersToken[b_store_6[index_31]] = 0;
}

for (uint256 index_32 = 0; index_32 < a_store_8.length; index_32 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_32]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_32]]] >= 1);
}

}

for (uint256 index_35 = 0; index_35 < a_store_10.length; index_35 += 1) {
assert(_ownedTokensCount[a_store_10[index_35]] == sum_ownersToken[a_store_10[index_35]]);
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
require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastMint(to, tokenIds[i]);
}

_ownedTokensCount[to] = _ownedTokensCount[to].add(tokenIds.length);if (! a_checker_3[to]) {
a_store_4.push(to);
a_checker_3[to] = true;
}
if (! a_checker_9[to]) {
a_store_10.push(to);
a_checker_9[to] = true;
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
uint256 tmp_43;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_43 := mload(0x40)
mstore(0x40, add(tmp_43, 0))
sstore(memoryStart_0_slot, tmp_43)
}

}

_mint(to, tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_37 = 0; index_37 < a_store_4.length; index_37 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_37]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_37]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_38 = 0; index_38 < b_store_6.length; index_38 += 1) {
sum_ownersToken[b_store_6[index_38]] = 0;
}

for (uint256 index_39 = 0; index_39 < a_store_8.length; index_39 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_39]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_39]]] >= 1);
}

}

for (uint256 index_42 = 0; index_42 < a_store_10.length; index_42 += 1) {
assert(_ownedTokensCount[a_store_10[index_42]] == sum_ownersToken[a_store_10[index_42]]);
}

memoryStart_0 = 0;
}

}

function mintCardsFromPack (address to, uint[] memory tokenIds) onlyMinter public {
uint256 entry_1 = 0;
uint256 tmp_48;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_48 := mload(0x40)
mstore(0x40, add(tmp_48, 0))
sstore(memoryStart_0_slot, tmp_48)
}

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
{
{
sum_tokenCount = 0;
}

for (uint256 index_44 = 0; index_44 < a_store_4.length; index_44 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_44]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_44]]);
}

}

assert(sum_tokenCount == _allTokens.length);
for (uint256 index_47 = 0; index_47 < a_store_10.length; index_47 += 1) {
assert(_ownedTokensCount[a_store_10[index_47]] == sum_ownersToken[a_store_10[index_47]]);
}

memoryStart_0 = 0;
}

}

function migrateCards (address to, uint[] memory tokenIds) onlyMinter public {
uint256 entry_1 = 0;
uint256 tmp_53;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_53 := mload(0x40)
mstore(0x40, add(tmp_53, 0))
sstore(memoryStart_0_slot, tmp_53)
}

}

_mintBatch(to, tokenIds);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_49 = 0; index_49 < a_store_4.length; index_49 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_49]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_49]]);
}

}

assert(sum_tokenCount == _allTokens.length);
for (uint256 index_52 = 0; index_52 < a_store_10.length; index_52 += 1) {
assert(_ownedTokensCount[a_store_10[index_52]] == sum_ownersToken[a_store_10[index_52]]);
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
uint256 tmp_65;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_65 := mload(0x40)
mstore(0x40, add(tmp_65, 0))
sstore(memoryStart_0_slot, tmp_65)
}

}

require(owner == ownerOf(tokenA), "User does not own this Card");
{
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_54 = 0; index_54 < a_store_4.length; index_54 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_54]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_54]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_55 = 0; index_55 < b_store_6.length; index_55 += 1) {
sum_ownersToken[b_store_6[index_55]] = 0;
}

for (uint256 index_56 = 0; index_56 < a_store_8.length; index_56 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_56]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_56]]] >= 1);
}

}

for (uint256 index_59 = 0; index_59 < a_store_10.length; index_59 += 1) {
assert(_ownedTokensCount[a_store_10[index_59]] == sum_ownersToken[a_store_10[index_59]]);
}

memoryStart_0 = 0;
}

return _combineTokens(tokenA, tokenB, newIssue, uuid);
}

if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_60 = 0; index_60 < a_store_4.length; index_60 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_60]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_60]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_61 = 0; index_61 < b_store_6.length; index_61 += 1) {
sum_ownersToken[b_store_6[index_61]] = 0;
}

for (uint256 index_62 = 0; index_62 < a_store_8.length; index_62 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_62]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_62]]] >= 1);
}

}

for (uint256 index_64 = 0; index_64 < a_store_10.length; index_64 += 1) {
assert(_ownedTokensCount[a_store_10[index_64]] == sum_ownersToken[a_store_10[index_64]]);
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
uint256 tmp_72;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_72 := mload(0x40)
mstore(0x40, add(tmp_72, 0))
sstore(memoryStart_0_slot, tmp_72)
}

}

_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_66 = 0; index_66 < a_store_4.length; index_66 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_66]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_66]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_67 = 0; index_67 < b_store_6.length; index_67 += 1) {
sum_ownersToken[b_store_6[index_67]] = 0;
}

for (uint256 index_68 = 0; index_68 < a_store_8.length; index_68 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_68]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_68]]] >= 1);
}

}

for (uint256 index_71 = 0; index_71 < a_store_10.length; index_71 += 1) {
assert(_ownedTokensCount[a_store_10[index_71]] == sum_ownersToken[a_store_10[index_71]]);
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
uint256 tmp_79;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_79 := mload(0x40)
mstore(0x40, add(tmp_79, 0))
sstore(memoryStart_0_slot, tmp_79)
}

}

safeTransferFrom(msg.sender, _to, _tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_73 = 0; index_73 < a_store_4.length; index_73 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_73]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_73]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_74 = 0; index_74 < b_store_6.length; index_74 += 1) {
sum_ownersToken[b_store_6[index_74]] = 0;
}

for (uint256 index_75 = 0; index_75 < a_store_8.length; index_75 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_75]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_75]]] >= 1);
}

}

for (uint256 index_78 = 0; index_78 < a_store_10.length; index_78 += 1) {
assert(_ownedTokensCount[a_store_10[index_78]] == sum_ownersToken[a_store_10[index_78]]);
}

memoryStart_0 = 0;
}

}

}
