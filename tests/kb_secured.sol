pragma solidity ^0.5.0;
interface IERC165 {
function supportsInterface (bytes4 interfaceId) external view returns (bool);
}
pragma solidity ^0.5.0;
contract IERC721 is IERC165 {
event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
uint256[] internal _allTokens;
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
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_93;
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
uint256 tmp_97;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_97 := mload(0x40)
mstore(0x40, add(tmp_97, 640))
sstore(memoryStart_0_slot, tmp_97)
mstore(add(tmp_97, 0), 0)
}

}

address[] memory a_94;
assembly {
a_94 := add(sload(memoryStart_0_slot), 0)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_95 = 0; index_95 < a_94.length; index_95 += 1) {
address tmp_96;
assembly {
tmp_96 := mload(add(a_94, mul(add(index_95, 1), 32)))
}

assert(_ownedTokensCount[tmp_96] == sum_ownersToken[tmp_96]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_101;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_101 := mload(0x40)
mstore(0x40, add(tmp_101, 640))
sstore(memoryStart_0_slot, tmp_101)
mstore(add(tmp_101, 0), 0)
}

}

address[] memory a_98;
assembly {
a_98 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_99 = 0; index_99 < a_98.length; index_99 += 1) {
address tmp_100;
assembly {
tmp_100 := mload(add(a_98, mul(add(index_99, 1), 32)))
}

assert(_ownedTokensCount[tmp_100] == sum_ownersToken[tmp_100]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
uint256 entry_1 = 0;
uint256 tmp_105;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_105 := mload(0x40)
mstore(0x40, add(tmp_105, 640))
sstore(memoryStart_0_slot, tmp_105)
mstore(add(tmp_105, 0), 0)
}

}

address[] memory a_102;
assembly {
a_102 := add(sload(memoryStart_0_slot), 0)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_103 = 0; index_103 < a_102.length; index_103 += 1) {
address tmp_104;
assembly {
tmp_104 := mload(add(a_102, mul(add(index_103, 1), 32)))
}

assert(_ownedTokensCount[tmp_104] == sum_ownersToken[tmp_104]);
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
address[] memory a_107;
assembly {
a_107 := add(sload(memoryStart_0_slot), 0)
}

require(to != address(0));
require(! _exists(tokenId));
{
address opt_106 = _tokenOwner[tokenId];
{
if (opt_106 == opt_106 && opt_106 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_106] >= 1);
{
address tmp_108 = opt_106;
assembly {
let tmp := add(mload(a_107), 1)
mstore(a_107, tmp)
mstore(add(a_107, mul(tmp, 32)), tmp_108)
}

}
sum_ownersToken[opt_106] -= 1;
}

}

opt_106 = to;
{
if (opt_106 == opt_106 && opt_106 != 0x0000000000000000000000000000000000000000) {
{
address tmp_109 = opt_106;
assembly {
let tmp := add(mload(a_107), 1)
mstore(a_107, tmp)
mstore(add(a_107, mul(tmp, 32)), tmp_109)
}

}
sum_ownersToken[opt_106] += 1;
assert(sum_ownersToken[opt_106] >= 1);
}

}

_tokenOwner[tokenId] = opt_106;
}

{
uint256 opt_111 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_111);
sum_tokenCount -= opt_111;
}

}

{
address tmp_110 = to;
assembly {
let tmp := add(mload(a_107), 1)
mstore(a_107, tmp)
mstore(add(a_107, mul(tmp, 32)), tmp_110)
}

}

opt_111 = opt_111.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_111;
assert(sum_tokenCount >= opt_111);
}

}

_ownedTokensCount[to] = opt_111;
}

emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_113;
assembly {
a_113 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_115 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_115);
sum_tokenCount -= opt_115;
}

}

{
address tmp_114 = owner;
assembly {
let tmp := add(mload(a_113), 1)
mstore(a_113, tmp)
mstore(add(a_113, mul(tmp, 32)), tmp_114)
}

}

opt_115 = opt_115.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_115;
assert(sum_tokenCount >= opt_115);
}

}

_ownedTokensCount[owner] = opt_115;
}

