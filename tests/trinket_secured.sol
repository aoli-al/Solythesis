pragma solidity ^0.5.0;
library Address {
function isContract (address addr) internal view returns (bool) {
uint256 size;
assembly {
size := extcodesize(addr)
}

{
return size > 0;
}

}

}
contract Ownable {
address public owner;
constructor () public {
owner = msg.sender;
}

function setOwner (address _owner) onlyOwner public {
owner = _owner;
}

function getOwner () public view returns (address) {
{
return owner;
}

}

modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}
library SafeMath {
function mul (uint256 a, uint256 b) internal pure returns (uint256 c) {
if (a == 0) {
{
return 0;
}

}

c = a * b;
assert(c / a == b);
{
return c;
}

}

function div (uint256 a, uint256 b) internal pure returns (uint256) {
{
return a / b;
}

}

function sub (uint256 a, uint256 b) internal pure returns (uint256) {
assert(b <= a);
{
return a - b;
}

}

function add (uint256 a, uint256 b) internal pure returns (uint256 c) {
c = a + b;
assert(c >= a);
{
return c;
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
interface IERC165 {
function supportsInterface (bytes4 _interfaceId) external view returns (bool);
}
contract IERC721Receiver {
bytes4 internal constant ERC721_RECEIVED = 0x150b7a02;
function onERC721Received (
        address _operator,
        address _from,
        uint256 _tokenId,
        bytes memory _data
    ) public returns(bytes4);
}
contract IERC721Holder is IERC721Receiver {
function onERC721Received (address, address, uint256, bytes memory) public returns(bytes4) {
{
return ERC721_RECEIVED;
}

}

}
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
contract IERC721Enumerable is IERC721 {
function totalSupply () public view returns (uint256);
function tokenOfOwnerByIndex (
        address _owner,
        uint256 _index
    ) public view returns (uint256 _tokenId);
function tokenByIndex (uint256 _index) public view returns (uint256);
}
contract IERC721Metadata is IERC721 {
function name () external view returns (string memory _name);
function symbol () external view returns (string memory _symbol);
function tokenURI (uint256 _tokenId) public view returns (string memory);
}
contract SupportsInterfaceWithLookup is IERC165 {
bytes4 public constant InterfaceId_ERC165 = 0x01ffc9a7;
mapping (bytes4=>bool) internal supportedInterfaces;
constructor () public {
_registerInterface(InterfaceId_ERC165);
}

function supportsInterface (bytes4 _interfaceId) external view returns (bool) {
{
return supportedInterfaces[_interfaceId];
}

}

function _registerInterface (bytes4 _interfaceId) internal {
require(_interfaceId != 0xffffffff);
supportedInterfaces[_interfaceId] = true;
}

}
contract Delegate {
function mint (address _sender, address _to) public returns (bool);
function approve (address _sender, address _to, uint256 _tokenId) public returns (bool);
function setApprovalForAll (address _sender, address _operator, bool _approved) public returns (bool);
function transferFrom (address _sender, address _from, address _to, uint256 _tokenId) public returns (bool);
function safeTransferFrom (address _sender, address _from, address _to, uint256 _tokenId) public returns (bool);
function safeTransferFrom (address _sender, address _from, address _to, uint256 _tokenId, bytes memory _data) public returns (bool);
}
contract ERC165 is IERC165 {
bytes4 private constant _InterfaceId_ERC165 = 0x01ffc9a7;
mapping (bytes4=>bool) private _supportedInterfaces;
constructor () internal {
_registerInterface(_InterfaceId_ERC165);
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
contract ERC721 is ERC165, IERC721 {
uint256 memoryStart_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_119;
using SafeMath for uint256;
using Address for address;
bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
mapping (uint256=>address) internal _tokenOwner;
mapping (uint256=>address) internal _tokenApprovals;
mapping (address=>uint256) internal _ownedTokensCount;
mapping (address=>mapping (address=>bool)) private _operatorApprovals;
bytes4 private constant _InterfaceId_ERC721 = 0x80ac58cd;
constructor () public {
_registerInterface(_InterfaceId_ERC721);
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

function isApprovedForAll (
        address owner,
        address operator
    ) public view returns (bool) {
{
return _operatorApprovals[owner][operator];
}

}

function transferFrom (
        address from,
        address to,
        uint256 tokenId
    ) public {
uint256 entry_1 = 0;
uint256 tmp_123;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_123 := mload(0x40)
mstore(0x40, add(tmp_123, 640))
sstore(memoryStart_0_slot, tmp_123)
mstore(add(tmp_123, 0), 0)
}

}

address[] memory a_120;
assembly {
a_120 := add(sload(memoryStart_0_slot), 0)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
require(to != address(0));
_clearApproval(from, tokenId);
_removeTokenFrom(from, tokenId);
_addTokenTo(to, tokenId);
emit Transfer(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_121 = 0; index_121 < a_120.length; index_121 += 1) {
address tmp_122;
assembly {
tmp_122 := mload(add(a_120, mul(add(index_121, 1), 32)))
}

assert(_ownedTokensCount[tmp_122] == sum_ownersToken[tmp_122]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (
        address from,
        address to,
        uint256 tokenId
    ) public {
uint256 entry_1 = 0;
uint256 tmp_127;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_127 := mload(0x40)
mstore(0x40, add(tmp_127, 640))
sstore(memoryStart_0_slot, tmp_127)
mstore(add(tmp_127, 0), 0)
}

}

address[] memory a_124;
assembly {
a_124 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_125 = 0; index_125 < a_124.length; index_125 += 1) {
address tmp_126;
assembly {
tmp_126 := mload(add(a_124, mul(add(index_125, 1), 32)))
}

assert(_ownedTokensCount[tmp_126] == sum_ownersToken[tmp_126]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public {
uint256 entry_1 = 0;
uint256 tmp_131;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_131 := mload(0x40)
mstore(0x40, add(tmp_131, 640))
sstore(memoryStart_0_slot, tmp_131)
mstore(add(tmp_131, 0), 0)
}

}

address[] memory a_128;
assembly {
a_128 := add(sload(memoryStart_0_slot), 0)
}

transferFrom(from, to, tokenId);
require(_checkAndCallSafeTransfer(from, to, tokenId, _data));
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_129 = 0; index_129 < a_128.length; index_129 += 1) {
address tmp_130;
assembly {
tmp_130 := mload(add(a_128, mul(add(index_129, 1), 32)))
}

assert(_ownedTokensCount[tmp_130] == sum_ownersToken[tmp_130]);
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

function _isApprovedOrOwner (
        address spender,
        uint256 tokenId
    ) internal view returns (bool) {
address owner = ownerOf(tokenId);
{
return (
        spender == owner ||
        getApproved(tokenId) == spender ||
        isApprovedForAll(owner, spender)
        );
}

}

function _mint (address to, uint256 tokenId) internal {
require(to != address(0));
_addTokenTo(to, tokenId);
emit Transfer(address(0), to, tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
_clearApproval(owner, tokenId);
_removeTokenFrom(owner, tokenId);
emit Transfer(owner, address(0), tokenId);
}

function _clearApproval (address owner, uint256 tokenId) internal {
require(ownerOf(tokenId) == owner);
if (_tokenApprovals[tokenId] != address(0)) {
_tokenApprovals[tokenId] = address(0);
}

}

function _addTokenTo (address to, uint256 tokenId) internal {
address[] memory a_133;
assembly {
a_133 := add(sload(memoryStart_0_slot), 0)
}

require(_tokenOwner[tokenId] == address(0));
{
address opt_132 = _tokenOwner[tokenId];
{
if (opt_132 == opt_132 && opt_132 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_132] >= 1);
{
address tmp_134 = opt_132;
assembly {
let tmp := add(mload(a_133), 1)
mstore(a_133, tmp)
mstore(add(a_133, mul(tmp, 32)), tmp_134)
}

}
sum_ownersToken[opt_132] -= 1;
}

}

opt_132 = to;
{
if (opt_132 == opt_132 && opt_132 != 0x0000000000000000000000000000000000000000) {
{
address tmp_135 = opt_132;
assembly {
let tmp := add(mload(a_133), 1)
mstore(a_133, tmp)
mstore(add(a_133, mul(tmp, 32)), tmp_135)
}

}
sum_ownersToken[opt_132] += 1;
assert(sum_ownersToken[opt_132] >= 1);
}

}

_tokenOwner[tokenId] = opt_132;
}

{
uint256 opt_137 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_137);
sum_tokenCount -= opt_137;
}

}

{
address tmp_136 = to;
assembly {
let tmp := add(mload(a_133), 1)
mstore(a_133, tmp)
mstore(add(a_133, mul(tmp, 32)), tmp_136)
}

}

opt_137 = opt_137.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_137;
assert(sum_tokenCount >= opt_137);
}

}

_ownedTokensCount[to] = opt_137;
}

}

function _removeTokenFrom (address from, uint256 tokenId) internal {
address[] memory a_139;
assembly {
a_139 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == from);
{
uint256 opt_141 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_141);
sum_tokenCount -= opt_141;
}

}

{
address tmp_140 = from;
assembly {
let tmp := add(mload(a_139), 1)
mstore(a_139, tmp)
mstore(add(a_139, mul(tmp, 32)), tmp_140)
}

}

opt_141 = opt_141.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_141;
assert(sum_tokenCount >= opt_141);
}

}

