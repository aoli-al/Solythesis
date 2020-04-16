pragma solidity ^0.5.0;
interface IERC165 {
function supportsInterface (bytes4 interfaceId) external view returns (bool);
}
contract IERC721 is IERC165 {
event Transfer(
    address indexed from,
    address indexed to,
    uint256 indexed tokenId
  );
event Approval(
    address indexed owner,
    address indexed approved,
    uint256 indexed tokenId
  );
event ApprovalForAll(
    address indexed owner,
    address indexed operator,
    bool approved
  );
uint256[] internal _allTokens;
function balanceOf (address owner) public view returns (uint256 balance);
function ownerOf (uint256 tokenId) public view returns (address owner);
function approve (address to, uint256 tokenId) public;
function getApproved (uint256 tokenId) public view returns (address operator);
function setApprovalForAll (address operator, bool _approved) public;
function isApprovedForAll (address owner, address operator) public view returns (bool);
function transferFrom (address from, address to, uint256 tokenId) public;
function safeTransferFrom (address from, address to, uint256 tokenId) public;
function safeTransferFrom (
    address from,
    address to,
    uint256 tokenId,
    bytes memory data
  ) public;
}
contract IERC721Receiver {
function onERC721Received (
    address operator,
    address from,
    uint256 tokenId,
    bytes memory data
  ) public returns(bytes4);
}
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
uint256 a_addr_90;
using SafeMath for uint256;
using Address for address;
bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
mapping (uint256=>address) public _tokenOwner;
mapping (uint256=>address) private _tokenApprovals;
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
uint256 tmp_94;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_94 := mload(0x40)
mstore(0x40, add(tmp_94, 640))
sstore(memoryStart_0_slot, tmp_94)
mstore(add(tmp_94, 0), 0)
}

}

address[] memory a_91;
assembly {
a_91 := add(sload(memoryStart_0_slot), 0)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
require(to != address(0));
_clearApproval(from, tokenId);
_removeTokenFrom(from, tokenId);
_addTokenTo(to, tokenId);
emit Transfer(from, to, tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_92 = 0; index_92 < a_91.length; index_92 += 1) {
address tmp_93;
assembly {
tmp_93 := mload(add(a_91, mul(add(index_92, 1), 32)))
}

assert(_ownedTokensCount[tmp_93] == sum_ownersToken[tmp_93]);
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
uint256 tmp_98;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_98 := mload(0x40)
mstore(0x40, add(tmp_98, 640))
sstore(memoryStart_0_slot, tmp_98)
mstore(add(tmp_98, 0), 0)
}

}

address[] memory a_95;
assembly {
a_95 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(from, to, tokenId, "");
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_96 = 0; index_96 < a_95.length; index_96 += 1) {
address tmp_97;
assembly {
tmp_97 := mload(add(a_95, mul(add(index_96, 1), 32)))
}

assert(_ownedTokensCount[tmp_97] == sum_ownersToken[tmp_97]);
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
uint256 tmp_102;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_102 := mload(0x40)
mstore(0x40, add(tmp_102, 640))
sstore(memoryStart_0_slot, tmp_102)
mstore(add(tmp_102, 0), 0)
}

}

address[] memory a_99;
assembly {
a_99 := add(sload(memoryStart_0_slot), 0)
}

transferFrom(from, to, tokenId);
require(_checkOnERC721Received(from, to, tokenId, _data));
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_100 = 0; index_100 < a_99.length; index_100 += 1) {
address tmp_101;
assembly {
tmp_101 := mload(add(a_99, mul(add(index_100, 1), 32)))
}

assert(_ownedTokensCount[tmp_101] == sum_ownersToken[tmp_101]);
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

function _addTokenTo (address to, uint256 tokenId) internal {
address[] memory a_104;
assembly {
a_104 := add(sload(memoryStart_0_slot), 0)
}

require(_tokenOwner[tokenId] == address(0));
{
address opt_103 = _tokenOwner[tokenId];
{
if (opt_103 == opt_103 && opt_103 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_103] >= 1);
{
address tmp_105 = opt_103;
assembly {
let tmp := add(mload(a_104), 1)
mstore(a_104, tmp)
mstore(add(a_104, mul(tmp, 32)), tmp_105)
}

}
sum_ownersToken[opt_103] -= 1;
}

}

opt_103 = to;
{
if (opt_103 == opt_103 && opt_103 != 0x0000000000000000000000000000000000000000) {
{
address tmp_106 = opt_103;
assembly {
let tmp := add(mload(a_104), 1)
mstore(a_104, tmp)
mstore(add(a_104, mul(tmp, 32)), tmp_106)
}

}
sum_ownersToken[opt_103] += 1;
assert(sum_ownersToken[opt_103] >= 1);
}

}

_tokenOwner[tokenId] = opt_103;
}

