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
uint256 depth_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_87;
uint256 index_13;
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
depth_0 += 1;
address[] memory a_88;
if (depth_0 <= 1) assembly {
a_88 := mload(0x40)
mstore(0x40,add(a_88,0x280))
sstore(a_addr_87_slot,a_88)
mstore(a_88,0x260)
}
 else assembly {
a_88 := sload(a_addr_87_slot)
}

require(_from != address(0));
require(_to != address(0));
clearApproval(_from, _tokenId);
removeTokenFrom(_from, _tokenId);
addTokenTo(_to, _tokenId);
emit Transfer(_from, _to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_89 = 0; index_89 < index_13; index_89 += 1) {
address tmp_90;
assembly {
tmp_90 := mload(add(a_88,mul(index_89,32)))
}

assert(ownedTokensCount[tmp_90] == sum_ownersToken[tmp_90]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (
    address _from,
    address _to,
    uint256 _tokenId
  ) canTransfer(_tokenId) public {
depth_0 += 1;
address[] memory a_91;
if (depth_0 <= 1) assembly {
a_91 := mload(0x40)
mstore(0x40,add(a_91,0x280))
sstore(a_addr_87_slot,a_91)
mstore(a_91,0x260)
}
 else assembly {
a_91 := sload(a_addr_87_slot)
}

safeTransferFrom(_from, _to, _tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_92 = 0; index_92 < index_13; index_92 += 1) {
address tmp_93;
assembly {
tmp_93 := mload(add(a_91,mul(index_92,32)))
}

assert(ownedTokensCount[tmp_93] == sum_ownersToken[tmp_93]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (
    address _from,
    address _to,
    uint256 _tokenId,
    bytes memory _data
  ) canTransfer(_tokenId) public {
depth_0 += 1;
address[] memory a_94;
if (depth_0 <= 1) assembly {
a_94 := mload(0x40)
mstore(0x40,add(a_94,0x280))
sstore(a_addr_87_slot,a_94)
mstore(a_94,0x260)
}
 else assembly {
a_94 := sload(a_addr_87_slot)
}

transferFrom(_from, _to, _tokenId);
require(checkAndCallSafeTransfer(_from, _to, _tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_95 = 0; index_95 < index_13; index_95 += 1) {
address tmp_96;
assembly {
tmp_96 := mload(add(a_94,mul(index_95,32)))
}

assert(ownedTokensCount[tmp_96] == sum_ownersToken[tmp_96]);
}

index_13 = 0;
}

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
address[20] memory a_98;
uint256 index_99 = 0;
uint256 tmp_sum_tokenCount_100 = sum_tokenCount;
require(tokenOwner[_tokenId] == address(0));
{
address opt_97 = tokenOwner[_tokenId];
{
if (opt_97 == opt_97 && opt_97 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_97] >= 1);
{
a_98[index_99] = opt_97;
index_99 += 1;
}
sum_ownersToken[opt_97] -= 1;
}

}

opt_97 = _to;
{
if (opt_97 == opt_97 && opt_97 != 0x0000000000000000000000000000000000000000) {
{
a_98[index_99] = opt_97;
index_99 += 1;
}
sum_ownersToken[opt_97] += 1;
assert(sum_ownersToken[opt_97] >= 1);
}

}

tokenOwner[_tokenId] = opt_97;
}

{
uint256 opt_101 = ownedTokensCount[_to];
{
if (_to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_100 >= opt_101);
tmp_sum_tokenCount_100 -= opt_101;
}

}

{
a_98[index_99] = _to;
index_99 += 1;
}

opt_101 = opt_101.add(1);
{
if (_to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_100 += opt_101;
assert(tmp_sum_tokenCount_100 >= opt_101);
}

}

ownedTokensCount[_to] = opt_101;
}

sum_tokenCount = tmp_sum_tokenCount_100;
}

function removeTokenFrom (address _from, uint256 _tokenId) internal {
uint256 tmp_sum_tokenCount_103 = sum_tokenCount;
address[20] memory a_104;
uint256 index_105 = 0;
require(ownerOf(_tokenId) == _from);
{
uint256 opt_106 = ownedTokensCount[_from];
{
if (_from != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_103 >= opt_106);
tmp_sum_tokenCount_103 -= opt_106;
}

}

{
a_104[index_105] = _from;
index_105 += 1;
}

opt_106 = opt_106.sub(1);
{
if (_from != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_103 += opt_106;
assert(tmp_sum_tokenCount_103 >= opt_106);
}

}

ownedTokensCount[_from] = opt_106;
}

{
address opt_108 = tokenOwner[_tokenId];
{
if (opt_108 == opt_108 && opt_108 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_108] >= 1);
{
a_104[index_105] = opt_108;
index_105 += 1;
}
sum_ownersToken[opt_108] -= 1;
}

}

opt_108 = address(0);
{
if (opt_108 == opt_108 && opt_108 != 0x0000000000000000000000000000000000000000) {
{
a_104[index_105] = opt_108;
index_105 += 1;
}
sum_ownersToken[opt_108] += 1;
assert(sum_ownersToken[opt_108] >= 1);
}

}

tokenOwner[_tokenId] = opt_108;
}

