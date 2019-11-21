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
contract WhitelistAdminRole {
using Roles for Roles.Role;
event WhitelistAdminAdded(address indexed account);
event WhitelistAdminRemoved(address indexed account);
Roles.Role private _whitelistAdmins;
constructor () internal {
_addWhitelistAdmin(msg.sender);
}

modifier onlyWhitelistAdmin() {
        require(isWhitelistAdmin(msg.sender));
        _;
    }
function isWhitelistAdmin (address account) public view returns (bool) {
{
return _whitelistAdmins.has(account);
}

}

function addWhitelistAdmin (address account) onlyWhitelistAdmin public {
_addWhitelistAdmin(account);
}

function renounceWhitelistAdmin () public {
_removeWhitelistAdmin(msg.sender);
}

function _addWhitelistAdmin (address account) internal {
_whitelistAdmins.add(account);
emit WhitelistAdminAdded(account);
}

function _removeWhitelistAdmin (address account) internal {
_whitelistAdmins.remove(account);
emit WhitelistAdminRemoved(account);
}

}
pragma solidity ^0.5.0;
contract WhitelistedRole is WhitelistAdminRole {
using Roles for Roles.Role;
event WhitelistedAdded(address indexed account);
event WhitelistedRemoved(address indexed account);
Roles.Role private _whitelisteds;
modifier onlyWhitelisted() {
        require(isWhitelisted(msg.sender));
        _;
    }
function isWhitelisted (address account) public view returns (bool) {
{
return _whitelisteds.has(account);
}

}

function addWhitelisted (address account) onlyWhitelistAdmin public {
_addWhitelisted(account);
}

function removeWhitelisted (address account) onlyWhitelistAdmin public {
_removeWhitelisted(account);
}

function renounceWhitelisted () public {
_removeWhitelisted(msg.sender);
}

function _addWhitelisted (address account) internal {
_whitelisteds.add(account);
emit WhitelistedAdded(account);
}

function _removeWhitelisted (address account) internal {
_whitelisteds.remove(account);
emit WhitelistedRemoved(account);
}

}
pragma solidity ^0.5.0;
library Strings {
function strConcat (string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) internal pure returns (string memory _concatenatedString) {
bytes memory _ba = bytes(_a);
bytes memory _bb = bytes(_b);
bytes memory _bc = bytes(_c);
bytes memory _bd = bytes(_d);
bytes memory _be = bytes(_e);
string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
bytes memory babcde = bytes(abcde);
uint k = 0;
uint i = 0;
for (i = 0; i < _ba.length; i ++) {
babcde[k ++] = _ba[i];
}

for (i = 0; i < _bb.length; i ++) {
babcde[k ++] = _bb[i];
}

for (i = 0; i < _bc.length; i ++) {
babcde[k ++] = _bc[i];
}

for (i = 0; i < _bd.length; i ++) {
babcde[k ++] = _bd[i];
}

for (i = 0; i < _be.length; i ++) {
babcde[k ++] = _be[i];
}

{
return string(babcde);
}

}

function strConcat (string memory _a, string memory _b) internal pure returns (string memory) {
{
return strConcat(_a, _b, "", "", "");
}

}

function strConcat (string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
{
return strConcat(_a, _b, _c, "", "");
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
pragma solidity ^0.5.0;
interface IBlockCitiesCreator {
function createBuilding (
        uint256 _exteriorColorway,
        uint256 _backgroundColorway,
        uint256 _city,
        uint256 _building,
        uint256 _base,
        uint256 _body,
        uint256 _roof,
        uint256 _special,
        address _architect
    ) external returns (uint256 _tokenId);
}
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
uint256 a_addr_84;
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
address[] memory a_85;
if (depth_0 <= 1) assembly {
a_85 := mload(0x40)
mstore(0x40,add(a_85,0x280))
sstore(a_addr_84_slot,a_85)
mstore(a_85,0x260)
}
 else assembly {
a_85 := sload(a_addr_84_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_86 = 0; index_86 < index_13; index_86 += 1) {
address tmp_87;
assembly {
tmp_87 := mload(add(a_85,mul(index_86,32)))
}

assert(_ownedTokensCount[tmp_87] == sum_ownersToken[tmp_87]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
address[] memory a_88;
if (depth_0 <= 1) assembly {
a_88 := mload(0x40)
mstore(0x40,add(a_88,0x280))
sstore(a_addr_84_slot,a_88)
mstore(a_88,0x260)
}
 else assembly {
a_88 := sload(a_addr_84_slot)
}

safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_89 = 0; index_89 < index_13; index_89 += 1) {
address tmp_90;
assembly {
tmp_90 := mload(add(a_88,mul(index_89,32)))
}

assert(_ownedTokensCount[tmp_90] == sum_ownersToken[tmp_90]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
depth_0 += 1;
address[] memory a_91;
if (depth_0 <= 1) assembly {
a_91 := mload(0x40)
mstore(0x40,add(a_91,0x280))
sstore(a_addr_84_slot,a_91)
mstore(a_91,0x260)
}
 else assembly {
a_91 := sload(a_addr_84_slot)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_92 = 0; index_92 < index_13; index_92 += 1) {
address tmp_93;
assembly {
tmp_93 := mload(add(a_91,mul(index_92,32)))
}

assert(_ownedTokensCount[tmp_93] == sum_ownersToken[tmp_93]);
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
address[20] memory a_95;
uint256 index_96 = 0;
uint256 tmp_sum_tokenCount_97 = sum_tokenCount;
require(to != address(0));
require(! _exists(tokenId));
{
address opt_94 = _tokenOwner[tokenId];
{
if (opt_94 == opt_94 && opt_94 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_94] >= 1);
{
a_95[index_96] = opt_94;
index_96 += 1;
}
sum_ownersToken[opt_94] -= 1;
}

}

opt_94 = to;
{
if (opt_94 == opt_94 && opt_94 != 0x0000000000000000000000000000000000000000) {
{
a_95[index_96] = opt_94;
index_96 += 1;
}
sum_ownersToken[opt_94] += 1;
assert(sum_ownersToken[opt_94] >= 1);
}

}

_tokenOwner[tokenId] = opt_94;
}

{
uint256 opt_98 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_97 >= opt_98);
tmp_sum_tokenCount_97 -= opt_98;
}

}

{
a_95[index_96] = to;
index_96 += 1;
}

opt_98 = opt_98.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_97 += opt_98;
assert(tmp_sum_tokenCount_97 >= opt_98);
}

}

_ownedTokensCount[to] = opt_98;
}

emit Transfer(address(0), to, tokenId);
sum_tokenCount = tmp_sum_tokenCount_97;
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_100;
assembly {
a_100 := sload(a_addr_84_slot)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_102 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_102);
sum_tokenCount -= opt_102;
}

}

