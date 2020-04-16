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

function safeTransferFrom (address from, address to, uint256 tokenId) public {
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

safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
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

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
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

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
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
address[20] memory a_122;
uint256 index_123 = 0;
uint256 tmp_sum_tokenCount_124 = sum_tokenCount;
require(to != address(0));
require(! _exists(tokenId));
{
address opt_121 = _tokenOwner[tokenId];
{
if (opt_121 == opt_121 && opt_121 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_121] >= 1);
{
a_122[index_123] = opt_121;
index_123 += 1;
}
sum_ownersToken[opt_121] -= 1;
}

}

opt_121 = to;
{
if (opt_121 == opt_121 && opt_121 != 0x0000000000000000000000000000000000000000) {
{
a_122[index_123] = opt_121;
index_123 += 1;
}
sum_ownersToken[opt_121] += 1;
assert(sum_ownersToken[opt_121] >= 1);
}

}

_tokenOwner[tokenId] = opt_121;
}

{
uint256 opt_125 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_124 >= opt_125);
tmp_sum_tokenCount_124 -= opt_125;
}

}

{
a_122[index_123] = to;
index_123 += 1;
}

opt_125 = opt_125.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_124 += opt_125;
assert(tmp_sum_tokenCount_124 >= opt_125);
}

}

_ownedTokensCount[to] = opt_125;
}

emit Transfer(address(0), to, tokenId);
sum_tokenCount = tmp_sum_tokenCount_124;
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_127;
assembly {
a_127 := sload(a_addr_111_slot)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_129 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_129);
sum_tokenCount -= opt_129;
}

}

{
address tmp_128 = owner;
assembly {
mstore(add(a_127,mul(sload(index_13_slot),32)),tmp_128)
}

index_13 += 1;
}

opt_129 = opt_129.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_129;
assert(sum_tokenCount >= opt_129);
}

}

_ownedTokensCount[owner] = opt_129;
}

{
address opt_131 = _tokenOwner[tokenId];
{
if (opt_131 == opt_131 && opt_131 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_131] >= 1);
{
address tmp_132 = opt_131;
assembly {
mstore(add(a_127,mul(sload(index_13_slot),32)),tmp_132)
}

index_13 += 1;
}
sum_ownersToken[opt_131] -= 1;
}

}

opt_131 = address(0);
{
if (opt_131 == opt_131 && opt_131 != 0x0000000000000000000000000000000000000000) {
{
address tmp_133 = opt_131;
assembly {
mstore(add(a_127,mul(sload(index_13_slot),32)),tmp_133)
}

index_13 += 1;
}
sum_ownersToken[opt_131] += 1;
assert(sum_ownersToken[opt_131] >= 1);
}

}

_tokenOwner[tokenId] = opt_131;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_134;
assembly {
a_134 := sload(a_addr_111_slot)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_136 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_136);
sum_tokenCount -= opt_136;
}

}

{
address tmp_135 = from;
assembly {
mstore(add(a_134,mul(sload(index_13_slot),32)),tmp_135)
}

index_13 += 1;
}

opt_136 = opt_136.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_136;
assert(sum_tokenCount >= opt_136);
}

}

_ownedTokensCount[from] = opt_136;
}

{
uint256 opt_139 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_139);
sum_tokenCount -= opt_139;
}

}

{
address tmp_138 = to;
assembly {
mstore(add(a_134,mul(sload(index_13_slot),32)),tmp_138)
}

index_13 += 1;
}

opt_139 = opt_139.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_139;
assert(sum_tokenCount >= opt_139);
}

}

_ownedTokensCount[to] = opt_139;
}

{
address opt_141 = _tokenOwner[tokenId];
{
if (opt_141 == opt_141 && opt_141 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_141] >= 1);
{
address tmp_142 = opt_141;
assembly {
mstore(add(a_134,mul(sload(index_13_slot),32)),tmp_142)
}

index_13 += 1;
}
sum_ownersToken[opt_141] -= 1;
}

}

opt_141 = to;
{
if (opt_141 == opt_141 && opt_141 != 0x0000000000000000000000000000000000000000) {
{
address tmp_143 = opt_141;
assembly {
mstore(add(a_134,mul(sload(index_13_slot),32)),tmp_143)
}

index_13 += 1;
}
sum_ownersToken[opt_141] += 1;
assert(sum_ownersToken[opt_141] >= 1);
}

}

