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
uint256 depth_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_79;
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
address[] memory a_80;
if (depth_0 <= 1) assembly {
a_80 := mload(0x40)
mstore(0x40,add(a_80,0x280))
sstore(a_addr_79_slot,a_80)
mstore(a_80,0x260)
}
 else assembly {
a_80 := sload(a_addr_79_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_81 = 0; index_81 < index_13; index_81 += 1) {
address tmp_82;
assembly {
tmp_82 := mload(add(a_80,mul(index_81,32)))
}

assert(_ownedTokensCount[tmp_82] == sum_ownersToken[tmp_82]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
address[] memory a_83;
if (depth_0 <= 1) assembly {
a_83 := mload(0x40)
mstore(0x40,add(a_83,0x280))
sstore(a_addr_79_slot,a_83)
mstore(a_83,0x260)
}
 else assembly {
a_83 := sload(a_addr_79_slot)
}

safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_84 = 0; index_84 < index_13; index_84 += 1) {
address tmp_85;
assembly {
tmp_85 := mload(add(a_83,mul(index_84,32)))
}

assert(_ownedTokensCount[tmp_85] == sum_ownersToken[tmp_85]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
depth_0 += 1;
address[] memory a_86;
if (depth_0 <= 1) assembly {
a_86 := mload(0x40)
mstore(0x40,add(a_86,0x280))
sstore(a_addr_79_slot,a_86)
mstore(a_86,0x260)
}
 else assembly {
a_86 := sload(a_addr_79_slot)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_87 = 0; index_87 < index_13; index_87 += 1) {
address tmp_88;
assembly {
tmp_88 := mload(add(a_86,mul(index_87,32)))
}

assert(_ownedTokensCount[tmp_88] == sum_ownersToken[tmp_88]);
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
address[20] memory a_90;
uint256 index_91 = 0;
uint256 tmp_sum_tokenCount_92 = sum_tokenCount;
require(to != address(0));
require(! _exists(tokenId));
{
address opt_89 = _tokenOwner[tokenId];
{
if (opt_89 == opt_89 && opt_89 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_89] >= 1);
{
a_90[index_91] = opt_89;
index_91 += 1;
}
sum_ownersToken[opt_89] -= 1;
}

}

opt_89 = to;
{
if (opt_89 == opt_89 && opt_89 != 0x0000000000000000000000000000000000000000) {
{
a_90[index_91] = opt_89;
index_91 += 1;
}
sum_ownersToken[opt_89] += 1;
assert(sum_ownersToken[opt_89] >= 1);
}

}

_tokenOwner[tokenId] = opt_89;
}

{
uint256 opt_93 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_92 >= opt_93);
tmp_sum_tokenCount_92 -= opt_93;
}

}

{
a_90[index_91] = to;
index_91 += 1;
}

opt_93 = opt_93.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_92 += opt_93;
assert(tmp_sum_tokenCount_92 >= opt_93);
}

}

_ownedTokensCount[to] = opt_93;
}

emit Transfer(address(0), to, tokenId);
sum_tokenCount = tmp_sum_tokenCount_92;
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_95;
assembly {
a_95 := sload(a_addr_79_slot)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_97 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_97);
sum_tokenCount -= opt_97;
}

}

{
address tmp_96 = owner;
assembly {
mstore(add(a_95,mul(sload(index_13_slot),32)),tmp_96)
}

index_13 += 1;
}

opt_97 = opt_97.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_97;
assert(sum_tokenCount >= opt_97);
}

}

_ownedTokensCount[owner] = opt_97;
}

{
address opt_99 = _tokenOwner[tokenId];
{
if (opt_99 == opt_99 && opt_99 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_99] >= 1);
{
address tmp_100 = opt_99;
assembly {
mstore(add(a_95,mul(sload(index_13_slot),32)),tmp_100)
}

index_13 += 1;
}
sum_ownersToken[opt_99] -= 1;
}

}

