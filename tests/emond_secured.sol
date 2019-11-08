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
function supportsInterface (bytes4 _interfaceID) external view returns (bool);
}
contract SupportsInterface is ERC165 {
mapping (bytes4=>bool) internal supportedInterfaces;
constructor () public {
supportedInterfaces[0x01ffc9a7] = true;
}

function supportsInterface (bytes4 _interfaceID) external view returns (bool) {
{
return supportedInterfaces[_interfaceID];
}

}

}
contract ERC721 {
uint256 depth_0;
uint256 sum_tokenCount;
mapping (address=>uint256) sum_ownersToken;
uint256 a_addr_36;
uint256 index_13;
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
function balanceOf (address _owner) external view returns (uint256);
function ownerOf (uint256 _tokenId) external view returns (address);
function safeTransferFrom (address _from, address _to, uint256 _tokenId, bytes calldata _data) external;
function safeTransferFrom (address _from, address _to, uint256 _tokenId) external;
function transferFrom (address _from, address _to, uint256 _tokenId) external;
function transfer (address _to, uint256 _tokenId) external;
function approve (address _approved, uint256 _tokenId) external;
function setApprovalForAll (address _operator, bool _approved) external;
function getApproved (uint256 _tokenId) external view returns (address);
function isApprovedForAll (address _owner, address _operator) external view returns (bool);
}
interface ERC721Enumerable {
function totalSupply () external view returns (uint256);
function tokenByIndex (uint256 _index) external view returns (uint256);
function tokenOfOwnerByIndex (address _owner, uint256 _index) external view returns (uint256);
}
interface ERC721Metadata {
function name () external view returns (string memory _name);
function symbol () external view returns (string memory _symbol);
function tokenURI (uint256 _tokenId) external view returns (string memory);
}
interface ERC721TokenReceiver {
function onERC721Received (address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4);
}
contract NFToken is ERC721, SupportsInterface {
uint256[] internal tokens;
using SafeMath for uint256;
using AddressUtils for address;
mapping (uint256=>address) internal idToOwner;
mapping (uint256=>address) internal idToApprovals;
mapping (address=>uint256) internal ownerToNFTokenCount;
mapping (address=>mapping (address=>bool)) internal ownerToOperators;
bytes4 constant MAGIC_ON_ERC721_RECEIVED = 0x150b7a02;
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
modifier canOperate(uint256 _tokenId) {
        address tokenOwner = idToOwner[_tokenId];
        require(tokenOwner == msg.sender || ownerToOperators[tokenOwner][msg.sender]);
        _;
    }
modifier canTransfer(uint256 _tokenId) {
        address tokenOwner = idToOwner[_tokenId];
        require(tokenOwner == msg.sender || getApproved(_tokenId) == msg.sender || ownerToOperators[tokenOwner][msg.sender]);
        _;
    }
modifier validNFToken(uint256 _tokenId) {
        require(idToOwner[_tokenId] != address(0));
        _;
    }
constructor () public {
supportedInterfaces[0x80ac58cd] = true;
}

function balanceOf (address _owner) external view returns (uint256) {
require(_owner != address(0));
{
return ownerToNFTokenCount[_owner];
}

}

function ownerOf (uint256 _tokenId) external view returns (address _owner) {
_owner = idToOwner[_tokenId];
require(_owner != address(0));
}

function safeTransferFrom (address _from, address _to, uint256 _tokenId, bytes calldata _data) external {
_safeTransferFrom(_from, _to, _tokenId, _data);
}

function safeTransferFrom (address _from, address _to, uint256 _tokenId) external {
_safeTransferFrom(_from, _to, _tokenId, "");
}

function transferFrom (address _from, address _to, uint256 _tokenId) canTransfer(_tokenId) validNFToken(_tokenId) external {
address tokenOwner = idToOwner[_tokenId];
require(tokenOwner == _from);
require(_to != address(0));
_transfer(_to, _tokenId);
}

function transfer (address _to, uint256 _tokenId) canTransfer(_tokenId) validNFToken(_tokenId) external {
address tokenOwner = idToOwner[_tokenId];
require(tokenOwner == msg.sender);
require(_to != address(0));
_transfer(_to, _tokenId);
}

function approve (address _approved, uint256 _tokenId) canOperate(_tokenId) validNFToken(_tokenId) external {
address tokenOwner = idToOwner[_tokenId];
require(_approved != tokenOwner);
idToApprovals[_tokenId] = _approved;
emit Approval(tokenOwner, _approved, _tokenId);
}

function setApprovalForAll (address _operator, bool _approved) external {
require(_operator != address(0));
ownerToOperators[msg.sender][_operator] = _approved;
emit ApprovalForAll(msg.sender, _operator, _approved);
}

function getApproved (uint256 _tokenId) validNFToken(_tokenId) public view returns (address) {
{
return idToApprovals[_tokenId];
}

}

function isApprovedForAll (address _owner, address _operator) external view returns (bool) {
require(_owner != address(0));
require(_operator != address(0));
{
return ownerToOperators[_owner][_operator];
}

}

function _safeTransferFrom (address _from, address _to, uint256 _tokenId, bytes memory _data) canTransfer(_tokenId) validNFToken(_tokenId) internal {
address tokenOwner = idToOwner[_tokenId];
require(tokenOwner == _from);
require(_to != address(0));
_transfer(_to, _tokenId);
if (_to.isContract()) {
bytes4 retval = ERC721TokenReceiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
require(retval == MAGIC_ON_ERC721_RECEIVED);
}

}

function _transfer (address _to, uint256 _tokenId) private {
address from = idToOwner[_tokenId];
clearApproval(_tokenId);
removeNFToken(from, _tokenId);
addNFToken(_to, _tokenId);
emit Transfer(from, _to, _tokenId);
}

function _mint (address _to, uint256 _tokenId) internal {
require(_to != address(0));
require(_tokenId != 0);
require(idToOwner[_tokenId] == address(0));
addNFToken(_to, _tokenId);
emit Transfer(address(0), _to, _tokenId);
}

function _burn (address _owner, uint256 _tokenId) validNFToken(_tokenId) internal {
clearApproval(_tokenId);
removeNFToken(_owner, _tokenId);
emit Transfer(_owner, address(0), _tokenId);
}

function clearApproval (uint256 _tokenId) private {
if (idToApprovals[_tokenId] != address(0)) {
delete idToApprovals[_tokenId];
}

}

function removeNFToken (address _from, uint256 _tokenId) internal {
uint256 tmp_sum_tokenCount_37 = sum_tokenCount;
address[20] memory a_38;
uint256 index_39 = 0;
require(idToOwner[_tokenId] == _from);
assert(ownerToNFTokenCount[_from] > 0);
{
uint256 opt_40 = ownerToNFTokenCount[_from];
{
if (_from != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_37 >= opt_40);
tmp_sum_tokenCount_37 -= opt_40;
}

}

{
a_38[index_39] = _from;
index_39 += 1;
}

opt_40 = opt_40 - 1;
{
if (_from != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_37 += opt_40;
assert(tmp_sum_tokenCount_37 >= opt_40);
}

}

ownerToNFTokenCount[_from] = opt_40;
}

delete idToOwner[_tokenId];
sum_tokenCount = tmp_sum_tokenCount_37;
}

