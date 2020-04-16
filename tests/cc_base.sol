pragma solidity ^0.5.0;
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
library AddressUtils {
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
interface ERC165 {
function supportsInterface (bytes4 _interfaceId) external view returns (bool);
}
contract SupportsInterfaceWithLookup is ERC165 {
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
contract ERC721Receiver {
bytes4 internal constant ERC721_RECEIVED = 0x150b7a02;
function onERC721Received (
    address _operator,
    address _from,
    uint256 _tokenId,
    bytes memory _data
  ) public returns(bytes4);
}
contract ERC721Basic is ERC165 {
event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 indexed _tokenId
  );
event Approval(
    address indexed _owner,
    address indexed _approved,
    uint256 indexed _tokenId
  );
event ApprovalForAll(
    address indexed _owner,
    address indexed _operator,
    bool _approved
  );
function balanceOf (address _owner) public view returns (uint256 _balance);
function ownerOf (uint256 _tokenId) public view returns (address _owner);
function exists (uint256 _tokenId) public view returns (bool _exists);
function approve (address _to, uint256 _tokenId) public;
function getApproved (uint256 _tokenId) public view returns (address _operator);
function setApprovalForAll (address _operator, bool _approved) public;
function isApprovedForAll (address _owner, address _operator) public view returns (bool);
function transferFrom (address _from, address _to, uint256 _tokenId) public;
function safeTransferFrom (address _from, address _to, uint256 _tokenId) public;
function safeTransferFrom (
    address _from,
    address _to,
    uint256 _tokenId,
    bytes memory _data
  ) public;
}
contract ERC721BasicToken is SupportsInterfaceWithLookup, ERC721Basic {
uint256 memoryStart_0;
mapping (address=>bool) a_checker_3;
address[] a_store_4;
uint256 sum_tokenCount;
mapping (uint256=>bool) a_checker_7;
uint256[] a_store_8;
mapping (address=>bool) b_checker_5;
address[] b_store_6;
mapping (address=>uint256) sum_ownersToken;
mapping (address=>bool) a_checker_9;
address[] a_store_10;
bytes4 private constant InterfaceId_ERC721 = 0x80ac58cd;
bytes4 private constant InterfaceId_ERC721Exists = 0x4f558e79;
using SafeMath for uint256;
using AddressUtils for address;
bytes4 private constant ERC721_RECEIVED = 0x150b7a02;
mapping (uint256=>address) internal tokenOwner;
mapping (uint256=>address) internal tokenApprovals;
mapping (address=>uint256) internal ownedTokensCount;
uint256[] internal allTokens;
mapping (address=>mapping (address=>bool)) internal operatorApprovals;
modifier onlyOwnerOf(uint256 _tokenId) {
    require(ownerOf(_tokenId) == msg.sender);
    _;
  }
modifier canTransfer(uint256 _tokenId) {
    require(isApprovedOrOwner(msg.sender, _tokenId));
    _;
  }
constructor () public {
_registerInterface(InterfaceId_ERC721);
_registerInterface(InterfaceId_ERC721Exists);
}

function balanceOf (address _owner) public view returns (uint256) {
require(_owner != address(0));
{
return ownedTokensCount[_owner];
}

}

function ownerOf (uint256 _tokenId) public view returns (address) {
address owner = tokenOwner[_tokenId];
require(owner != address(0));
{
return owner;
}

}

function exists (uint256 _tokenId) public view returns (bool) {
address owner = tokenOwner[_tokenId];
{
return owner != address(0);
}

}

function approve (address _to, uint256 _tokenId) public {
address owner = ownerOf(_tokenId);
require(_to != owner);
require(msg.sender == owner || isApprovedForAll(owner, msg.sender));
tokenApprovals[_tokenId] = _to;
emit Approval(owner, _to, _tokenId);
}

function getApproved (uint256 _tokenId) public view returns (address) {
{
return tokenApprovals[_tokenId];
}

}

function setApprovalForAll (address _to, bool _approved) public {
require(_to != msg.sender);
operatorApprovals[msg.sender][_to] = _approved;
emit ApprovalForAll(msg.sender, _to, _approved);
}

function isApprovedForAll (
    address _owner,
    address _operator
  ) public view returns (bool) {
{
return operatorApprovals[_owner][_operator];
}

}

function transferFrom (
    address _from,
    address _to,
    uint256 _tokenId
  ) canTransfer(_tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_9;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_9 := mload(0x40)
mstore(0x40, add(tmp_9, 0))
sstore(memoryStart_0_slot, tmp_9)
}

}

require(_from != address(0));
require(_to != address(0));
clearApproval(_from, _tokenId);
removeTokenFrom(_from, _tokenId);
addTokenTo(_to, _tokenId);
emit Transfer(_from, _to, _tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_3 = 0; index_3 < a_store_4.length; index_3 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_3]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_3]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_4 = 0; index_4 < b_store_6.length; index_4 += 1) {
sum_ownersToken[b_store_6[index_4]] = 0;
}

