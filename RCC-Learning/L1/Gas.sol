// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Gas {
    /*
        每一笔交易都需要花费ether，计算公式为：gas spent * gas price
        gas spent： 是交易中需要花费的gas数量
        gas price： 是每个gas你愿意付出的价格
        具有较高gas价格的交易有更高的优先级被写入区块中
        未使用的gas会被归还

        gas有两个限制：
        gas limit：在交易中使用的最大gas数量(由自己设置)
        block gas limit：区块中允许的最大gas数量(由网络设置)
    */
}