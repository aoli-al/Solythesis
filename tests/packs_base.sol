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
uint256 depth_0;
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
depth_0 += 1;
require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_2 = 0; index_2 < a_store_4.length; index_2 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_2]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_2]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_3 = 0; index_3 < b_store_6.length; index_3 += 1) {
sum_ownersToken[b_store_6[index_3]] = 0;
}

for (uint256 index_4 = 0; index_4 < a_store_8.length; index_4 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_4]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_4]]] >= 1);
}

}

for (uint256 index_7 = 0; index_7 < a_store_10.length; index_7 += 1) {
assert(_ownedTokensCount[a_store_10[index_7]] == sum_ownersToken[a_store_10[index_7]]);
}

}

}

function fastTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
require(_isApprovedOrOwner(msg.sender, tokenId));
_fastTransferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_8 = 0; index_8 < b_store_6.length; index_8 += 1) {
sum_ownersToken[b_store_6[index_8]] = 0;
}

for (uint256 index_9 = 0; index_9 < a_store_8.length; index_9 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_9]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_9]]] >= 1);
}

}

for (uint256 index_12 = 0; index_12 < a_store_10.length; index_12 += 1) {
assert(_ownedTokensCount[a_store_10[index_12]] == sum_ownersToken[a_store_10[index_12]]);
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_13 = 0; index_13 < a_store_4.length; index_13 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_13]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_13]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_14 = 0; index_14 < b_store_6.length; index_14 += 1) {
sum_ownersToken[b_store_6[index_14]] = 0;
}

for (uint256 index_15 = 0; index_15 < a_store_8.length; index_15 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_15]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_15]]] >= 1);
}

}

for (uint256 index_18 = 0; index_18 < a_store_10.length; index_18 += 1) {
assert(_ownedTokensCount[a_store_10[index_18]] == sum_ownersToken[a_store_10[index_18]]);
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
depth_0 += 1;
transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_19 = 0; index_19 < a_store_4.length; index_19 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_19]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_19]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_20 = 0; index_20 < b_store_6.length; index_20 += 1) {
sum_ownersToken[b_store_6[index_20]] = 0;
}

for (uint256 index_21 = 0; index_21 < a_store_8.length; index_21 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_21]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_21]]] >= 1);
}

}

for (uint256 index_24 = 0; index_24 < a_store_10.length; index_24 += 1) {
assert(_ownedTokensCount[a_store_10[index_24]] == sum_ownersToken[a_store_10[index_24]]);
}

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
depth_0 += 1;
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

depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_25 = 0; index_25 < a_store_4.length; index_25 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_25]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_25]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_26 = 0; index_26 < b_store_6.length; index_26 += 1) {
sum_ownersToken[b_store_6[index_26]] = 0;
}

for (uint256 index_27 = 0; index_27 < a_store_8.length; index_27 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_27]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_27]]] >= 1);
}

}

for (uint256 index_30 = 0; index_30 < a_store_10.length; index_30 += 1) {
assert(_ownedTokensCount[a_store_10[index_30]] == sum_ownersToken[a_store_10[index_30]]);
}

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
depth_0 += 1;
_totalMintedPacks = _totalMintedPacks + 1;
_mint(to, tokenId);
_packData[tokenId] = "tokenId";
{
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_31 = 0; index_31 < a_store_4.length; index_31 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_31]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_31]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_32 = 0; index_32 < b_store_6.length; index_32 += 1) {
sum_ownersToken[b_store_6[index_32]] = 0;
}

for (uint256 index_33 = 0; index_33 < a_store_8.length; index_33 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_33]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_33]]] >= 1);
}

}

for (uint256 index_36 = 0; index_36 < a_store_10.length; index_36 += 1) {
assert(_ownedTokensCount[a_store_10[index_36]] == sum_ownersToken[a_store_10[index_36]]);
}

}

return tokenId;
}

depth_0 -= 1;
if (depth_0 == 0) {
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

for (uint256 index_41 = 0; index_41 < a_store_10.length; index_41 += 1) {
assert(_ownedTokensCount[a_store_10[index_41]] == sum_ownersToken[a_store_10[index_41]]);
}

}

}

function burnPack (address from, uint256 tokenId) onlyMinter public {
_burn(from, tokenId);
_packData[tokenId] = "";
}

function tokenTransfer (address from, address to, uint256 tokenId) onlyMinter public {
depth_0 += 1;
_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_42 = 0; index_42 < a_store_4.length; index_42 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_42]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_42]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_43 = 0; index_43 < b_store_6.length; index_43 += 1) {
sum_ownersToken[b_store_6[index_43]] = 0;
}

for (uint256 index_44 = 0; index_44 < a_store_8.length; index_44 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_44]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_44]]] >= 1);
}

}

for (uint256 index_47 = 0; index_47 < a_store_10.length; index_47 += 1) {
assert(_ownedTokensCount[a_store_10[index_47]] == sum_ownersToken[a_store_10[index_47]]);
}

}

}

function setProxyRegistryAddress (address proxy) onlyOwner public {
_setProxyRegistryAddress(proxy);
}

}
