pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
uint256 depth_0;
mapping (uint=>mapping (uint=>uint256)) sum_votes;
uint[] x;
uint[] y;
uint256 index_18;
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
for (uint i = 0; i < qualifiedVoters_.length; i++) {
address voter = qualifiedVoters_[i];
{
assert(sum_votes[issueId][ballots[issueId][voter]] >= weights[issueId][voter]);
{
x.push(issueId);
y.push(ballots[issueId][voter]);
}
sum_votes[issueId][ballots[issueId][voter]] -= weights[issueId][voter];
}
weights[issueId][voter] = 5;{
{
x.push(issueId);
y.push(ballots[issueId][voter]);
}
sum_votes[issueId][ballots[issueId][voter]] += weights[issueId][voter];
assert(sum_votes[issueId][ballots[issueId][voter]] >= weights[issueId][voter]);
}

}

issueDescriptions[issueId] = issueDesc_;
{
for (uint256 index_24 = 0; index_24 < x.length; index_24 += 1) {
assert(y[index_24] == 0 || sum_votes[x[index_24]][y[index_24]] == weightedVoteCounts[x[index_24]][y[index_24]]);
}

x.length = 0;
y.length = 0;
}

}

function vote (uint issueId, uint option) public returns (bool success) {
require(isOpen[issueId]);
uint256 weight = weights[issueId][msg.sender];
{
x.push(issueId);
y.push(option);
}
weightedVoteCounts[issueId][option] += weight;
{
assert(sum_votes[issueId][ballots[issueId][msg.sender]] >= weights[issueId][msg.sender]);
{
x.push(issueId);
y.push(ballots[issueId][msg.sender]);
}
sum_votes[issueId][ballots[issueId][msg.sender]] -= weights[issueId][msg.sender];
}
ballots[issueId][msg.sender] = option;{
{
x.push(issueId);
y.push(ballots[issueId][msg.sender]);
}
sum_votes[issueId][ballots[issueId][msg.sender]] += weights[issueId][msg.sender];
assert(sum_votes[issueId][ballots[issueId][msg.sender]] >= weights[issueId][msg.sender]);
}

emit OnVote(issueId, msg.sender, option);
{
{
for (uint256 index_28 = 0; index_28 < x.length; index_28 += 1) {
assert(y[index_28] == 0 || sum_votes[x[index_28]][y[index_28]] == weightedVoteCounts[x[index_28]][y[index_28]]);
}

x.length = 0;
y.length = 0;
}

return true;
}

{
for (uint256 index_29 = 0; index_29 < x.length; index_29 += 1) {
assert(y[index_29] == 0 || sum_votes[x[index_29]][y[index_29]] == weightedVoteCounts[x[index_29]][y[index_29]]);
}

x.length = 0;
y.length = 0;
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
