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
uint256 a_addr_53;
uint256 index_2;
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
address[] memory a_54;
if (depth_0 <= 1) assembly {
a_54 := mload(0x40)
mstore(0x40,add(a_54,0x280))
sstore(a_addr_53_slot,a_54)
mstore(a_54,0x260)
}
 else assembly {
a_54 := sload(a_addr_53_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_55 = 0; index_55 < index_2; index_55 += 1) {
address tmp_56;
assembly {
tmp_56 := mload(add(a_54,mul(index_55,32)))
}

assert(_ownedTokensCount[tmp_56] == sum_ownersToken[tmp_56]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
depth_0 += 1;
address[] memory a_57;
if (depth_0 <= 1) assembly {
a_57 := mload(0x40)
mstore(0x40,add(a_57,0x280))
sstore(a_addr_53_slot,a_57)
mstore(a_57,0x260)
}
 else assembly {
a_57 := sload(a_addr_53_slot)
}

safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_58 = 0; index_58 < index_2; index_58 += 1) {
address tmp_59;
assembly {
tmp_59 := mload(add(a_57,mul(index_58,32)))
}

assert(_ownedTokensCount[tmp_59] == sum_ownersToken[tmp_59]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
depth_0 += 1;
address[] memory a_60;
if (depth_0 <= 1) assembly {
a_60 := mload(0x40)
mstore(0x40,add(a_60,0x280))
sstore(a_addr_53_slot,a_60)
mstore(a_60,0x260)
}
 else assembly {
a_60 := sload(a_addr_53_slot)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_61 = 0; index_61 < index_2; index_61 += 1) {
address tmp_62;
assembly {
tmp_62 := mload(add(a_60,mul(index_61,32)))
}

assert(_ownedTokensCount[tmp_62] == sum_ownersToken[tmp_62]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
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
address[20] memory a_64;
uint256 index_65 = 0;
uint256 tmp_sum_tokenCount_66 = sum_tokenCount;
require(to != address(0));
require(!_exists(tokenId));
{
address opt_63 = _tokenOwner[tokenId];
{
if (opt_63 == opt_63 && opt_63 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_63] >= 1);
{
a_64[index_65] = opt_63;
index_65 += 1;
}
sum_ownersToken[opt_63] -= 1;
}

}

opt_63 = to;
{
if (opt_63 == opt_63 && opt_63 != 0x0000000000000000000000000000000000000000) {
{
a_64[index_65] = opt_63;
index_65 += 1;
}
sum_ownersToken[opt_63] += 1;
assert(sum_ownersToken[opt_63] >= 1);
}

}

_tokenOwner[tokenId] = opt_63;
}

{
uint256 opt_67 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_66 >= opt_67);
tmp_sum_tokenCount_66 -= opt_67;
}

}

{
a_64[index_65] = to;
index_65 += 1;
}

opt_67 = opt_67.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_66 += opt_67;
assert(tmp_sum_tokenCount_66 >= opt_67);
}

}

_ownedTokensCount[to] = opt_67;
}

emit Transfer(address(0), to, tokenId);
sum_tokenCount = tmp_sum_tokenCount_66;
}

function _burn (address owner, uint256 tokenId) internal {
address[] memory a_69;
assembly {
a_69 := sload(a_addr_53_slot)
}

require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
uint256 opt_71 = _ownedTokensCount[owner];
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_71);
sum_tokenCount -= opt_71;
}

}

{
address tmp_70 = owner;
assembly {
mstore(add(a_69,mul(sload(index_2_slot),32)),tmp_70)
}

index_2 += 1;
}

opt_71 = opt_71.sub(1);
{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_71;
assert(sum_tokenCount >= opt_71);
}

}

_ownedTokensCount[owner] = opt_71;
}