for (uint256 index_5 = 0; index_5 < a_store_8.length; index_5 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_5]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_5]]] >= 1);
}

}

for (uint256 index_8 = 0; index_8 < a_store_10.length; index_8 += 1) {
assert(ownedTokensCount[a_store_10[index_8]] == sum_ownersToken[a_store_10[index_8]]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (
    address _from,
    address _to,
    uint256 _tokenId
  ) canTransfer(_tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_16;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_16 := mload(0x40)
mstore(0x40, add(tmp_16, 0))
sstore(memoryStart_0_slot, tmp_16)
}

}

safeTransferFrom(_from, _to, _tokenId, "");
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_10 = 0; index_10 < a_store_4.length; index_10 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_10]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_10]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_11 = 0; index_11 < b_store_6.length; index_11 += 1) {
sum_ownersToken[b_store_6[index_11]] = 0;
}

for (uint256 index_12 = 0; index_12 < a_store_8.length; index_12 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_12]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_12]]] >= 1);
}

}

for (uint256 index_15 = 0; index_15 < a_store_10.length; index_15 += 1) {
assert(ownedTokensCount[a_store_10[index_15]] == sum_ownersToken[a_store_10[index_15]]);
}

memoryStart_0 = 0;
}

}

function safeTransferFrom (
    address _from,
    address _to,
    uint256 _tokenId,
    bytes memory _data
  ) canTransfer(_tokenId) public {
uint256 entry_1 = 0;
uint256 tmp_23;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_23 := mload(0x40)
mstore(0x40, add(tmp_23, 0))
sstore(memoryStart_0_slot, tmp_23)
}

}

transferFrom(_from, _to, _tokenId);
require(checkAndCallSafeTransfer(_from, _to, _tokenId, _data));
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_17 = 0; index_17 < a_store_4.length; index_17 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_17]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_17]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_18 = 0; index_18 < b_store_6.length; index_18 += 1) {
sum_ownersToken[b_store_6[index_18]] = 0;
}

for (uint256 index_19 = 0; index_19 < a_store_8.length; index_19 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_19]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_19]]] >= 1);
}

}

for (uint256 index_22 = 0; index_22 < a_store_10.length; index_22 += 1) {
assert(ownedTokensCount[a_store_10[index_22]] == sum_ownersToken[a_store_10[index_22]]);
}

memoryStart_0 = 0;
}

}

function isApprovedOrOwner (
    address _spender,
    uint256 _tokenId
  ) internal view returns (bool) {
address owner = ownerOf(_tokenId);
{
return (
      _spender == owner ||
      getApproved(_tokenId) == _spender ||
      isApprovedForAll(owner, _spender)
    );
}

}

function _mint (address _to, uint256 _tokenId) internal {
require(_to != address(0));
addTokenTo(_to, _tokenId);
emit Transfer(address(0), _to, _tokenId);
}

function _burn (address _owner, uint256 _tokenId) internal {
clearApproval(_owner, _tokenId);
removeTokenFrom(_owner, _tokenId);
emit Transfer(_owner, address(0), _tokenId);
}

function clearApproval (address _owner, uint256 _tokenId) internal {
require(ownerOf(_tokenId) == _owner);
if (tokenApprovals[_tokenId] != address(0)) {
tokenApprovals[_tokenId] = address(0);
}

}