_ownedTokensCount[from] = opt_141;
}

{
address opt_143 = _tokenOwner[tokenId];
{
if (opt_143 == opt_143 && opt_143 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_143] >= 1);
{
address tmp_144 = opt_143;
assembly {
let tmp := add(mload(a_139), 1)
mstore(a_139, tmp)
mstore(add(a_139, mul(tmp, 32)), tmp_144)
}

}
sum_ownersToken[opt_143] -= 1;
}

}

opt_143 = address(0);
{
if (opt_143 == opt_143 && opt_143 != 0x0000000000000000000000000000000000000000) {
{
address tmp_145 = opt_143;
assembly {
let tmp := add(mload(a_139), 1)
mstore(a_139, tmp)
mstore(add(a_139, mul(tmp, 32)), tmp_145)
}

}
sum_ownersToken[opt_143] += 1;
assert(sum_ownersToken[opt_143] >= 1);
}

}

_tokenOwner[tokenId] = opt_143;
}

}

function _checkAndCallSafeTransfer (
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal returns (bool) {
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

}
contract ERC721Enumerable is ERC165, ERC721, IERC721Enumerable {
mapping (address=>uint256[]) private _ownedTokens;
mapping (uint256=>uint256) private _ownedTokensIndex;
mapping (uint256=>uint256) private _allTokensIndex;
bytes4 private constant _InterfaceId_ERC721Enumerable = 0x780e9d63;
constructor () public {
_registerInterface(_InterfaceId_ERC721Enumerable);
}

function tokenOfOwnerByIndex (
        address owner,
        uint256 index
    ) public view returns (uint256) {
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

function _addTokenTo (address to, uint256 tokenId) internal {
super._addTokenTo(to, tokenId);
uint256 length = _ownedTokens[to].length;
_ownedTokens[to].push(tokenId);
_ownedTokensIndex[tokenId] = length;
}

function _removeTokenFrom (address from, uint256 tokenId) internal {
super._removeTokenFrom(from, tokenId);
uint256 tokenIndex = _ownedTokensIndex[tokenId];
uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
uint256 lastToken = _ownedTokens[from][lastTokenIndex];
_ownedTokens[from][tokenIndex] = lastToken;
_ownedTokens[from].length --;
_ownedTokensIndex[tokenId] = 0;
_ownedTokensIndex[lastToken] = tokenIndex;
}

function _mint (address to, uint256 tokenId) internal {
super._mint(to, tokenId);
_allTokensIndex[tokenId] = _allTokens.length;
_allTokens.push(tokenId);
}

function _burn (address owner, uint256 tokenId) internal {
super._burn(owner, tokenId);
uint256 tokenIndex = _allTokensIndex[tokenId];
uint256 lastTokenIndex = _allTokens.length.sub(1);
uint256 lastToken = _allTokens[lastTokenIndex];
_allTokens[tokenIndex] = lastToken;
_allTokens[lastTokenIndex] = 0;
_allTokens.length --;
_allTokensIndex[tokenId] = 0;
_allTokensIndex[lastToken] = tokenIndex;
}

}
contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
string internal _name;
string internal _symbol;
mapping (uint256=>string) private _tokenURIs;
bytes4 private constant InterfaceId_ERC721Metadata = 0x5b5e139f;
constructor (string memory name, string memory symbol) public {
_name = name;
_symbol = symbol;
_registerInterface(InterfaceId_ERC721Metadata);
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

function tokenURI (uint256 tokenId) public view returns (string memory) {
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
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
constructor (string memory name, string memory symbol) ERC721Metadata(name, symbol) public {
}

}
contract Collectables is ERC721Full("GU Collectable", "TRINKET"), Ownable {
using Strings for string;
mapping (uint32=>address) public delegates;
uint32[] public collectables;
uint public delegateCount;
constructor () public {
}

event DelegateAdded(address indexed delegate, uint32 indexed delegateID);
function addDelegate (address delegate) onlyOwner public {
uint32 delegateID = uint32(delegateCount ++);
require(delegates[delegateID] == address(0), "delegate is already set for collectable type");
delegates[delegateID] = delegate;
emit DelegateAdded(delegate, delegateID);
}

function mint_d (uint32 delegateID, address to) public returns (uint) {
uint256 entry_1 = 0;
uint256 tmp_151;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_151 := mload(0x40)
mstore(0x40, add(tmp_151, 640))
sstore(memoryStart_0_slot, tmp_151)
mstore(add(tmp_151, 0), 0)
}

}

address[] memory a_146;
assembly {
a_146 := add(sload(memoryStart_0_slot), 0)
}

Delegate delegate = getDelegate(delegateID);
require(delegate.mint(msg.sender, to), "delegate could not mint token");
uint id = collectables.push(delegateID) - 1;
super._mint(to, id);
{
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_147 = 0; index_147 < a_146.length; index_147 += 1) {
address tmp_148;
assembly {
tmp_148 := mload(add(a_146, mul(add(index_147, 1), 32)))
}

assert(_ownedTokensCount[tmp_148] == sum_ownersToken[tmp_148]);
}

memoryStart_0 = 0;
}

return id;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_149 = 0; index_149 < a_146.length; index_149 += 1) {
address tmp_150;
assembly {
tmp_150 := mload(add(a_146, mul(add(index_149, 1), 32)))
}

assert(_ownedTokensCount[tmp_150] == sum_ownersToken[tmp_150]);
}

memoryStart_0 = 0;
}

}

