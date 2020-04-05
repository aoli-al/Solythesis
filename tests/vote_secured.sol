pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
uint256 memoryStart_0;
mapping (uint=>mapping (uint=>uint256)) sum_votes;
uint256 x_addr_61;
uint256 y_addr_62;
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
uint256 tmp_75;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_75 := mload(0x40)
mstore(0x40, add(tmp_75, 1280))
sstore(memoryStart_0_slot, tmp_75)
mstore(add(tmp_75, 0), 0)
mstore(add(tmp_75, 640), 0)
}

}

uint[] memory x_66;
assembly {
x_66 := add(sload(memoryStart_0_slot), 0)
}

uint[] memory y_67;
assembly {
y_67 := add(sload(memoryStart_0_slot), 640)
}

require(options_.length >= 2);
require(options[issueId].length == 0);
options[issueId] = options_;
isOpen[issueId] = true;
for (uint i = 0; i < qualifiedVoters_.length; i ++) {
address voter = qualifiedVoters_[i];
{
uint opt_63 = ballots[issueId][voter];
uint256 opt_65 = weights[issueId][voter];
{
if (opt_63 == opt_63) {
assert(sum_votes[issueId][opt_63] >= opt_65);
{
uint tmp_68 = issueId;
assembly {
let tmp := add(mload(x_66), 1)
mstore(x_66, tmp)
mstore(add(x_66, mul(tmp, 32)), tmp_68)
}

uint tmp_69 = opt_63;
assembly {
let tmp := add(mload(y_67), 1)
mstore(y_67, tmp)
mstore(add(y_67, mul(tmp, 32)), tmp_69)
}

}
sum_votes[issueId][opt_63] -= opt_65;
}

}

opt_65 = 5;
{
if (opt_63 == opt_63) {
{
uint tmp_70 = issueId;
assembly {
let tmp := add(mload(x_66), 1)
mstore(x_66, tmp)
mstore(add(x_66, mul(tmp, 32)), tmp_70)
}

uint tmp_71 = opt_63;
assembly {
let tmp := add(mload(y_67), 1)
mstore(y_67, tmp)
mstore(add(y_67, mul(tmp, 32)), tmp_71)
}

}
sum_votes[issueId][opt_63] += opt_65;
assert(sum_votes[issueId][opt_63] >= opt_65);
}

}

weights[issueId][voter] = opt_65;
}

}

issueDescriptions[issueId] = issueDesc_;
for (uint256 index_72 = 0; index_72 < x_66.length; index_72 += 1) {
uint tmp_73;
assembly {
tmp_73 := mload(add(x_66, mul(add(index_72, 1), 32)))
}

uint tmp_74;
assembly {
tmp_74 := mload(add(y_67, mul(add(index_72, 1), 32)))
}

assert(tmp_74 == 0 || sum_votes[tmp_73][tmp_74] == weightedVoteCounts[tmp_73][tmp_74]);
}

}

function vote (uint issueId, uint option) public returns (bool success) {
uint256 entry_1 = 0;
uint256 tmp_93;
if (memoryStart_0 == 0) {
entry_1 = 1;
assembly {
tmp_93 := mload(0x40)
mstore(0x40, add(tmp_93, 1280))
sstore(memoryStart_0_slot, tmp_93)
mstore(add(tmp_93, 0), 0)
mstore(add(tmp_93, 640), 0)
}

}

uint[] memory x_76;
assembly {
x_76 := add(sload(memoryStart_0_slot), 0)
}

uint[] memory y_77;
assembly {
y_77 := add(sload(memoryStart_0_slot), 640)
}

require(isOpen[issueId]);
uint256 weight = weights[issueId][msg.sender];
{
uint tmp_78 = issueId;
assembly {
let tmp := add(mload(x_76), 1)
mstore(x_76, tmp)
mstore(add(x_76, mul(tmp, 32)), tmp_78)
}

uint tmp_79 = option;
assembly {
let tmp := add(mload(y_77), 1)
mstore(y_77, tmp)
mstore(add(y_77, mul(tmp, 32)), tmp_79)
}

}
weightedVoteCounts[issueId][option] += weight;
{
uint opt_80 = ballots[issueId][msg.sender];
uint256 opt_82 = weights[issueId][msg.sender];
{
if (opt_80 == opt_80) {
assert(sum_votes[issueId][opt_80] >= opt_82);
{
uint tmp_83 = issueId;
assembly {
let tmp := add(mload(x_76), 1)
mstore(x_76, tmp)
mstore(add(x_76, mul(tmp, 32)), tmp_83)
}

uint tmp_84 = opt_80;
assembly {
let tmp := add(mload(y_77), 1)
mstore(y_77, tmp)
mstore(add(y_77, mul(tmp, 32)), tmp_84)
}

}
sum_votes[issueId][opt_80] -= opt_82;
}

}

opt_80 = option;
{
if (opt_80 == opt_80) {
{
uint tmp_85 = issueId;
assembly {
let tmp := add(mload(x_76), 1)
mstore(x_76, tmp)
mstore(add(x_76, mul(tmp, 32)), tmp_85)
}

uint tmp_86 = opt_80;
assembly {
let tmp := add(mload(y_77), 1)
mstore(y_77, tmp)
mstore(add(y_77, mul(tmp, 32)), tmp_86)
}

}
sum_votes[issueId][opt_80] += opt_82;
assert(sum_votes[issueId][opt_80] >= opt_82);
}

}

ballots[issueId][msg.sender] = opt_80;
}

emit OnVote(issueId, msg.sender, option);
{
for (uint256 index_87 = 0; index_87 < x_76.length; index_87 += 1) {
uint tmp_88;
assembly {
tmp_88 := mload(add(x_76, mul(add(index_87, 1), 32)))
}

uint tmp_89;
assembly {
tmp_89 := mload(add(y_77, mul(add(index_87, 1), 32)))
}

assert(tmp_89 == 0 || sum_votes[tmp_88][tmp_89] == weightedVoteCounts[tmp_88][tmp_89]);
}

return true;
}

for (uint256 index_90 = 0; index_90 < x_76.length; index_90 += 1) {
uint tmp_91;
assembly {
tmp_91 := mload(add(x_76, mul(add(index_90, 1), 32)))
}

uint tmp_92;
assembly {
tmp_92 := mload(add(y_77, mul(add(index_90, 1), 32)))
}

assert(tmp_92 == 0 || sum_votes[tmp_91][tmp_92] == weightedVoteCounts[tmp_91][tmp_92]);
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