function addTokenTo (address _to, uint256 _tokenId) internal {
require(tokenOwner[_tokenId] == address(0));
tokenOwner[_tokenId] = _to;if (! a_checker_7[_tokenId]) {
a_store_8.push(_tokenId);
a_checker_7[_tokenId] = true;
}
if (! b_checker_5[tokenOwner[_tokenId]]) {
b_store_6.push(tokenOwner[_tokenId]);
b_checker_5[tokenOwner[_tokenId]] = true;
}

ownedTokensCount[_to] = ownedTokensCount[_to].add(1);if (! a_checker_3[_to]) {
a_store_4.push(_to);
a_checker_3[_to] = true;
}
if (! a_checker_9[_to]) {
a_store_10.push(_to);
a_checker_9[_to] = true;
}

}

function removeTokenFrom (address _from, uint256 _tokenId) internal {
require(ownerOf(_tokenId) == _from);
ownedTokensCount[_from] = ownedTokensCount[_from].sub(1);if (! a_checker_3[_from]) {
a_store_4.push(_from);
a_checker_3[_from] = true;
}
if (! a_checker_9[_from]) {
a_store_10.push(_from);
a_checker_9[_from] = true;
}

tokenOwner[_tokenId] = address(0);if (! a_checker_7[_tokenId]) {
a_store_8.push(_tokenId);
a_checker_7[_tokenId] = true;
}
if (! b_checker_5[tokenOwner[_tokenId]]) {
b_store_6.push(tokenOwner[_tokenId]);
b_checker_5[tokenOwner[_tokenId]] = true;
}

}