function mint (address to, uint256 id) public returns (uint) {
uint256 entry_1 = 0;
uint256 tmp_157;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_157 := mload(0x40)
mstore(0x40, add(tmp_157, 640))
sstore(memoryStart_0_slot, tmp_157)
mstore(add(tmp_157, 0), 0)
}

}

address[] memory a_152;
assembly {
a_152 := add(sload(memoryStart_0_slot), 0)
}

super._mint(to, id);
{
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_153 = 0; index_153 < a_152.length; index_153 += 1) {
address tmp_154;
assembly {
tmp_154 := mload(add(a_152, mul(add(index_153, 1), 32)))
}

assert(_ownedTokensCount[tmp_154] == sum_ownersToken[tmp_154]);
}

memoryStart_0 = 0;
}

return id;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_155 = 0; index_155 < a_152.length; index_155 += 1) {
address tmp_156;
assembly {
tmp_156 := mload(add(a_152, mul(add(index_155, 1), 32)))
}

assert(_ownedTokensCount[tmp_156] == sum_ownersToken[tmp_156]);
}

memoryStart_0 = 0;
}

}

function transferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_161;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_161 := mload(0x40)
mstore(0x40, add(tmp_161, 640))
sstore(memoryStart_0_slot, tmp_161)
mstore(add(tmp_161, 0), 0)
}

}