{
address tmp_101 = owner;
assembly {
mstore(add(a_100,mul(sload(index_13_slot),32)),tmp_101)
}

index_13 += 1;
}

opt_102 = opt_102.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_102;
assert(sum_tokenCount >= opt_102);
}

}

_ownedTokensCount[owner] = opt_102;
}

{
address opt_104 = _tokenOwner[tokenId];
{
if (opt_104 == opt_104 && opt_104 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_104] >= 1);
{
address tmp_105 = opt_104;
assembly {
mstore(add(a_100,mul(sload(index_13_slot),32)),tmp_105)
}

index_13 += 1;
}
sum_ownersToken[opt_104] -= 1;
}

}

opt_104 = address(0);
{
if (opt_104 == opt_104 && opt_104 != 0x0000000000000000000000000000000000000000) {
{
address tmp_106 = opt_104;
assembly {
mstore(add(a_100,mul(sload(index_13_slot),32)),tmp_106)
}

index_13 += 1;
}
sum_ownersToken[opt_104] += 1;
assert(sum_ownersToken[opt_104] >= 1);
}

}

_tokenOwner[tokenId] = opt_104;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_107;
assembly {
a_107 := sload(a_addr_84_slot)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_109 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_109);
sum_tokenCount -= opt_109;
}

}

{
address tmp_108 = from;
assembly {
mstore(add(a_107,mul(sload(index_13_slot),32)),tmp_108)
}

index_13 += 1;
}

opt_109 = opt_109.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_109;
assert(sum_tokenCount >= opt_109);
}

}

_ownedTokensCount[from] = opt_109;
}

{
uint256 opt_112 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_112);
sum_tokenCount -= opt_112;
}

}

{
address tmp_111 = to;
assembly {
mstore(add(a_107,mul(sload(index_13_slot),32)),tmp_111)
}

index_13 += 1;
}

opt_112 = opt_112.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_112;
assert(sum_tokenCount >= opt_112);
}

}

_ownedTokensCount[to] = opt_112;
}

{
address opt_114 = _tokenOwner[tokenId];
{
if (opt_114 == opt_114 && opt_114 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_114] >= 1);
{
address tmp_115 = opt_114;
assembly {
mstore(add(a_107,mul(sload(index_13_slot),32)),tmp_115)
}

index_13 += 1;
}
sum_ownersToken[opt_114] -= 1;
}

}

opt_114 = to;
{
if (opt_114 == opt_114 && opt_114 != 0x0000000000000000000000000000000000000000) {
{
address tmp_116 = opt_114;
assembly {
mstore(add(a_107,mul(sload(index_13_slot),32)),tmp_116)
}

index_13 += 1;
}
sum_ownersToken[opt_114] += 1;
assert(sum_ownersToken[opt_114] >= 1);
}

}

