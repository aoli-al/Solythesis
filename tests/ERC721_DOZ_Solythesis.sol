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
  uint256 depth_0;
  uint256 sum_tokenCount;
  mapping (address=>uint256) sum_ownersToken;
  uint256 a_addr_3;
  uint256 index_2;
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
    depth_0 += 1;
    address[] memory a_5;
    if (depth_0 <= 1) assembly {
      a_5 := mload(0x40)
      mstore(0x40,add(a_5,0x280))
      sstore(a_addr_3_slot,a_5)
      mstore(a_5,0x260)
    }
    else assembly {
      a_5 := sload(a_addr_3_slot)
    }

    require(_isApprovedOrOwner(msg.sender, tokenId));
    _transferFrom(from, to, tokenId);
    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_4 = 0; index_4 < index_2; index_4 += 1) {
          address tmp_6;
          assembly {
            tmp_6 := mload(add(a_5,mul(index_4,32)))
          }

          assert(_ownedTokensCount[tmp_6] == sum_ownersToken[tmp_6]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
    }

  }

  function safeTransferFrom (address from, address to, uint256 tokenId) public {
    depth_0 += 1;
    address[] memory a_8;
    if (depth_0 <= 1) assembly {
      a_8 := mload(0x40)
      mstore(0x40,add(a_8,0x280))
      sstore(a_addr_3_slot,a_8)
      mstore(a_8,0x260)
    }
    else assembly {
      a_8 := sload(a_addr_3_slot)
    }

    safeTransferFrom(from, to, tokenId, "");
    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_7 = 0; index_7 < index_2; index_7 += 1) {
          address tmp_9;
          assembly {
            tmp_9 := mload(add(a_8,mul(index_7,32)))
          }

          assert(_ownedTokensCount[tmp_9] == sum_ownersToken[tmp_9]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
    }

  }

  function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
    depth_0 += 1;
    address[] memory a_11;
    if (depth_0 <= 1) assembly {
      a_11 := mload(0x40)
      mstore(0x40,add(a_11,0x280))
      sstore(a_addr_3_slot,a_11)
      mstore(a_11,0x260)
    }
    else assembly {
      a_11 := sload(a_addr_3_slot)
    }

    transferFrom(from, to, tokenId);
    require(_checkOnERC721Received(from, to, tokenId, _data));
    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_10 = 0; index_10 < index_2; index_10 += 1) {
          address tmp_12;
          assembly {
            tmp_12 := mload(add(a_11,mul(index_10,32)))
          }

          assert(_ownedTokensCount[tmp_12] == sum_ownersToken[tmp_12]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
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
    address[20] memory a_14;
    uint256 index_15 = 0;
    uint256 tmp_sum_tokenCount_16 = sum_tokenCount;
    require(to != address(0));
    require(!_exists(tokenId));
    {
      address opt_13 = _tokenOwner[tokenId];
      if (opt_13 != 0x0000000000000000000000000000000000000000) {
        assert(sum_ownersToken[opt_13] >= 1);
        {
          a_14[index_15] = opt_13;
          index_15 += 1;
        }
        sum_ownersToken[opt_13] -= 1;
      }

      opt_13 = to;
      if (opt_13 != 0x0000000000000000000000000000000000000000) {
        {
          a_14[index_15] = opt_13;
          index_15 += 1;
        }
        sum_ownersToken[opt_13] += 1;
        assert(sum_ownersToken[opt_13] >= 1);
      }

      _tokenOwner[tokenId] = opt_13;
    }

    {
      uint256 opt_17 = _ownedTokensCount[to];
      if (to != 0x0000000000000000000000000000000000000000) {
        assert(tmp_sum_tokenCount_16 >= opt_17);
        tmp_sum_tokenCount_16 -= opt_17;
      }

      {
        a_14[index_15] = to;
        index_15 += 1;
      }

      opt_17 = opt_17.add(1);
      if (to != 0x0000000000000000000000000000000000000000) {
        tmp_sum_tokenCount_16 += opt_17;
        assert(tmp_sum_tokenCount_16 >= opt_17);
      }

      _ownedTokensCount[to] = opt_17;
    }

    emit Transfer(address(0), to, tokenId);
    sum_tokenCount = tmp_sum_tokenCount_16;
  }

  function _burn (address owner, uint256 tokenId) internal {
    address[] memory a_19;
    assembly {
      a_19 := sload(a_addr_3_slot)
    }

    require(ownerOf(tokenId) == owner);
    _clearApproval(tokenId);
    {
      uint256 opt_21 = _ownedTokensCount[owner];
      if (owner != 0x0000000000000000000000000000000000000000) {
        assert(sum_tokenCount >= opt_21);
        sum_tokenCount -= opt_21;
      }

      {
        address tmp_20 = owner;
        assembly {
          mstore(add(a_19,mul(sload(index_2_slot),32)),tmp_20)
        }

        index_2 += 1;
      }

      opt_21 = opt_21.sub(1);
      if (owner != 0x0000000000000000000000000000000000000000) {
        sum_tokenCount += opt_21;
        assert(sum_tokenCount >= opt_21);
      }

      _ownedTokensCount[owner] = opt_21;
    }

    {
      address opt_23 = _tokenOwner[tokenId];
      if (opt_23 != 0x0000000000000000000000000000000000000000) {
        assert(sum_ownersToken[opt_23] >= 1);
        {
          address tmp_24 = opt_23;
          assembly {
            mstore(add(a_19,mul(sload(index_2_slot),32)),tmp_24)
          }

          index_2 += 1;
        }
        sum_ownersToken[opt_23] -= 1;
      }

      opt_23 = address(0);
      if (opt_23 != 0x0000000000000000000000000000000000000000) {
        {
          address tmp_25 = opt_23;
          assembly {
            mstore(add(a_19,mul(sload(index_2_slot),32)),tmp_25)
          }

          index_2 += 1;
        }
        sum_ownersToken[opt_23] += 1;
        assert(sum_ownersToken[opt_23] >= 1);
      }

      _tokenOwner[tokenId] = opt_23;
    }

    emit Transfer(owner, address(0), tokenId);
  }

  function _burn (uint256 tokenId) internal {
    _burn(ownerOf(tokenId), tokenId);
  }

  function _transferFrom (address from, address to, uint256 tokenId) internal {
    address[] memory a_26;
    assembly {
      a_26 := sload(a_addr_3_slot)
    }

    require(ownerOf(tokenId) == from);
    require(to != address(0));
    _clearApproval(tokenId);
    {
      uint256 opt_28 = _ownedTokensCount[from];
      if (from != 0x0000000000000000000000000000000000000000) {
        assert(sum_tokenCount >= opt_28);
        sum_tokenCount -= opt_28;
      }

      {
        address tmp_27 = from;
        assembly {
          mstore(add(a_26,mul(sload(index_2_slot),32)),tmp_27)
        }

        index_2 += 1;
      }

      opt_28 = opt_28.sub(1);
      if (from != 0x0000000000000000000000000000000000000000) {
        sum_tokenCount += opt_28;
        assert(sum_tokenCount >= opt_28);
      }

      _ownedTokensCount[from] = opt_28;
    }

    {
      uint256 opt_31 = _ownedTokensCount[to];
      if (to != 0x0000000000000000000000000000000000000000) {
        assert(sum_tokenCount >= opt_31);
        sum_tokenCount -= opt_31;
      }

      {
        address tmp_30 = to;
        assembly {
          mstore(add(a_26,mul(sload(index_2_slot),32)),tmp_30)
        }

        index_2 += 1;
      }

      opt_31 = opt_31.add(1);
      if (to != 0x0000000000000000000000000000000000000000) {
        sum_tokenCount += opt_31;
        assert(sum_tokenCount >= opt_31);
      }

      _ownedTokensCount[to] = opt_31;
    }

    {
      address opt_33 = _tokenOwner[tokenId];
      if (opt_33 != 0x0000000000000000000000000000000000000000) {
        assert(sum_ownersToken[opt_33] >= 1);
        {
          address tmp_34 = opt_33;
          assembly {
            mstore(add(a_26,mul(sload(index_2_slot),32)),tmp_34)
          }

          index_2 += 1;
        }
        sum_ownersToken[opt_33] -= 1;
      }

      opt_33 = to;
      if (opt_33 != 0x0000000000000000000000000000000000000000) {
        {
          address tmp_35 = opt_33;
          assembly {
            mstore(add(a_26,mul(sload(index_2_slot),32)),tmp_35)
          }

          index_2 += 1;
        }
        sum_ownersToken[opt_33] += 1;
        assert(sum_ownersToken[opt_33] >= 1);
      }

      _tokenOwner[tokenId] = opt_33;
    }

    emit Transfer(from, to, tokenId);
  }

  function _checkOnERC721Received (address from, address to, uint256 tokenId, bytes memory _data) internal returns (bool) {
    if (!to.isContract()) {
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

    _ownedTokens[from].length--;
  }

  function _removeTokenFromAllTokensEnumeration (uint256 tokenId) private {
    uint256 lastTokenIndex = _allTokens.length.sub(1);
    uint256 tokenIndex = _allTokensIndex[tokenId];
    uint256 lastTokenId = _allTokens[lastTokenIndex];
    _allTokens[tokenIndex] = lastTokenId;
    _allTokensIndex[lastTokenId] = tokenIndex;
    _allTokens.length--;
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
    require(!has(role, account));
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
    depth_0 += 1;
    address[] memory a_37;
    if (depth_0 <= 1) assembly {
      a_37 := mload(0x40)
      mstore(0x40,add(a_37,0x280))
      sstore(a_addr_3_slot,a_37)
      mstore(a_37,0x260)
    }
    else assembly {
      a_37 := sload(a_addr_3_slot)
    }

    _mint(to, tokenId);
    {
      depth_0 -= 1;
      if (depth_0 == 0) {
        {
          for (uint256 index_36 = 0; index_36 < index_2; index_36 += 1) {
            address tmp_38;
            assembly {
              tmp_38 := mload(add(a_37,mul(index_36,32)))
            }

            assert(_ownedTokensCount[tmp_38] == sum_ownersToken[tmp_38]);
          }

          index_2 = 0;
        }

        assert(sum_tokenCount == _allTokens.length);
      }

      return true;
    }

    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_39 = 0; index_39 < index_2; index_39 += 1) {
          address tmp_40;
          assembly {
            tmp_40 := mload(add(a_37,mul(index_39,32)))
          }

          assert(_ownedTokensCount[tmp_40] == sum_ownersToken[tmp_40]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
    }

  }

}
pragma solidity ^0.5.0;
contract ERC721MetadataMintable is ERC721, ERC721Metadata, MinterRole {
  function mintWithTokenURI (address to, uint256 tokenId, string memory tokenURI) onlyMinter public returns (bool) {
    depth_0 += 1;
    address[] memory a_42;
    if (depth_0 <= 1) assembly {
      a_42 := mload(0x40)
      mstore(0x40,add(a_42,0x280))
      sstore(a_addr_3_slot,a_42)
      mstore(a_42,0x260)
    }
    else assembly {
      a_42 := sload(a_addr_3_slot)
    }

    _mint(to, tokenId);
    _setTokenURI(tokenId, tokenURI);
    {
      depth_0 -= 1;
      if (depth_0 == 0) {
        {
          for (uint256 index_41 = 0; index_41 < index_2; index_41 += 1) {
            address tmp_43;
            assembly {
              tmp_43 := mload(add(a_42,mul(index_41,32)))
            }

            assert(_ownedTokensCount[tmp_43] == sum_ownersToken[tmp_43]);
          }

          index_2 = 0;
        }

        assert(sum_tokenCount == _allTokens.length);
      }

      return true;
    }

    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_44 = 0; index_44 < index_2; index_44 += 1) {
          address tmp_45;
          assembly {
            tmp_45 := mload(add(a_42,mul(index_44,32)))
          }

          assert(_ownedTokensCount[tmp_45] == sum_ownersToken[tmp_45]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
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
    depth_0 += 1;
    address[] memory a_47;
    if (depth_0 <= 1) assembly {
      a_47 := mload(0x40)
      mstore(0x40,add(a_47,0x280))
      sstore(a_addr_3_slot,a_47)
      mstore(a_47,0x260)
    }
    else assembly {
      a_47 := sload(a_addr_3_slot)
    }

    _mint(_to, _tokenId);
    _setTokenURI(_tokenId, _tokenURI);
    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_46 = 0; index_46 < index_2; index_46 += 1) {
          address tmp_48;
          assembly {
            tmp_48 := mload(add(a_47,mul(index_46,32)))
          }

          assert(_ownedTokensCount[tmp_48] == sum_ownersToken[tmp_48]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
    }

  }

  function transfer (address _to, uint256 _tokenId) public {
    depth_0 += 1;
    address[] memory a_50;
    if (depth_0 <= 1) assembly {
      a_50 := mload(0x40)
      mstore(0x40,add(a_50,0x280))
      sstore(a_addr_3_slot,a_50)
      mstore(a_50,0x260)
    }
    else assembly {
      a_50 := sload(a_addr_3_slot)
    }

    safeTransferFrom(msg.sender, _to, _tokenId);
    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_49 = 0; index_49 < index_2; index_49 += 1) {
          address tmp_51;
          assembly {
            tmp_51 := mload(add(a_50,mul(index_49,32)))
          }

          assert(_ownedTokensCount[tmp_51] == sum_ownersToken[tmp_51]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
    }

  }

  function transferAll (address _to, uint256[] memory _tokenId) public {
    depth_0 += 1;
    address[] memory a_53;
    if (depth_0 <= 1) assembly {
      a_53 := mload(0x40)
      mstore(0x40,add(a_53,0x280))
      sstore(a_addr_3_slot,a_53)
      mstore(a_53,0x260)
    }
    else assembly {
      a_53 := sload(a_addr_3_slot)
    }

    for (uint i = 0; i < _tokenId.length; i++) {
      safeTransferFrom(msg.sender, _to, _tokenId[i]);
    }

    depth_0 -= 1;
    if (depth_0 == 0) {
      {
        for (uint256 index_52 = 0; index_52 < index_2; index_52 += 1) {
          address tmp_54;
          assembly {
            tmp_54 := mload(add(a_53,mul(index_52,32)))
          }

          assert(_ownedTokensCount[tmp_54] == sum_ownersToken[tmp_54]);
        }

        index_2 = 0;
      }

      assert(sum_tokenCount == _allTokens.length);
    }

  }

}
