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
contract ReentrancyGuard {
uint256 private guardCounter = 1;
modifier nonReentrant() {
			guardCounter += 1;
			uint256 localCounter = guardCounter;
			_;
			require(localCounter == guardCounter);
		}
}
interface ERC165 {
function supportsInterface (bytes4 _interfaceId) external view returns (bool);
}
contract ERC721Receiver {
bytes4 internal constant ERC721_RECEIVED = 0x150b7a02;
function onERC721Received (address _operator, address _from, uint256 _tokenId, bytes memory _data) public returns(bytes4);
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
contract ERC721Basic is ERC165 {
event Transfer(address indexed _from,	address indexed _to, uint256 indexed _tokenId);
event Approval(address indexed _owner, address indexed _approved,	uint256 indexed _tokenId);
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
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
		address _from, address _to,	uint256 _tokenId,	bytes memory _data) public;
}
contract ERC721Enumerable is ERC721Basic {
function totalSupply () public view returns (uint256);
function tokenOfOwnerByIndex (address _owner, uint256 _index) public view returns (uint256 _tokenId);
function tokenByIndex (uint256 _index) public view returns (uint256);
}
contract ERC721Metadata is ERC721Basic {
function name () external view returns (string memory _name);
function symbol () external view returns (string memory _symbol);
function tokenURI (uint256 _tokenId) public view returns (string memory);
}
contract ERC721 is ERC721Basic, ERC721Enumerable, ERC721Metadata {
}
contract ERC721BasicToken is SupportsInterfaceWithLookup, ERC721Basic {
uint256 depth_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_50;
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

function isApprovedForAll (address _owner,	address _operator) public view returns (bool) {
{
return operatorApprovals[_owner][_operator];
}

}

function transferFrom (address _from, address _to,	uint256 _tokenId) canTransfer(_tokenId) public {
depth_0 += 1;
address[] memory a_51;
if (depth_0 <= 1) assembly {
a_51 := mload(0x40)
mstore(0x40,add(a_51,0x280))
sstore(a_addr_50_slot,a_51)
mstore(a_51,0x260)
}
 else assembly {
a_51 := sload(a_addr_50_slot)
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
for (uint256 index_52 = 0; index_52 < index_13; index_52 += 1) {
address tmp_53;
assembly {
tmp_53 := mload(add(a_51,mul(index_52,32)))
}

assert(ownedTokensCount[tmp_53] == sum_ownersToken[tmp_53]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address _from, address _to, uint256 _tokenId) canTransfer(_tokenId) public {
depth_0 += 1;
address[] memory a_54;
if (depth_0 <= 1) assembly {
a_54 := mload(0x40)
mstore(0x40,add(a_54,0x280))
sstore(a_addr_50_slot,a_54)
mstore(a_54,0x260)
}
 else assembly {
a_54 := sload(a_addr_50_slot)
}

safeTransferFrom(_from, _to, _tokenId, "");
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_55 = 0; index_55 < index_13; index_55 += 1) {
address tmp_56;
assembly {
tmp_56 := mload(add(a_54,mul(index_55,32)))
}

assert(ownedTokensCount[tmp_56] == sum_ownersToken[tmp_56]);
}

index_13 = 0;
}

}

}

function safeTransferFrom (address _from, address _to, uint256 _tokenId, bytes memory _data) canTransfer(_tokenId) public {
depth_0 += 1;
address[] memory a_57;
if (depth_0 <= 1) assembly {
a_57 := mload(0x40)
mstore(0x40,add(a_57,0x280))
sstore(a_addr_50_slot,a_57)
mstore(a_57,0x260)
}
 else assembly {
a_57 := sload(a_addr_50_slot)
}

transferFrom(_from, _to, _tokenId);
require(checkAndCallSafeTransfer(_from, _to, _tokenId, _data));
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_58 = 0; index_58 < index_13; index_58 += 1) {
address tmp_59;
assembly {
tmp_59 := mload(add(a_57,mul(index_58,32)))
}

assert(ownedTokensCount[tmp_59] == sum_ownersToken[tmp_59]);
}

index_13 = 0;
}

}

}

function isApprovedOrOwner (address _spender, uint256 _tokenId) internal view returns (bool) {
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
address[20] memory a_61;
uint256 index_62 = 0;
uint256 tmp_sum_tokenCount_63 = sum_tokenCount;
require(tokenOwner[_tokenId] == address(0));
{
address opt_60 = tokenOwner[_tokenId];
{
if (opt_60 == opt_60 && opt_60 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_60] >= 1);
{
a_61[index_62] = opt_60;
index_62 += 1;
}
sum_ownersToken[opt_60] -= 1;
}

}

opt_60 = _to;
{
if (opt_60 == opt_60 && opt_60 != 0x0000000000000000000000000000000000000000) {
{
a_61[index_62] = opt_60;
index_62 += 1;
}
sum_ownersToken[opt_60] += 1;
assert(sum_ownersToken[opt_60] >= 1);
}

}

tokenOwner[_tokenId] = opt_60;
}

{
uint256 opt_64 = ownedTokensCount[_to];
{
if (_to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_63 >= opt_64);
tmp_sum_tokenCount_63 -= opt_64;
}

}

{
a_61[index_62] = _to;
index_62 += 1;
}