_tokenOwner[tokenId] = opt_114;
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
contract ERC721MetadataWithoutTokenUri is ERC165, ERC721, IERC721Metadata {
string private _name;
string private _symbol;
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

function _burn (address owner, uint256 tokenId) internal {
super._burn(owner, tokenId);
}

}
pragma solidity ^0.5.0;
contract CustomERC721Full is ERC721, ERC721Enumerable, ERC721MetadataWithoutTokenUri {
constructor (string memory name, string memory symbol) ERC721MetadataWithoutTokenUri(name, symbol) public {
}

}
pragma solidity ^0.5.0;
contract BlockCities is CustomERC721Full, WhitelistedRole, IBlockCitiesCreator {
using SafeMath for uint256;
string public tokenBaseURI = "";
event BuildingMinted(
        uint256 indexed _tokenId,
        address indexed _to,
        address indexed _architect
    );
uint256 public totalBuildings = 0;
uint256 public tokenIdPointer = 0;
struct Building {
        uint256 exteriorColorway;
        uint256 backgroundColorway;
        uint256 city;
        uint256 building;
        uint256 base;
        uint256 body;
        uint256 roof;
        uint256 special;
        address architect;
    }
mapping (uint256=>Building) internal buildings;
constructor () CustomERC721Full("BlockCities", "BKC") public {
super.addWhitelisted(msg.sender);
}

function createBuilding (
        uint256 _exteriorColorway,
        uint256 _backgroundColorway,
        uint256 _city,
        uint256 _building,
        uint256 _base,
        uint256 _body,
        uint256 _roof,
        uint256 _special,
        address _architect
    ) onlyWhitelisted public returns (uint256 _tokenId) {
depth_0 += 1;
address[] memory a_117;
if (depth_0 <= 1) assembly {
a_117 := mload(0x40)
mstore(0x40,add(a_117,0x280))
sstore(a_addr_84_slot,a_117)
mstore(a_117,0x260)
}
 else assembly {
a_117 := sload(a_addr_84_slot)
}

uint256 tokenId = tokenIdPointer.add(1);
tokenIdPointer = tokenId;
buildings[tokenId] = Building({ exteriorColorway : _exteriorColorway, backgroundColorway : _backgroundColorway, city : _city, building : _building, base : _base, body : _body, roof : _roof, special : _special, architect : _architect });
totalBuildings = totalBuildings.add(1);
_mint(_architect, tokenId);
emit BuildingMinted(tokenId, _architect, _architect);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_118 = 0; index_118 < index_13; index_118 += 1) {
address tmp_119;
assembly {
tmp_119 := mload(add(a_117,mul(index_118,32)))
}

assert(_ownedTokensCount[tmp_119] == sum_ownersToken[tmp_119]);
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
for (uint256 index_120 = 0; index_120 < index_13; index_120 += 1) {
address tmp_121;
assembly {
tmp_121 := mload(add(a_117,mul(index_120,32)))
}

assert(_ownedTokensCount[tmp_121] == sum_ownersToken[tmp_121]);
}

index_13 = 0;
}

}

}

function mint (address to, uint256 id) public returns (uint) {
depth_0 += 1;
address[] memory a_122;
if (depth_0 <= 1) assembly {
a_122 := mload(0x40)
mstore(0x40,add(a_122,0x280))
sstore(a_addr_84_slot,a_122)
mstore(a_122,0x260)
}
 else assembly {
a_122 := sload(a_addr_84_slot)
}

_mint(to, id);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_123 = 0; index_123 < index_13; index_123 += 1) {
address tmp_124;
assembly {
tmp_124 := mload(add(a_122,mul(index_123,32)))
}

assert(_ownedTokensCount[tmp_124] == sum_ownersToken[tmp_124]);
}

index_13 = 0;
}

}

return id;
}

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_125 = 0; index_125 < index_13; index_125 += 1) {
address tmp_126;
assembly {
tmp_126 := mload(add(a_122,mul(index_125,32)))
}

assert(_ownedTokensCount[tmp_126] == sum_ownersToken[tmp_126]);
}

index_13 = 0;
}

}

}

function tokenURI (uint256 tokenId) external view returns (string memory) {
require(_exists(tokenId));
{
return Strings.strConcat(tokenBaseURI, Strings.uint2str(tokenId));
}

}

function attributes (uint256 _tokenId) public view returns (
        uint256 _exteriorColorway,
        uint256 _backgroundColorway,
        uint256 _city,
        uint256 _building,
        uint256 _base,
        uint256 _body,
        uint256 _roof,
        uint256 _special,
        address _architect
    ) {
require(_exists(_tokenId), "Token ID not found");
Building storage building = buildings[_tokenId];
{
return (
        building.exteriorColorway,
        building.backgroundColorway,
        building.city,
        building.building,
        building.base,
        building.body,
        building.roof,
        building.special,
        building.architect
        );
}

}

function tokensOfOwner (address owner) public view returns (uint256[] memory) {
{
return _tokensOfOwner(owner);
}

}

function burn (uint256 _tokenId) onlyWhitelisted public returns (bool) {
_burn(_tokenId);
delete buildings[_tokenId];
{
return true;
}

}

function updateTokenBaseURI (string memory _newBaseURI) onlyWhitelisted public {
require(bytes(_newBaseURI).length != 0, "Base URI invalid");
tokenBaseURI = _newBaseURI;
}

}
