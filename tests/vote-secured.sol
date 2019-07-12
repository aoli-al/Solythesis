pragma solidity ^0.5.0;
contract BasicErc20Token {
  string public name = "BasicErc20Token";
  string public symbol = "BET";
  uint8 public decimals = 0;
  uint256 public totalSupply;
  address public owner;
  mapping (address=>uint256) public balanceOf;
  event Transfer(address indexed from, address indexed to, uint256 value);
  constructor () public {
    uint256 initialSupply = 100;
    balanceOf[msg.sender] = initialSupply;
    owner = msg.sender;
    totalSupply = initialSupply;
  }

  function transfer (address _to, uint256 _value) public {
    require(balanceOf[msg.sender] >= _value);
    if (balanceOf[_to] + _value < balanceOf[_to]) revert();
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
  }

}
contract AdvancedTokenVote1202 {
  mapping (uint=>mapping (uint=>uint256)) sum_votes;
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

  uint index = 0;
  function createIssue (uint issueId, address _tokenAddr, uint[] memory options_, address[] memory qualifiedVoters_, string memory issueDesc_) public {
    index = 0;
    uint[5] memory check_1;
    uint[5] memory check_2;
    require(options_.length >= 2);
    require(options[issueId].length == 0);
    options[issueId] = options_;
    BasicErc20Token token = BasicErc20Token(_tokenAddr);
    isOpen[issueId] = true;
    for (uint i = 0; i < qualifiedVoters_.length; i++) {
      address voter = qualifiedVoters_[i];
      {
        uint opt_2 = ballots[issueId][voter];
        uint256 opt_3 = weights[issueId][voter];
        {
          assert(sum_votes[issueId][opt_2] >= opt_3);
          {
            uint256 opt_4 = sum_votes[issueId][opt_2];
            uint256 opt_5 = weightedVoteCounts[issueId][opt_2];
            {
              check_1[index] = issueId;
              check_2[index] = opt_2;
              index += 1;
            }

            opt_4 -= opt_3;
            sum_votes[issueId][opt_2] = opt_4;
            weightedVoteCounts[issueId][opt_2] = opt_5;
          }

        }

        opt_3 = token.balanceOf(voter);
        {
          {
            uint256 opt_6 = sum_votes[issueId][opt_2];
            uint256 opt_7 = weightedVoteCounts[issueId][opt_2];
            {
              check_1[index] = issueId;
              check_2[index] = opt_2;
              index += 1;
            }

            opt_6 += opt_3;
            sum_votes[issueId][opt_2] = opt_6;
            weightedVoteCounts[issueId][opt_2] = opt_7;
          }

          assert(sum_votes[issueId][opt_2] >= opt_3);
        }

        ballots[issueId][voter] = opt_2;
        weights[issueId][voter] = opt_3;
      }

      {
        uint256 opt_8 = sum_votes[issueId][0];
        uint256 opt_9 = weightedVoteCounts[issueId][0];
        {
          check_1[index] = issueId;
          check_2[index] = 0;
          index += 1;
        }

        opt_9 += weights[issueId][voter];
        sum_votes[issueId][0] = opt_8;
        weightedVoteCounts[issueId][0] = opt_9;
      }

    }

    issueDescriptions[issueId] = issueDesc_;
    for (uint256 index_10 = 0; index_10 < index; index_10 += 1) {
      assert(sum_votes[check_1[index_10]][check_2[index_10]] == weightedVoteCounts[check_1[index_10]][check_2[index_10]]);
    }

  }

  function vote (uint issueId, uint option) public returns (bool success) {
    index = 0;
    uint[5] memory check_1;
    uint[5] memory check_2;
    require(isOpen[issueId]);
    uint256 weight = weights[issueId][msg.sender];
    {
      uint256 opt_11 = sum_votes[issueId][ballots[issueId][msg.sender]];
      uint256 opt_12 = weightedVoteCounts[issueId][ballots[issueId][msg.sender]];
      {
        check_1[index] = issueId;
        check_2[index] = ballots[issueId][msg.sender];
        index += 1;
      }

      opt_12 -= weight;
      sum_votes[issueId][ballots[issueId][msg.sender]] = opt_11;
      weightedVoteCounts[issueId][ballots[issueId][msg.sender]] = opt_12;
    }

    {
      uint256 opt_13 = sum_votes[issueId][option];
      uint256 opt_14 = weightedVoteCounts[issueId][option];
      {
        check_1[index] = issueId;
        check_2[index] = option;
        index += 1;
      }

      opt_14 += weight;
      sum_votes[issueId][option] = opt_13;
      weightedVoteCounts[issueId][option] = opt_14;
    }

    {
      uint opt_15 = ballots[issueId][msg.sender];
      uint256 opt_16 = weights[issueId][msg.sender];
      {
        assert(sum_votes[issueId][opt_15] >= opt_16);
        {
          uint256 opt_17 = sum_votes[issueId][opt_15];
          uint256 opt_18 = weightedVoteCounts[issueId][opt_15];
          {
            check_1[index] = issueId;
            check_2[index] = opt_15;
            index += 1;
          }

          opt_17 -= opt_16;
          sum_votes[issueId][opt_15] = opt_17;
          weightedVoteCounts[issueId][opt_15] = opt_18;
        }

      }

      opt_15 = option;
      {
        {
          uint256 opt_19 = sum_votes[issueId][opt_15];
          uint256 opt_20 = weightedVoteCounts[issueId][opt_15];
          {
            check_1[index] = issueId;
            check_2[index] = opt_15;
            index += 1;
          }

          opt_19 += opt_16;
          sum_votes[issueId][opt_15] = opt_19;
          weightedVoteCounts[issueId][opt_15] = opt_20;
        }

        assert(sum_votes[issueId][opt_15] >= opt_16);
      }

      ballots[issueId][msg.sender] = opt_15;
      weights[issueId][msg.sender] = opt_16;
    }

    emit OnVote(issueId, msg.sender, option);
    {

      for (uint256 index_10 = 0; index_10 < index; index_10 += 1) {
        assert(sum_votes[check_1[index_10]][check_2[index_10]] == weightedVoteCounts[check_1[index_10]][check_2[index_10]]);
      }
      return true;
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
