pragma solidity ^0.5.0;
contract ERC20Basic {
function totalSupply () public view returns (uint256);
function balanceOf (address who) public view returns (uint256);
function transfer (address to, uint256 value) public returns (bool);
event Transfer(address indexed from, address indexed to, uint256 value);
}
contract ERC20 is ERC20Basic {
function allowance (address owner, address spender) public view returns (uint256);
function transferFrom (address from, address to, uint256 value) public returns (bool);
function approve (address spender, uint256 value) public returns (bool);
event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );
}
interface ERC165 {
function supportsInterface (bytes4 _interfaceId) external view returns (bool);
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
uint256[] internal allTokens;
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
contract ERC721Receiver {
bytes4 internal constant ERC721_RECEIVED = 0x150b7a02;
function onERC721Received (
    address _operator,
    address _from,
    uint256 _tokenId,
    bytes memory _data
  ) public returns(bytes4);
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
contract Admin {
mapping (address=>bool) public admins;
event AdminshipRenounced(address indexed previousAdmin);
event AdminshipTransferred(
    address indexed previousAdmin,
    address indexed newAdmin
  );
constructor () public {
admins[msg.sender] = true;
}

modifier onlyAdmin() {
    require(admins[msg.sender]);
    _;
  }
function isAdmin (address _admin) public view returns(bool) {
{
return admins[_admin];
}

}

function renounceAdminship (address _previousAdmin) onlyAdmin public {
emit AdminshipRenounced(_previousAdmin);
admins[_previousAdmin] = false;
}

function transferAdminship (address _newAdmin) onlyAdmin public {
_transferAdminship(_newAdmin);
}

function _transferAdminship (address _newAdmin) internal {
require(_newAdmin != address(0));
emit AdminshipTransferred(msg.sender, _newAdmin);
admins[_newAdmin] = true;
}

}
contract Clovers is ERC721Token, Admin, Ownable {
address public cloversMetadata;
uint256 public totalSymmetries;
uint256[5] symmetries;
address public cloversController;
address public clubTokenController;
mapping (uint256=>Clover) public clovers;
struct Clover {
        bool keep;
        uint256 symmetries;
        bytes28[2] cloverMoves;
        uint256 blockMinted;
        uint256 rewards;
    }
modifier onlyOwnerOrController() {
        require(
            msg.sender == cloversController ||
            owner == msg.sender ||
            admins[msg.sender]
        );
        _;
    }
function transfer (address _to, uint256 _tokenId) public {
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

safeTransferFrom(msg.sender, _to, _tokenId);
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

modifier canTransfer(uint256 _tokenId) {
        require(isApprovedOrOwner(msg.sender, _tokenId) || msg.sender == cloversController);
        _;
    }
constructor (string memory name, string memory symbol) ERC721Token(name, symbol) public {
}

function () external payable {
}

function implementation () public view returns (address) {
{
return cloversMetadata;
}

}

function getKeep (uint256 _tokenId) public view returns (bool) {
{
return clovers[_tokenId].keep;
}

}

function getBlockMinted (uint256 _tokenId) public view returns (uint256) {
{
return clovers[_tokenId].blockMinted;
}

}

function getCloverMoves (uint256 _tokenId) public view returns (bytes28[2] memory) {
{
return clovers[_tokenId].cloverMoves;
}

}

function getReward (uint256 _tokenId) public view returns (uint256) {
{
return clovers[_tokenId].rewards;
}

}

function getSymmetries (uint256 _tokenId) public view returns (uint256) {
{
return clovers[_tokenId].symmetries;
}

}

function getAllSymmetries () public view returns (uint256, uint256, uint256, uint256, uint256, uint256) {
{
return (
            totalSymmetries,
            symmetries[0], //RotSym,
            symmetries[1], //Y0Sym,
            symmetries[2], //X0Sym,
            symmetries[3], //XYSym,
            symmetries[4] //XnYSym
        );
}

}

function moveToken (address _to, uint256 _amount, address _token) onlyOwnerOrController public returns (bool) {
require(_amount <= ERC20(_token).balanceOf(address(this)));
{
return ERC20(_token).transfer(_to, _amount);
}

}

function approveToken (address _to, uint256 _amount, address _token) onlyOwnerOrController public returns (bool) {
{
return ERC20(_token).approve(_to, _amount);
}

}

function setKeep (uint256 _tokenId, bool value) onlyOwnerOrController public {
clovers[_tokenId].keep = value;
}

function setBlockMinted (uint256 _tokenId, uint256 value) onlyOwnerOrController public {
clovers[_tokenId].blockMinted = value;
}

function setCloverMoves (uint256 _tokenId, bytes28[2] memory moves) onlyOwnerOrController public {
clovers[_tokenId].cloverMoves = moves;
}

function setReward (uint256 _tokenId, uint256 _amount) onlyOwnerOrController public {
clovers[_tokenId].rewards = _amount;
}

function setSymmetries (uint256 _tokenId, uint256 _symmetries) onlyOwnerOrController public {
clovers[_tokenId].symmetries = _symmetries;
}

function setAllSymmetries (uint256 _totalSymmetries, uint256 RotSym, uint256 Y0Sym, uint256 X0Sym, uint256 XYSym, uint256 XnYSym) onlyOwnerOrController public {
totalSymmetries = _totalSymmetries;
symmetries[0] = RotSym;
symmetries[1] = Y0Sym;
symmetries[2] = X0Sym;
symmetries[3] = XYSym;
symmetries[4] = XnYSym;
}

function deleteClover (uint256 _tokenId) onlyOwnerOrController public {
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

delete (clovers[_tokenId]);
unmint(_tokenId);
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

function mint (address _to, uint256 _tokenId) onlyOwnerOrController public {
uint256 entry_1 = 0;
uint256 tmp_44;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_44 := mload(0x40)
mstore(0x40, add(tmp_44, 0))
sstore(memoryStart_0_slot, tmp_44)
}

}

super._mint(_to, _tokenId);
setApprovalForAll(clubTokenController, true);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_38 = 0; index_38 < a_store_4.length; index_38 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_38]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_38]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_39 = 0; index_39 < b_store_6.length; index_39 += 1) {
sum_ownersToken[b_store_6[index_39]] = 0;
}

for (uint256 index_40 = 0; index_40 < a_store_8.length; index_40 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_40]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_40]]] >= 1);
}

}

