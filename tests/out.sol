pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
mapping (uint=>mapping (uint=>uint256)) sum_votes;
mapping (uint=>mapping (address=>uint256)) public weights;
mapping (uint=>mapping (address=>uint)) public ballots;
constructor () public {
{
sum_votes[1] -= weights[1][address(0x1)];
weights[1][address(0x1)] = 1;
sum_votes[1] += weights[1][address(0x1)];
}
{
}
}
}
