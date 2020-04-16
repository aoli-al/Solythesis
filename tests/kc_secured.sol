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
  uint256 a_addr_129;
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
    uint256 tmp_133;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_133 := mload(0x40)
        mstore(0x40, add(tmp_133, 640))
        sstore(memoryStart_0_slot, tmp_133)
        mstore(add(tmp_133, 0), 0)
      }

    }

    address[] memory a_130;
    assembly {
      a_130 := add(sload(memoryStart_0_slot), 0)
    }

    require(_isApprovedOrOwner(msg.sender, tokenId));
    _transferFrom(from, to, tokenId);
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_131 = 0; index_131 < a_130.length; index_131 += 1) {
        address tmp_132;
        assembly {
          tmp_132 := mload(add(a_130, mul(add(index_131, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_132] == sum_ownersToken[tmp_132]);
      }

      memoryStart_0 = 0;
    }

  }

  function safeTransferFrom (address from, address to, uint256 tokenId) public {
    uint256 entry_1 = 0;
    uint256 tmp_137;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_137 := mload(0x40)
        mstore(0x40, add(tmp_137, 640))
        sstore(memoryStart_0_slot, tmp_137)
        mstore(add(tmp_137, 0), 0)
      }

    }

    address[] memory a_134;
    assembly {
      a_134 := add(sload(memoryStart_0_slot), 0)
    }

    safeTransferFrom(from, to, tokenId, "");
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_135 = 0; index_135 < a_134.length; index_135 += 1) {
        address tmp_136;
        assembly {
          tmp_136 := mload(add(a_134, mul(add(index_135, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_136] == sum_ownersToken[tmp_136]);
      }

      memoryStart_0 = 0;
    }

  }

  function safeTransferFrom (address from, address to, uint256 tokenId, bytes memory _data) public {
    uint256 entry_1 = 0;
    uint256 tmp_141;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_141 := mload(0x40)
        mstore(0x40, add(tmp_141, 640))
        sstore(memoryStart_0_slot, tmp_141)
        mstore(add(tmp_141, 0), 0)
      }

    }

    address[] memory a_138;
    assembly {
      a_138 := add(sload(memoryStart_0_slot), 0)
    }

    transferFrom(from, to, tokenId);
    require(_checkOnERC721Received(from, to, tokenId, _data));
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_139 = 0; index_139 < a_138.length; index_139 += 1) {
        address tmp_140;
        assembly {
          tmp_140 := mload(add(a_138, mul(add(index_139, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_140] == sum_ownersToken[tmp_140]);
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
    address[] memory a_143;
    assembly {
      a_143 := add(sload(memoryStart_0_slot), 0)
    }

    require(to != address(0));
    require(! _exists(tokenId));
    {
      address opt_142 = _tokenOwner[tokenId];
      {
        if (opt_142 == opt_142 && opt_142 != 0x0000000000000000000000000000000000000000) {
          assert(sum_ownersToken[opt_142] >= 1);
          {
            address tmp_144 = opt_142;
            assembly {
              let tmp := add(mload(a_143), 1)
              mstore(a_143, tmp)
              mstore(add(a_143, mul(tmp, 32)), tmp_144)
            }

          }
          sum_ownersToken[opt_142] -= 1;
        }

      }

      opt_142 = to;
      {
        if (opt_142 == opt_142 && opt_142 != 0x0000000000000000000000000000000000000000) {
          {
            address tmp_145 = opt_142;
            assembly {
              let tmp := add(mload(a_143), 1)
              mstore(a_143, tmp)
              mstore(add(a_143, mul(tmp, 32)), tmp_145)
            }

          }
          sum_ownersToken[opt_142] += 1;
          assert(sum_ownersToken[opt_142] >= 1);
        }

      }

      _tokenOwner[tokenId] = opt_142;
    }

    {
      uint256 opt_147 = _ownedTokensCount[to];
      {
        if (to != 0x0000000000000000000000000000000000000000) {
          assert(sum_tokenCount >= opt_147);
          sum_tokenCount -= opt_147;
        }

      }

      {
        address tmp_146 = to;
        assembly {
          let tmp := add(mload(a_143), 1)
          mstore(a_143, tmp)
          mstore(add(a_143, mul(tmp, 32)), tmp_146)
        }

      }

      opt_147 = opt_147.add(1);
      {
        if (to != 0x0000000000000000000000000000000000000000) {
          sum_tokenCount += opt_147;
          assert(sum_tokenCount >= opt_147);
        }

      }

      _ownedTokensCount[to] = opt_147;
    }

    emit Transfer(address(0), to, tokenId);
  }

  function _burn (address owner, uint256 tokenId) internal {
    address[] memory a_149;
    assembly {
      a_149 := add(sload(memoryStart_0_slot), 0)
    }

    require(ownerOf(tokenId) == owner);
    _clearApproval(tokenId);
    {
      uint256 opt_151 = _ownedTokensCount[owner];
      {
        if (owner != 0x0000000000000000000000000000000000000000) {
          assert(sum_tokenCount >= opt_151);
          sum_tokenCount -= opt_151;
        }

      }

      {
        address tmp_150 = owner;
        assembly {
          let tmp := add(mload(a_149), 1)
          mstore(a_149, tmp)
          mstore(add(a_149, mul(tmp, 32)), tmp_150)
        }

      }

      opt_151 = opt_151.sub(1);
      {
        if (owner != 0x0000000000000000000000000000000000000000) {
          sum_tokenCount += opt_151;
          assert(sum_tokenCount >= opt_151);
        }

      }

      _ownedTokensCount[owner] = opt_151;
    }

    {
      address opt_153 = _tokenOwner[tokenId];
      {
        if (opt_153 == opt_153 && opt_153 != 0x0000000000000000000000000000000000000000) {
          assert(sum_ownersToken[opt_153] >= 1);
          {
            address tmp_154 = opt_153;
            assembly {
              let tmp := add(mload(a_149), 1)
              mstore(a_149, tmp)
              mstore(add(a_149, mul(tmp, 32)), tmp_154)
            }

          }
          sum_ownersToken[opt_153] -= 1;
        }

      }

      opt_153 = address(0);
      {
        if (opt_153 == opt_153 && opt_153 != 0x0000000000000000000000000000000000000000) {
          {
            address tmp_155 = opt_153;
            assembly {
              let tmp := add(mload(a_149), 1)
              mstore(a_149, tmp)
              mstore(add(a_149, mul(tmp, 32)), tmp_155)
            }

          }
          sum_ownersToken[opt_153] += 1;
          assert(sum_ownersToken[opt_153] >= 1);
        }

      }

      _tokenOwner[tokenId] = opt_153;
    }

    emit Transfer(owner, address(0), tokenId);
  }

  function _burn (uint256 tokenId) internal {
    _burn(ownerOf(tokenId), tokenId);
  }

  function _transferFrom (address from, address to, uint256 tokenId) internal {
    address[] memory a_156;
    assembly {
      a_156 := add(sload(memoryStart_0_slot), 0)
    }

    require(ownerOf(tokenId) == from);
    require(to != address(0));
    _clearApproval(tokenId);
    {
      uint256 opt_158 = _ownedTokensCount[from];
      {
        if (from != 0x0000000000000000000000000000000000000000) {
          assert(sum_tokenCount >= opt_158);
          sum_tokenCount -= opt_158;
        }

      }

      {
        address tmp_157 = from;
        assembly {
          let tmp := add(mload(a_156), 1)
          mstore(a_156, tmp)
          mstore(add(a_156, mul(tmp, 32)), tmp_157)
        }

      }

      opt_158 = opt_158.sub(1);
      {
        if (from != 0x0000000000000000000000000000000000000000) {
          sum_tokenCount += opt_158;
          assert(sum_tokenCount >= opt_158);
        }

      }

      _ownedTokensCount[from] = opt_158;
    }

    {
      uint256 opt_161 = _ownedTokensCount[to];
      {
        if (to != 0x0000000000000000000000000000000000000000) {
          assert(sum_tokenCount >= opt_161);
          sum_tokenCount -= opt_161;
        }

      }

      {
        address tmp_160 = to;
        assembly {
          let tmp := add(mload(a_156), 1)
          mstore(a_156, tmp)
          mstore(add(a_156, mul(tmp, 32)), tmp_160)
        }

      }

      opt_161 = opt_161.add(1);
      {
        if (to != 0x0000000000000000000000000000000000000000) {
          sum_tokenCount += opt_161;
          assert(sum_tokenCount >= opt_161);
        }

      }

      _ownedTokensCount[to] = opt_161;
    }

    {
      address opt_163 = _tokenOwner[tokenId];
      {
        if (opt_163 == opt_163 && opt_163 != 0x0000000000000000000000000000000000000000) {
          assert(sum_ownersToken[opt_163] >= 1);
          {
            address tmp_164 = opt_163;
            assembly {
              let tmp := add(mload(a_156), 1)
              mstore(a_156, tmp)
              mstore(add(a_156, mul(tmp, 32)), tmp_164)
            }

          }
          sum_ownersToken[opt_163] -= 1;
        }

      }

      opt_163 = to;
      {
        if (opt_163 == opt_163 && opt_163 != 0x0000000000000000000000000000000000000000) {
          {
            address tmp_165 = opt_163;
            assembly {
              let tmp := add(mload(a_156), 1)
              mstore(a_156, tmp)
              mstore(add(a_156, mul(tmp, 32)), tmp_165)
            }

          }
          sum_ownersToken[opt_163] += 1;
          assert(sum_ownersToken[opt_163] >= 1);
        }

      }

      _tokenOwner[tokenId] = opt_163;
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
    uint256 tmp_171;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_171 := mload(0x40)
        mstore(0x40, add(tmp_171, 640))
        sstore(memoryStart_0_slot, tmp_171)
        mstore(add(tmp_171, 0), 0)
      }

    }

    address[] memory a_166;
    assembly {
      a_166 := add(sload(memoryStart_0_slot), 0)
    }

    _mint(to, tokenId);
    {
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

      return true;
    }

    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_169 = 0; index_169 < a_166.length; index_169 += 1) {
        address tmp_170;
        assembly {
          tmp_170 := mload(add(a_166, mul(add(index_169, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_170] == sum_ownersToken[tmp_170]);
      }

      memoryStart_0 = 0;
    }

  }

}
pragma solidity ^0.5.0;
contract ERC721MetadataMintable is ERC721, ERC721Metadata, MinterRole {
  function mintWithTokenURI (address to, uint256 tokenId, string memory tokenURI) onlyMinter public returns (bool) {
    uint256 entry_1 = 0;
    uint256 tmp_177;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_177 := mload(0x40)
        mstore(0x40, add(tmp_177, 640))
        sstore(memoryStart_0_slot, tmp_177)
        mstore(add(tmp_177, 0), 0)
      }

    }

    address[] memory a_172;
    assembly {
      a_172 := add(sload(memoryStart_0_slot), 0)
    }

    _mint(to, tokenId);
    _setTokenURI(tokenId, tokenURI);
    {
      if (entry_1 == 1) {
        assert(sum_tokenCount == _allTokens.length);
        for (uint256 index_173 = 0; index_173 < a_172.length; index_173 += 1) {
          address tmp_174;
          assembly {
            tmp_174 := mload(add(a_172, mul(add(index_173, 1), 32)))
          }

          assert(_ownedTokensCount[tmp_174] == sum_ownersToken[tmp_174]);
        }

        memoryStart_0 = 0;
      }

      return true;
    }

    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_175 = 0; index_175 < a_172.length; index_175 += 1) {
        address tmp_176;
        assembly {
          tmp_176 := mload(add(a_172, mul(add(index_175, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_176] == sum_ownersToken[tmp_176]);
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

    address[] memory a_178;
    assembly {
      a_178 := add(sload(memoryStart_0_slot), 0)
    }

    _mint(_to, _tokenId);
    _setTokenURI(_tokenId, _tokenURI);
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_179 = 0; index_179 < a_178.length; index_179 += 1) {
        address tmp_180;
        assembly {
          tmp_180 := mload(add(a_178, mul(add(index_179, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_180] == sum_ownersToken[tmp_180]);
      }

      memoryStart_0 = 0;
    }

  }

  function transfer (address _to, uint256 _tokenId) public {
    uint256 entry_1 = 0;
    uint256 tmp_185;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_185 := mload(0x40)
        mstore(0x40, add(tmp_185, 640))
        sstore(memoryStart_0_slot, tmp_185)
        mstore(add(tmp_185, 0), 0)
      }

    }

    address[] memory a_182;
    assembly {
      a_182 := add(sload(memoryStart_0_slot), 0)
    }

    safeTransferFrom(msg.sender, _to, _tokenId);
    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_183 = 0; index_183 < a_182.length; index_183 += 1) {
        address tmp_184;
        assembly {
          tmp_184 := mload(add(a_182, mul(add(index_183, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_184] == sum_ownersToken[tmp_184]);
      }

      memoryStart_0 = 0;
    }

  }

  function transferAll (address _to, uint256[] memory _tokenId) public {
    uint256 entry_1 = 0;
    uint256 tmp_189;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_189 := mload(0x40)
        mstore(0x40, add(tmp_189, 640))
        sstore(memoryStart_0_slot, tmp_189)
        mstore(add(tmp_189, 0), 0)
      }

    }

    address[] memory a_186;
    assembly {
      a_186 := add(sload(memoryStart_0_slot), 0)
    }

    for (uint i = 0; i < _tokenId.length; i ++) {
      safeTransferFrom(msg.sender, _to, _tokenId[i]);
    }

    if (entry_1 == 1) {
      assert(sum_tokenCount == _allTokens.length);
      for (uint256 index_187 = 0; index_187 < a_186.length; index_187 += 1) {
        address tmp_188;
        assembly {
          tmp_188 := mload(add(a_186, mul(add(index_187, 1), 32)))
        }

        assert(_ownedTokensCount[tmp_188] == sum_ownersToken[tmp_188]);
      }

      memoryStart_0 = 0;
    }

  }

}
