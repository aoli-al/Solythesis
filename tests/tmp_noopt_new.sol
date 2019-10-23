pragma solidity ^0.5.0;
contract test {
uint256 depth_0;
mapping (uint256=>bool) y_checker_13;
uint256[] y_store_14;
mapping (uint256=>bool) x_checker_11;
uint256[] x_store_12;
mapping (uint256=>uint256) a;
mapping (uint256=>uint256) b;
function vote (uint issueId, uint option) public returns (bool success) {
{
}
a[3] = 5;if (! x_checker_11[3]) {
x_store_12.push(3);
x_checker_11[3] = true;
}

{
}
b[2] = 6;if (! y_checker_13[2]) {
y_store_14.push(2);
y_checker_13[2] = true;
}

{
for (uint256 index_38 = 0; index_38 < x_store_12.length; index_38 += 1) {
for (uint256 index_39 = 0; index_39 < y_store_14.length; index_39 += 1) {
assert(a[x_store_12[index_38]] == b[y_store_14[index_39]]);
}

}

return false;
}

for (uint256 index_41 = 0; index_41 < x_store_12.length; index_41 += 1) {
for (uint256 index_42 = 0; index_42 < y_store_14.length; index_42 += 1) {
assert(a[x_store_12[index_41]] == b[y_store_14[index_42]]);
}

}

}

}