function checkAndCallSafeTransfer (
    address _from,
    address _to,
    uint256 _tokenId,
    bytes memory _data
  ) internal returns (bool) {
if (! _to.isContract()) {
{
return true;
}

}

bytes4 retval = ERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
{
return (retval == ERC721_RECEIVED);
}

}

}
contract ERC721Enumerable is ERC721Basic {
function totalSupply () public view returns (uint256);
function tokenOfOwnerByIndex (
    address _owner,
    uint256 _index
  ) public view returns (uint256 _tokenId);
function tokenByIndex (uint256 _index) public view returns (uint256);
}
contract ERC721Metadata is ERC721Basic {
function name () external view returns (string memory _name);
function symbol () external view returns (string memory _symbol);
function tokenURI (uint256 _tokenId) public view returns (string memory);
}
contract ERC721 is ERC721Basic, ERC721Enumerable, ERC721Metadata {
}
contract ERC721Token is SupportsInterfaceWithLookup, ERC721BasicToken, ERC721 {
bytes4 private constant InterfaceId_ERC721Enumerable = 0x780e9d63;
bytes4 private constant InterfaceId_ERC721Metadata = 0x5b5e139f;
string internal name_;
string internal symbol_;
mapping (address=>uint256[]) internal ownedTokens;
mapping (uint256=>uint256) internal ownedTokensIndex;
mapping (uint256=>uint256) internal allTokensIndex;
mapping (uint256=>string) internal tokenURIs;
constructor (string memory _name, string memory _symbol) public {
name_ = _name;
symbol_ = _symbol;
_registerInterface(InterfaceId_ERC721Enumerable);
_registerInterface(InterfaceId_ERC721Metadata);
}

function name () external view returns (string memory) {
{
return name_;
}

}

function symbol () external view returns (string memory) {
{
return symbol_;
}

}

function tokenURI (uint256 _tokenId) public view returns (string memory) {
require(exists(_tokenId));
{
return tokenURIs[_tokenId];
}

}

function tokenOfOwnerByIndex (
    address _owner,
    uint256 _index
  ) public view returns (uint256) {
require(_index < balanceOf(_owner));
{
return ownedTokens[_owner][_index];
}

}

function totalSupply () public view returns (uint256) {
{
return allTokens.length;
}

}

function tokenByIndex (uint256 _index) public view returns (uint256) {
require(_index < totalSupply());
{
return allTokens[_index];
}

}

function _setTokenURI (uint256 _tokenId, string memory _uri) internal {
require(exists(_tokenId));
tokenURIs[_tokenId] = _uri;
}

function addTokenTo (address _to, uint256 _tokenId) internal {
super.addTokenTo(_to, _tokenId);
uint256 length = ownedTokens[_to].length;
ownedTokens[_to].push(_tokenId);
ownedTokensIndex[_tokenId] = length;
}

function removeTokenFrom (address _from, uint256 _tokenId) internal {
super.removeTokenFrom(_from, _tokenId);
uint256 tokenIndex = ownedTokensIndex[_tokenId];
uint256 lastTokenIndex = ownedTokens[_from].length.sub(1);
uint256 lastToken = ownedTokens[_from][lastTokenIndex];
ownedTokens[_from][tokenIndex] = lastToken;
ownedTokens[_from][lastTokenIndex] = 0;
ownedTokens[_from].length --;
ownedTokensIndex[_tokenId] = 0;
ownedTokensIndex[lastToken] = tokenIndex;
}

function _mint (address _to, uint256 _tokenId) internal {
super._mint(_to, _tokenId);
allTokensIndex[_tokenId] = allTokens.length;
allTokens.push(_tokenId);
}

function _burn (address _owner, uint256 _tokenId) internal {
super._burn(_owner, _tokenId);
if (bytes(tokenURIs[_tokenId]).length != 0) {
delete tokenURIs[_tokenId];
}

uint256 tokenIndex = allTokensIndex[_tokenId];
uint256 lastTokenIndex = allTokens.length.sub(1);
uint256 lastToken = allTokens[lastTokenIndex];
allTokens[tokenIndex] = lastToken;
allTokens[lastTokenIndex] = 0;
allTokens.length --;
allTokensIndex[_tokenId] = 0;
allTokensIndex[lastToken] = tokenIndex;
}

}
contract Ownable {
address public owner;
event OwnershipRenounced(address indexed previousOwner);
event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );
constructor () public {
owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
function renounceOwnership () onlyOwner public {
emit OwnershipRenounced(owner);
owner = address(0);
}

function transferOwnership (address _newOwner) onlyOwner public {
_transferOwnership(_newOwner);
}

function _transferOwnership (address _newOwner) internal {
require(_newOwner != address(0));
emit OwnershipTransferred(owner, _newOwner);
owner = _newOwner;
}

}
library Roles {
struct Role {
    mapping (address => bool) bearer;
  }
function add (Role storage role, address addr) internal {
role.bearer[addr] = true;
}

function remove (Role storage role, address addr) internal {
role.bearer[addr] = false;
}

function check (Role storage role, address addr) internal view {
require(has(role, addr));
}

function has (Role storage role, address addr) internal view returns (bool) {
{
return role.bearer[addr];
}

}

}
contract RBAC {
using Roles for Roles.Role;
mapping (string=>Roles.Role) private roles;
event RoleAdded(address indexed operator, string role);
event RoleRemoved(address indexed operator, string role);
function checkRole (address _operator, string memory _role) public view {
roles[_role].check(_operator);
}

function hasRole (address _operator, string memory _role) public view returns (bool) {
{
return roles[_role].has(_operator);
}

}

function addRole (address _operator, string memory _role) internal {
roles[_role].add(_operator);
emit RoleAdded(_operator, _role);
}

function removeRole (address _operator, string memory _role) internal {
roles[_role].remove(_operator);
emit RoleRemoved(_operator, _role);
}

modifier onlyRole(string memory _role)
  {
    checkRole(msg.sender, _role);
    _;
  }
}
contract Whitelist is Ownable, RBAC {
string public constant ROLE_WHITELISTED = "whitelist";
modifier onlyIfWhitelisted(address _operator) {
    checkRole(_operator, ROLE_WHITELISTED);
    _;
  }
function addAddressToWhitelist (address _operator) onlyOwner public {
addRole(_operator, ROLE_WHITELISTED);
}

function whitelist (address _operator) public view returns (bool) {
{
return hasRole(_operator, ROLE_WHITELISTED);
}

}

function addAddressesToWhitelist (address[] memory _operators) onlyOwner public {
for (uint256 i = 0; i < _operators.length; i ++) {
addAddressToWhitelist(_operators[i]);
}

}

function removeAddressFromWhitelist (address  _operator) onlyOwner public {
removeRole(_operator, ROLE_WHITELISTED);
}

function removeAddressesFromWhitelist (address[] memory _operators) onlyOwner public {
for (uint256 i = 0; i < _operators.length; i ++) {
removeAddressFromWhitelist(_operators[i]);
}

}

}
contract CrabData {
modifier crabDataLength(uint256[] memory _crabData) {
    require(_crabData.length == 8);
    _;
  }
struct CrabPartData {
    uint256 hp;
    uint256 dps;
    uint256 blockRate;
    uint256 resistanceBonus;
    uint256 hpBonus;
    uint256 dpsBonus;
    uint256 blockBonus;
    uint256 mutiplierBonus;
  }
function arrayToCrabPartData (
    uint256[] memory _partData
  ) crabDataLength(_partData) internal pure returns (CrabPartData memory _parsedData) {
_parsedData = CrabPartData(_partData[0], _partData[1], _partData[2], _partData[3], _partData[4], _partData[5], _partData[6], _partData[7]);
}

function crabPartDataToArray (CrabPartData memory _crabPartData) internal pure returns (uint256[] memory _resultData) {
_resultData = new uint256[](8);
_resultData[0] = _crabPartData.hp;
_resultData[1] = _crabPartData.dps;
_resultData[2] = _crabPartData.blockRate;
_resultData[3] = _crabPartData.resistanceBonus;
_resultData[4] = _crabPartData.hpBonus;
_resultData[5] = _crabPartData.dpsBonus;
_resultData[6] = _crabPartData.blockBonus;
_resultData[7] = _crabPartData.mutiplierBonus;
}

}
contract GeneSurgeon {
uint256[] internal crabPartMultiplier = [0, 10**9, 10**6, 10**3, 1];
function extractElementsFromGene (uint256 _gene) internal view returns (uint256[] memory _elements) {
_elements = new uint256[](4);
_elements[0] = _gene / crabPartMultiplier[1] / 100 % 10;
_elements[1] = _gene / crabPartMultiplier[2] / 100 % 10;
_elements[2] = _gene / crabPartMultiplier[3] / 100 % 10;
_elements[3] = _gene / crabPartMultiplier[4] / 100 % 10;
}

function extractPartsFromGene (uint256 _gene) internal view returns (uint256[] memory _parts) {
_parts = new uint256[](4);
_parts[0] = _gene / crabPartMultiplier[1] % 100;
_parts[1] = _gene / crabPartMultiplier[2] % 100;
_parts[2] = _gene / crabPartMultiplier[3] % 100;
_parts[3] = _gene / crabPartMultiplier[4] % 100;
}

}
contract CryptantCrabNFT is ERC721Token, Whitelist, CrabData, GeneSurgeon {
event CrabPartAdded(uint256 hp, uint256 dps, uint256 blockAmount);
event GiftTransfered(address indexed _from, address indexed _to, uint256 indexed _tokenId);
event DefaultMetadataURIChanged(string newUri);
bytes4 internal constant CRAB_BODY = 0xc398430e;
bytes4 internal constant CRAB_LEG = 0x889063b1;
bytes4 internal constant CRAB_LEFT_CLAW = 0xdb6290a2;
bytes4 internal constant CRAB_RIGHT_CLAW = 0x13453f89;
mapping (bytes4=>mapping (uint256=>CrabPartData[])) internal crabPartData;
mapping (uint256=>uint256) internal crabSpecialSkins;
string public defaultMetadataURI = "https://www.cryptantcrab.io/md/";
constructor (string memory _name, string memory _symbol) ERC721Token(_name, _symbol) public {
initiateCrabPartData();
}

function tokenURI (uint256 _tokenId) public view returns (string memory) {
require(exists(_tokenId));
string memory _uri = tokenURIs[_tokenId];
if (bytes(_uri).length == 0) {
}

{
return _uri;
}

}

function dataOfPart (uint256 _partIndex, uint256 _element, uint256 _setIndex) public view returns (uint256[] memory _resultData) {
bytes4 _key;
if (_partIndex == 1) {
_key = CRAB_BODY;
}
 else if (_partIndex == 2) {
_key = CRAB_LEG;
}
 else if (_partIndex == 3) {
_key = CRAB_LEFT_CLAW;
}
 else if (_partIndex == 4) {
_key = CRAB_RIGHT_CLAW;
}
 else {
revert();
}

CrabPartData storage _crabPartData = crabPartData[_key][_element][_setIndex];
_resultData = crabPartDataToArray(_crabPartData);
}

function giftToken (address _from, address _to, uint256 _tokenId) external {
uint256 entry_1 = 0;
uint256 tmp_30;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_30 := mload(0x40)
mstore(0x40, add(tmp_30, 0))
sstore(memoryStart_0_slot, tmp_30)
}

}

