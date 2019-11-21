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
uint256 a_addr_143;
uint256 index_13;
using SafeMath for uint256;
using Address for address;
bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
mapping (uint256=>address) private _tokenOwner;
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
depth_0 += 1;
address[] memory a_144;
if (depth_0 <= 1) assembly {
a_144 := mload(0x40)
mstore(0x40,add(a_144,0x280))
sstore(a_addr_143_slot,a_144)
mstore(a_144,0x260)
}
 else assembly {
a_144 := sload(a_addr_143_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_145 = 0; index_145 < index_13; index_145 += 1) {
address tmp_146;
assembly {
tmp_146 := mload(add(a_144,mul(index_145,32)))
}

assert(_ownedTokensCount[tmp_146] == sum_ownersToken[tmp_146]);
}

index_13 = 0;
}

}

}

function fastTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
address[] memory a_147;
if (depth_0 <= 1) assembly {
a_147 := mload(0x40)
mstore(0x40,add(a_147,0x280))
sstore(a_addr_143_slot,a_147)
mstore(a_147,0x260)
}
 else assembly {
a_147 := sload(a_addr_143_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_fastTransferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_148 = 0; index_148 < index_13; index_148 += 1) {
address tmp_149;
assembly {
tmp_149 := mload(add(a_147,mul(index_148,32)))
}

assert(_ownedTokensCount[tmp_149] == sum_ownersToken[tmp_149]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
address[] memory a_150;
if (depth_0 <= 1) assembly {
a_150 := mload(0x40)
mstore(0x40,add(a_150,0x280))
sstore(a_addr_143_slot,a_150)
mstore(a_150,0x260)
}
 else assembly {
a_150 := sload(a_addr_143_slot)
}

safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_151 = 0; index_151 < index_13; index_151 += 1) {
address tmp_152;
assembly {
tmp_152 := mload(add(a_150,mul(index_151,32)))
}

assert(_ownedTokensCount[tmp_152] == sum_ownersToken[tmp_152]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
depth_0 += 1;
address[] memory a_153;
if (depth_0 <= 1) assembly {
a_153 := mload(0x40)
mstore(0x40,add(a_153,0x280))
sstore(a_addr_143_slot,a_153)
mstore(a_153,0x260)
}
 else assembly {
a_153 := sload(a_addr_143_slot)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_154 = 0; index_154 < index_13; index_154 += 1) {
address tmp_155;
assembly {
tmp_155 := mload(add(a_153,mul(index_154,32)))
}

assert(_ownedTokensCount[tmp_155] == sum_ownersToken[tmp_155]);
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
address[20] memory a_157;
uint256 index_158 = 0;
uint256 tmp_sum_tokenCount_159 = sum_tokenCount;
require(to != address(0));
require(! _exists(tokenId));
{
address opt_156 = _tokenOwner[tokenId];
{
if (opt_156 == opt_156 && opt_156 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_156] >= 1);
{
a_157[index_158] = opt_156;
index_158 += 1;
}
sum_ownersToken[opt_156] -= 1;
}

}

opt_156 = to;
{
if (opt_156 == opt_156 && opt_156 != 0x0000000000000000000000000000000000000000) {
{
a_157[index_158] = opt_156;
index_158 += 1;
}
sum_ownersToken[opt_156] += 1;
assert(sum_ownersToken[opt_156] >= 1);
}

}

_tokenOwner[tokenId] = opt_156;
}

{
uint256 opt_160 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_159 >= opt_160);
tmp_sum_tokenCount_159 -= opt_160;
}

}

{
a_157[index_158] = to;
index_158 += 1;
}

opt_160 = opt_160.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_159 += opt_160;
assert(tmp_sum_tokenCount_159 >= opt_160);
}

}

_ownedTokensCount[to] = opt_160;
}

emit Transfer(address(0), to, tokenId);
sum_tokenCount = tmp_sum_tokenCount_159;
}