{
uint256 opt_108 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_108);
sum_tokenCount -= opt_108;
}

}

{
address tmp_107 = to;
assembly {
let tmp := add(mload(a_104), 1)
mstore(a_104, tmp)
mstore(add(a_104, mul(tmp, 32)), tmp_107)
}

}

opt_108 = opt_108.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_108;
assert(sum_tokenCount >= opt_108);
}

}

_ownedTokensCount[to] = opt_108;
}

}

function _removeTokenFrom (address from, uint256 tokenId) internal {
address[] memory a_110;
assembly {
a_110 := add(sload(memoryStart_0_slot), 0)
}

require(ownerOf(tokenId) == from);
{
uint256 opt_112 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= opt_112);
sum_tokenCount -= opt_112;
}

}

{
address tmp_111 = from;
assembly {
let tmp := add(mload(a_110), 1)
mstore(a_110, tmp)
mstore(add(a_110, mul(tmp, 32)), tmp_111)
}

}

opt_112 = opt_112.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += opt_112;
assert(sum_tokenCount >= opt_112);
}

}

_ownedTokensCount[from] = opt_112;
}

{
address opt_114 = _tokenOwner[tokenId];
{
if (opt_114 == opt_114 && opt_114 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_114] >= 1);
{
address tmp_115 = opt_114;
assembly {
let tmp := add(mload(a_110), 1)
mstore(a_110, tmp)
mstore(add(a_110, mul(tmp, 32)), tmp_115)
}

}
sum_ownersToken[opt_114] -= 1;
}

}

opt_114 = address(0);
{
if (opt_114 == opt_114 && opt_114 != 0x0000000000000000000000000000000000000000) {
{
address tmp_116 = opt_114;
assembly {
let tmp := add(mload(a_110), 1)
mstore(a_110, tmp)
mstore(add(a_110, mul(tmp, 32)), tmp_116)
}

}
sum_ownersToken[opt_114] += 1;
assert(sum_ownersToken[opt_114] >= 1);
}

}

_tokenOwner[tokenId] = opt_114;
}

}