safeTransferFrom(_from, _to, _tokenId);
emit GiftTransfered(_from, _to, _tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_24 = 0; index_24 < a_store_4.length; index_24 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_24]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_24]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_25 = 0; index_25 < b_store_6.length; index_25 += 1) {
sum_ownersToken[b_store_6[index_25]] = 0;
}

for (uint256 index_26 = 0; index_26 < a_store_8.length; index_26 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_26]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_26]]] >= 1);
}

}

for (uint256 index_29 = 0; index_29 < a_store_10.length; index_29 += 1) {
assert(ownedTokensCount[a_store_10[index_29]] == sum_ownersToken[a_store_10[index_29]]);
}

memoryStart_0 = 0;
}

}

function mintToken (address _tokenOwner, uint256 _tokenId) external {
uint256 entry_1 = 0;
uint256 tmp_37;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_37 := mload(0x40)
mstore(0x40, add(tmp_37, 0))
sstore(memoryStart_0_slot, tmp_37)
}

}

super._mint(_tokenOwner, _tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_31 = 0; index_31 < a_store_4.length; index_31 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_31]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_31]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_32 = 0; index_32 < b_store_6.length; index_32 += 1) {
sum_ownersToken[b_store_6[index_32]] = 0;
}

for (uint256 index_33 = 0; index_33 < a_store_8.length; index_33 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_33]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_33]]] >= 1);
}

}

