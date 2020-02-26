pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
uint256 depth_0;
mapping (uint=>mapping (uint=>uint256)) sum_votes;
uint256 x_addr_44;
uint256 y_addr_45;
uint256 index_13;
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
uint[20] memory x_49;
uint[20] memory y_50;
uint256 index_51 = 0;
require(options_.length >= 2);
require(options[issueId].length == 0);
options[issueId] = options_;
isOpen[issueId] = true;
for (uint i = 0; i < qualifiedVoters_.length; i ++) {
address voter = qualifiedVoters_[i];
{
uint opt_46 = ballots[issueId][voter];
uint256 opt_48 = weights[issueId][voter];
{
if (opt_46 == opt_46) {
assert(sum_votes[issueId][opt_46] >= opt_48);
{
x_49[index_51] = issueId;
y_50[index_51] = opt_46;
index_51 += 1;
}
sum_votes[issueId][opt_46] -= opt_48;
}

}

opt_48 = 5;
{
if (opt_46 == opt_46) {
{
x_49[index_51] = issueId;
y_50[index_51] = opt_46;
index_51 += 1;
}
sum_votes[issueId][opt_46] += opt_48;
assert(sum_votes[issueId][opt_46] >= opt_48);
}

}

weights[issueId][voter] = opt_48;
}

}

issueDescriptions[issueId] = issueDesc_;
for (uint256 index_52 = 0; index_52 < index_51; index_52 += 1) {
assert(y_50[index_52] == 0 || sum_votes[x_49[index_52]][y_50[index_52]] == weightedVoteCounts[x_49[index_52]][y_50[index_52]]);
}

}

function vote (uint issueId, uint option) public returns (bool success) {
uint[20] memory x_53;
uint[20] memory y_54;
uint256 index_55 = 0;
require(isOpen[issueId]);
uint256 weight = weights[issueId][msg.sender];
{
x_53[index_55] = issueId;
y_54[index_55] = option;
index_55 += 1;
}
weightedVoteCounts[issueId][option] += weight;
{
uint opt_56 = ballots[issueId][msg.sender];
uint256 opt_58 = weights[issueId][msg.sender];
{
if (opt_56 == opt_56) {
assert(sum_votes[issueId][opt_56] >= opt_58);
{
x_53[index_55] = issueId;
y_54[index_55] = opt_56;
index_55 += 1;
}
sum_votes[issueId][opt_56] -= opt_58;
}

}

opt_56 = option;
{
if (opt_56 == opt_56) {
{
x_53[index_55] = issueId;
y_54[index_55] = opt_56;
index_55 += 1;
}
sum_votes[issueId][opt_56] += opt_58;
assert(sum_votes[issueId][opt_56] >= opt_58);
}

}

ballots[issueId][msg.sender] = opt_56;
}

emit OnVote(issueId, msg.sender, option);
{
for (uint256 index_59 = 0; index_59 < index_55; index_59 += 1) {
assert(y_54[index_59] == 0 || sum_votes[x_53[index_59]][y_54[index_59]] == weightedVoteCounts[x_53[index_59]][y_54[index_59]]);
}

return true;
}

for (uint256 index_60 = 0; index_60 < index_55; index_60 += 1) {
assert(y_54[index_60] == 0 || sum_votes[x_53[index_60]][y_54[index_60]] == weightedVoteCounts[x_53[index_60]][y_54[index_60]]);
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
