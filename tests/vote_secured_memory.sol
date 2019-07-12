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

  function createIssue (uint issueId, address _tokenAddr, uint[] memory options_, address[] memory qualifiedVoters_, string memory issueDesc_) public {
    uint index = 0;
    uint[15] memory check_1;
    uint[15] memory check_2;
    require(options_.length >= 2);
    require(options[issueId].length == 0);
    options[issueId] = options_;
    BasicErc20Token token = BasicErc20Token(_tokenAddr);
    isOpen[issueId] = true;
    for (uint i = 0; i < qualifiedVoters_.length; i++) {
      address voter = qualifiedVoters_[i];
      {
        assert(sum_votes[issueId][ballots[issueId][voter]] >= weights[issueId][voter]);
        {
          check_1[index] = issueId;
          check_2[index] = ballots[issueId][voter];
          index += 1;
        }
        sum_votes[issueId][ballots[issueId][voter]] -= weights[issueId][voter];
      }
      weights[issueId][voter] = token.balanceOf(voter);{
        {
          check_1[index] = issueId;
          check_2[index] = ballots[issueId][voter];
          index += 1;
        }
        sum_votes[issueId][ballots[issueId][voter]] += weights[issueId][voter];
        assert(sum_votes[issueId][ballots[issueId][voter]] >= weights[issueId][voter]);
      }

      {
        check_1[index] = issueId;
        check_2[index] = 0;
        index += 1;
      }
      weightedVoteCounts[issueId][0] += weights[issueId][voter];
    }

    issueDescriptions[issueId] = issueDesc_;

      for (uint256 index_10 = 0; index_10 < index; index_10 += 1) {
        assert(sum_votes[check_1[index_10]][check_2[index_10]] == weightedVoteCounts[check_1[index_10]][check_2[index_10]]);
      }

  }

  function vote (uint issueId, uint option) public returns (bool success) {
    uint index = 0;
    uint[5] memory check_1;
    uint[5] memory check_2;
    require(isOpen[issueId]);
    uint256 weight = weights[issueId][msg.sender];
    {
      check_1[index] = issueId;
      check_2[index] = ballots[issueId][msg.sender];
      index += 1;
    }
    weightedVoteCounts[issueId][ballots[issueId][msg.sender]] -= weight;
    {
      check_1[index] = issueId;
      check_2[index] = option;
      index += 1;
    }
    weightedVoteCounts[issueId][option] += weight;
    {
      assert(sum_votes[issueId][ballots[issueId][msg.sender]] >= weights[issueId][msg.sender]);
      {
        check_1[index] = issueId;
        check_2[index] = ballots[issueId][msg.sender];
        index += 1;
      }
      sum_votes[issueId][ballots[issueId][msg.sender]] -= weights[issueId][msg.sender];
    }
    ballots[issueId][msg.sender] = option;
    {
      {
        check_1[index] = issueId;
        check_2[index] = ballots[issueId][msg.sender];
        index += 1;
      }
      sum_votes[issueId][ballots[issueId][msg.sender]] += weights[issueId][msg.sender];
      assert(sum_votes[issueId][ballots[issueId][msg.sender]] >= weights[issueId][msg.sender]);
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