for (uint256 index_36 = 0; index_36 < a_store_10.length; index_36 += 1) {
assert(ownedTokensCount[a_store_10[index_36]] == sum_ownersToken[a_store_10[index_36]]);
}

memoryStart_0 = 0;
}

}

function crabPartDataFromGene (uint256 _gene) external view returns (
    uint256[] memory _bodyData,
    uint256[] memory _legData,
    uint256[] memory _leftClawData,
    uint256[] memory _rightClawData
  ) {
uint256[] memory _parts = extractPartsFromGene(_gene);
uint256[] memory _elements = extractElementsFromGene(_gene);
_bodyData = dataOfPart(1, _elements[0], _parts[0]);
_legData = dataOfPart(2, _elements[1], _parts[1]);
_leftClawData = dataOfPart(3, _elements[2], _parts[2]);
_rightClawData = dataOfPart(4, _elements[3], _parts[3]);
}

function setPartData (uint256 _partIndex, uint256 _element, uint256[] calldata _partDataArray) onlyOwner external {
CrabPartData memory _partData = arrayToCrabPartData(_partDataArray);
bytes4 _key;
if (_partIndex == 1) {
_key = CRAB_BODY;
}
 else if (_partIndex == 2) {
_key = CRAB_LEG;
}
 else if (_partIndex == 3) {
_key = CRAB_LEFT_CLAW;
}
 else if (_partIndex == 4) {
_key = CRAB_RIGHT_CLAW;
}

if (crabPartData[_key][_element][1].hp == 0 && crabPartData[_key][_element][1].dps == 0) {
crabPartData[_key][_element][1] = _partData;
}
 else {
crabPartData[_key][_element].push(_partData);
}

emit CrabPartAdded(_partDataArray[0], _partDataArray[1], _partDataArray[2]);
}

function setDefaultMetadataURI (string calldata _defaultUri) onlyOwner external {
defaultMetadataURI = _defaultUri;
emit DefaultMetadataURIChanged(_defaultUri);
}

function setTokenURI (uint256 _tokenId, string calldata _uri) onlyIfWhitelisted(msg.sender) external {
_setTokenURI(_tokenId, _uri);
}

function specialSkinOfTokenId (uint256 _tokenId) external view returns (uint256) {
{
return crabSpecialSkins[_tokenId];
}

}

function initiateCrabPartData () internal {
require(crabPartData[CRAB_BODY][1].length == 0);
for (uint256 i = 1; i <= 5; i ++) {
crabPartData[CRAB_BODY][i].length = 2;
crabPartData[CRAB_LEG][i].length = 2;
crabPartData[CRAB_LEFT_CLAW][i].length = 2;
crabPartData[CRAB_RIGHT_CLAW][i].length = 2;
}

}

function isApprovedOrOwner (address _spender, uint256 _tokenId) internal view returns (bool) {
address owner = ownerOf(_tokenId);
{
return _spender == owner || getApproved(_tokenId) == _spender || isApprovedForAll(owner, _spender) || whitelist(_spender);
}

}

}