{
address opt_117 = _tokenOwner[tokenId];
{
if (opt_117 == opt_117 && opt_117 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_117] >= 1);
{
address tmp_118 = opt_117;
assembly {
let tmp := add(mload(a_113), 1)
mstore(a_113, tmp)
mstore(add(a_113, mul(tmp, 32)), tmp_118)
}

}
sum_ownersToken[opt_117] -= 1;
}

}

opt_117 = address(0);
{
if (opt_117 == opt_117 && opt_117 != 0x0000000000000000000000000000000000000000) {
{
address tmp_119 = opt_117;
assembly {
let tmp := add(mload(a_113), 1)
mstore(a_113, tmp)
mstore(add(a_113, mul(tmp, 32)), tmp_119)
}

}
sum_ownersToken[opt_117] += 1;
assert(sum_ownersToken[opt_117] >= 1);
}

}

_tokenOwner[tokenId] = opt_117;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_120;
assembly {
a_120 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_122 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_122);
sum_tokenCount -= opt_122;
}

}

{
address tmp_121 = from;
assembly {
let tmp := add(mload(a_120), 1)
mstore(a_120, tmp)
mstore(add(a_120, mul(tmp, 32)), tmp_121)
}

}

opt_122 = opt_122.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_122;
assert(sum_tokenCount >= opt_122);
}

}

_ownedTokensCount[from] = opt_122;
}

{
uint256 opt_125 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_125);
sum_tokenCount -= opt_125;
}

}

{
address tmp_124 = to;
assembly {
let tmp := add(mload(a_120), 1)
mstore(a_120, tmp)
mstore(add(a_120, mul(tmp, 32)), tmp_124)
}

}

opt_125 = opt_125.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_125;
assert(sum_tokenCount >= opt_125);
}

}

_ownedTokensCount[to] = opt_125;
}

{
address opt_127 = _tokenOwner[tokenId];
{
if (opt_127 == opt_127 && opt_127 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_127] >= 1);
{
address tmp_128 = opt_127;
assembly {
let tmp := add(mload(a_120), 1)
mstore(a_120, tmp)
mstore(add(a_120, mul(tmp, 32)), tmp_128)
}

}
sum_ownersToken[opt_127] -= 1;
}

}

opt_127 = to;
{
if (opt_127 == opt_127 && opt_127 != 0x0000000000000000000000000000000000000000) {
{
address tmp_129 = opt_127;
assembly {
let tmp := add(mload(a_120), 1)
mstore(a_120, tmp)
mstore(add(a_120, mul(tmp, 32)), tmp_129)
}

}
sum_ownersToken[opt_127] += 1;
assert(sum_ownersToken[opt_127] >= 1);
}

}