_tokenOwner[tokenId] = opt_141;
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
depth_0 += 1;
address[] memory a_144;
if (depth_0 <= 1) assembly {
a_144 := mload(0x40)
mstore(0x40,add(a_144,0x280))
sstore(a_addr_111_slot,a_144)
mstore(a_144,0x260)
}
 else assembly {
a_144 := sload(a_addr_111_slot)
}

_mint(to, tokenId);
{
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

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_147 = 0; index_147 < index_13; index_147 += 1) {
address tmp_148;
assembly {
tmp_148 := mload(add(a_144,mul(index_147,32)))
}

assert(_ownedTokensCount[tmp_148] == sum_ownersToken[tmp_148]);
}

index_13 = 0;
}

}

}

}
pragma solidity ^0.5.0;
contract ERC721MetadataMintable is ERC721, ERC721Metadata, MinterRole {
function mintWithTokenURI (address to, uint256 tokenId, string memory tokenURI) onlyMinter public returns (bool) {
depth_0 += 1;
address[] memory a_149;
if (depth_0 <= 1) assembly {
a_149 := mload(0x40)
mstore(0x40,add(a_149,0x280))
sstore(a_addr_111_slot,a_149)
mstore(a_149,0x260)
}
 else assembly {
a_149 := sload(a_addr_111_slot)
}

_mint(to, tokenId);
_setTokenURI(tokenId, tokenURI);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_150 = 0; index_150 < index_13; index_150 += 1) {
address tmp_151;
assembly {
tmp_151 := mload(add(a_149,mul(index_150,32)))
}

assert(_ownedTokensCount[tmp_151] == sum_ownersToken[tmp_151]);
}

index_13 = 0;
}

}

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_152 = 0; index_152 < index_13; index_152 += 1) {
address tmp_153;
assembly {
tmp_153 := mload(add(a_149,mul(index_152,32)))
}

assert(_ownedTokensCount[tmp_153] == sum_ownersToken[tmp_153]);
}

index_13 = 0;
}

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

_mint(_to, _tokenId);
_setTokenURI(_tokenId, _tokenURI);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_155 = 0; index_155 < index_13; index_155 += 1) {
address tmp_156;
assembly {
tmp_156 := mload(add(a_154,mul(index_155,32)))
}

assert(_ownedTokensCount[tmp_156] == sum_ownersToken[tmp_156]);
}

index_13 = 0;
}

}

}

function transfer (address _to, uint256 _tokenId) public {
depth_0 += 1;
address[] memory a_157;
if (depth_0 <= 1) assembly {
a_157 := mload(0x40)
mstore(0x40,add(a_157,0x280))
sstore(a_addr_111_slot,a_157)
mstore(a_157,0x260)
}
 else assembly {
a_157 := sload(a_addr_111_slot)
}

safeTransferFrom(msg.sender, _to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_158 = 0; index_158 < index_13; index_158 += 1) {
address tmp_159;
assembly {
tmp_159 := mload(add(a_157,mul(index_158,32)))
}

assert(_ownedTokensCount[tmp_159] == sum_ownersToken[tmp_159]);
}

index_13 = 0;
}

}

}

function transferAll (address _to, uint256[] memory _tokenId) public {
depth_0 += 1;
address[] memory a_160;
if (depth_0 <= 1) assembly {
a_160 := mload(0x40)
mstore(0x40,add(a_160,0x280))
sstore(a_addr_111_slot,a_160)
mstore(a_160,0x260)
}
 else assembly {
a_160 := sload(a_addr_111_slot)
}

for (uint i = 0; i < _tokenId.length; i ++) {
safeTransferFrom(msg.sender, _to, _tokenId[i]);
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_161 = 0; index_161 < index_13; index_161 += 1) {
address tmp_162;
assembly {
tmp_162 := mload(add(a_160,mul(index_161,32)))
}

assert(_ownedTokensCount[tmp_162] == sum_ownersToken[tmp_162]);
}

index_13 = 0;
}

}

}

}
