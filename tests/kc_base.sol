pragma solidity ^0.5.0;
interface IERC165 {
function supportsInterface (bytes4 interfaceId) external view returns (bool);
}
pragma solidity ^0.5.0;
contract IERC721 is IERC165 {
uint256[] internal _allTokens;
event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
function balanceOf (address owner) public view returns (uint256 balance);
function ownerOf (uint256 tokenId) public view returns (address owner);
function approve (address to, uint256 tokenId) public;
function getApproved (uint256 tokenId) public view returns (address operator);
function setApprovalForAll (address operator, bool _approved) public;
function isApprovedForAll (address owner, address operator) public view returns (bool);
function transferFrom (address from, address to, uint256 tokenId) public;
function safeTransferFrom (address from, address to, uint256 tokenId) public;
function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory data) public;
}
pragma solidity ^0.5.0;
contract IERC721Receiver {
function onERC721Received (address operator, address from, uint256 tokenId, bytes memory data) public returns (bytes4);
}
pragma solidity ^0.5.0;
library SafeMath {
function mul (uint256 a, uint256 b) internal pure returns (uint256) {
if (a == 0) {
{
return 0;
}

}

uint256 c = a * b;
require(c / a == b);
{
return c;
}

}

function div (uint256 a, uint256 b) internal pure returns (uint256) {
require(b > 0);
uint256 c = a / b;
{
return c;
}

}

function sub (uint256 a, uint256 b) internal pure returns (uint256) {
require(b <= a);
uint256 c = a - b;
{
return c;
}

}

function add (uint256 a, uint256 b) internal pure returns (uint256) {
uint256 c = a + b;
require(c >= a);
{
return c;
}

}

function mod (uint256 a, uint256 b) internal pure returns (uint256) {
require(b != 0);
{
return a % b;
}

}

}
pragma solidity ^0.5.0;
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
pragma solidity ^0.5.0;
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
require(interfaceId != 0xffffffff);
_supportedInterfaces[interfaceId] = true;
}

}
pragma solidity ^0.5.0;
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

function safeTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_16;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_16 := mload(0x40)
mstore(0x40, add(tmp_16, 0))
sstore(memoryStart_0_slot, tmp_16)
}

}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_10 = 0; index_10 < a_store_4.length; index_10 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_10]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_10]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_11 = 0; index_11 < b_store_6.length; index_11 += 1) {
sum_ownersToken[b_store_6[index_11]] = 0;
}

for (uint256 index_12 = 0; index_12 < a_store_8.length; index_12 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_12]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_12]]] >= 1);
}

}

for (uint256 index_15 = 0; index_15 < a_store_10.length; index_15 += 1) {
assert(_ownedTokensCount[a_store_10[index_15]] == sum_ownersToken[a_store_10[index_15]]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
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

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_17 = 0; index_17 < a_store_4.length; index_17 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_17]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_17]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_18 = 0; index_18 < b_store_6.length; index_18 += 1) {
sum_ownersToken[b_store_6[index_18]] = 0;
}

for (uint256 index_19 = 0; index_19 < a_store_8.length; index_19 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_19]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_19]]] >= 1);
}

}