function _fastMint (address to, uint256 tokenId) internal {
address[20] memory a_163;
uint256 index_164 = 0;
if (_tokenOwner[tokenId] == address(0)) {
{
address opt_162 = _tokenOwner[tokenId];
{
if (opt_162 == opt_162 && opt_162 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_162] >= 1);
{
a_163[index_164] = opt_162;
index_164 += 1;
}
sum_ownersToken[opt_162] -= 1;
}

}

opt_162 = to;
{
if (opt_162 == opt_162 && opt_162 != 0x0000000000000000000000000000000000000000) {
{
a_163[index_164] = opt_162;
index_164 += 1;
}
sum_ownersToken[opt_162] += 1;
assert(sum_ownersToken[opt_162] >= 1);
}

}

_tokenOwner[tokenId] = opt_162;
}

}

emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_165;
assembly {
a_165 := sload(a_addr_143_slot)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_167 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_167);
sum_tokenCount -= opt_167;
}

}

{
address tmp_166 = owner;
assembly {
mstore(add(a_165,mul(sload(index_13_slot),32)),tmp_166)
}

index_13 += 1;
}

opt_167 = opt_167.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_167;
assert(sum_tokenCount >= opt_167);
}

}

_ownedTokensCount[owner] = opt_167;
}

{
address opt_169 = _tokenOwner[tokenId];
{
if (opt_169 == opt_169 && opt_169 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_169] >= 1);
{
address tmp_170 = opt_169;
assembly {
mstore(add(a_165,mul(sload(index_13_slot),32)),tmp_170)
}

index_13 += 1;
}
sum_ownersToken[opt_169] -= 1;
}

}

opt_169 = address(0);
{
if (opt_169 == opt_169 && opt_169 != 0x0000000000000000000000000000000000000000) {
{
address tmp_171 = opt_169;
assembly {
mstore(add(a_165,mul(sload(index_13_slot),32)),tmp_171)
}

index_13 += 1;
}
sum_ownersToken[opt_169] += 1;
assert(sum_ownersToken[opt_169] >= 1);
}

}

_tokenOwner[tokenId] = opt_169;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_172;
assembly {
a_172 := sload(a_addr_143_slot)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_174 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_174);
sum_tokenCount -= opt_174;
}

}

{
address tmp_173 = from;
assembly {
mstore(add(a_172,mul(sload(index_13_slot),32)),tmp_173)
}

index_13 += 1;
}

opt_174 = opt_174.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_174;
assert(sum_tokenCount >= opt_174);
}

}

_ownedTokensCount[from] = opt_174;
}

{
uint256 opt_177 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_177);
sum_tokenCount -= opt_177;
}

}

{
address tmp_176 = to;
assembly {
mstore(add(a_172,mul(sload(index_13_slot),32)),tmp_176)
}

index_13 += 1;
}

opt_177 = opt_177.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_177;
assert(sum_tokenCount >= opt_177);
}

}

_ownedTokensCount[to] = opt_177;
}

{
address opt_179 = _tokenOwner[tokenId];
{
if (opt_179 == opt_179 && opt_179 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_179] >= 1);
{
address tmp_180 = opt_179;
assembly {
mstore(add(a_172,mul(sload(index_13_slot),32)),tmp_180)
}

index_13 += 1;
}
sum_ownersToken[opt_179] -= 1;
}

}

opt_179 = to;
{
if (opt_179 == opt_179 && opt_179 != 0x0000000000000000000000000000000000000000) {
{
address tmp_181 = opt_179;
assembly {
mstore(add(a_172,mul(sload(index_13_slot),32)),tmp_181)
}

index_13 += 1;
}
sum_ownersToken[opt_179] += 1;
assert(sum_ownersToken[opt_179] >= 1);
}

}

_tokenOwner[tokenId] = opt_179;
}

emit Transfer(from, to, tokenId);
}

function _fastTransferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_183;
assembly {
a_183 := sload(a_addr_143_slot)
}

require(ownerOf(tokenId) == from);
_clearApproval(tokenId);
{
address opt_182 = _tokenOwner[tokenId];
{
if (opt_182 == opt_182 && opt_182 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_182] >= 1);
{
address tmp_184 = opt_182;
assembly {
mstore(add(a_183,mul(sload(index_13_slot),32)),tmp_184)
}

index_13 += 1;
}
sum_ownersToken[opt_182] -= 1;
}

}

