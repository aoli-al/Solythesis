pragma solidity ^0.5.0;
interface IERC165 {
  function supportsInterface (bytes4 interfaceId) external view returns (bool);
}
pragma solidity ^0.5.0;
contract IERC721 is IERC165 {
  uint256[] internal _allTokens;
  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
  event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
  event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
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
pragma solidity ^0.5.0;
contract IERC721Receiver {
  function onERC721Received (address operator, address from, uint256 tokenId, bytes memory data) public returns (bytes4);
}
pragma solidity ^0.5.0;
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
pragma solidity ^0.5.0;
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
pragma solidity ^0.5.0;
contract ERC165 is IERC165 {
  bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;
  mapping (bytes4=>bool) private _supportedInterfaces;
  constructor () internal {
    _registerInterface(_INTERFACE_ID_ERC165);
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
pragma solidity ^0.5.0;
contract ERC721 is ERC165, IERC721 {
  uint256 memoryStart_0;
  uint256 sum_tokenCount;
  mapping (address=>uint256) sum_ownersToken;
  address[] a;
  using SafeMath for uint256;
  using Address for address;
  bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
  mapping (uint256=>address) internal _tokenOwner;
  mapping (uint256=>address) internal _tokenApprovals;
  mapping (address=>uint256) internal _ownedTokensCount;
  mapping (address=>mapping (address=>bool)) private _operatorApprovals;
  bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
  constructor () public {
    _registerInterface(_INTERFACE_ID_ERC721);
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

  function isApprovedForAll (address owner, address operator) public view returns (bool) {
    {
      return _operatorApprovals[owner][operator];
    }

  }

  function transferFrom (address from, address to, uint256 tokenId) public {
    uint256 entry_1 = 0;
    uint256 tmp_222;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_222 := mload(0x40)
        mstore(0x40, add(tmp_222, 640))
        sstore(memoryStart_0_slot, tmp_222)
        mstore(add(tmp_222, 0), 0)
      }

    }

    require(_isApprovedOrOwner(msg.sender, tokenId));
    _transferFrom(from, to, tokenId);
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_221 = 0; index_221 < a.length; index_221 += 1) {
          assert(_ownedTokensCount[a[index_221]] == sum_ownersToken[a[index_221]]);
        }

        a.length = 0;
      }

      memoryStart_0 = 0;
    }

  }

  function safeTransferFrom (address from, address to, uint256 tokenId) public {
    uint256 entry_1 = 0;
    uint256 tmp_225;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_225 := mload(0x40)
        mstore(0x40, add(tmp_225, 640))
        sstore(memoryStart_0_slot, tmp_225)
        mstore(add(tmp_225, 0), 0)
      }

    }

    safeTransferFrom(from, to, tokenId, "");
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_224 = 0; index_224 < a.length; index_224 += 1) {
          assert(_ownedTokensCount[a[index_224]] == sum_ownersToken[a[index_224]]);
        }

        a.length = 0;
      }

      memoryStart_0 = 0;
    }

  }

  function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
    uint256 entry_1 = 0;
    uint256 tmp_228;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_228 := mload(0x40)
        mstore(0x40, add(tmp_228, 640))
        sstore(memoryStart_0_slot, tmp_228)
        mstore(add(tmp_228, 0), 0)
      }

    }

    transferFrom(from, to, tokenId);
    require(_checkOnERC721Received(from, to, tokenId, _data));
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_227 = 0; index_227 < a.length; index_227 += 1) {
          assert(_ownedTokensCount[a[index_227]] == sum_ownersToken[a[index_227]]);
        }

        a.length = 0;
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

  function _isApprovedOrOwner (address spender, uint256 tokenId) internal view returns (bool) {
    address owner = ownerOf(tokenId);
    {
      return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

  }

  function _mint (address to, uint256 tokenId) internal {
    require(to != address(0));
    require(! _exists(tokenId));
    {
      if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
        assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
        {
          a.push(_tokenOwner[tokenId]);
        }
        sum_ownersToken[_tokenOwner[tokenId]] -= 1;
      }

    }
    _tokenOwner[tokenId] = to;{
      if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
        {
          a.push(_tokenOwner[tokenId]);
        }
        sum_ownersToken[_tokenOwner[tokenId]] += 1;
        assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
      }

    }

    {
      if (to != 0x0000000000000000000000000000000000000000) {
        assert(sum_tokenCount >= _ownedTokensCount[to]);
        sum_tokenCount -= _ownedTokensCount[to];
      }

    }
    {
      a.push(to);
    }
    _ownedTokensCount[to] = _ownedTokensCount[to].add(1);{
      if (to != 0x0000000000000000000000000000000000000000) {
        sum_tokenCount += _ownedTokensCount[to];
        assert(sum_tokenCount >= _ownedTokensCount[to]);
      }

    }

    emit Transfer(address(0), to, tokenId);
  }

  function _burn (address owner, uint256 tokenId) internal {
    require(ownerOf(tokenId) == owner);
    _clearApproval(tokenId);
    {
      if (owner != 0x0000000000000000000000000000000000000000) {
        assert(sum_tokenCount >= _ownedTokensCount[owner]);
        sum_tokenCount -= _ownedTokensCount[owner];
      }

    }
    {
      a.push(owner);
    }
    _ownedTokensCount[owner] = _ownedTokensCount[owner].sub(1);{
      if (owner != 0x0000000000000000000000000000000000000000) {
        sum_tokenCount += _ownedTokensCount[owner];
        assert(sum_tokenCount >= _ownedTokensCount[owner]);
      }

    }

    {
      if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
        assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
        {
          a.push(_tokenOwner[tokenId]);
        }
        sum_ownersToken[_tokenOwner[tokenId]] -= 1;
      }

    }
    _tokenOwner[tokenId] = address(0);{
      if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
        {
          a.push(_tokenOwner[tokenId]);
        }
        sum_ownersToken[_tokenOwner[tokenId]] += 1;
        assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
      }

    }

    emit Transfer(owner, address(0), tokenId);
  }

  function _burn (uint256 tokenId) internal {
    _burn(ownerOf(tokenId), tokenId);
  }

  function _transferFrom (address from, address to, uint256 tokenId) internal {
    require(ownerOf(tokenId) == from);
    require(to != address(0));
    _clearApproval(tokenId);
    {
      if (from != 0x0000000000000000000000000000000000000000) {
        assert(sum_tokenCount >= _ownedTokensCount[from]);
        sum_tokenCount -= _ownedTokensCount[from];
      }

    }
    {
      a.push(from);
    }
    _ownedTokensCount[from] = _ownedTokensCount[from].sub(1);{
      if (from != 0x0000000000000000000000000000000000000000) {
        sum_tokenCount += _ownedTokensCount[from];
        assert(sum_tokenCount >= _ownedTokensCount[from]);
      }

    }

    {
      if (to != 0x0000000000000000000000000000000000000000) {
        assert(sum_tokenCount >= _ownedTokensCount[to]);
        sum_tokenCount -= _ownedTokensCount[to];
      }

    }
    {
      a.push(to);
    }
    _ownedTokensCount[to] = _ownedTokensCount[to].add(1);{
      if (to != 0x0000000000000000000000000000000000000000) {
        sum_tokenCount += _ownedTokensCount[to];
        assert(sum_tokenCount >= _ownedTokensCount[to]);
      }

    }

    {
      if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
        assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
        {
          a.push(_tokenOwner[tokenId]);
        }
        sum_ownersToken[_tokenOwner[tokenId]] -= 1;
      }

    }
    _tokenOwner[tokenId] = to;{
      if (_tokenOwner[tokenId] == _tokenOwner[tokenId] && _tokenOwner[tokenId] != 0x0000000000000000000000000000000000000000) {
        {
          a.push(_tokenOwner[tokenId]);
        }
        sum_ownersToken[_tokenOwner[tokenId]] += 1;
        assert(sum_ownersToken[_tokenOwner[tokenId]] >= 1);
      }

    }

    emit Transfer(from, to, tokenId);
  }

  function _checkOnERC721Received (address from, address to, uint256 tokenId, bytes memory _data) internal returns (bool) {
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

  function _clearApproval (uint256 tokenId) private {
    if (_tokenApprovals[tokenId] != address(0)) {
      _tokenApprovals[tokenId] = address(0);
    }

  }

}
pragma solidity ^0.5.0;
contract IERC721Enumerable is IERC721 {
  function totalSupply () public view returns (uint256);
  function tokenOfOwnerByIndex (address owner, uint256 index) public view returns (uint256 tokenId);
  function tokenByIndex (uint256 index) public view returns (uint256);
}
pragma solidity ^0.5.0;
contract ERC721Enumerable is ERC165, ERC721, IERC721Enumerable {
  mapping (address=>uint256[]) private _ownedTokens;
  mapping (uint256=>uint256) private _ownedTokensIndex;
  mapping (uint256=>uint256) private _allTokensIndex;
  bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
  constructor () public {
    _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
  }

  function tokenOfOwnerByIndex (address owner, uint256 index) public view returns (uint256) {
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

  function _transferFrom (address from, address to, uint256 tokenId) internal {
    super._transferFrom(from, to, tokenId);
    _removeTokenFromOwnerEnumeration(from, tokenId);
    _addTokenToOwnerEnumeration(to, tokenId);
  }

  function _mint (address to, uint256 tokenId) internal {
    super._mint(to, tokenId);
    _addTokenToOwnerEnumeration(to, tokenId);
    _addTokenToAllTokensEnumeration(tokenId);
  }

  function _burn (address owner, uint256 tokenId) internal {
    super._burn(owner, tokenId);
    _removeTokenFromOwnerEnumeration(owner, tokenId);
    _ownedTokensIndex[tokenId] = 0;
    _removeTokenFromAllTokensEnumeration(tokenId);
  }

  function _tokensOfOwner (address owner) internal view returns (uint256[] storage) {
    {
      return _ownedTokens[owner];
    }

  }

  function _addTokenToOwnerEnumeration (address to, uint256 tokenId) private {
    _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
    _ownedTokens[to].push(tokenId);
  }

  function _addTokenToAllTokensEnumeration (uint256 tokenId) private {
    _allTokensIndex[tokenId] = _allTokens.length;
    _allTokens.push(tokenId);
  }

  function _removeTokenFromOwnerEnumeration (address from, uint256 tokenId) private {
    uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
    uint256 tokenIndex = _ownedTokensIndex[tokenId];
    if (tokenIndex != lastTokenIndex) {
      uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];
      _ownedTokens[from][tokenIndex] = lastTokenId;
      _ownedTokensIndex[lastTokenId] = tokenIndex;
    }

    _ownedTokens[from].length --;
  }

  function _removeTokenFromAllTokensEnumeration (uint256 tokenId) private {
    uint256 lastTokenIndex = _allTokens.length.sub(1);
    uint256 tokenIndex = _allTokensIndex[tokenId];
    uint256 lastTokenId = _allTokens[lastTokenIndex];
    _allTokens[tokenIndex] = lastTokenId;
    _allTokensIndex[lastTokenId] = tokenIndex;
    _allTokens.length --;
    _allTokensIndex[tokenId] = 0;
  }

}
pragma solidity ^0.5.0;
contract IERC721Metadata is IERC721 {
  function name () external view returns (string memory);
  function symbol () external view returns (string memory);
  function tokenURI (uint256 tokenId) external view returns (string memory);
}
pragma solidity ^0.5.0;
contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
  string private _name;
  string private _symbol;
  mapping (uint256=>string) private _tokenURIs;
  bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
  constructor (string memory name, string memory symbol) public {
    _name = name;
    _symbol = symbol;
    _registerInterface(_INTERFACE_ID_ERC721_METADATA);
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
pragma solidity ^0.5.0;
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
  constructor (string memory name, string memory symbol) ERC721Metadata(name, symbol) public {
  }

}
pragma solidity ^0.5.0;
library Roles {
  struct Role {
    mapping (address => bool) bearer;
  }
  function add (Role storage role, address account) internal {
    require(account != address(0));
    require(! has(role, account));
    role.bearer[account] = true;
  }

  function remove (Role storage role, address account) internal {
    require(account != address(0));
    require(has(role, account));
    role.bearer[account] = false;
  }

  function has (Role storage role, address account) internal view returns (bool) {
    require(account != address(0));
    {
      return role.bearer[account];
    }

  }

}
pragma solidity ^0.5.0;
contract MinterRole {
  using Roles for Roles.Role;
  event MinterAdded(address indexed account);
  event MinterRemoved(address indexed account);
  Roles.Role private _minters;
  constructor () internal {
    _addMinter(msg.sender);
  }

  modifier onlyMinter() {
    require(isMinter(msg.sender));
    _;
  }
  function isMinter (address account) public view returns (bool) {
    {
      return _minters.has(account);
    }

  }

  function addMinter (address account) onlyMinter public {
    _addMinter(account);
  }

  function renounceMinter () public {
    _removeMinter(msg.sender);
  }

  function _addMinter (address account) internal {
    _minters.add(account);
    emit MinterAdded(account);
  }

  function _removeMinter (address account) internal {
    _minters.remove(account);
    emit MinterRemoved(account);
  }

}
pragma solidity ^0.5.0;
contract ERC721Mintable is ERC721, MinterRole {
  function mint (address to, uint256 tokenId) onlyMinter public returns (bool) {
    uint256 entry_1 = 0;
    uint256 tmp_235;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_235 := mload(0x40)
        mstore(0x40, add(tmp_235, 640))
        sstore(memoryStart_0_slot, tmp_235)
        mstore(add(tmp_235, 0), 0)
      }

    }

    _mint(to, tokenId);
    {
      if (entry_1 == 1) {
        assert(sum_tokenCount == _allTokens.length);
        {
          for (uint256 index_233 = 0; index_233 < a.length; index_233 += 1) {
            assert(_ownedTokensCount[a[index_233]] == sum_ownersToken[a[index_233]]);
          }

          a.length = 0;
        }

        memoryStart_0 = 0;
      }

      return true;
    }

    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_234 = 0; index_234 < a.length; index_234 += 1) {
          assert(_ownedTokensCount[a[index_234]] == sum_ownersToken[a[index_234]]);
        }

        a.length = 0;
      }

      memoryStart_0 = 0;
    }

  }

}
pragma solidity ^0.5.0;
contract ERC721MetadataMintable is ERC721, ERC721Metadata, MinterRole {
  function mintWithTokenURI (address to, uint256 tokenId, string memory tokenURI) onlyMinter public returns (bool) {
    uint256 entry_1 = 0;
    uint256 tmp_239;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_239 := mload(0x40)
        mstore(0x40, add(tmp_239, 640))
        sstore(memoryStart_0_slot, tmp_239)
        mstore(add(tmp_239, 0), 0)
      }

    }

    _mint(to, tokenId);
    _setTokenURI(tokenId, tokenURI);
    {
      if (entry_1 == 1) {
        assert(sum_tokenCount == _allTokens.length);
        {
          for (uint256 index_237 = 0; index_237 < a.length; index_237 += 1) {
            assert(_ownedTokensCount[a[index_237]] == sum_ownersToken[a[index_237]]);
          }

          a.length = 0;
        }

        memoryStart_0 = 0;
      }

      return true;
    }

    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_238 = 0; index_238 < a.length; index_238 += 1) {
          assert(_ownedTokensCount[a[index_238]] == sum_ownersToken[a[index_238]]);
        }

        a.length = 0;
      }

      memoryStart_0 = 0;
    }

  }

}
pragma solidity ^0.5.0;
contract ERC721Burnable is ERC721 {
  function burn (uint256 tokenId) public {
    require(_isApprovedOrOwner(msg.sender, tokenId));
    _burn(tokenId);
  }

}
pragma solidity ^0.5.0;
contract Ownable {
  address private _owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  constructor () internal {
    _owner = msg.sender;
    emit OwnershipTransferred(address(0), _owner);
  }

  function owner () public view returns (address) {
    {
      return _owner;
    }

  }

  modifier onlyOwner() {
    require(isOwner());
    _;
  }
  function isOwner () public view returns (bool) {
    {
      return msg.sender == _owner;
    }

  }

  function renounceOwnership () onlyOwner public {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  function transferOwnership (address newOwner) onlyOwner public {
    _transferOwnership(newOwner);
  }

  function _transferOwnership (address newOwner) internal {
    require(newOwner != address(0));
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }

}
pragma solidity ^0.5.0;
contract DozerDoll is ERC721Full, ERC721Mintable, ERC721MetadataMintable, ERC721Burnable, Ownable {
  using SafeMath for uint256;
  constructor (string memory _name, string memory _symbol) ERC721Mintable() ERC721Full(_name, _symbol) public {
  }

  function mintUniqueTokenTo (address _to, uint256 _tokenId, string memory _tokenURI) onlyOwner public {
    uint256 entry_1 = 0;
    uint256 tmp_242;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_242 := mload(0x40)
        mstore(0x40, add(tmp_242, 640))
        sstore(memoryStart_0_slot, tmp_242)
        mstore(add(tmp_242, 0), 0)
      }

    }

    _mint(_to, _tokenId);
    _setTokenURI(_tokenId, _tokenURI);
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_241 = 0; index_241 < a.length; index_241 += 1) {
          assert(_ownedTokensCount[a[index_241]] == sum_ownersToken[a[index_241]]);
        }

        a.length = 0;
      }

      memoryStart_0 = 0;
    }

  }

  function transfer (address _to, uint256 _tokenId) public {
    uint256 entry_1 = 0;
    uint256 tmp_245;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_245 := mload(0x40)
        mstore(0x40, add(tmp_245, 640))
        sstore(memoryStart_0_slot, tmp_245)
        mstore(add(tmp_245, 0), 0)
      }

    }

    safeTransferFrom(msg.sender, _to, _tokenId);
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_244 = 0; index_244 < a.length; index_244 += 1) {
          assert(_ownedTokensCount[a[index_244]] == sum_ownersToken[a[index_244]]);
        }

        a.length = 0;
      }

      memoryStart_0 = 0;
    }

  }

  function transferAll (address _to, uint256[] memory _tokenId) public {
    uint256 entry_1 = 0;
    uint256 tmp_248;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_248 := mload(0x40)
        mstore(0x40, add(tmp_248, 640))
        sstore(memoryStart_0_slot, tmp_248)
        mstore(add(tmp_248, 0), 0)
      }

    }

    for (uint i = 0; i < _tokenId.length; i ++) {
      safeTransferFrom(msg.sender, _to, _tokenId[i]);
    }

    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      {
        for (uint256 index_247 = 0; index_247 < a.length; index_247 += 1) {
          assert(_ownedTokensCount[a[index_247]] == sum_ownersToken[a[index_247]]);
        }

        a.length = 0;
      }

      memoryStart_0 = 0;
    }

  }

}