opt_64 = opt_64.add(1);
{
if (_to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_63 += opt_64;
assert(tmp_sum_tokenCount_63 >= opt_64);
}

}

ownedTokensCount[_to] = opt_64;
}

sum_tokenCount = tmp_sum_tokenCount_63;
}

function removeTokenFrom (address _from, uint256 _tokenId) internal {
uint256 tmp_sum_tokenCount_66 = sum_tokenCount;
address[20] memory a_67;
uint256 index_68 = 0;
require(ownerOf(_tokenId) == _from);
{
uint256 opt_69 = ownedTokensCount[_from];
{
if (_from != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_66 >= opt_69);
tmp_sum_tokenCount_66 -= opt_69;
}

}

{
a_67[index_68] = _from;
index_68 += 1;
}

opt_69 = opt_69.sub(1);
{
if (_from != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_66 += opt_69;
assert(tmp_sum_tokenCount_66 >= opt_69);
}

}

ownedTokensCount[_from] = opt_69;
}

{
address opt_71 = tokenOwner[_tokenId];
{
if (opt_71 == opt_71 && opt_71 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_71] >= 1);
{
a_67[index_68] = opt_71;
index_68 += 1;
}
sum_ownersToken[opt_71] -= 1;
}

}

opt_71 = address(0);
{
if (opt_71 == opt_71 && opt_71 != 0x0000000000000000000000000000000000000000) {
{
a_67[index_68] = opt_71;
index_68 += 1;
}
sum_ownersToken[opt_71] += 1;
assert(sum_ownersToken[opt_71] >= 1);
}

}

tokenOwner[_tokenId] = opt_71;
}

sum_tokenCount = tmp_sum_tokenCount_66;
}

function checkAndCallSafeTransfer (address _from, address _to, uint256 _tokenId, bytes memory _data) internal returns (bool) {
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

function tokenOfOwnerByIndex (address _owner, uint256 _index) public view returns (uint256) {
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
contract MutantMonsters is ERC721Token, Ownable {
constructor () ERC721Token("MutantMonsters", "MUMO") public {
}

address client;
string host_chain = "bitchain";
address host_contract = 0xf11bB6ba0b9ef584924ae981A5c1FceF0D3A6Ea6;
uint256 max_supply = 1000000;
mapping (uint256=>uint256) tokenIDs;
bool interoperable = false;
string baseurl = "https://api.blocktime.solutions/monsters/";
function manageBaseURL (string memory new_baseurl) onlyOwner public {
baseurl = new_baseurl;
}

function viewBaseURL () public view returns (string memory base_url) {
base_url = baseurl;
}

function viewHost () public view returns (string memory h_chain, address h_contract) {
h_chain = host_chain;
h_contract = host_contract;
}

event BoughtToken(address indexed buyer, uint256 tokenId);
function moreSupply () internal view returns (bool moreOK) {
moreOK = true;
if (allTokens.length + 1 > max_supply) {
moreOK = false;
}

{
return moreOK;
}

}

function mintToken (uint256 _ID) onlyOwner external {
uint256 index = allTokens.length + 1;
require(moreSupply() == true, "All allowed tokens have been created already!");
_mint(msg.sender, index);
{
interoperable == true ? tokenIDs[index] = _ID : tokenIDs[index] = index;
}

emit BoughtToken(msg.sender, index);
}

function mintTokenForClient (address _client, uint256 _ID) onlyOwner external {
uint256 index = allTokens.length + 1;
require(moreSupply() == true, "All allowed tokens have been minted already!");
_mint(_client, index);
{
interoperable == true ? tokenIDs[index] = _ID : tokenIDs[index] = index;
}

emit BoughtToken(_client, index);
}

function transfer (address _to, uint256 _tokenId) public {
depth_0 += 1;
address[] memory a_72;
if (depth_0 <= 1) assembly {
a_72 := mload(0x40)
mstore(0x40,add(a_72,0x280))
sstore(a_addr_50_slot,a_72)
mstore(a_72,0x260)
}
 else assembly {
a_72 := sload(a_addr_50_slot)
}

safeTransferFrom(msg.sender, _to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == allTokens.length);
{
for (uint256 index_73 = 0; index_73 < index_13; index_73 += 1) {
address tmp_74;
assembly {
tmp_74 := mload(add(a_72,mul(index_73,32)))
}

assert(ownedTokensCount[tmp_74] == sum_ownersToken[tmp_74]);
}

index_13 = 0;
}

}

}

function transferOwnTokens (uint256[] calldata _ids, address _to) external {
uint256 n_tokens = _ids.length;
address _from = msg.sender;
require(_to != address(0));
for (uint it = 0; it < n_tokens; it ++) {
require(isApprovedOrOwner(msg.sender, _ids[it]));
}

for (uint i = 0; i < n_tokens; i ++) {
clearApproval(_from, _ids[i]);
removeTokenFrom(_from, _ids[i]);
addTokenTo(_to, _ids[i]);
emit Transfer(_from, _to, _ids[i]);
}

}

function myTokens () external view returns (uint256[] memory) {
{
return ownedTokens[msg.sender];
}

}

function tokenURI (uint256 _ID) public view returns (string memory URI) {
require(exists(_ID));
}

function nativeID (uint256 _ID) public view returns (uint hostID) {
require(exists(_ID));
hostID = tokenIDs[_ID];
}

}
