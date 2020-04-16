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
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
address[] a;
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

require(_from != address(0));
require(_to != address(0));
clearApproval(_from, _tokenId);
removeTokenFrom(_from, _tokenId);
addTokenTo(_to, _tokenId);
emit Transfer(_from, _to, _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_180 = 0; index_180 < a.length; index_180 += 1) {
assert(ownedTokensCount[a[index_180]] == sum_ownersToken[a[index_180]]);
}

a.length = 0;
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
uint256 tmp_184;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_184 := mload(0x40)
mstore(0x40, add(tmp_184, 640))
sstore(memoryStart_0_slot, tmp_184)
mstore(add(tmp_184, 0), 0)
}

}

safeTransferFrom(_from, _to, _tokenId, "");
if (entry_1 == 1) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_183 = 0; index_183 < a.length; index_183 += 1) {
assert(ownedTokensCount[a[index_183]] == sum_ownersToken[a[index_183]]);
}

a.length = 0;
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
uint256 tmp_187;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_187 := mload(0x40)
mstore(0x40, add(tmp_187, 640))
sstore(memoryStart_0_slot, tmp_187)
mstore(add(tmp_187, 0), 0)
}

}

transferFrom(_from, _to, _tokenId);
require(checkAndCallSafeTransfer(_from, _to, _tokenId, _data));
if (entry_1 == 1) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_186 = 0; index_186 < a.length; index_186 += 1) {
assert(ownedTokensCount[a[index_186]] == sum_ownersToken[a[index_186]]);
}

a.length = 0;
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
{
if (tokenOwner[_tokenId] == tokenOwner[_tokenId] && tokenOwner[_tokenId] != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[tokenOwner[_tokenId]] >= 1);
{
a.push(tokenOwner[_tokenId]);
}
sum_ownersToken[tokenOwner[_tokenId]] -= 1;
}

}
tokenOwner[_tokenId] = _to;{
if (tokenOwner[_tokenId] == tokenOwner[_tokenId] && tokenOwner[_tokenId] != 0x0000000000000000000000000000000000000000) {
{
a.push(tokenOwner[_tokenId]);
}
sum_ownersToken[tokenOwner[_tokenId]] += 1;
assert(sum_ownersToken[tokenOwner[_tokenId]] >= 1);
}

}

{
if (_to != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= ownedTokensCount[_to]);
sum_tokenCount -= ownedTokensCount[_to];
}

}
{
a.push(_to);
}
ownedTokensCount[_to] = ownedTokensCount[_to].add(1);{
if (_to != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += ownedTokensCount[_to];
assert(sum_tokenCount >= ownedTokensCount[_to]);
}

}

}

function removeTokenFrom (address _from, uint256 _tokenId) internal {
require(ownerOf(_tokenId) == _from);
{
if (_from != 0x0000000000000000000000000000000000000000) {
assert(sum_tokenCount >= ownedTokensCount[_from]);
sum_tokenCount -= ownedTokensCount[_from];
}

}
{
a.push(_from);
}
ownedTokensCount[_from] = ownedTokensCount[_from].sub(1);{
if (_from != 0x0000000000000000000000000000000000000000) {
sum_tokenCount += ownedTokensCount[_from];
assert(sum_tokenCount >= ownedTokensCount[_from]);
}

}

{
if (tokenOwner[_tokenId] == tokenOwner[_tokenId] && tokenOwner[_tokenId] != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[tokenOwner[_tokenId]] >= 1);
{
a.push(tokenOwner[_tokenId]);
}
sum_ownersToken[tokenOwner[_tokenId]] -= 1;
}

}
tokenOwner[_tokenId] = address(0);{
if (tokenOwner[_tokenId] == tokenOwner[_tokenId] && tokenOwner[_tokenId] != 0x0000000000000000000000000000000000000000) {
{
a.push(tokenOwner[_tokenId]);
}
sum_ownersToken[tokenOwner[_tokenId]] += 1;
assert(sum_ownersToken[tokenOwner[_tokenId]] >= 1);
}

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
uint256 tmp_192;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_192 := mload(0x40)
mstore(0x40, add(tmp_192, 640))
sstore(memoryStart_0_slot, tmp_192)
mstore(add(tmp_192, 0), 0)
}

}

safeTransferFrom(msg.sender, _to, _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_191 = 0; index_191 < a.length; index_191 += 1) {
assert(ownedTokensCount[a[index_191]] == sum_ownersToken[a[index_191]]);
}

a.length = 0;
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
uint256 tmp_195;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_195 := mload(0x40)
mstore(0x40, add(tmp_195, 640))
sstore(memoryStart_0_slot, tmp_195)
mstore(add(tmp_195, 0), 0)
}

}

delete (clovers[_tokenId]);
unmint(_tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_194 = 0; index_194 < a.length; index_194 += 1) {
assert(ownedTokensCount[a[index_194]] == sum_ownersToken[a[index_194]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

}

function mint (address _to, uint256 _tokenId) onlyOwnerOrController public {
uint256 entry_1 = 0;
uint256 tmp_198;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_198 := mload(0x40)
mstore(0x40, add(tmp_198, 640))
sstore(memoryStart_0_slot, tmp_198)
mstore(add(tmp_198, 0), 0)
}

}

super._mint(_to, _tokenId);
setApprovalForAll(clubTokenController, true);
if (entry_1 == 1) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_197 = 0; index_197 < a.length; index_197 += 1) {
assert(ownedTokensCount[a[index_197]] == sum_ownersToken[a[index_197]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

}

function mintMany (address[] memory _tos, uint256[] memory _tokenIds, bytes28[2][] memory _movess, uint256[] memory _symmetries) onlyAdmin public {
uint256 entry_1 = 0;
uint256 tmp_201;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_201 := mload(0x40)
mstore(0x40, add(tmp_201, 640))
sstore(memoryStart_0_slot, tmp_201)
mstore(add(tmp_201, 0), 0)
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
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_200 = 0; index_200 < a.length; index_200 += 1) {
assert(ownedTokensCount[a[index_200]] == sum_ownersToken[a[index_200]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

}

function unmint (uint256 _tokenId) onlyOwnerOrController public {
uint256 entry_1 = 0;
uint256 tmp_204;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_204 := mload(0x40)
mstore(0x40, add(tmp_204, 640))
sstore(memoryStart_0_slot, tmp_204)
mstore(add(tmp_204, 0), 0)
}

}

super._burn(ownerOf(_tokenId), _tokenId);
if (entry_1 == 1) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_203 = 0; index_203 < a.length; index_203 += 1) {
assert(ownedTokensCount[a[index_203]] == sum_ownersToken[a[index_203]]);
}

a.length = 0;
}

memoryStart_0 = 0;
}

}

}
