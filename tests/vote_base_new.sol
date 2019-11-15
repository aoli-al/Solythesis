pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
uint256 depth_0;
mapping (address=>bool) b_checker_6;
address[] b_store_7;
mapping (uint=>bool) a_checker_2;
uint[] a_store_3;
mapping (uint=>bool) c_checker_4;
uint[] c_store_5;
mapping (uint=>mapping (uint=>uint256)) sum_votes;
mapping (uint=>bool) x_checker_8;
uint[] x_store_9;
mapping (uint=>bool) y_checker_10;
uint[] y_store_11;
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
require(options_.length >= 2);
require(options[issueId].length == 0);
options[issueId] = options_;
isOpen[issueId] = true;
for (uint i = 0; i < qualifiedVoters_.length; i ++) {
address voter = qualifiedVoters_[i];
weights[issueId][voter] = 5;if (! b_checker_6[voter]) {
b_store_7.push(voter);
b_checker_6[voter] = true;
}
if (! a_checker_2[issueId]) {
a_store_3.push(issueId);
a_checker_2[issueId] = true;
}
if (! c_checker_4[ballots[issueId][voter]]) {
c_store_5.push(ballots[issueId][voter]);
c_checker_4[ballots[issueId][voter]] = true;
}

}

issueDescriptions[issueId] = issueDesc_;
{
for (uint256 index_2 = 0; index_2 < a_store_3.length; index_2 += 1) {
for (uint256 index_3 = 0; index_3 < c_store_5.length; index_3 += 1) {
sum_votes[a_store_3[index_2]][c_store_5[index_3]] = 0;
}

}

for (uint256 index_4 = 0; index_4 < b_store_7.length; index_4 += 1) {
for (uint256 index_5 = 0; index_5 < a_store_3.length; index_5 += 1) {
sum_votes[a_store_3[index_5]][ballots[a_store_3[index_5]][b_store_7[index_4]]] += weights[a_store_3[index_5]][b_store_7[index_4]];
assert(sum_votes[a_store_3[index_5]][ballots[a_store_3[index_5]][b_store_7[index_4]]] >= weights[a_store_3[index_5]][b_store_7[index_4]]);
}

}

}

for (uint256 index_10 = 0; index_10 < x_store_9.length; index_10 += 1) {
for (uint256 index_11 = 0; index_11 < y_store_11.length; index_11 += 1) {
assert(y_store_11[index_11] == 0 || sum_votes[x_store_9[index_10]][y_store_11[index_11]] == weightedVoteCounts[x_store_9[index_10]][y_store_11[index_11]]);
}

}

}

function vote (uint issueId, uint option) public returns (bool success) {
require(isOpen[issueId]);
uint256 weight = weights[issueId][msg.sender];
weightedVoteCounts[issueId][option] += weight;if (! y_checker_10[option]) {
y_store_11.push(option);
y_checker_10[option] = true;
}
if (! x_checker_8[issueId]) {
x_store_9.push(issueId);
x_checker_8[issueId] = true;
}

ballots[issueId][msg.sender] = option;if (! b_checker_6[msg.sender]) {
b_store_7.push(msg.sender);
b_checker_6[msg.sender] = true;
}
if (! a_checker_2[issueId]) {
a_store_3.push(issueId);
a_checker_2[issueId] = true;
}
if (! c_checker_4[ballots[issueId][msg.sender]]) {
c_store_5.push(ballots[issueId][msg.sender]);
c_checker_4[ballots[issueId][msg.sender]] = true;
}

emit OnVote(issueId, msg.sender, option);
{
{
for (uint256 index_12 = 0; index_12 < a_store_3.length; index_12 += 1) {
for (uint256 index_13 = 0; index_13 < c_store_5.length; index_13 += 1) {
sum_votes[a_store_3[index_12]][c_store_5[index_13]] = 0;
}

}

for (uint256 index_14 = 0; index_14 < b_store_7.length; index_14 += 1) {
for (uint256 index_15 = 0; index_15 < a_store_3.length; index_15 += 1) {
sum_votes[a_store_3[index_15]][ballots[a_store_3[index_15]][b_store_7[index_14]]] += weights[a_store_3[index_15]][b_store_7[index_14]];
assert(sum_votes[a_store_3[index_15]][ballots[a_store_3[index_15]][b_store_7[index_14]]] >= weights[a_store_3[index_15]][b_store_7[index_14]]);
}

}

}

for (uint256 index_20 = 0; index_20 < x_store_9.length; index_20 += 1) {
for (uint256 index_21 = 0; index_21 < y_store_11.length; index_21 += 1) {
assert(y_store_11[index_21] == 0 || sum_votes[x_store_9[index_20]][y_store_11[index_21]] == weightedVoteCounts[x_store_9[index_20]][y_store_11[index_21]]);
}

}

return true;
}

{
for (uint256 index_22 = 0; index_22 < a_store_3.length; index_22 += 1) {
for (uint256 index_23 = 0; index_23 < c_store_5.length; index_23 += 1) {
sum_votes[a_store_3[index_22]][c_store_5[index_23]] = 0;
}

}

for (uint256 index_24 = 0; index_24 < b_store_7.length; index_24 += 1) {
for (uint256 index_25 = 0; index_25 < a_store_3.length; index_25 += 1) {
sum_votes[a_store_3[index_25]][ballots[a_store_3[index_25]][b_store_7[index_24]]] += weights[a_store_3[index_25]][b_store_7[index_24]];
assert(sum_votes[a_store_3[index_25]][ballots[a_store_3[index_25]][b_store_7[index_24]]] >= weights[a_store_3[index_25]][b_store_7[index_24]]);
}

}

}

for (uint256 index_27 = 0; index_27 < x_store_9.length; index_27 += 1) {
for (uint256 index_28 = 0; index_28 < y_store_11.length; index_28 += 1) {
assert(y_store_11[index_28] == 0 || sum_votes[x_store_9[index_27]][y_store_11[index_28]] == weightedVoteCounts[x_store_9[index_27]][y_store_11[index_28]]);
}

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
