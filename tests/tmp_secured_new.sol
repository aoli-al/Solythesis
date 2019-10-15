pragma solidity ^0.5.0;
contract test {
uint256 depth_0;
mapping (uint256=>boolean) y_checker_3;
uint256[] y_store_4;
mapping (uint256=>boolean) x_checker_1;
uint256[] x_store_2;
mapping (uint256=>uint256) a;
mapping (uint256=>uint256) b;
function vote (uint issueId, uint option) public returns (bool success) {
uint256 index_11 = 0;
{
}
a[3] = 5;if (! x_checker_1[3]) x_store_2.push(3);
{
}
b[2] = 6;if (! y_checker_3[2]) y_store_4.push(2);
{
for (uint256 index_13 = 0; index_13 < x_store_2.length; index_13 += 1) {
for (uint256 index_14 = 0; index_14 < y_store_4.length; index_14 += 1) {
assert(a[x_store_2[index_13]] == b[y_store_4[index_14]]);
}

}

return false;
}

for (uint256 index_16 = 0; index_16 < x_store_2.length; index_16 += 1) {
for (uint256 index_17 = 0; index_17 < y_store_4.length; index_17 += 1) {
assert(a[x_store_2[index_16]] == b[y_store_4[index_17]]);
}

}

}

}