for (uint256 index_22 = 0; index_22 < a_store_10.length; index_22 += 1) {
assert(_ownedTokensCount[a_store_10[index_22]] == sum_ownersToken[a_store_10[index_22]]);
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
pragma solidity ^0.5.0;
contract IERC721Enumerable is IERC721 {
function totalSupply () public view returns (uint256);
function tokenOfOwnerByIndex (address owner, uint256 index) public view returns (uint256 tokenId);
function tokenByIndex (uint256 index) public view returns (uint256);
}
pragma solidity ^0.5.0;
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

function _mint (address to, uint256 tokenId) internal {
super._mint(to, tokenId);
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
pragma solidity ^0.5.0;
contract IERC721Metadata is IERC721 {
function name () external view returns (string memory);
function symbol () external view returns (string memory);
function tokenURI (uint256 tokenId) external view returns (string memory);
}
pragma solidity ^0.5.0;
contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
string private _name;
string private _symbol;
mapping (uint256=>string) private _tokenURIs;
bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
constructor (string memory name, string memory symbol) public {
_name = name;
_symbol = symbol;
_registerInterface(_INTERFACE_ID_ERC721_METADATA);
}

function name () external view returns (string memory) {
{
return _name;
}

}

function symbol () external view returns (string memory) {
{
return _symbol;
}

}

function tokenURI (uint256 tokenId) external view returns (string memory) {
require(_exists(tokenId));
{
return _tokenURIs[tokenId];
}

}

function _setTokenURI (uint256 tokenId, string memory uri) internal {
require(_exists(tokenId));
_tokenURIs[tokenId] = uri;
}

function _burn (address owner, uint256 tokenId) internal {
super._burn(owner, tokenId);
if (bytes(_tokenURIs[tokenId]).length != 0) {
delete _tokenURIs[tokenId];
}

}

}
pragma solidity ^0.5.0;
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
constructor (string memory name, string memory symbol) ERC721Metadata(name, symbol) public {
}

}
pragma solidity ^0.5.0;
library Roles {
struct Role {
        mapping (address => bool) bearer;
    }
function add (Role storage role, address account) internal {
require(account != address(0));
require(! has(role, account));
role.bearer[account] = true;
}

function remove (Role storage role, address account) internal {
require(account != address(0));
require(has(role, account));
role.bearer[account] = false;
}

function has (Role storage role, address account) internal view returns (bool) {
require(account != address(0));
{
return role.bearer[account];
}

}

}
pragma solidity ^0.5.0;
contract MinterRole {
using Roles for Roles.Role;
event MinterAdded(address indexed account);
event MinterRemoved(address indexed account);
Roles.Role private _minters;
constructor () internal {
_addMinter(msg.sender);
}

modifier onlyMinter() {
        require(isMinter(msg.sender));
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
pragma solidity ^0.5.0;
contract ERC721Mintable is ERC721, MinterRole {
function mint (address to, uint256 tokenId) onlyMinter public returns (bool) {
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

_mint(to, tokenId);
{
bool tmp_24 = true;
if (entry_1 == 1) {
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

memoryStart_0 = 0;
}

return (tmp_24);
}

if (entry_1 == 1) {
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

for (uint256 index_35 = 0; index_35 < a_store_10.length; index_35 += 1) {
assert(_ownedTokensCount[a_store_10[index_35]] == sum_ownersToken[a_store_10[index_35]]);
}

memoryStart_0 = 0;
}

}

}
pragma solidity ^0.5.0;
contract ERC721MetadataMintable is ERC721, ERC721Metadata, MinterRole {
function mintWithTokenURI (address to, uint256 tokenId, string memory tokenURI) onlyMinter public returns (bool) {
uint256 entry_1 = 0;
uint256 tmp_49;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_49 := mload(0x40)
mstore(0x40, add(tmp_49, 0))
sstore(memoryStart_0_slot, tmp_49)
}

}

_mint(to, tokenId);
_setTokenURI(tokenId, tokenURI);
{
bool tmp_37 = true;
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_38 = 0; index_38 < a_store_4.length; index_38 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_38]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_38]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_39 = 0; index_39 < b_store_6.length; index_39 += 1) {
sum_ownersToken[b_store_6[index_39]] = 0;
}

for (uint256 index_40 = 0; index_40 < a_store_8.length; index_40 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_40]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_40]]] >= 1);
}

}

for (uint256 index_43 = 0; index_43 < a_store_10.length; index_43 += 1) {
assert(_ownedTokensCount[a_store_10[index_43]] == sum_ownersToken[a_store_10[index_43]]);
}

memoryStart_0 = 0;
}

return (tmp_37);
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
{
for (uint256 index_45 = 0; index_45 < b_store_6.length; index_45 += 1) {
sum_ownersToken[b_store_6[index_45]] = 0;
}

for (uint256 index_46 = 0; index_46 < a_store_8.length; index_46 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_46]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_46]]] >= 1);
}

}

