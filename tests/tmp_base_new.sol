pragma solidity ^0.5.0;
contract test {
uint256 depth_0;
mapping (uint256=>bool) x_checker_1;
uint256[] x_store_2;
mapping (uint256=>bool) y_checker_3;
uint256[] y_store_4;
mapping (uint256=>uint256) a;
mapping (uint256=>uint256) b;
function vote (uint issueId, uint option) public returns (bool success) {
a[3] = 5;if (! x_checker_1[3]) {
x_store_2.push(3);
x_checker_1[3] = true;
}

b[2] = 6;if (! y_checker_3[2]) {
y_store_4.push(2);
y_checker_3[2] = true;
}

{
for (uint256 index_6 = 0; index_6 < x_store_2.length; index_6 += 1) {
for (uint256 index_7 = 0; index_7 < y_store_4.length; index_7 += 1) {
assert(a[x_store_2[index_6]] == b[y_store_4[index_7]]);
}

}

return false;
}

for (uint256 index_9 = 0; index_9 < x_store_2.length; index_9 += 1) {
for (uint256 index_10 = 0; index_10 < y_store_4.length; index_10 += 1) {
assert(a[x_store_2[index_9]] == b[y_store_4[index_10]]);
}

}

}

}