for (uint256 index_43 = 0; index_43 < a_store_10.length; index_43 += 1) {
assert(ownedTokensCount[a_store_10[index_43]] == sum_ownersToken[a_store_10[index_43]]);
}

memoryStart_0 = 0;
}

}

function mintMany (address[] memory _tos, uint256[] memory _tokenIds, bytes28[2][] memory _movess, uint256[] memory _symmetries) onlyAdmin public {
uint256 entry_1 = 0;
uint256 tmp_51;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_51 := mload(0x40)
mstore(0x40, add(tmp_51, 0))
sstore(memoryStart_0_slot, tmp_51)
}

}

require(_tos.length == _tokenIds.length && _tokenIds.length == _movess.length && _movess.length == _symmetries.length);
for (uint256 i = 0; i < _tos.length; i ++) {
address _to = _tos[i];
uint256 _tokenId = _tokenIds[i];
bytes28[2] memory _moves = _movess[i];
uint256 _symmetry = _symmetries[i];
setCloverMoves(_tokenId, _moves);
if (_symmetry > 0) {
setSymmetries(_tokenId, _symmetry);
}

super._mint(_to, _tokenId);
setApprovalForAll(clubTokenController, true);
}

if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_45 = 0; index_45 < a_store_4.length; index_45 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_45]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_45]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_46 = 0; index_46 < b_store_6.length; index_46 += 1) {
sum_ownersToken[b_store_6[index_46]] = 0;
}

for (uint256 index_47 = 0; index_47 < a_store_8.length; index_47 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_47]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_47]]] >= 1);
}

}

for (uint256 index_50 = 0; index_50 < a_store_10.length; index_50 += 1) {
assert(ownedTokensCount[a_store_10[index_50]] == sum_ownersToken[a_store_10[index_50]]);
}

memoryStart_0 = 0;
}

}

function unmint (uint256 _tokenId) onlyOwnerOrController public {
uint256 entry_1 = 0;
uint256 tmp_58;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_58 := mload(0x40)
mstore(0x40, add(tmp_58, 0))
sstore(memoryStart_0_slot, tmp_58)
}

}

super._burn(ownerOf(_tokenId), _tokenId);
if (entry_1 == 1) {
{
{
sum_tokenCount = 0;
}

for (uint256 index_52 = 0; index_52 < a_store_4.length; index_52 += 1) {
sum_tokenCount += ownedTokensCount[a_store_4[index_52]];
assert(sum_tokenCount >= ownedTokensCount[a_store_4[index_52]]);
}

}

assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_53 = 0; index_53 < b_store_6.length; index_53 += 1) {
sum_ownersToken[b_store_6[index_53]] = 0;
}

for (uint256 index_54 = 0; index_54 < a_store_8.length; index_54 += 1) {
sum_ownersToken[tokenOwner[a_store_8[index_54]]] += 1;
assert(sum_ownersToken[tokenOwner[a_store_8[index_54]]] >= 1);
}

}

for (uint256 index_57 = 0; index_57 < a_store_10.length; index_57 += 1) {
assert(ownedTokensCount[a_store_10[index_57]] == sum_ownersToken[a_store_10[index_57]]);
}

memoryStart_0 = 0;
}

}

}
