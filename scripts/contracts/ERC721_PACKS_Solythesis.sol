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
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_111;
uint256 index_13;
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
address[] memory a_112;
if (depth_0 <= 1) assembly {
a_112 := mload(0x40)
mstore(0x40,add(a_112,0x280))
sstore(a_addr_111_slot,a_112)
mstore(a_112,0x260)
}
 else assembly {
a_112 := sload(a_addr_111_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_113 = 0; index_113 < index_13; index_113 += 1) {
address tmp_114;
assembly {
tmp_114 := mload(add(a_112,mul(index_113,32)))
}

assert(_ownedTokensCount[tmp_114] == sum_ownersToken[tmp_114]);
}

index_13 = 0;
}

}

}

function fastTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
address[] memory a_115;
if (depth_0 <= 1) assembly {
a_115 := mload(0x40)
mstore(0x40,add(a_115,0x280))
sstore(a_addr_111_slot,a_115)
mstore(a_115,0x260)
}
 else assembly {
a_115 := sload(a_addr_111_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_fastTransferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_116 = 0; index_116 < index_13; index_116 += 1) {
address tmp_117;
assembly {
tmp_117 := mload(add(a_115,mul(index_116,32)))
}

assert(_ownedTokensCount[tmp_117] == sum_ownersToken[tmp_117]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
address[] memory a_118;
if (depth_0 <= 1) assembly {
a_118 := mload(0x40)
mstore(0x40,add(a_118,0x280))
sstore(a_addr_111_slot,a_118)
mstore(a_118,0x260)
}
 else assembly {
a_118 := sload(a_addr_111_slot)
}

safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_119 = 0; index_119 < index_13; index_119 += 1) {
address tmp_120;
assembly {
tmp_120 := mload(add(a_118,mul(index_119,32)))
}

assert(_ownedTokensCount[tmp_120] == sum_ownersToken[tmp_120]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
depth_0 += 1;
address[] memory a_121;
if (depth_0 <= 1) assembly {
a_121 := mload(0x40)
mstore(0x40,add(a_121,0x280))
sstore(a_addr_111_slot,a_121)
mstore(a_121,0x260)
}
 else assembly {
a_121 := sload(a_addr_111_slot)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_122 = 0; index_122 < index_13; index_122 += 1) {
address tmp_123;
assembly {
tmp_123 := mload(add(a_121,mul(index_122,32)))
}

assert(_ownedTokensCount[tmp_123] == sum_ownersToken[tmp_123]);
}

index_13 = 0;
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
address[20] memory a_125;
uint256 index_126 = 0;
uint256 tmp_sum_tokenCount_127 = sum_tokenCount;
require(to != address(0));
require(! _exists(tokenId));
{
address opt_124 = _tokenOwner[tokenId];
{
if (opt_124 == opt_124 && opt_124 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_124] >= 1);
{
a_125[index_126] = opt_124;
index_126 += 1;
}
sum_ownersToken[opt_124] -= 1;
}

}

opt_124 = to;
{
if (opt_124 == opt_124 && opt_124 != 0x0000000000000000000000000000000000000000) {
{
a_125[index_126] = opt_124;
index_126 += 1;
}
sum_ownersToken[opt_124] += 1;
assert(sum_ownersToken[opt_124] >= 1);
}

}

_tokenOwner[tokenId] = opt_124;
}

{
uint256 opt_128 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_127 >= opt_128);
tmp_sum_tokenCount_127 -= opt_128;
}

}

{
a_125[index_126] = to;
index_126 += 1;
}

opt_128 = opt_128.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_127 += opt_128;
assert(tmp_sum_tokenCount_127 >= opt_128);
}

}

_ownedTokensCount[to] = opt_128;
}

emit Transfer(address(0), to, tokenId);
sum_tokenCount = tmp_sum_tokenCount_127;
}

function _fastMint (address to, uint256 tokenId) internal {
address[20] memory a_131;
uint256 index_132 = 0;
if (_tokenOwner[tokenId] == address(0)) {
{
address opt_130 = _tokenOwner[tokenId];
{
if (opt_130 == opt_130 && opt_130 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_130] >= 1);
{
a_131[index_132] = opt_130;
index_132 += 1;
}
sum_ownersToken[opt_130] -= 1;
}

}

opt_130 = to;
{
if (opt_130 == opt_130 && opt_130 != 0x0000000000000000000000000000000000000000) {
{
a_131[index_132] = opt_130;
index_132 += 1;
}
sum_ownersToken[opt_130] += 1;
assert(sum_ownersToken[opt_130] >= 1);
}

}

_tokenOwner[tokenId] = opt_130;
}

}

emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_133;
assembly {
a_133 := sload(a_addr_111_slot)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_135 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_135);
sum_tokenCount -= opt_135;
}

}

{
address tmp_134 = owner;
assembly {
mstore(add(a_133,mul(sload(index_13_slot),32)),tmp_134)
}

index_13 += 1;
}

opt_135 = opt_135.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_135;
assert(sum_tokenCount >= opt_135);
}

}

_ownedTokensCount[owner] = opt_135;
}

{
address opt_137 = _tokenOwner[tokenId];
{
if (opt_137 == opt_137 && opt_137 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_137] >= 1);
{
address tmp_138 = opt_137;
assembly {
mstore(add(a_133,mul(sload(index_13_slot),32)),tmp_138)
}

index_13 += 1;
}
sum_ownersToken[opt_137] -= 1;
}

}

opt_137 = address(0);
{
if (opt_137 == opt_137 && opt_137 != 0x0000000000000000000000000000000000000000) {
{
address tmp_139 = opt_137;
assembly {
mstore(add(a_133,mul(sload(index_13_slot),32)),tmp_139)
}

index_13 += 1;
}
sum_ownersToken[opt_137] += 1;
assert(sum_ownersToken[opt_137] >= 1);
}

}

_tokenOwner[tokenId] = opt_137;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_140;
assembly {
a_140 := sload(a_addr_111_slot)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_142 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_142);
sum_tokenCount -= opt_142;
}

}

{
address tmp_141 = from;
assembly {
mstore(add(a_140,mul(sload(index_13_slot),32)),tmp_141)
}

index_13 += 1;
}

opt_142 = opt_142.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_142;
assert(sum_tokenCount >= opt_142);
}

}

_ownedTokensCount[from] = opt_142;
}

{
uint256 opt_145 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_145);
sum_tokenCount -= opt_145;
}

}

{
address tmp_144 = to;
assembly {
mstore(add(a_140,mul(sload(index_13_slot),32)),tmp_144)
}

index_13 += 1;
}

opt_145 = opt_145.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_145;
assert(sum_tokenCount >= opt_145);
}

}

_ownedTokensCount[to] = opt_145;
}

{
address opt_147 = _tokenOwner[tokenId];
{
if (opt_147 == opt_147 && opt_147 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_147] >= 1);
{
address tmp_148 = opt_147;
assembly {
mstore(add(a_140,mul(sload(index_13_slot),32)),tmp_148)
}

index_13 += 1;
}
sum_ownersToken[opt_147] -= 1;
}

}

opt_147 = to;
{
if (opt_147 == opt_147 && opt_147 != 0x0000000000000000000000000000000000000000) {
{
address tmp_149 = opt_147;
assembly {
mstore(add(a_140,mul(sload(index_13_slot),32)),tmp_149)
}

index_13 += 1;
}
sum_ownersToken[opt_147] += 1;
assert(sum_ownersToken[opt_147] >= 1);
}

}

_tokenOwner[tokenId] = opt_147;
}

emit Transfer(from, to, tokenId);
}

function _fastTransferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_151;
assembly {
a_151 := sload(a_addr_111_slot)
}

require(ownerOf(tokenId) == from);
_clearApproval(tokenId);
{
address opt_150 = _tokenOwner[tokenId];
{
if (opt_150 == opt_150 && opt_150 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_150] >= 1);
{
address tmp_152 = opt_150;
assembly {
mstore(add(a_151,mul(sload(index_13_slot),32)),tmp_152)
}

index_13 += 1;
}
sum_ownersToken[opt_150] -= 1;
}

}

opt_150 = to;
{
if (opt_150 == opt_150 && opt_150 != 0x0000000000000000000000000000000000000000) {
{
address tmp_153 = opt_150;
assembly {
mstore(add(a_151,mul(sload(index_13_slot),32)),tmp_153)
}

index_13 += 1;
}
sum_ownersToken[opt_150] += 1;
assert(sum_ownersToken[opt_150] >= 1);
}

}