opt_182 = to;
{
if (opt_182 == opt_182 && opt_182 != 0x0000000000000000000000000000000000000000) {
{
address tmp_185 = opt_182;
assembly {
mstore(add(a_183,mul(sload(index_13_slot),32)),tmp_185)
}

index_13 += 1;
}
sum_ownersToken[opt_182] += 1;
assert(sum_ownersToken[opt_182] >= 1);
}

}

_tokenOwner[tokenId] = opt_182;
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
depth_0 += 1;
address[] memory a_186;
if (depth_0 <= 1) assembly {
a_186 := mload(0x40)
mstore(0x40,add(a_186,0x280))
sstore(a_addr_143_slot,a_186)
mstore(a_186,0x260)
}
 else assembly {
a_186 := sload(a_addr_143_slot)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastTransferFrom(from, to, tokenIds[i]);
}

{
uint256 opt_188 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_188);
sum_tokenCount -= opt_188;
}

}

{
address tmp_187 = from;
assembly {
mstore(add(a_186,mul(sload(index_13_slot),32)),tmp_187)
}

index_13 += 1;
}

opt_188 = opt_188.sub(tokenIds.length);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_188;
assert(sum_tokenCount >= opt_188);
}

}

_ownedTokensCount[from] = opt_188;
}

{
uint256 opt_191 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_191);
sum_tokenCount -= opt_191;
}

}

{
address tmp_190 = to;
assembly {
mstore(add(a_186,mul(sload(index_13_slot),32)),tmp_190)
}

index_13 += 1;
}

opt_191 = opt_191.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_191;
assert(sum_tokenCount >= opt_191);
}

}

_ownedTokensCount[to] = opt_191;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_193 = 0; index_193 < index_13; index_193 += 1) {
address tmp_194;
assembly {
tmp_194 := mload(add(a_186,mul(index_193,32)))
}

assert(_ownedTokensCount[tmp_194] == sum_ownersToken[tmp_194]);
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
address[] memory a_195;
assembly {
a_195 := sload(a_addr_143_slot)
}

require(to != address(0));
for (uint256 i = 0; i < tokenIds.length; i ++) {
_fastMint(to, tokenIds[i]);
}

{
uint256 opt_197 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_197);
sum_tokenCount -= opt_197;
}

}

{
address tmp_196 = to;
assembly {
mstore(add(a_195,mul(sload(index_13_slot),32)),tmp_196)
}

index_13 += 1;
}

opt_197 = opt_197.add(tokenIds.length);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_197;
assert(sum_tokenCount >= opt_197);
}

}

_ownedTokensCount[to] = opt_197;
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
depth_0 += 1;
address[] memory a_199;
if (depth_0 <= 1) assembly {
a_199 := mload(0x40)
mstore(0x40,add(a_199,0x280))
sstore(a_addr_143_slot,a_199)
mstore(a_199,0x260)
}
 else assembly {
a_199 := sload(a_addr_143_slot)
}

_mint(to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_200 = 0; index_200 < index_13; index_200 += 1) {
address tmp_201;
assembly {
tmp_201 := mload(add(a_199,mul(index_200,32)))
}

assert(_ownedTokensCount[tmp_201] == sum_ownersToken[tmp_201]);
}

index_13 = 0;
}

}

}

function mintCardsFromPack (address to, uint[] memory tokenIds) onlyMinter public {
depth_0 += 1;
address[] memory a_202;
if (depth_0 <= 1) assembly {
a_202 := mload(0x40)
mstore(0x40,add(a_202,0x280))
sstore(a_addr_143_slot,a_202)
mstore(a_202,0x260)
}
 else assembly {
a_202 := sload(a_addr_143_slot)
}

_mintBatch(to, tokenIds);
uint totalWrappedEth;
for (uint i = 0; i < tokenIds.length; i ++) {
totalWrappedEth = totalWrappedEth + getWrappedEther(tokenIds[i]);
}

if (totalWrappedEth > 0) {
_wrappedEtherDemand = _wrappedEtherDemand + totalWrappedEth;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_203 = 0; index_203 < index_13; index_203 += 1) {
address tmp_204;
assembly {
tmp_204 := mload(add(a_202,mul(index_203,32)))
}

assert(_ownedTokensCount[tmp_204] == sum_ownersToken[tmp_204]);
}

index_13 = 0;
}

}

}

