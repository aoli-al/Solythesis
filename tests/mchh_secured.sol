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

_mint(to, tokenId);
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

return true;
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

function mintWithTokenURI (
    address to,
    uint256 tokenId,
    string memory tokenURI
  ) onlyMinter onlyBeforeMintingFinished public returns (bool) {
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

mint(to, tokenId);
_setTokenURI(tokenId, tokenURI);
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

return true;
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

uint16 _heroType = uint16(_tokenId / HERO_TYPE_OFFSET);
uint16 _heroTypeIndex = uint16(_tokenId % HERO_TYPE_OFFSET) - 1;
require(_heroTypeIndex < heroTypeToSupplyLimit[_heroType], "supply over");
_mint(_owner, _tokenId);
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

function transfer (address _to, uint256 _tokenId) public {
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

safeTransferFrom(msg.sender, _to, _tokenId);
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
