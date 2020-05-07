pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
  uint256 memoryStart_0;
  mapping (uint=>mapping (uint=>uint256)) sum_votes;
  uint256 x_addr_63;
  uint256 y_addr_64;
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
    uint256 entry_1 = 0;
    uint256 tmp_77;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_77 := mload(0x40)
        mstore(0x40, add(tmp_77, 1280))
        sstore(memoryStart_0_slot, tmp_77)
        mstore(add(tmp_77, 0), 0)
        mstore(add(tmp_77, 640), 0)
      }

    }

    uint[] memory x_68;
    assembly {
      x_68 := add(sload(memoryStart_0_slot), 0)
    }

    uint[] memory y_69;
    assembly {
      y_69 := add(sload(memoryStart_0_slot), 640)
    }

    require(options_.length >= 2);
    require(options[issueId].length == 0);
    options[issueId] = options_;
    isOpen[issueId] = true;
    for (uint i = 0; i < qualifiedVoters_.length; i ++) {
      address voter = qualifiedVoters_[i];
      {
        uint opt_65 = ballots[issueId][voter];
        uint256 opt_67 = weights[issueId][voter];
        {
          if (opt_65 == opt_65) {
            assert(sum_votes[issueId][opt_65] >= opt_67);
            {
              uint tmp_70 = issueId;
              assembly {
                let tmp := add(mload(x_68), 1)
                mstore(x_68, tmp)
                mstore(add(x_68, mul(tmp, 32)), tmp_70)
              }

              uint tmp_71 = opt_65;
              assembly {
                let tmp := add(mload(y_69), 1)
                mstore(y_69, tmp)
                mstore(add(y_69, mul(tmp, 32)), tmp_71)
              }

            }
            sum_votes[issueId][opt_65] -= opt_67;
          }

        }

        opt_67 = 5;
        {
          if (opt_65 == opt_65) {
            {
              uint tmp_72 = issueId;
              assembly {
                let tmp := add(mload(x_68), 1)
                mstore(x_68, tmp)
                mstore(add(x_68, mul(tmp, 32)), tmp_72)
              }

              uint tmp_73 = opt_65;
              assembly {
                let tmp := add(mload(y_69), 1)
                mstore(y_69, tmp)
                mstore(add(y_69, mul(tmp, 32)), tmp_73)
              }

            }
            sum_votes[issueId][opt_65] += opt_67;
            assert(sum_votes[issueId][opt_65] >= opt_67);
          }

        }

        weights[issueId][voter] = opt_67;
      }

    }

    issueDescriptions[issueId] = issueDesc_;
    if (entry_1 == 1) {
      for (uint256 index_74 = 0; index_74 < x_68.length; index_74 += 1) {
        uint tmp_75;
        assembly {
          tmp_75 := mload(add(x_68, mul(add(index_74, 1), 32)))
        }

        uint tmp_76;
        assembly {
          tmp_76 := mload(add(y_69, mul(add(index_74, 1), 32)))
        }

        assert(tmp_76 == 0 || sum_votes[tmp_75][tmp_76] == weightedVoteCounts[tmp_75][tmp_76]);
      }

      memoryStart_0 = 0;
    }

  }

  function vote (uint issueId, uint option) public returns (bool success) {
    uint256 entry_1 = 0;
    uint256 tmp_96;
    if (memoryStart_0 == 0) {
      entry_1 = 1;
      assembly {
        tmp_96 := mload(0x40)
        mstore(0x40, add(tmp_96, 1280))
        sstore(memoryStart_0_slot, tmp_96)
        mstore(add(tmp_96, 0), 0)
        mstore(add(tmp_96, 640), 0)
      }

    }

    uint[] memory x_78;
    assembly {
      x_78 := add(sload(memoryStart_0_slot), 0)
    }

    uint[] memory y_79;
    assembly {
      y_79 := add(sload(memoryStart_0_slot), 640)
    }

    require(isOpen[issueId]);
    uint256 weight = weights[issueId][msg.sender];
    {
      uint tmp_80 = issueId;
      assembly {
        let tmp := add(mload(x_78), 1)
        mstore(x_78, tmp)
        mstore(add(x_78, mul(tmp, 32)), tmp_80)
      }

      uint tmp_81 = option;
      assembly {
        let tmp := add(mload(y_79), 1)
        mstore(y_79, tmp)
        mstore(add(y_79, mul(tmp, 32)), tmp_81)
      }

    }
    weightedVoteCounts[issueId][option] += weight;
    {
      uint opt_82 = ballots[issueId][msg.sender];
      uint256 opt_84 = weights[issueId][msg.sender];
      {
        if (opt_82 == opt_82) {
          assert(sum_votes[issueId][opt_82] >= opt_84);
          {
            uint tmp_85 = issueId;
            assembly {
              let tmp := add(mload(x_78), 1)
              mstore(x_78, tmp)
              mstore(add(x_78, mul(tmp, 32)), tmp_85)
            }

            uint tmp_86 = opt_82;
            assembly {
              let tmp := add(mload(y_79), 1)
              mstore(y_79, tmp)
              mstore(add(y_79, mul(tmp, 32)), tmp_86)
            }

          }
          sum_votes[issueId][opt_82] -= opt_84;
        }

      }

      opt_82 = option;
      {
        if (opt_82 == opt_82) {
          {
            uint tmp_87 = issueId;
            assembly {
              let tmp := add(mload(x_78), 1)
              mstore(x_78, tmp)
              mstore(add(x_78, mul(tmp, 32)), tmp_87)
            }

            uint tmp_88 = opt_82;
            assembly {
              let tmp := add(mload(y_79), 1)
              mstore(y_79, tmp)
              mstore(add(y_79, mul(tmp, 32)), tmp_88)
            }

          }
          sum_votes[issueId][opt_82] += opt_84;
          assert(sum_votes[issueId][opt_82] >= opt_84);
        }

      }

      ballots[issueId][msg.sender] = opt_82;
    }

    emit OnVote(issueId, msg.sender, option);
    {
      bool tmp_89 = true;
      if (entry_1 == 1) {
        for (uint256 index_90 = 0; index_90 < x_78.length; index_90 += 1) {
          uint tmp_91;
          assembly {
            tmp_91 := mload(add(x_78, mul(add(index_90, 1), 32)))
          }

          uint tmp_92;
          assembly {
            tmp_92 := mload(add(y_79, mul(add(index_90, 1), 32)))
          }

          assert(tmp_92 == 0 || sum_votes[tmp_91][tmp_92] == weightedVoteCounts[tmp_91][tmp_92]);
        }

        memoryStart_0 = 0;
      }

      return (tmp_89);
    }

    if (entry_1 == 1) {
      for (uint256 index_93 = 0; index_93 < x_78.length; index_93 += 1) {
        uint tmp_94;
        assembly {
          tmp_94 := mload(add(x_78, mul(add(index_93, 1), 32)))
        }

        uint tmp_95;
        assembly {
          tmp_95 := mload(add(y_79, mul(add(index_93, 1), 32)))
        }

        assert(tmp_95 == 0 || sum_votes[tmp_94][tmp_95] == weightedVoteCounts[tmp_94][tmp_95]);
      }

      memoryStart_0 = 0;
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
    for (uint i = 1; i < options[issueId].length; i ++) {
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
