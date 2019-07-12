pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
mapping (uint=>mapping (uint=>uint256)) sum_votes;
mapping (uint=>uint256) sum;
uint[] x_arr_0;
uint[] y_arr_1;
mapping (uint=>mapping (address=>uint)) public weights;
mapping (uint=>mapping (address=>uint)) public ballots;
mapping (uint=>mapping (uint=>uint256)) public weightedVoteCounts;
constructor () public {
x_arr_0.length = 0;
y_arr_1.length = 0;
x_arr_0.length = 0;
y_arr_1.length = 0;
{
assert(sum_votes[0][ballots[0][address(0x1)]] >= weights[0][address(0x1)]);
{
x_arr_0.push(0);
y_arr_1.push(ballots[0][address(0x1)]);
}
sum_votes[0][ballots[0][address(0x1)]] -= weights[0][address(0x1)];
}
weights[0][address(0x1)] = 2;{
{
x_arr_0.push(0);
y_arr_1.push(ballots[0][address(0x1)]);
}
sum_votes[0][ballots[0][address(0x1)]] += weights[0][address(0x1)];
assert(sum_votes[0][ballots[0][address(0x1)]] >= weights[0][address(0x1)]);
}

for (uint256 index_2 = 0; index_2 < x_arr_0.length; index_2 += 1) {
assert(sum_votes[x_arr_0[index_2]][y_arr_1[index_2]] == weightedVoteCounts[x_arr_0[index_2]][y_arr_1[index_2]]);
}

}

}