_tokenOwner[tokenId] = opt_150;
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
address[] memory a_154;
if (depth_0 <= 1) assembly {
a_154 := mload(0x40)
mstore(0x40,add(a_154,0x280))
sstore(a_addr_111_slot,a_154)
mstore(a_154,0x260)
}
 else assembly {
a_154 := sload(a_addr_111_slot)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastTransferFrom(from, to, tokenIds[i]);
}

{
uint256 opt_156 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_156);
sum_tokenCount -= opt_156;
}

}

{
address tmp_155 = from;
assembly {
mstore(add(a_154,mul(sload(index_13_slot),32)),tmp_155)
}

index_13 += 1;
}

opt_156 = opt_156.sub(tokenIds.length);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_156;
assert(sum_tokenCount >= opt_156);
}

}

_ownedTokensCount[from] = opt_156;
}

{
uint256 opt_159 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_159);
sum_tokenCount -= opt_159;
}

}

{
address tmp_158 = to;
assembly {
mstore(add(a_154,mul(sload(index_13_slot),32)),tmp_158)
}

index_13 += 1;
}

opt_159 = opt_159.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_159;
assert(sum_tokenCount >= opt_159);
}

}

_ownedTokensCount[to] = opt_159;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_161 = 0; index_161 < index_13; index_161 += 1) {
address tmp_162;
assembly {
tmp_162 := mload(add(a_154,mul(index_161,32)))
}

assert(_ownedTokensCount[tmp_162] == sum_ownersToken[tmp_162]);
}

index_13 = 0;
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
address[] memory a_163;
assembly {
a_163 := sload(a_addr_111_slot)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastMint(to, tokenIds[i]);
}

{
uint256 opt_165 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_165);
sum_tokenCount -= opt_165;
}

}

{
address tmp_164 = to;
assembly {
mstore(add(a_163,mul(sload(index_13_slot),32)),tmp_164)
}

index_13 += 1;
}

opt_165 = opt_165.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_165;
assert(sum_tokenCount >= opt_165);
}

}

_ownedTokensCount[to] = opt_165;
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
address[] memory a_167;
if (depth_0 <= 1) assembly {
a_167 := mload(0x40)
mstore(0x40,add(a_167,0x280))
sstore(a_addr_111_slot,a_167)
mstore(a_167,0x260)
}
 else assembly {
a_167 := sload(a_addr_111_slot)
}

_totalMintedPacks = _totalMintedPacks + 1;
_mint(to, tokenId);
_packData[tokenId] = "tokenId";
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_168 = 0; index_168 < index_13; index_168 += 1) {
address tmp_169;
assembly {
tmp_169 := mload(add(a_167,mul(index_168,32)))
}

assert(_ownedTokensCount[tmp_169] == sum_ownersToken[tmp_169]);
}

index_13 = 0;
}

}

return tokenId;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_170 = 0; index_170 < index_13; index_170 += 1) {
address tmp_171;
assembly {
tmp_171 := mload(add(a_167,mul(index_170,32)))
}

assert(_ownedTokensCount[tmp_171] == sum_ownersToken[tmp_171]);
}

index_13 = 0;
}

}

}

function burnPack (address from, uint256 tokenId) onlyMinter public {
_burn(from, tokenId);
_packData[tokenId] = "";
}

function tokenTransfer (address from, address to, uint256 tokenId) onlyMinter public {
depth_0 += 1;
address[] memory a_172;
if (depth_0 <= 1) assembly {
a_172 := mload(0x40)
mstore(0x40,add(a_172,0x280))
sstore(a_addr_111_slot,a_172)
mstore(a_172,0x260)
}
 else assembly {
a_172 := sload(a_addr_111_slot)
}

_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_173 = 0; index_173 < index_13; index_173 += 1) {
address tmp_174;
assembly {
tmp_174 := mload(add(a_172,mul(index_173,32)))
}

assert(_ownedTokensCount[tmp_174] == sum_ownersToken[tmp_174]);
}

index_13 = 0;
}

}

}

function setProxyRegistryAddress (address proxy) onlyOwner public {
_setProxyRegistryAddress(proxy);
}

}
