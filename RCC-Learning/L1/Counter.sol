// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Counter{
    // 计数(全局变量)
    uint256 private count;

    // 获取计数
    function getCount() external view returns(uint256) {
        return count;
    }

    // 计数+1
    function inc() public {
        count += 1;
    }

    // 计数-1
    function dec() public {
        require(count > 0, "The count can not less than zero");
        count -= 1;
    }
}