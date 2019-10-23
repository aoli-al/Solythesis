pragma solidity ^0.5.0;
contract test {
uint256 depth_0;
mapping (uint256=>bool) y_checker_8;
uint256[] y_store_9;
mapping (uint256=>bool) x_checker_6;
uint256[] x_store_7;
mapping (uint256=>uint256) a;
mapping (uint256=>uint256) b;
function vote (uint issueId, uint option) public returns (bool success) {
uint256 index_20 = 0;
{
}
a[3] = 5;if (! x_checker_6[3]) {
x_store_7.push(3);
x_checker_6[3] = true;
}

{
}
b[2] = 6;if (! y_checker_8[2]) {
y_store_9.push(2);
y_checker_8[2] = true;
}

{
for (uint256 index_22 = 0; index_22 < x_store_7.length; index_22 += 1) {
for (uint256 index_23 = 0; index_23 < y_store_9.length; index_23 += 1) {
assert(a[x_store_7[index_22]] == b[y_store_9[index_23]]);
}

}

return false;
}

for (uint256 index_25 = 0; index_25 < x_store_7.length; index_25 += 1) {
for (uint256 index_26 = 0; index_26 < y_store_9.length; index_26 += 1) {
assert(a[x_store_7[index_25]] == b[y_store_9[index_26]]);
}

}

}

}