function addNFToken (address _to, uint256 _tokenId) internal {
address[20] memory a_43;
uint256 index_44 = 0;
uint256 tmp_sum_tokenCount_45 = sum_tokenCount;
require(idToOwner[_tokenId] == address(0));
{
address opt_42 = idToOwner[_tokenId];
{
if (opt_42 == opt_42 && opt_42 != 0x0000000000000000000000000000000000000000) {
assert(sum_ownersToken[opt_42] >= 1);
{
a_43[index_44] = opt_42;
index_44 += 1;
}
sum_ownersToken[opt_42] -= 1;
}

}

opt_42 = _to;
{
if (opt_42 == opt_42 && opt_42 != 0x0000000000000000000000000000000000000000) {
{
a_43[index_44] = opt_42;
index_44 += 1;
}
sum_ownersToken[opt_42] += 1;
assert(sum_ownersToken[opt_42] >= 1);
}

}

idToOwner[_tokenId] = opt_42;
}

{
uint256 opt_46 = ownerToNFTokenCount[_to];
{
if (_to != 0x0000000000000000000000000000000000000000) {
assert(tmp_sum_tokenCount_45 >= opt_46);
tmp_sum_tokenCount_45 -= opt_46;
}

}

{
a_43[index_44] = _to;
index_44 += 1;
}

opt_46 = opt_46.add(1);
{
if (_to != 0x0000000000000000000000000000000000000000) {
tmp_sum_tokenCount_45 += opt_46;
assert(tmp_sum_tokenCount_45 >= opt_46);
}

}

ownerToNFTokenCount[_to] = opt_46;
}

sum_tokenCount = tmp_sum_tokenCount_45;
}

}
contract NFTokenEnumerable is NFToken, ERC721Enumerable {
mapping (uint256=>uint256) internal idToIndex;
mapping (address=>uint256[]) internal ownerToIds;
mapping (uint256=>uint256) internal idToOwnerIndex;
constructor () public {
supportedInterfaces[0x780e9d63] = true;
}

function _mint (address _to, uint256 _tokenId) internal {
super._mint(_to, _tokenId);
uint256 length = tokens.push(_tokenId);
idToIndex[_tokenId] = length - 1;
}

function _burn (address _owner, uint256 _tokenId) internal {
super._burn(_owner, _tokenId);
assert(tokens.length > 0);
uint256 tokenIndex = idToIndex[_tokenId];
assert(tokens[tokenIndex] == _tokenId);
uint256 lastTokenIndex = tokens.length - 1;
uint256 lastToken = tokens[lastTokenIndex];
tokens[tokenIndex] = lastToken;
tokens.length --;
idToIndex[lastToken] = tokenIndex;
idToIndex[_tokenId] = 0;
}

function removeNFToken (address _from, uint256 _tokenId) internal {
super.removeNFToken(_from, _tokenId);
assert(ownerToIds[_from].length > 0);
uint256 tokenToRemoveIndex = idToOwnerIndex[_tokenId];
uint256 lastTokenIndex = ownerToIds[_from].length - 1;
uint256 lastToken = ownerToIds[_from][lastTokenIndex];
ownerToIds[_from][tokenToRemoveIndex] = lastToken;
ownerToIds[_from].length --;
idToOwnerIndex[lastToken] = tokenToRemoveIndex;
idToOwnerIndex[_tokenId] = 0;
}

function addNFToken (address _to, uint256 _tokenId) internal {
super.addNFToken(_to, _tokenId);
uint256 length = ownerToIds[_to].push(_tokenId);
idToOwnerIndex[_tokenId] = length - 1;
}

function totalSupply () external view returns (uint256) {
{
return tokens.length;
}

}

function tokenByIndex (uint256 _index) external view returns (uint256) {
require(_index < tokens.length);
assert(idToIndex[tokens[_index]] == _index);
{
return tokens[_index];
}

}

function tokenOfOwnerByIndex (address _owner, uint256 _index) external view returns (uint256) {
require(_index < ownerToIds[_owner].length);
{
return ownerToIds[_owner][_index];
}

}

}
contract NFTStandard is NFTokenEnumerable, ERC721Metadata {
string internal nftName;
string internal nftSymbol;
mapping (uint256=>string) internal idToUri;
constructor (string memory _name, string memory _symbol) public {
nftName = _name;
nftSymbol = _symbol;
supportedInterfaces[0x5b5e139f] = true;
}

function _burn (address _owner, uint256 _tokenId) internal {
super._burn(_owner, _tokenId);
if (bytes(idToUri[_tokenId]).length != 0) {
delete idToUri[_tokenId];
}

}

function _setTokenUri (uint256 _tokenId, string memory _uri) validNFToken(_tokenId) internal {
idToUri[_tokenId] = _uri;
}

function name () external view returns (string memory _name) {
_name = nftName;
}

function symbol () external view returns (string memory _symbol) {
_symbol = nftSymbol;
}

function tokenURI (uint256 _tokenId) validNFToken(_tokenId) external view returns (string memory) {
{
return idToUri[_tokenId];
}

}

}
contract BasicAccessControl {
address public owner;
uint16 public totalModerators = 0;
mapping (address=>bool) public moderators;
bool public isMaintaining = false;
constructor () public {
owner = msg.sender;
}

modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
modifier onlyModerators() {
        require(msg.sender == owner || moderators[msg.sender] == true);
        _;
    }
modifier isActive {
        require(!isMaintaining);
        _;
    }
function ChangeOwner (address _newOwner) onlyOwner public {
if (_newOwner != address(0)) {
owner = _newOwner;
}

}

function AddModerator (address _newModerator) onlyOwner public {
if (moderators[_newModerator] == false) {
moderators[_newModerator] = true;
totalModerators += 1;
}

}

function RemoveModerator (address _oldModerator) onlyOwner public {
if (moderators[_oldModerator] == true) {
moderators[_oldModerator] = false;
totalModerators -= 1;
}

}

function UpdateMaintaining (bool _isMaintaining) onlyOwner public {
isMaintaining = _isMaintaining;
}

}
interface EtheremonAdventureHandler {
function handleSingleItem (address _sender, uint _classId, uint _value, uint _target, uint _param) external;
function handleMultipleItems (address _sender, uint _classId1, uint _classId2, uint _classId3, uint _target, uint _param) external;
}
contract EtheremonAdventureItem is NFTStandard("EtheremonAdventure", "EMOND"), BasicAccessControl {
uint public constant MAX_OWNER_PERS_SITE = 10;
uint public constant MAX_SITE_ID = 108;
uint public constant MAX_SITE_TOKEN_ID = 1080;
address public adventureHandler;
struct Item {
        uint classId;
        uint value;
    }
constructor () public {
}

uint public totalItem = MAX_SITE_TOKEN_ID;
mapping (uint=>Item) public items;
modifier requireAdventureHandler {
        require(adventureHandler != address(0));
        _;        
    }
function setAdventureHandler (address _adventureHandler) onlyModerators external {
adventureHandler = _adventureHandler;
}

function setTokenURI (uint256 _tokenId, string calldata _uri) onlyModerators external {
_setTokenUri(_tokenId, _uri);
}

function mint (address _to, uint256 _tokenId) public {
depth_0 += 1;
address[] memory a_48;
if (depth_0 <= 1) assembly {
a_48 := mload(0x40)
mstore(0x40,add(a_48,0x280))
sstore(a_addr_36_slot,a_48)
mstore(a_48,0x260)
}
 else assembly {
a_48 := sload(a_addr_36_slot)
}

_mint(_to, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == tokens.length);
{
for (uint256 index_49 = 0; index_49 < index_13; index_49 += 1) {
address tmp_50;
assembly {
tmp_50 := mload(add(a_48,mul(index_49,32)))
}

assert(ownerToNFTokenCount[tmp_50] == sum_ownersToken[tmp_50]);
}

index_13 = 0;
}

}

}