function migrateCards (address to, uint[] memory tokenIds) onlyMinter public {
depth_0 += 1;
address[] memory a_205;
if (depth_0 <= 1) assembly {
a_205 := mload(0x40)
mstore(0x40,add(a_205,0x280))
sstore(a_addr_143_slot,a_205)
mstore(a_205,0x260)
}
 else assembly {
a_205 := sload(a_addr_143_slot)
}

_mintBatch(to, tokenIds);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_206 = 0; index_206 < index_13; index_206 += 1) {
address tmp_207;
assembly {
tmp_207 := mload(add(a_205,mul(index_206,32)))
}

assert(_ownedTokensCount[tmp_207] == sum_ownersToken[tmp_207]);
}

index_13 = 0;
}

}

}

function printFor (address owner, uint tokenId, bytes16 uuid) onlyMinter public {
require(owner == ownerOf(tokenId), "User does not own this Card");
_printToken(owner, tokenId, uuid);
}

function combineFor (address owner, uint tokenA, uint tokenB, uint newIssue, bytes16 uuid) onlyMinter public returns (uint) {
depth_0 += 1;
address[] memory a_208;
if (depth_0 <= 1) assembly {
a_208 := mload(0x40)
mstore(0x40,add(a_208,0x280))
sstore(a_addr_143_slot,a_208)
mstore(a_208,0x260)
}
 else assembly {
a_208 := sload(a_addr_143_slot)
}

require(owner == ownerOf(tokenA), "User does not own this Card");
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_209 = 0; index_209 < index_13; index_209 += 1) {
address tmp_210;
assembly {
tmp_210 := mload(add(a_208,mul(index_209,32)))
}

assert(_ownedTokensCount[tmp_210] == sum_ownersToken[tmp_210]);
}

index_13 = 0;
}

}

return _combineTokens(tokenA, tokenB, newIssue, uuid);
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_211 = 0; index_211 < index_13; index_211 += 1) {
address tmp_212;
assembly {
tmp_212 := mload(add(a_208,mul(index_211,32)))
}

assert(_ownedTokensCount[tmp_212] == sum_ownersToken[tmp_212]);
}

index_13 = 0;
}

}

}

function meltFor (address owner, uint tokenId, bytes16 uuid) onlyMinter public returns (uint) {
require(owner == ownerOf(tokenId), "User does not own this Card");
{
return _meltToken(tokenId, uuid);
}

}

function tokenTransfer (address from, address to, uint tokenId) onlyMinter public {
depth_0 += 1;
address[] memory a_213;
if (depth_0 <= 1) assembly {
a_213 := mload(0x40)
mstore(0x40,add(a_213,0x280))
sstore(a_addr_143_slot,a_213)
mstore(a_213,0x260)
}
 else assembly {
a_213 := sload(a_addr_143_slot)
}

_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_214 = 0; index_214 < index_13; index_214 += 1) {
address tmp_215;
assembly {
tmp_215 := mload(add(a_213,mul(index_214,32)))
}

assert(_ownedTokensCount[tmp_215] == sum_ownersToken[tmp_215]);
}

index_13 = 0;
}

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
depth_0 += 1;
address[] memory a_216;
if (depth_0 <= 1) assembly {
a_216 := mload(0x40)
mstore(0x40,add(a_216,0x280))
sstore(a_addr_143_slot,a_216)
mstore(a_216,0x260)
}
 else assembly {
a_216 := sload(a_addr_143_slot)
}

safeTransferFrom(msg.sender, _to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_217 = 0; index_217 < index_13; index_217 += 1) {
address tmp_218;
assembly {
tmp_218 := mload(add(a_216,mul(index_217,32)))
}

assert(_ownedTokensCount[tmp_218] == sum_ownersToken[tmp_218]);
}

index_13 = 0;
}

}

}

}
