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
uint256 memoryStart_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
address[] a;
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
uint256 tmp_168;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_168 := mload(0x40)
mstore(0x40, add(tmp_168, 640))
sstore(memoryStart_0_slot, tmp_168)
mstore(add(tmp_168, 0), 0)
}

}

require(_isApprovedOrOwner(msg.sender, tokenId));
_transferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_167 = 0; index_167 < a.length; index_167 += 1) {
assert(_ownedTokensCount[a[index_167]] == sum_ownersToken[a[index_167]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_171;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_171 := mload(0x40)
mstore(0x40, add(tmp_171, 640))
sstore(memoryStart_0_slot, tmp_171)
mstore(add(tmp_171, 0), 0)
}

}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_170 = 0; index_170 < a.length; index_170 += 1) {
assert(_ownedTokensCount[a[index_170]] == sum_ownersToken[a[index_170]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
uint256 entry_1 = 0;
uint256 tmp_174;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_174 := mload(0x40)
mstore(0x40, add(tmp_174, 640))
sstore(memoryStart_0_slot, tmp_174)
mstore(add(tmp_174, 0), 0)
}

}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_173 = 0; index_173 < a.length; index_173 += 1) {
assert(_ownedTokensCount[a[index_173]] == sum_ownersToken[a[index_173]]);
}

a.length = 0;
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
{
if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
{
a.push(_tokenOwner[tokenId]);
}
sum_ownersToken[_tokenOwner[tokenId]] -= 1;
}

}
_tokenOwner[tokenId] = to;{
if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
{
a.push(_tokenOwner[tokenId]);
}
sum_ownersToken[_tokenOwner[tokenId]] += 1;
assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
}

}

{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= _ownedTokensCount[to]);
sum_tokenCount -= _ownedTokensCount[to];
}

}
{
a.push(to);
}
_ownedTokensCount[to] = _ownedTokensCount[to].add(1);{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += _ownedTokensCount[to];
assert(sum_tokenCount >= _ownedTokensCount[to]);
}

}

emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
require(ownerOf(tokenId) == owner);
_clearApproval(tokenId);
{
if (owner != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= _ownedTokensCount[owner]);
sum_tokenCount -= _ownedTokensCount[owner];
}

}
{
a.push(owner);
}
_ownedTokensCount[owner] = _ownedTokensCount[owner].sub(1);{
if (owner != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += _ownedTokensCount[owner];
assert(sum_tokenCount >= _ownedTokensCount[owner]);
}

}

{
if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
{
a.push(_tokenOwner[tokenId]);
}
sum_ownersToken[_tokenOwner[tokenId]] -= 1;
}

}
_tokenOwner[tokenId] = address(0);{
if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
{
a.push(_tokenOwner[tokenId]);
}
sum_ownersToken[_tokenOwner[tokenId]] += 1;
assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
}

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
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= _ownedTokensCount[from]);
sum_tokenCount -= _ownedTokensCount[from];
}

}
{
a.push(from);
}
_ownedTokensCount[from] = _ownedTokensCount[from].sub(1);{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += _ownedTokensCount[from];
assert(sum_tokenCount >= _ownedTokensCount[from]);
}

}

{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= _ownedTokensCount[to]);
sum_tokenCount -= _ownedTokensCount[to];
}

}
{
a.push(to);
}
_ownedTokensCount[to] = _ownedTokensCount[to].add(1);{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += _ownedTokensCount[to];
assert(sum_tokenCount >= _ownedTokensCount[to]);
}

}

{
if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
{
a.push(_tokenOwner[tokenId]);
}
sum_ownersToken[_tokenOwner[tokenId]] -= 1;
}

}
_tokenOwner[tokenId] = to;{
if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
{
a.push(_tokenOwner[tokenId]);
}
sum_ownersToken[_tokenOwner[tokenId]] += 1;
assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
}

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
uint256 entry_1 = 0;
uint256 tmp_181;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_181 := mload(0x40)
mstore(0x40, add(tmp_181, 640))
sstore(memoryStart_0_slot, tmp_181)
mstore(add(tmp_181, 0), 0)
}

}

uint256 tokenId = tokenIdPointer.add(1);
tokenIdPointer = tokenId;
buildings[tokenId] = Building({ exteriorColorway : _exteriorColorway, backgroundColorway : _backgroundColorway, city : _city, building : _building, base : _base, body : _body, roof : _roof, special : _special, architect : _architect });
totalBuildings = totalBuildings.add(1);
_mint(_architect, tokenId);
emit BuildingMinted(tokenId, _architect, _architect);
{
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_179 = 0; index_179 < a.length; index_179 += 1) {
assert(_ownedTokensCount[a[index_179]] == sum_ownersToken[a[index_179]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

return tokenId;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_180 = 0; index_180 < a.length; index_180 += 1) {
assert(_ownedTokensCount[a[index_180]] == sum_ownersToken[a[index_180]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

}

function mint (address to, uint256 id) public returns (uint) {
uint256 entry_1 = 0;
uint256 tmp_185;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_185 := mload(0x40)
mstore(0x40, add(tmp_185, 640))
sstore(memoryStart_0_slot, tmp_185)
mstore(add(tmp_185, 0), 0)
}

}

_mint(to, id);
{
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_183 = 0; index_183 < a.length; index_183 += 1) {
assert(_ownedTokensCount[a[index_183]] == sum_ownersToken[a[index_183]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

return id;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_184 = 0; index_184 < a.length; index_184 += 1) {
assert(_ownedTokensCount[a[index_184]] == sum_ownersToken[a[index_184]]);
}

a.length = 0;
}

memoryStart_0 = 0;
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
