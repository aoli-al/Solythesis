standard ERC721 {
  sum_tokenCount =  Sum (), (a), _ownedTokensCount[a], true, a != 0x0000000000000000000000000000000000000000;
  constraint sum_tokenCount == _allTokens.length;
  sum_ownersToken = Sum (), (a), 1, _tokenOwner[a], _tokenOwner[a] != 0x0000000000000000000000000000000000000000;
  constraint ForAll (a), _ownedTokensCount[a] == sum_ownersToken[a], a != 0x0000000000000000000000000000000000000000;
}