for (uint256 index_48 = 0; index_48 < a_store_10.length; index_48 += 1) {
assert(_ownedTokensCount[a_store_10[index_48]] == sum_ownersToken[a_store_10[index_48]]);
}

memoryStart_0 = 0;
}

}

}
pragma solidity ^0.5.0;
contract ERC721Burnable is ERC721 {
function burn (uint256 tokenId) public {
require(_isApprovedOrOwner(msg.sender, tokenId));
_burn(tokenId);
}

}
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
        require(isOwner());
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
require(newOwner != address(0));
emit OwnershipTransferred(_owner, newOwner);
_owner = newOwner;
}

}
pragma solidity ^0.5.0;
contract DozerDoll is ERC721Full, ERC721Mintable, ERC721MetadataMintable, ERC721Burnable, Ownable {
using SafeMath for uint256;
constructor (string memory _name, string memory _symbol) ERC721Mintable() ERC721Full(_name, _symbol) public {
}

function mintUniqueTokenTo (address _to, uint256 _tokenId, string memory _tokenURI) onlyOwner public {
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

_mint(_to, _tokenId);
_setTokenURI(_tokenId, _tokenURI);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_50 = 0; index_50 < a_store_4.length; index_50 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_50]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_50]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_51 = 0; index_51 < b_store_6.length; index_51 += 1) {
sum_ownersToken[b_store_6[index_51]] = 0;
}

for (uint256 index_52 = 0; index_52 < a_store_8.length; index_52 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_52]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_52]]] >= 1);
}

}

for (uint256 index_55 = 0; index_55 < a_store_10.length; index_55 += 1) {
assert(_ownedTokensCount[a_store_10[index_55]] == sum_ownersToken[a_store_10[index_55]]);
}

memoryStart_0 = 0;
}

}

function transfer (address _to, uint256 _tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_63;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_63 := mload(0x40)
mstore(0x40, add(tmp_63, 0))
sstore(memoryStart_0_slot, tmp_63)
}

}

safeTransferFrom(msg.sender, _to, _tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_57 = 0; index_57 < a_store_4.length; index_57 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_57]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_57]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_58 = 0; index_58 < b_store_6.length; index_58 += 1) {
sum_ownersToken[b_store_6[index_58]] = 0;
}

for (uint256 index_59 = 0; index_59 < a_store_8.length; index_59 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_59]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_59]]] >= 1);
}

}

for (uint256 index_62 = 0; index_62 < a_store_10.length; index_62 += 1) {
assert(_ownedTokensCount[a_store_10[index_62]] == sum_ownersToken[a_store_10[index_62]]);
}

memoryStart_0 = 0;
}

}

function transferAll (address _to, uint256[] memory _tokenId) public {
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

for (uint i = 0; i < _tokenId.length; i ++) {
safeTransferFrom(msg.sender, _to, _tokenId[i]);
}

if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_64 = 0; index_64 < a_store_4.length; index_64 += 1) {
sum_tokenCount += _ownedTokensCount[a_store_4[index_64]];
assert(sum_tokenCount >= _ownedTokensCount[a_store_4[index_64]]);
}

}

assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_65 = 0; index_65 < b_store_6.length; index_65 += 1) {
sum_ownersToken[b_store_6[index_65]] = 0;
}

for (uint256 index_66 = 0; index_66 < a_store_8.length; index_66 += 1) {
sum_ownersToken[_tokenOwner[a_store_8[index_66]]] += 1;
assert(sum_ownersToken[_tokenOwner[a_store_8[index_66]]] >= 1);
}

}

for (uint256 index_69 = 0; index_69 < a_store_10.length; index_69 += 1) {
assert(_ownedTokensCount[a_store_10[index_69]] == sum_ownersToken[a_store_10[index_69]]);
}

memoryStart_0 = 0;
}

}

}
