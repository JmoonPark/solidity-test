// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract IfElse {
    /*
        solidity中的判断语句写法与java相同，也可以用三元表达式
    */
    function foo(uint256 x) public pure returns (uint256) {
        if (x < 10) {
            return 1;
        } else if (x < 100) {
            return 2;
        } else if (x < 1000) {
            return 3;
        } else {
            return 4;
        }
    }

    function ternary(uint256 x) public pure returns (uint256) {
        return x < 10 ? 1 : x < 100 ? 2 : x < 1000 ? 3 : 4;
    } 
}