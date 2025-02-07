// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleStorage {
    /*
        要写入或更新状态变量，需要发送交易，支付交易费
        但读取状态变量，不需要支付交易费
    */
    uint256 private num;

    function set(uint256 _num) public {
        num = _num;
    }

    function get() public view returns(uint256) {
        return num;
    }
}