{
address opt_73 = _tokenOwner[tokenId];
{
if (opt_73 == opt_73 && opt_73 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_73] >= 1);
{
address tmp_74 = opt_73;
assembly {
mstore(add(a_69,mul(sload(index_2_slot),32)),tmp_74)
}

index_2 += 1;
}
sum_ownersToken[opt_73] -= 1;
}

}

opt_73 = address(0);
{
if (opt_73 == opt_73 && opt_73 != 0x0000000000000000000000000000000000000000) {
{
address tmp_75 = opt_73;
assembly {
mstore(add(a_69,mul(sload(index_2_slot),32)),tmp_75)
}

index_2 += 1;
}
sum_ownersToken[opt_73] += 1;
assert(sum_ownersToken[opt_73] >= 1);
}

}

_tokenOwner[tokenId] = opt_73;
}

emit Transfer(owner, address(0), tokenId);
}

function _burn (uint256 tokenId) internal {
_burn(ownerOf(tokenId), tokenId);
}

function _transferFrom (address from, address to, uint256 tokenId) internal {
address[] memory a_76;
assembly {
a_76 := sload(a_addr_53_slot)
}

require(ownerOf(tokenId) == from);
require(to != address(0));
_clearApproval(tokenId);
{
uint256 opt_78 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_78);
sum_tokenCount -= opt_78;
}

}

{
address tmp_77 = from;
assembly {
mstore(add(a_76,mul(sload(index_2_slot),32)),tmp_77)
}

index_2 += 1;
}

opt_78 = opt_78.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_78;
assert(sum_tokenCount >= opt_78);
}

}

_ownedTokensCount[from] = opt_78;
}

{
uint256 opt_81 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_81);
sum_tokenCount -= opt_81;
}

}

{
address tmp_80 = to;
assembly {
mstore(add(a_76,mul(sload(index_2_slot),32)),tmp_80)
}

index_2 += 1;
}

opt_81 = opt_81.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_81;
assert(sum_tokenCount >= opt_81);
}

}

_ownedTokensCount[to] = opt_81;
}

{
address opt_83 = _tokenOwner[tokenId];
{
if (opt_83 == opt_83 && opt_83 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_83] >= 1);
{
address tmp_84 = opt_83;
assembly {
mstore(add(a_76,mul(sload(index_2_slot),32)),tmp_84)
}

index_2 += 1;
}
sum_ownersToken[opt_83] -= 1;
}

}

opt_83 = to;
{
if (opt_83 == opt_83 && opt_83 != 0x0000000000000000000000000000000000000000) {
{
address tmp_85 = opt_83;
assembly {
mstore(add(a_76,mul(sload(index_2_slot),32)),tmp_85)
}

index_2 += 1;
}
sum_ownersToken[opt_83] += 1;
assert(sum_ownersToken[opt_83] >= 1);
}

}

_tokenOwner[tokenId] = opt_83;
}

emit Transfer(from, to, tokenId);
}

