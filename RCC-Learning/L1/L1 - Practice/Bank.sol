// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/*
    所有人都可以存钱
    只有合约owner可以取钱
    只要取钱，合约就销毁掉selfdestruct
    扩展：支持主币以外的资产
        ERC20
        ERC721
*/
contract Bank {
    address public immutable owner;
    event Deposit(address _ads, uint256 amount);
    event Withdraw(uint256 amount);
    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() external payable {
        require(msg.sender == owner, "Not Owner");
        emit Withdraw(msg.value);
        selfdestruct(payable(msg.sender));// 0.8.18版本之后该方法的行为有些变化，不再会销毁合约和存储数据。
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}