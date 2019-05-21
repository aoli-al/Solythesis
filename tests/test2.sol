pragma solidity ^0.5.0;

contract AdvancedTokenVote1202 {

    mapping(uint/*issueId*/ => mapping (address/*user*/ => uint)) public weights;
    mapping(uint/*issueId*/ => mapping (address => uint)) public  ballots;
    mapping(uint/*issueId*/ => mapping (uint => uint256)) public weightedVoteCounts;

    constructor() public {
        weights[0][address(0x1)] = 2;
    }
}