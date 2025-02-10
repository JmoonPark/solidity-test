// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Unchecked {
    /*
        在0.8.0版本后算术运算有了两种模式，unchecked模式和checked模式
        unchecked模式下的运算不会对其结果进行溢出判断
        checked模式下的运算会判断是否溢出，默认模式
        如果想要进入unchecked模式来提高运行效率，则在函数内使用unchecked{}代码块即可
    */
    function test() public pure returns(uint256) {
        uint256 a = 1;
        uint256 b = 2;
        unchecked {
            return a + b;
        }
    }
}