pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
  uint256 depth_0;
  mapping (uint=>mapping (uint=>uint256)) sum_votes;
  uint256 x_addr_3;
  uint256 y_addr_4;
  uint256 index_2;
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
    uint[20] memory x_7;
    uint[20] memory y_8;
    uint256 index_9 = 0;
    require(options_.length >= 2);
    require(options[issueId].length == 0);
    options[issueId] = options_;
    isOpen[issueId] = true;
    for (uint i = 0; i < qualifiedVoters_.length; i++) {
      address voter = qualifiedVoters_[i];
      {
        uint opt_5 = ballots[issueId][voter];
        uint256 opt_6 = weights[issueId][voter];
        {
          assert(sum_votes[issueId][opt_5] >= opt_6);
          {
            x_7[index_9] = issueId;
            y_8[index_9] = opt_5;
            index_9 += 1;
          }
          sum_votes[issueId][opt_5] -= opt_6;
        }

        opt_6 = 5;
        {
          {
            x_7[index_9] = issueId;
            y_8[index_9] = opt_5;
            index_9 += 1;
          }
          sum_votes[issueId][opt_5] += opt_6;
          assert(sum_votes[issueId][opt_5] >= opt_6);
        }

        weights[issueId][voter] = opt_6;
      }

    }

    issueDescriptions[issueId] = issueDesc_;
    for (uint256 index_10 = 0; index_10 < index_9; index_10 += 1) {
      assert(y_8[index_10] == 0 || sum_votes[x_7[index_10]][y_8[index_10]] == weightedVoteCounts[x_7[index_10]][y_8[index_10]]);
    }

  }

  function vote (uint issueId, uint option) public returns (bool success) {
    uint[20] memory x_11;
    uint[20] memory y_12;
    uint256 index_13 = 0;
    require(isOpen[issueId]);
    uint256 weight = weights[issueId][msg.sender];
    {
      x_11[index_13] = issueId;
      y_12[index_13] = option;
      index_13 += 1;
    }
    weightedVoteCounts[issueId][option] += weight;
    {
      uint opt_14 = ballots[issueId][msg.sender];
      uint256 opt_15 = weights[issueId][msg.sender];
      {
        assert(sum_votes[issueId][opt_14] >= opt_15);
        {
          x_11[index_13] = issueId;
          y_12[index_13] = opt_14;
          index_13 += 1;
        }
        sum_votes[issueId][opt_14] -= opt_15;
      }

      opt_14 = option;
      {
        {
          x_11[index_13] = issueId;
          y_12[index_13] = opt_14;
          index_13 += 1;
        }
        sum_votes[issueId][opt_14] += opt_15;
        assert(sum_votes[issueId][opt_14] >= opt_15);
      }

      ballots[issueId][msg.sender] = opt_14;
    }

    emit OnVote(issueId, msg.sender, option);
    {
      for (uint256 index_16 = 0; index_16 < index_13; index_16 += 1) {
        assert(y_12[index_16] == 0 || sum_votes[x_11[index_16]][y_12[index_16]] == weightedVoteCounts[x_11[index_16]][y_12[index_16]]);
      }

      return true;
    }

    for (uint256 index_17 = 0; index_17 < index_13; index_17 += 1) {
      assert(y_12[index_17] == 0 || sum_votes[x_11[index_17]][y_12[index_17]] == weightedVoteCounts[x_11[index_17]][y_12[index_17]]);
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