function _checkOnERC721Received (address from, address to, uint256 tokenId, bytes memory _data) internal returns (bool) {
if (!to.isContract()) {
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

_ownedTokens[from].length--;
}

function _removeTokenFromAllTokensEnumeration (uint256 tokenId) private {
uint256 lastTokenIndex = _allTokens.length.sub(1);
uint256 tokenIndex = _allTokensIndex[tokenId];
uint256 lastTokenId = _allTokens[lastTokenIndex];
_allTokens[tokenIndex] = lastTokenId;
_allTokensIndex[lastTokenId] = tokenIndex;
_allTokens.length--;
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
require(!has(role, account));
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
address[] memory a_86;
if (depth_0 <= 1) assembly {
a_86 := mload(0x40)
mstore(0x40,add(a_86,0x280))
sstore(a_addr_53_slot,a_86)
mstore(a_86,0x260)
}
 else assembly {
a_86 := sload(a_addr_53_slot)
}

_mint(to, tokenId);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_87 = 0; index_87 < index_2; index_87 += 1) {
address tmp_88;
assembly {
tmp_88 := mload(add(a_86,mul(index_87,32)))
}

assert(_ownedTokensCount[tmp_88] == sum_ownersToken[tmp_88]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_89 = 0; index_89 < index_2; index_89 += 1) {
address tmp_90;
assembly {
tmp_90 := mload(add(a_86,mul(index_89,32)))
}

assert(_ownedTokensCount[tmp_90] == sum_ownersToken[tmp_90]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

}

}
pragma solidity ^0.5.0;
contract ERC721MetadataMintable is ERC721, ERC721Metadata, MinterRole {
function mintWithTokenURI (address to, uint256 tokenId, string memory tokenURI) onlyMinter public returns (bool) {
depth_0 += 1;
address[] memory a_91;
if (depth_0 <= 1) assembly {
a_91 := mload(0x40)
mstore(0x40,add(a_91,0x280))
sstore(a_addr_53_slot,a_91)
mstore(a_91,0x260)
}
 else assembly {
a_91 := sload(a_addr_53_slot)
}

_mint(to, tokenId);
_setTokenURI(tokenId, tokenURI);
{
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_92 = 0; index_92 < index_2; index_92 += 1) {
address tmp_93;
assembly {
tmp_93 := mload(add(a_91,mul(index_92,32)))
}

assert(_ownedTokensCount[tmp_93] == sum_ownersToken[tmp_93]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

return true;
}

depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_94 = 0; index_94 < index_2; index_94 += 1) {
address tmp_95;
assembly {
tmp_95 := mload(add(a_91,mul(index_94,32)))
}

assert(_ownedTokensCount[tmp_95] == sum_ownersToken[tmp_95]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
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
address[] memory a_96;
if (depth_0 <= 1) assembly {
a_96 := mload(0x40)
mstore(0x40,add(a_96,0x280))
sstore(a_addr_53_slot,a_96)
mstore(a_96,0x260)
}
 else assembly {
a_96 := sload(a_addr_53_slot)
}

_mint(_to, _tokenId);
_setTokenURI(_tokenId, _tokenURI);
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_97 = 0; index_97 < index_2; index_97 += 1) {
address tmp_98;
assembly {
tmp_98 := mload(add(a_96,mul(index_97,32)))
}

assert(_ownedTokensCount[tmp_98] == sum_ownersToken[tmp_98]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

}

function transfer (address _to, uint256 _tokenId) public {
depth_0 += 1;
address[] memory a_99;
if (depth_0 <= 1) assembly {
a_99 := mload(0x40)
mstore(0x40,add(a_99,0x280))
sstore(a_addr_53_slot,a_99)
mstore(a_99,0x260)
}
 else assembly {
a_99 := sload(a_addr_53_slot)
}

safeTransferFrom(msg.sender, _to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_100 = 0; index_100 < index_2; index_100 += 1) {
address tmp_101;
assembly {
tmp_101 := mload(add(a_99,mul(index_100,32)))
}

assert(_ownedTokensCount[tmp_101] == sum_ownersToken[tmp_101]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

}

function transferAll (address _to, uint256[] memory _tokenId) public {
depth_0 += 1;
address[] memory a_102;
if (depth_0 <= 1) assembly {
a_102 := mload(0x40)
mstore(0x40,add(a_102,0x280))
sstore(a_addr_53_slot,a_102)
mstore(a_102,0x260)
}
 else assembly {
a_102 := sload(a_addr_53_slot)
}

for (uint i = 0; i < _tokenId.length; i++) {
safeTransferFrom(msg.sender, _to, _tokenId[i]);
}

depth_0 -= 1;
if (depth_0 == 0) {
{
for (uint256 index_103 = 0; index_103 < index_2; index_103 += 1) {
address tmp_104;
assembly {
tmp_104 := mload(add(a_102,mul(index_103,32)))
}

assert(_ownedTokensCount[tmp_104] == sum_ownersToken[tmp_104]);
}

index_2 = 0;
}

assert(sum_tokenCount == _allTokens.length);
}

}

}