address[] memory a_158;
assembly {
a_158 := add(sload(memoryStart_0_slot), 0)
}

super.transferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_159 = 0; index_159 < a_158.length; index_159 += 1) {
address tmp_160;
assembly {
tmp_160 := mload(add(a_158, mul(add(index_159, 1), 32)))
}

assert(_ownedTokensCount[tmp_160] == sum_ownersToken[tmp_160]);
}

memoryStart_0 = 0;
}

}

function approve (address to, uint256 tokenId) public {
Delegate delegate = getTokenDelegate(tokenId);
require(delegate.approve(msg.sender, to, tokenId), "could not approve token");
super.approve(to, tokenId);
}

function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory data) public {
uint256 entry_1 = 0;
uint256 tmp_165;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_165 := mload(0x40)
mstore(0x40, add(tmp_165, 640))
sstore(memoryStart_0_slot, tmp_165)
mstore(add(tmp_165, 0), 0)
}

}

address[] memory a_162;
assembly {
a_162 := add(sload(memoryStart_0_slot), 0)
}

Delegate delegate = getTokenDelegate(tokenId);
require(delegate.safeTransferFrom(msg.sender, from, to, tokenId, data), "could not safe transfer token");
super.safeTransferFrom(from, to, tokenId, data);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_163 = 0; index_163 < a_162.length; index_163 += 1) {
address tmp_164;
assembly {
tmp_164 := mload(add(a_162, mul(add(index_163, 1), 32)))
}

assert(_ownedTokensCount[tmp_164] == sum_ownersToken[tmp_164]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (address from, address to, uint256 tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_169;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_169 := mload(0x40)
mstore(0x40, add(tmp_169, 640))
sstore(memoryStart_0_slot, tmp_169)
mstore(add(tmp_169, 0), 0)
}

}

address[] memory a_166;
assembly {
a_166 := add(sload(memoryStart_0_slot), 0)
}

Delegate delegate = getTokenDelegate(tokenId);
require(delegate.safeTransferFrom(msg.sender, from, to, tokenId), "could not safe transfer token");
super.safeTransferFrom(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_167 = 0; index_167 < a_166.length; index_167 += 1) {
address tmp_168;
assembly {
tmp_168 := mload(add(a_166, mul(add(index_167, 1), 32)))
}

assert(_ownedTokensCount[tmp_168] == sum_ownersToken[tmp_168]);
}

memoryStart_0 = 0;
}

}

function getTokenDelegate (uint id) public view returns (Delegate) {
address d = delegates[collectables[id]];
require(d != address(0), "invalid delegate");
{
return Delegate(d);
}

}

function getDelegate (uint32 id) public view returns (Delegate) {
address d = delegates[id];
require(d != address(0), "invalid delegate");
{
return Delegate(d);
}

}

string public constant tokenMetadataBaseURI = "https://api.godsunchained.com/collectable/";
function tokenURI (uint256 _tokenId) public view returns (string memory) {
require(_exists(_tokenId), "token doesn't exist");
{
return Strings.strConcat(
            tokenMetadataBaseURI,
            Strings.uint2str(_tokenId)
        );
}

}

}