function _checkOnERC721Received (
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

function _clearApproval (address owner, uint256 tokenId) private {
require(ownerOf(tokenId) == owner);
if (_tokenApprovals[tokenId] != address(0)) {
_tokenApprovals[tokenId] = address(0);
}

}

}
contract IERC721Enumerable is IERC721, ERC721 {
function totalSupply () public view returns (uint256);
function tokenOfOwnerByIndex (
    address owner,
    uint256 index
  ) public view returns (uint256 tokenId);
function tokenByIndex (uint256 index) public view returns (uint256);
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
contract IERC721Metadata is IERC721 {
function name () external view returns (string memory);
function symbol () external view returns (string memory);
function tokenURI (uint256 tokenId) external view returns (string memory);
}
contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
string private _name;
string private _symbol;
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
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
constructor (string memory name, string memory symbol) ERC721Metadata(name, symbol) public {
}

}
contract Landemic is ERC721Full("Landemic","LAND") {
uint256 public _basePrice = 810000000000000;
uint8 public _bountyDivisor = 20;
uint16 public _defaultMultiple = 100;
address public _owner = msg.sender;
string public _baseURL = "https://landemic.io/";
struct Price {
        uint240 lastPrice;
        uint16 multiple;
    }
mapping (uint256=>Price) public _prices;
constructor () public {
}

mapping (address=>uint256) public failedPayouts;
uint256 public failedPayoutsSum;
modifier onlyContractOwner() {
        require(msg.sender == _owner);
        _;
    }
function _lastPrice (uint256 tokenId) public view returns (uint256) {
{
return uint256(_prices[tokenId].lastPrice);
}

}

function _multiple (uint256 tokenId) public view returns (uint16) {
{
return _prices[tokenId].multiple;
}

}

function setBasePrice (uint256 basePrice) onlyContractOwner public {
_basePrice = basePrice;
}

function setBountyDivisor (uint8 bountyDivisor) onlyContractOwner public {
_bountyDivisor = bountyDivisor;
}

function setBaseURL (string memory baseURL) onlyContractOwner public {
_baseURL = baseURL;
}

function setOwner (address owner) onlyContractOwner public {
_owner = owner;
}

function withdraw (uint256 amount) onlyContractOwner public {
msg.sender.transfer(amount);
}

function withdrawProfit () onlyContractOwner public {
msg.sender.transfer(address(this).balance.sub(failedPayoutsSum));
}

function getAllOwned () public view returns (uint256[]  memory, address[] memory) {
uint totalOwned = totalSupply();
uint256[] memory ownedUint256 = new uint256[](totalOwned);
address[] memory ownersAddress = new address[](totalOwned);
for (uint i = 0; i < totalOwned; i ++) {
ownedUint256[i] = tokenByIndex(i);
ownersAddress[i] = ownerOf(ownedUint256[i]);
}

{
return (ownedUint256, ownersAddress);
}

}

function metadataForToken (uint256 tokenId) public view returns (uint256, address, uint16, uint256) {
uint256 price = priceOf(tokenId);
if (_exists(tokenId)) {
{
return (_lastPrice(tokenId), ownerOf(tokenId), multipleOf(tokenId), price);
}

}

{
return (_basePrice, address(0), uint16(10), price);
}

}

function priceOf (uint256 tokenId) public view returns (uint256) {
if (_exists(tokenId)) {
{
return _lastPrice(tokenId).mul(uint256(multipleOf(tokenId))).div(10);
}

}

{
return _basePrice;
}

}

function multipleOf (uint256 tokenId) public view returns (uint16) {
uint16 multiple = _multiple(tokenId);
if (multiple > 0) {
{
return multiple;
}

}

{
return _defaultMultiple;
}

}

modifier onlyTokenOwner(uint256 tokenId) {
        require(msg.sender == ownerOf(tokenId));
        _;
    }
function setMultiple (uint256 tokenId, uint16 multiple) onlyTokenOwner(tokenId) public {
require(multiple >= 1 && multiple <= 1000);
_prices[tokenId].multiple = multiple;
}

function mint (address _to, uint256 _tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_120;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_120 := mload(0x40)
mstore(0x40, add(tmp_120, 640))
sstore(memoryStart_0_slot, tmp_120)
mstore(add(tmp_120, 0), 0)
}

}

address[] memory a_117;
assembly {
a_117 := add(sload(memoryStart_0_slot), 0)
}

_mint(_to, _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_118 = 0; index_118 < a_117.length; index_118 += 1) {
address tmp_119;
assembly {
tmp_119 := mload(add(a_117, mul(add(index_118, 1), 32)))
}

assert(_ownedTokensCount[tmp_119] == sum_ownersToken[tmp_119]);
}

memoryStart_0 = 0;
}

}

function transfer (address _to, uint256 _tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_124;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_124 := mload(0x40)
mstore(0x40, add(tmp_124, 640))
sstore(memoryStart_0_slot, tmp_124)
mstore(add(tmp_124, 0), 0)
}

}

address[] memory a_121;
assembly {
a_121 := add(sload(memoryStart_0_slot), 0)
}

safeTransferFrom(msg.sender, _to, _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_122 = 0; index_122 < a_121.length; index_122 += 1) {
address tmp_123;
assembly {
tmp_123 := mload(add(a_121, mul(add(index_122, 1), 32)))
}

assert(_ownedTokensCount[tmp_123] == sum_ownersToken[tmp_123]);
}

memoryStart_0 = 0;
}

}