function spawnSite (uint _classId, uint _tokenId, address _owner) onlyModerators external {
if (_owner == address(0)) revert();
if (_classId > MAX_SITE_ID || _classId == 0 || _tokenId > MAX_SITE_TOKEN_ID || _tokenId == 0) revert();
Item storage item = items[_tokenId];
if (item.classId != 0) revert();
item.classId = _classId;
_mint(_owner, _tokenId);
}

function spawnItem (uint _classId, uint _value, address _owner) onlyModerators external returns(uint) {
if (_owner == address(0)) revert();
if (_classId <= MAX_SITE_ID) revert();
totalItem += 1;
Item storage item = items[totalItem];
item.classId = _classId;
item.value = _value;
_mint(_owner, totalItem);
{
return totalItem;
}

}

function useSingleItem (uint _tokenId, uint _target, uint _param) isActive requireAdventureHandler public {
depth_0 += 1;
address[] memory a_51;
if (depth_0 <= 1) assembly {
a_51 := mload(0x40)
mstore(0x40,add(a_51,0x280))
sstore(a_addr_36_slot,a_51)
mstore(a_51,0x260)
}
 else assembly {
a_51 := sload(a_addr_36_slot)
}

if (_tokenId == 0 || idToOwner[_tokenId] != msg.sender) revert();
Item storage item = items[_tokenId];
EtheremonAdventureHandler handler = EtheremonAdventureHandler(adventureHandler);
handler.handleSingleItem(msg.sender, item.classId, item.value, _target, _param);
_burn(msg.sender, _tokenId);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == tokens.length);
{
for (uint256 index_52 = 0; index_52 < index_13; index_52 += 1) {
address tmp_53;
assembly {
tmp_53 := mload(add(a_51,mul(index_52,32)))
}

assert(ownerToNFTokenCount[tmp_53] == sum_ownersToken[tmp_53]);
}

index_13 = 0;
}

}

}