opt_99 = address(0);
{
if (opt_99 == opt_99 && opt_99 != 0x0000000000000000000000000000000000000000) {
{
address tmp_101 = opt_99;
assembly {
mstore(add(a_95,mul(sload(index_13_slot),32)),tmp_101)
}

index_13 += 1;
}
sum_ownersToken[opt_99] += 1;
assert(sum_ownersToken[opt_99] >= 1);
}

}

_tokenOwner[tokenId] = opt_99;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_102;
assembly {
a_102 := sload(a_addr_79_slot)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_104 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_104);
sum_tokenCount -= opt_104;
}

}

{
address tmp_103 = from;
assembly {
mstore(add(a_102,mul(sload(index_13_slot),32)),tmp_103)
}

index_13 += 1;
}

opt_104 = opt_104.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_104;
assert(sum_tokenCount >= opt_104);
}

}

_ownedTokensCount[from] = opt_104;
}

{
uint256 opt_107 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_107);
sum_tokenCount -= opt_107;
}

}

{
address tmp_106 = to;
assembly {
mstore(add(a_102,mul(sload(index_13_slot),32)),tmp_106)
}

index_13 += 1;
}

opt_107 = opt_107.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_107;
assert(sum_tokenCount >= opt_107);
}

}

_ownedTokensCount[to] = opt_107;
}

{
address opt_109 = _tokenOwner[tokenId];
{
if (opt_109 == opt_109 && opt_109 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_109] >= 1);
{
address tmp_110 = opt_109;
assembly {
mstore(add(a_102,mul(sload(index_13_slot),32)),tmp_110)
}

index_13 += 1;
}
sum_ownersToken[opt_109] -= 1;
}

}

opt_109 = to;
{
if (opt_109 == opt_109 && opt_109 != 0x0000000000000000000000000000000000000000) {
{
address tmp_111 = opt_109;
assembly {
mstore(add(a_102,mul(sload(index_13_slot),32)),tmp_111)
}

index_13 += 1;
}
sum_ownersToken[opt_109] += 1;
assert(sum_ownersToken[opt_109] >= 1);
}

}

_tokenOwner[tokenId] = opt_109;
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
r := mload(add(signature,0x20))
s := mload(add(signature,0x40))
v := byte(0,mload(add(signature,0x60)))
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
depth_0 += 1;
address[] memory a_112;
if (depth_0 <= 1) assembly {
a_112 := mload(0x40)
mstore(0x40,add(a_112,0x280))
sstore(a_addr_79_slot,a_112)
mstore(a_112,0x260)
}
 else assembly {
a_112 := sload(a_addr_79_slot)
}

bytes32 messageHash = keccak256(abi.encodePacked(msg.sender, _assetId));
address recoveredAddress = messageHash.toEthSignedMessageHash().recover(_sig);
require(recoveredAddress == serverAddress);
for (uint256 index = 0; index < _assetId.length; index ++) {
_mint(msg.sender, _assetId[index]);
}

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

function tokenURI (uint256 _tokenId) external view returns (string memory) {
{
return Strings.strConcat(
        baseTokenURI,
        Strings.uint2str(_tokenId)
    );
}

}

function mint (address _to, uint256 _tokenId) public {
depth_0 += 1;
address[] memory a_115;
if (depth_0 <= 1) assembly {
a_115 := mload(0x40)
mstore(0x40,add(a_115,0x280))
sstore(a_addr_79_slot,a_115)
mstore(a_115,0x260)
}
 else assembly {
a_115 := sload(a_addr_79_slot)
}

_mint(_to, _tokenId);
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

function transfer (address _to, uint256 _tokenId) public {
depth_0 += 1;
address[] memory a_118;
if (depth_0 <= 1) assembly {
a_118 := mload(0x40)
mstore(0x40,add(a_118,0x280))
sstore(a_addr_79_slot,a_118)
mstore(a_118,0x260)
}
 else assembly {
a_118 := sload(a_addr_79_slot)
}

safeTransferFrom(msg.sender, _to, _tokenId);
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

}
