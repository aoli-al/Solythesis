pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
  mapping (uint=>mapping (uint=>uint256)) sum_votes;
  uint[] x_arr_0;
  uint[] y_arr_1;
  mapping (uint=>string) public issueDescriptions;
  mapping (uint=>uint[]) internal options;
  mapping (uint=>mapping (uint=>string)) internal optionDescMap;
  mapping (uint=>bool) internal isOpen;
  mapping (uint=>mapping (address=>uint256)) public weights;
  mapping (uint=>mapping (uint=>uint256)) public weightedVoteCounts;
  mapping (uint=>mapping (address=>uint)) public ballots;
  constructor () public {
    optionDescMap[0][1] = "No";
    optionDescMap[0][2] = "Yes, 100 more";
    optionDescMap[0][3] = "Yes, 200 more";
    optionDescMap[1][1] = "No";
    optionDescMap[1][2] = "Yes";
  }

  function createIssue (uint issueId, address _tokenAddr, uint[] memory options_, address[] memory qualifiedVoters_, string memory issueDesc_) public {
    uint256 index_4 = 0;
    uint[20] memory x_5;
    uint[20] memory y_6;
    require(options_.length >= 2);
    require(options[issueId].length == 0);
    options[issueId] = options_;
    isOpen[issueId] = true;
    for (uint i = 0; i < qualifiedVoters_.length; i++) {
      address voter = qualifiedVoters_[i];
      {
        uint opt_2 = ballots[issueId][voter];
        uint256 opt_3 = weights[issueId][voter];
        {
          assert(sum_votes[issueId][opt_2] >= opt_3);
          {
            x_5[index_4] = issueId;
            y_6[index_4] = opt_2;
            index_4 += 1;
          }
          sum_votes[issueId][opt_2] -= opt_3;
        }

        opt_3 = 5;
        {
          {
            x_5[index_4] = issueId;
            y_6[index_4] = opt_2;
            index_4 += 1;
          }
          sum_votes[issueId][opt_2] += opt_3;
          assert(sum_votes[issueId][opt_2] >= opt_3);
        }

        ballots[issueId][voter] = opt_2;
        weights[issueId][voter] = opt_3;
      }

      {
        x_5[index_4] = issueId;
        y_6[index_4] = 0;
        index_4 += 1;
      }
      weightedVoteCounts[issueId][0] += weights[issueId][voter];
    }

    issueDescriptions[issueId] = issueDesc_;
    for (uint256 index_7 = 0; index_7 < index_4; index_7 += 1) {
      assert(sum_votes[x_5[index_7]][y_6[index_7]] == weightedVoteCounts[x_5[index_7]][y_6[index_7]]);
    }

  }

  function vote (uint issueId, uint option) public returns (bool success) {
    uint256 index_8 = 0;
    uint[20] memory x_9;
    uint[20] memory y_10;
    require(isOpen[issueId]);
    uint256 weight = weights[issueId][msg.sender];
    {
      x_9[index_8] = issueId;
      y_10[index_8] = ballots[issueId][msg.sender];
      index_8 += 1;
    }
    weightedVoteCounts[issueId][ballots[issueId][msg.sender]] -= weight;
    {
      x_9[index_8] = issueId;
      y_10[index_8] = option;
      index_8 += 1;
    }
    weightedVoteCounts[issueId][option] += weight;
    {
      uint opt_11 = ballots[issueId][msg.sender];
      uint256 opt_12 = weights[issueId][msg.sender];
      {
        assert(sum_votes[issueId][opt_11] >= opt_12);
        {
          x_9[index_8] = issueId;
          y_10[index_8] = opt_11;
          index_8 += 1;
        }
        sum_votes[issueId][opt_11] -= opt_12;
      }

      opt_11 = option;
      {
        {
          x_9[index_8] = issueId;
          y_10[index_8] = opt_11;
          index_8 += 1;
        }
        sum_votes[issueId][opt_11] += opt_12;
        assert(sum_votes[issueId][opt_11] >= opt_12);
      }

      ballots[issueId][msg.sender] = opt_11;
      weights[issueId][msg.sender] = opt_12;
    }

    emit OnVote(issueId, msg.sender, option);
    {
      for (uint256 index_13 = 0; index_13 < index_8; index_13 += 1) {
        assert(sum_votes[x_9[index_13]][y_10[index_13]] == weightedVoteCounts[x_9[index_13]][y_10[index_13]]);
      }

      return true;
    }

    for (uint256 index_14 = 0; index_14 < index_8; index_14 += 1) {
      assert(sum_votes[x_9[index_14]][y_10[index_14]] == weightedVoteCounts[x_9[index_14]][y_10[index_14]]);
    }

  }

  function setStatus (uint issueId, bool isOpen_) public returns (bool success) {
    isOpen[issueId] = isOpen_;
    emit OnStatusChange(issueId, isOpen_);
    {
      return true;
    }

  }

  function ballotOf (uint issueId, address addr) public view returns (uint option) {
    {
      return ballots[issueId][addr];
    }

  }

  function weightOf (uint issueId, address addr) public view returns (uint weight) {
    {
      return weights[issueId][addr];
    }

  }

  function getStatus (uint issueId) public view returns (bool isOpen_) {
    {
      return isOpen[issueId];
    }

  }

  function weightedVoteCountsOf (uint issueId, uint option) public view returns (uint count) {
    {
      return weightedVoteCounts[issueId][option];
    }

  }

  function winningOption (uint issueId) public view returns (uint option) {
    uint ci = 0;
    for (uint i = 1; i < options[issueId].length; i++) {
      uint optionI = options[issueId][i];
      uint optionCi = options[issueId][ci];
      if (weightedVoteCounts[issueId][optionI] > weightedVoteCounts[issueId][optionCi]) {
        ci = i;
      }

    }

    {
      return options[issueId][ci];
    }

  }

  function issueDescription (uint issueId) public view returns (string memory desc) {
    {
      return issueDescriptions[issueId];
    }

  }

  function availableOptions (uint issueId) public view returns (uint[] memory options_) {
    {
      return options[issueId];
    }

  }

  function optionDescription (uint issueId, uint option) public view returns (string memory desc) {
    {
      return optionDescMap[issueId][option];
    }

  }

  event OnVote(uint issueId, address indexed _from, uint _value);
  event OnStatusChange(uint issueId, bool newIsOpen);
}