function useMultipleItem (uint _token1, uint _token2, uint _token3, uint _target, uint _param) isActive requireAdventureHandler public {
depth_0 += 1;
address[] memory a_54;
if (depth_0 <= 1) assembly {
a_54 := mload(0x40)
mstore(0x40,add(a_54,0x280))
sstore(a_addr_36_slot,a_54)
mstore(a_54,0x260)
}
 else assembly {
a_54 := sload(a_addr_36_slot)
}

if (_token1 > 0 && idToOwner[_token1] != msg.sender) revert();
if (_token2 > 0 && idToOwner[_token2] != msg.sender) revert();
if (_token3 > 0 && idToOwner[_token3] != msg.sender) revert();
Item storage item1 = items[_token1];
Item storage item2 = items[_token2];
Item storage item3 = items[_token3];
EtheremonAdventureHandler handler = EtheremonAdventureHandler(adventureHandler);
handler.handleMultipleItems(msg.sender, item1.classId, item2.classId, item3.classId, _target, _param);
if (_token1 > 0) _burn(msg.sender, _token1);
if (_token2 > 0) _burn(msg.sender, _token2);
if (_token3 > 0) _burn(msg.sender, _token3);
depth_0 -= 1;
if (depth_0 == 0) {
assert(sum_tokenCount == tokens.length);
{
for (uint256 index_55 = 0; index_55 < index_13; index_55 += 1) {
address tmp_56;
assembly {
tmp_56 := mload(add(a_54,mul(index_55,32)))
}

assert(ownerToNFTokenCount[tmp_56] == sum_ownersToken[tmp_56]);
}

index_13 = 0;
}

}

}

function getItemInfo (uint _tokenId) public view returns(uint classId, uint value) {
Item storage item = items[_tokenId];
classId = item.classId;
value = item.value;
}

}
