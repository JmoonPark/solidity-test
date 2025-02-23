// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Test1 {
    // 当给函数的返回值赋上值之后，return回的是什么？
    function test() public pure returns (uint mul) {
        uint256 a = 10;
        mul = 100;
        return a;// 10
    }
    
    // 计算无符号整数数组的综合
    function sumArray(uint[] memory numbers) public pure returns (uint total) {
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
    }
}