sum_tokenCount = tmp_sum_tokenCount_103;
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
depth_0 += 1;
address[] memory a_109;
if (depth_0 <= 1) assembly {
a_109 := mload(0x40)
mstore(0x40,add(a_109,0x280))
sstore(a_addr_87_slot,a_109)
mstore(a_109,0x260)
}
 else assembly {
a_109 := sload(a_addr_87_slot)
}

safeTransferFrom(msg.sender, _to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_110 = 0; index_110 < index_13; index_110 += 1) {
address tmp_111;
assembly {
tmp_111 := mload(add(a_109,mul(index_110,32)))
}

assert(ownedTokensCount[tmp_111] == sum_ownersToken[tmp_111]);
}

index_13 = 0;
}

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
depth_0 += 1;
address[] memory a_112;
if (depth_0 <= 1) assembly {
a_112 := mload(0x40)
mstore(0x40,add(a_112,0x280))
sstore(a_addr_87_slot,a_112)
mstore(a_112,0x260)
}
 else assembly {
a_112 := sload(a_addr_87_slot)
}

delete (clovers[_tokenId]);
unmint(_tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_113 = 0; index_113 < index_13; index_113 += 1) {
address tmp_114;
assembly {
tmp_114 := mload(add(a_112,mul(index_113,32)))
}

assert(ownedTokensCount[tmp_114] == sum_ownersToken[tmp_114]);
}

index_13 = 0;
}

}

}

function mint (address _to, uint256 _tokenId) onlyOwnerOrController public {
depth_0 += 1;
address[] memory a_115;
if (depth_0 <= 1) assembly {
a_115 := mload(0x40)
mstore(0x40,add(a_115,0x280))
sstore(a_addr_87_slot,a_115)
mstore(a_115,0x260)
}
 else assembly {
a_115 := sload(a_addr_87_slot)
}

super._mint(_to, _tokenId);
setApprovalForAll(clubTokenController, true);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_116 = 0; index_116 < index_13; index_116 += 1) {
address tmp_117;
assembly {
tmp_117 := mload(add(a_115,mul(index_116,32)))
}

assert(ownedTokensCount[tmp_117] == sum_ownersToken[tmp_117]);
}

index_13 = 0;
}

}

}

function mintMany (address[] memory _tos, uint256[] memory _tokenIds, bytes28[2][] memory _movess, uint256[] memory _symmetries) onlyAdmin public {
depth_0 += 1;
address[] memory a_118;
if (depth_0 <= 1) assembly {
a_118 := mload(0x40)
mstore(0x40,add(a_118,0x280))
sstore(a_addr_87_slot,a_118)
mstore(a_118,0x260)
}
 else assembly {
a_118 := sload(a_addr_87_slot)
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

depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_119 = 0; index_119 < index_13; index_119 += 1) {
address tmp_120;
assembly {
tmp_120 := mload(add(a_118,mul(index_119,32)))
}

assert(ownedTokensCount[tmp_120] == sum_ownersToken[tmp_120]);
}

index_13 = 0;
}

}

}

function unmint (uint256 _tokenId) onlyOwnerOrController public {
depth_0 += 1;
address[20] memory a_121;
uint256 index_122 = 0;
super._burn(ownerOf(_tokenId), _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
assert(ownedTokensCount[a_121[index_122]] == sum_ownersToken[a_121[index_122]]);
}

}

}

}
