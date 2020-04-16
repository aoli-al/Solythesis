pragma solidity ^0.5.0;
contract AdvancedTokenVote1202 {
  mapping (address=>bool) b_set;
  address[] b_arr;
  mapping (uint=>bool) a_set;
  uint[] a_arr;
  mapping (uint=>bool) c_set;
  uint[] c_arr;
  mapping (uint=>mapping (uint=>uint256)) sum_votes;
  mapping (uint=>bool) x_set;
  uint[] x_arr;
  mapping (uint=>bool) y_set;
  uint[] y_arr;

  function vote (uint issueId, uint option) public returns (bool success) {
    require(isOpen[issueId]);
    uint256 weight = weights[issueId][msg.sender];
    weightedVoteCounts[issueId][option] += weight;
    if (!y_set[option]) {
      y_arr.push(option);
      y_set[option] = true;
    }
    if (!x_set[issueId]) {
      x_arr.push(issueId);
      x_set[issueId] = true;
    }
    ballots[issueId][msg.sender] = option;
    if (!b_set[msg.sender]) {
      b_arr.push(msg.sender);
      b_set[msg.sender] = true;
    }
    if (!a_set[issueId]) {
      a_arr.push(issueId);
      a_set[issueId] = true;
    }
    if (!c_set[ballots[issueId][msg.sender]]) {
      c_arr.push(ballots[issueId][msg.sender]);
      c_set[ballots[issueId][msg.sender]] = true;
    }

    emit OnVote(issueId, msg.sender, option);
    for (uint256 i = 0; i < a_arr.length; i += 1) {
      for (uint256 j = 0; j < c_arr.length; j += 1) {
        sum_votes[a_arr[i]][c_arr[j]] = 0;
      }
    }
    for (uint256 i = 0; i < b_arr.length; i += 1) {
      for (uint256 j = 0; j < a_arr.length; j += 1) {
        sum_votes[a_arr[j]][ballots[a_arr[j]][b_arr[i]]] += weights[a_arr[j]][b_arr[i]];
        assert(sum_votes[a_arr[j]][ballots[a_arr[j]][b_arr[i]]] >= weights[a_arr[j]][b_arr[i]]);
      }
    }
    for (uint256 i = 0; i < x_arr.length; i += 1) {
      for (uint256 j = 0; j < y_arr.length; j += 1) {
        assert(y_arr[j] == 0 || sum_votes[x_arr[i]][y_arr[j]] == weightedVoteCounts[x_arr[i]][y_arr[j]]);
      }
    }
    return true;
  }

}

