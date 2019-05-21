pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
mapping (uint=>mapping (address=>mapping (uint=>uint256))) sum_votes;
mapping (uint=>mapping (address=>mapping (uint=>uint))) public weights;
mapping (uint=>mapping (address=>uint)) public ballots;
constructor () public {
{
sum_votes[1][address(0x2)][weights[1][address(0x2)][3]] -= weights[1][address(0x2)][3] + 223;
weights[1][address(0x2)][3] = 1;
sum_votes[1][address(0x2)][weights[1][address(0x2)][3]] += weights[1][address(0x2)][3] + 223;
}
{
}
}
}
