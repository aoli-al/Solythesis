pragma solidity ^0.5.0;
library Roles {
struct Role {
    mapping (address => bool) bearer;
  }
function add (Role storage role, address account) internal {
require(account != address(0));
role.bearer[account] = true;
}

function remove (Role storage role, address account) internal {
require(account != address(0));
role.bearer[account] = false;
}

function has (Role storage role, address account) internal view returns (bool) {
require(account != address(0));
{
return role.bearer[account];
}

}

}
contract MinterRole {
using Roles for Roles.Role;
event MinterAdded(address indexed account);
event MinterRemoved(address indexed account);
Roles.Role private minters;
constructor () public {
minters.add(msg.sender);
}

modifier onlyMinter() {
    require(isMinter(msg.sender));
    _;
  }
function isMinter (address account) public view returns (bool) {
{
return minters.has(account);
}

}

function addMinter (address account) onlyMinter public {
minters.add(account);
emit MinterAdded(account);
}

function renounceMinter () public {
minters.remove(msg.sender);
}

function _removeMinter (address account) internal {
minters.remove(account);
emit MinterRemoved(account);
}

}
interface IERC165 {
function supportsInterface (bytes4 interfaceId) external view returns (bool);
}
contract ERC165 is IERC165 {
bytes4 private constant _InterfaceId_ERC165 = 0x01ffc9a7;
mapping (bytes4=>bool) internal _supportedInterfaces;
constructor () public {
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
contract IERC721 is IERC165 {
uint256[] internal _allTokens;
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
contract ERC721 is ERC165, IERC721 {
uint256 depth_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_100;
uint256 index_13;
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
depth_0 += 1;
address[] memory a_101;
if (depth_0 <= 1) assembly {
a_101 := mload(0x40)
mstore(0x40,add(a_101,0x280))
sstore(a_addr_100_slot,a_101)
mstore(a_101,0x260)
}
 else assembly {
a_101 := sload(a_addr_100_slot)
}

require(_isApprovedOrOwner(msg.sender, tokenId));
require(to != address(0));
_clearApproval(from, tokenId);
_removeTokenFrom(from, tokenId);
_addTokenTo(to, tokenId);
emit Transfer(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_102 = 0; index_102 < index_13; index_102 += 1) {
address tmp_103;
assembly {
tmp_103 := mload(add(a_101,mul(index_102,32)))
}

assert(_ownedTokensCount[tmp_103] == sum_ownersToken[tmp_103]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (
    address from,
    address to,
    uint256 tokenId
  ) public {
depth_0 += 1;
address[] memory a_104;
if (depth_0 <= 1) assembly {
a_104 := mload(0x40)
mstore(0x40,add(a_104,0x280))
sstore(a_addr_100_slot,a_104)
mstore(a_104,0x260)
}
 else assembly {
a_104 := sload(a_addr_100_slot)
}

safeTransferFrom(from, to, tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_105 = 0; index_105 < index_13; index_105 += 1) {
address tmp_106;
assembly {
tmp_106 := mload(add(a_104,mul(index_105,32)))
}

assert(_ownedTokensCount[tmp_106] == sum_ownersToken[tmp_106]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (
    address from,
    address to,
    uint256 tokenId,
    bytes memory _data
  ) public {
depth_0 += 1;
address[] memory a_107;
if (depth_0 <= 1) assembly {
a_107 := mload(0x40)
mstore(0x40,add(a_107,0x280))
sstore(a_addr_100_slot,a_107)
mstore(a_107,0x260)
}
 else assembly {
a_107 := sload(a_addr_100_slot)
}

transferFrom(from, to, tokenId);
require(_checkAndCallSafeTransfer(from, to, tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_108 = 0; index_108 < index_13; index_108 += 1) {
address tmp_109;
assembly {
tmp_109 := mload(add(a_107,mul(index_108,32)))
}

assert(_ownedTokensCount[tmp_109] == sum_ownersToken[tmp_109]);
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
address[20] memory a_111;
uint256 index_112 = 0;
uint256 tmp_sum_tokenCount_113 = sum_tokenCount;
require(_tokenOwner[tokenId] == address(0));
{
address opt_110 = _tokenOwner[tokenId];
{
if (opt_110 == opt_110 && opt_110 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_110] >= 1);
{
a_111[index_112] = opt_110;
index_112 += 1;
}
sum_ownersToken[opt_110] -= 1;
}

}

opt_110 = to;
{
if (opt_110 == opt_110 && opt_110 != 0x0000000000000000000000000000000000000000) {
{
a_111[index_112] = opt_110;
index_112 += 1;
}
sum_ownersToken[opt_110] += 1;
assert(sum_ownersToken[opt_110] >= 1);
}

}

_tokenOwner[tokenId] = opt_110;
}

{
uint256 opt_114 = _ownedTokensCount[to];
{
if (to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_113 >= opt_114);
tmp_sum_tokenCount_113 -= opt_114;
}

}

{
a_111[index_112] = to;
index_112 += 1;
}

opt_114 = opt_114.add(1);
{
if (to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_113 += opt_114;
assert(tmp_sum_tokenCount_113 >= opt_114);
}

}

_ownedTokensCount[to] = opt_114;
}

sum_tokenCount = tmp_sum_tokenCount_113;
}

function _removeTokenFrom (address from, uint256 tokenId) internal {
uint256 tmp_sum_tokenCount_116 = sum_tokenCount;
address[20] memory a_117;
uint256 index_118 = 0;
require(ownerOf(tokenId) == from);
{
uint256 opt_119 = _ownedTokensCount[from];
{
if (from != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_116 >= opt_119);
tmp_sum_tokenCount_116 -= opt_119;
}

}

{
a_117[index_118] = from;
index_118 += 1;
}

opt_119 = opt_119.sub(1);
{
if (from != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_116 += opt_119;
assert(tmp_sum_tokenCount_116 >= opt_119);
}

}

_ownedTokensCount[from] = opt_119;
}

{
address opt_121 = _tokenOwner[tokenId];
{
if (opt_121 == opt_121 && opt_121 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_121] >= 1);
{
a_117[index_118] = opt_121;
index_118 += 1;
}
sum_ownersToken[opt_121] -= 1;
}

}

opt_121 = address(0);
{
if (opt_121 == opt_121 && opt_121 != 0x0000000000000000000000000000000000000000) {
{
a_117[index_118] = opt_121;
index_118 += 1;
}
sum_ownersToken[opt_121] += 1;
assert(sum_ownersToken[opt_121] >= 1);
}

}

_tokenOwner[tokenId] = opt_121;
}

sum_tokenCount = tmp_sum_tokenCount_116;
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
contract IERC721Enumerable is IERC721 {
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
function tokenURI (uint256 tokenId) public view returns (string memory);
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

function name () external view returns (string memory ) {
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
contract ERC721Mintable is ERC721Full, MinterRole {
event MintingFinished();
bool private _mintingFinished = false;
modifier onlyBeforeMintingFinished() {
    require(!_mintingFinished);
    _;
  }
function mintingFinished () public view returns(bool) {
{
return _mintingFinished;
}

}

function mint (
    address to,
    uint256 tokenId
  ) onlyMinter onlyBeforeMintingFinished public returns (bool) {
depth_0 += 1;
address[] memory a_122;
if (depth_0 <= 1) assembly {
a_122 := mload(0x40)
mstore(0x40,add(a_122,0x280))
sstore(a_addr_100_slot,a_122)
mstore(a_122,0x260)
}
 else assembly {
a_122 := sload(a_addr_100_slot)
}

_mint(to, tokenId);
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

return true;
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

function mintWithTokenURI (
    address to,
    uint256 tokenId,
    string memory tokenURI
  ) onlyMinter onlyBeforeMintingFinished public returns (bool) {
depth_0 += 1;
address[] memory a_127;
if (depth_0 <= 1) assembly {
a_127 := mload(0x40)
mstore(0x40,add(a_127,0x280))
sstore(a_addr_100_slot,a_127)
mstore(a_127,0x260)
}
 else assembly {
a_127 := sload(a_addr_100_slot)
}

mint(to, tokenId);
_setTokenURI(tokenId, tokenURI);
{
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_128 = 0; index_128 < index_13; index_128 += 1) {
address tmp_129;
assembly {
tmp_129 := mload(add(a_127,mul(index_128,32)))
}

assert(_ownedTokensCount[tmp_129] == sum_ownersToken[tmp_129]);
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
for (uint256 index_130 = 0; index_130 < index_13; index_130 += 1) {
address tmp_131;
assembly {
tmp_131 := mload(add(a_127,mul(index_130,32)))
}

assert(_ownedTokensCount[tmp_131] == sum_ownersToken[tmp_131]);
}

index_13 = 0;
}

}

}

function finishMinting () onlyMinter onlyBeforeMintingFinished public returns (bool) {
_mintingFinished = true;
emit MintingFinished();
{
return true;
}

}

}
contract PauserRole {
using Roles for Roles.Role;
event PauserAdded(address indexed account);
event PauserRemoved(address indexed account);
Roles.Role private pausers;
constructor () public {
pausers.add(msg.sender);
}

modifier onlyPauser() {
    require(isPauser(msg.sender));
    _;
  }
function isPauser (address account) public view returns (bool) {
{
return pausers.has(account);
}

}

function addPauser (address account) onlyPauser public {
pausers.add(account);
emit PauserAdded(account);
}

function renouncePauser () public {
pausers.remove(msg.sender);
}

function _removePauser (address account) internal {
pausers.remove(account);
emit PauserRemoved(account);
}

}
contract Pausable is PauserRole {
event Paused();
event Unpaused();
bool private _paused = false;
function paused () public view returns(bool) {
{
return _paused;
}

}

modifier whenNotPaused() {
    require(!_paused);
    _;
  }
modifier whenPaused() {
    require(_paused);
    _;
  }
function pause () onlyPauser whenNotPaused public {
_paused = true;
emit Paused();
}

function unpause () onlyPauser whenPaused public {
_paused = false;
emit Unpaused();
}

}
contract ERC721Pausable is ERC721, Pausable {
function approve (
    address to,
    uint256 tokenId
  ) whenNotPaused public {
super.approve(to, tokenId);
}

function setApprovalForAll (
    address to,
    bool approved
  ) whenNotPaused public {
super.setApprovalForAll(to, approved);
}

function transferFrom (
    address from,
    address to,
    uint256 tokenId
  ) whenNotPaused public {
depth_0 += 1;
address[] memory a_132;
if (depth_0 <= 1) assembly {
a_132 := mload(0x40)
mstore(0x40,add(a_132,0x280))
sstore(a_addr_100_slot,a_132)
mstore(a_132,0x260)
}
 else assembly {
a_132 := sload(a_addr_100_slot)
}

super.transferFrom(from, to, tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_133 = 0; index_133 < index_13; index_133 += 1) {
address tmp_134;
assembly {
tmp_134 := mload(add(a_132,mul(index_133,32)))
}

assert(_ownedTokensCount[tmp_134] == sum_ownersToken[tmp_134]);
}

index_13 = 0;
}

}

}

}
contract HeroAsset is ERC721Full, ERC721Mintable, ERC721Pausable {
uint16 public constant HERO_TYPE_OFFSET = 10000;
string public tokenURIPrefix = "https://www.mycryptoheroes.net/metadata/hero/";
mapping (uint16=>uint16) private heroTypeToSupplyLimit;
constructor () ERC721Full("MyCryptoHeroes:Hero", "MCHH") public {
}

function setSupplyLimit (uint16 _heroType, uint16 _supplyLimit) onlyMinter external {
require(heroTypeToSupplyLimit[_heroType] == 0 || _supplyLimit < heroTypeToSupplyLimit[_heroType], "_supplyLimit is bigger");
heroTypeToSupplyLimit[_heroType] = _supplyLimit;
}

function setTokenURIPrefix (string memory _tokenURIPrefix) onlyMinter public {
tokenURIPrefix = _tokenURIPrefix;
}

function getSupplyLimit (uint16 _heroType) public view returns (uint16) {
{
return heroTypeToSupplyLimit[_heroType];
}

}

function mintHeroAsset (address _owner, uint256 _tokenId) onlyMinter public {
depth_0 += 1;
address[] memory a_135;
if (depth_0 <= 1) assembly {
a_135 := mload(0x40)
mstore(0x40,add(a_135,0x280))
sstore(a_addr_100_slot,a_135)
mstore(a_135,0x260)
}
 else assembly {
a_135 := sload(a_addr_100_slot)
}

uint16 _heroType = uint16(_tokenId / HERO_TYPE_OFFSET);
uint16 _heroTypeIndex = uint16(_tokenId % HERO_TYPE_OFFSET) - 1;
require(_heroTypeIndex < heroTypeToSupplyLimit[_heroType], "supply over");
_mint(_owner, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_136 = 0; index_136 < index_13; index_136 += 1) {
address tmp_137;
assembly {
tmp_137 := mload(add(a_135,mul(index_136,32)))
}

assert(_ownedTokensCount[tmp_137] == sum_ownersToken[tmp_137]);
}

index_13 = 0;
}

}

}

function transfer (address _to, uint256 _tokenId) public {
depth_0 += 1;
address[] memory a_138;
if (depth_0 <= 1) assembly {
a_138 := mload(0x40)
mstore(0x40,add(a_138,0x280))
sstore(a_addr_100_slot,a_138)
mstore(a_138,0x260)
}
 else assembly {
a_138 := sload(a_addr_100_slot)
}

safeTransferFrom(msg.sender, _to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == _allTokens.length);
{
for (uint256 index_139 = 0; index_139 < index_13; index_139 += 1) {
address tmp_140;
assembly {
tmp_140 := mload(add(a_138,mul(index_139,32)))
}

assert(_ownedTokensCount[tmp_140] == sum_ownersToken[tmp_140]);
}

index_13 = 0;
}

}

}

function tokenURI (uint256 tokenId) public view returns (string memory) {
bytes32 tokenIdBytes;
if (tokenId == 0) {
tokenIdBytes = "0";
}
 else {
uint256 value = tokenId;
while (value > 0) {
                tokenIdBytes = bytes32(uint256(tokenIdBytes) / (2 ** 8));
                tokenIdBytes |= bytes32(((value % 10) + 48) * 2 ** (8 * 31));
                value /= 10;
            }
}

bytes memory prefixBytes = bytes(tokenURIPrefix);
bytes memory tokenURIBytes = new bytes(prefixBytes.length + tokenIdBytes.length);
uint8 i;
uint8 index = 0;
for (i = 0; i < prefixBytes.length; i ++) {
tokenURIBytes[index] = prefixBytes[i];
index ++;
}

for (i = 0; i < tokenIdBytes.length; i ++) {
tokenURIBytes[index] = tokenIdBytes[i];
index ++;
}

{
return string(tokenURIBytes);
}

}

}