function grabCode (uint256 tokenId) public payable {
uint256 entry_1 = 0;
uint256 tmp_130;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_130 := mload(0x40)
mstore(0x40, add(tmp_130, 640))
sstore(memoryStart_0_slot, tmp_130)
mstore(add(tmp_130, 0), 0)
}

}

address[] memory a_125;
assembly {
a_125 := add(sload(memoryStart_0_slot), 0)
}

uint256 price = priceOf(tokenId);
require(msg.value >= price);
_prices[tokenId] = Price(uint240(msg.value), uint16(0));
if (! _exists(tokenId)) {
_mint(msg.sender, tokenId);
{
if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_126 = 0; index_126 < a_125.length; index_126 += 1) {
address tmp_127;
assembly {
tmp_127 := mload(add(a_125, mul(add(index_126, 1), 32)))
}

assert(_ownedTokensCount[tmp_127] == sum_ownersToken[tmp_127]);
}

memoryStart_0 = 0;
}

return;
}

}

address owner = ownerOf(tokenId);
require(owner != msg.sender);
_burn(owner, tokenId);
_mint(msg.sender, tokenId);
uint256 bounty = msg.value.div(_bountyDivisor);
uint256 bountiesCount = 1;
uint256[4] memory neighbors;
for (uint i = 0; i < 4; i ++) {
uint256 neighbor = neighbors[i];
if (! _exists(neighbor)) {
continue;
}

bountiesCount ++;
}

if (entry_1 == 1) {
assert(sum_tokenCount == _allTokens.length);
for (uint256 index_128 = 0; index_128 < a_125.length; index_128 += 1) {
address tmp_129;
assembly {
tmp_129 := mload(add(a_125, mul(add(index_128, 1), 32)))
}

assert(_ownedTokensCount[tmp_129] == sum_ownersToken[tmp_129]);
}

memoryStart_0 = 0;
}

}

function pullBounty (address to) public {
uint256 bounty = failedPayouts[msg.sender];
if (bounty == 0) {
{
return;
}

}

failedPayouts[msg.sender] = 0;
failedPayoutsSum = failedPayoutsSum.sub(bounty);
}

function tokenURI (uint256 _tokenId) external view returns (string memory) {
require(_exists(_tokenId));
{
return strConcat(strConcat(_baseURL, uint256ToString(_tokenId)),".json");
}

}

function uint256ToString (uint256 y) private pure returns (string memory) {
bytes32 x = bytes32(y);
bytes memory bytesString = new bytes(32);
uint charCount = 0;
for (uint j = 0; j < 32; j ++) {
byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
if (char != 0) {
bytesString[charCount] = char;
charCount ++;
}

}

bytes memory bytesStringTrimmed = new bytes(charCount);
for (uint j = 0; j < charCount; j ++) {
bytesStringTrimmed[j] = bytesString[j];
}

{
return string(bytesStringTrimmed);
}

}

function stringToBytes32 (string memory source) private pure returns (bytes32 result) {
bytes memory testEmptyStringTest = bytes(source);
if (testEmptyStringTest.length == 0) {
{
return 0x0;
}

}

assembly {
result := mload(add(source, 32))
}

}

function strConcat (string memory _a, string memory _b) private pure returns (string memory) {
bytes memory bytes_a = bytes(_a);
bytes memory bytes_b = bytes(_b);
string memory ab = new string(bytes_a.length + bytes_b.length);
bytes memory bytes_ab = bytes(ab);
uint k = 0;
for (uint i = 0; i < bytes_a.length; i ++) bytes_ab[k ++] = bytes_a[i];
for (uint i = 0; i < bytes_b.length; i ++) bytes_ab[k ++] = bytes_b[i];
{
return string(bytes_ab);
}

}

bytes20 constant DIGITS = bytes20('23456789CFGHJMPQRVWX');
bytes20 constant STIGID = bytes20('XWVRQPMJHGFC98765432');
function nextChar (byte c, bytes20 digits) private pure returns (byte) {
for (uint i = 0; i < 20; i ++) if (c == digits[i]) {
return (i == 19) ? digits[0] : digits[i+1];
}

}

}
