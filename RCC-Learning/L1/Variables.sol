// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Variables {
    /*
        状态变量：存储在区块链上，在函数外面声明
    */
    string public text = "Hello";
    uint256 public a = 123;
    /*
        全局变量：提供有关区块链的相关信息
    */
    uint256 public timestamp = block.timestamp;
    address public sender = msg.sender;

    function test() public pure returns(uint) {
        /*
            局部变量：只在函数中使用
        */
        uint256 _a = 1;
        return _a;
    }
}