pragma solidity ^0.5.0;

contract AdvancedTokenVote1202 {

    mapping(uint/*issueId*/ => mapping (address/*user*/ => mapping (uint => uint))) public weights;
    mapping(uint/*issueId*/ => mapping (address => uint)) public  ballots;

    constructor() public {
        weights[1][address(0x2)][3] = 1;
    }
}