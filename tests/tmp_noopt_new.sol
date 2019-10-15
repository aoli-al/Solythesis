pragma solidity ^0.5.0;
contract test {
uint256 depth_0;
mapping (uint256=>boolean) y_checker_8;
uint256[] y_store_9;
mapping (uint256=>boolean) x_checker_6;
uint256[] x_store_7;
mapping (uint256=>uint256) a;
mapping (uint256=>uint256) b;
function vote (uint issueId, uint option) public returns (bool success) {
{
}
a[3] = 5;if (! x_checker_6[3]) x_store_7.push(3);
{
}
b[2] = 6;if (! y_checker_8[2]) y_store_9.push(2);
{
for (uint256 index_29 = 0; index_29 < x_store_7.length; index_29 += 1) {
for (uint256 index_30 = 0; index_30 < y_store_9.length; index_30 += 1) {
assert(a[x_store_7[index_29]] == b[y_store_9[index_30]]);
}

}

return false;
}

for (uint256 index_32 = 0; index_32 < x_store_7.length; index_32 += 1) {
for (uint256 index_33 = 0; index_33 < y_store_9.length; index_33 += 1) {
assert(a[x_store_7[index_32]] == b[y_store_9[index_33]]);
}

}

}

}