_tokenOwner[tokenId] = opt_127;
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
library ECDSA {
function recover (bytes32 hash, bytes memory signature) internal pure returns (address) {
bytes32 r;
bytes32 s;
uint8 v;
if (signature.length != 65) {
{
return (address(0));
}

}

assembly {
r := mload(add(signature, 0x20))
s := mload(add(signature, 0x40))
v := byte(0, mload(add(signature, 0x60)))
}

if (v < 27) {
v += 27;
}

if (v != 27 && v != 28) {
{
return (address(0));
}

}
 else {
{
return ecrecover(hash, v, r, s);
}

}

}

function toEthSignedMessageHash (bytes32 hash) internal pure returns (bytes32) {
{
return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
}

}

}
library Strings {
function strConcat (string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) internal pure returns (string memory) {
bytes memory _ba = bytes(_a);
bytes memory _bb = bytes(_b);
bytes memory _bc = bytes(_c);
bytes memory _bd = bytes(_d);
bytes memory _be = bytes(_e);
string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
bytes memory babcde = bytes(abcde);
uint k = 0;
for (uint i = 0; i < _ba.length; i ++) babcde[k ++] = _ba[i];
for (uint i = 0; i < _bb.length; i ++) babcde[k ++] = _bb[i];
for (uint i = 0; i < _bc.length; i ++) babcde[k ++] = _bc[i];
for (uint i = 0; i < _bd.length; i ++) babcde[k ++] = _bd[i];
for (uint i = 0; i < _be.length; i ++) babcde[k ++] = _be[i];
{
return string(babcde);
}

}

function strConcat (string memory _a, string memory _b, string memory _c, string memory _d) internal pure returns (string memory) {
{
return strConcat(_a, _b, _c, _d, "");
}

}

function strConcat (string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
{
return strConcat(_a, _b, _c, "", "");
}

}

function strConcat (string memory _a, string memory _b) internal pure returns (string memory) {
{
return strConcat(_a, _b, "", "", "");
}

}

function uint2str (uint _i) internal pure returns (string memory _uintAsString) {
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
contract KingdomsBeyond is ERC721Full, ERC721Burnable, Ownable {
using Strings for string;
using ECDSA for bytes32;
address serverAddress;
string baseTokenURI;
function setServerAddress (address _serverAddress) onlyOwner external {
serverAddress = _serverAddress;
}

function setBaseTokenURI (string calldata _tokenURI) onlyOwner external {
baseTokenURI = _tokenURI;
}

constructor (string memory _name, string memory _symbol) ERC721Full(_name, _symbol) public {
serverAddress = 0xf06168E1e86ab16dDf227c2997c8AD6E374E3b5F;
baseTokenURI = "https://www.kingdomsbeyond.com/_api/v1/token/getAssetDetail/";
}

function batchTokenizeAssets (uint256[] memory _assetId, bytes memory _sig) public {
uint256 entry_1 = 0;
uint256 tmp_133;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_133 := mload(0x40)
mstore(0x40, add(tmp_133, 640))
sstore(memoryStart_0_slot, tmp_133)
mstore(add(tmp_133, 0), 0)
}

}

address[] memory a_130;
assembly {
a_130 := add(sload(memoryStart_0_slot), 0)
}

bytes32 messageHash = keccak256(abi.encodePacked(msg.sender, _assetId));
address recoveredAddress = messageHash.toEthSignedMessageHash().recover(_sig);
require(recoveredAddress == serverAddress);
for (uint256 index = 0; index < _assetId.length; index ++) {
_mint(msg.sender, _assetId[index]);
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_131 = 0; index_131 < a_130.length; index_131 += 1) {
address tmp_132;
assembly {
tmp_132 := mload(add(a_130, mul(add(index_131, 1), 32)))
}

assert(_ownedTokensCount[tmp_132] == sum_ownersToken[tmp_132]);
}

memoryStart_0 = 0;
}

}

function tokenURI (uint256 _tokenId) external view returns (string memory) {
{
return Strings.strConcat(
        baseTokenURI,
        Strings.uint2str(_tokenId)
    );
}

}

function mint (address _to, uint256 _tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_137;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_137 := mload(0x40)
mstore(0x40, add(tmp_137, 640))
sstore(memoryStart_0_slot, tmp_137)
mstore(add(tmp_137, 0), 0)
}

}

address[] memory a_134;
assembly {
a_134 := add(sload(memoryStart_0_slot), 0)
}

_mint(_to, _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_135 = 0; index_135 < a_134.length; index_135 += 1) {
address tmp_136;
assembly {
tmp_136 := mload(add(a_134, mul(add(index_135, 1), 32)))
}

assert(_ownedTokensCount[tmp_136] == sum_ownersToken[tmp_136]);
}

memoryStart_0 = 0;
}

}

function transfer (address _to, uint256 _tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_141;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_141 := mload(0x40)
mstore(0x40, add(tmp_141, 640))
sstore(memoryStart_0_slot, tmp_141)
mstore(add(tmp_141, 0), 0)
}

}

address[] memory a_138;
assembly {
a_138 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(msg.sender, _to, _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_139 = 0; index_139 < a_138.length; index_139 += 1) {
address tmp_140;
assembly {
tmp_140 := mload(add(a_138, mul(add(index_139, 1), 32)))
}

assert(_ownedTokensCount[tmp_140] == sum_ownersToken[tmp_140]);
}

memoryStart_0 = 0;
}

}

}