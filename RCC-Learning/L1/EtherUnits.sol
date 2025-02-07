// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract EtherUnits {
    // 1 wei == 1 wei是以太坊货币中的最小单位
    uint256 public oneWei = 1 wei;
    bool public isOneWei = (oneWei == 1);
    // 1 gwei == 10 ** 9 wei
    uint256 public oneGwei = 1 gwei;
    bool public isOneGwei = (oneGwei == 1e9);
    // 1 ehter == 10 ** 18 wei
    uint256 public oneEther = 1 ether;
    bool public isOneEther = (oneEther == 1e18);
}