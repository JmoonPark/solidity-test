// SPDX-License-Identifier: MIT
pragma solidity *0.8.28;

/*
    任何人都可以发送金额到合约
    只有 owner 可以取款
    3 种取钱方式
*/
contract EtherWallet {
    address payable public immutable owner;

    event Log(string funcName, address from, uint256 value, bytes data);

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function withdraw1() external onlyOwner {
        // owner.transfer要比payable(msg.sender).transfer花费更多的gas
        // 因为owner是状态变量，读取需要调用SLOAD，而msg是全局变量，调用上下文读取，不需要额外从存储地址中获取
        payable(msg.sender).transfer(address(this).balance);
    }

    function withdraw2() external onlyOwner {
        bool result = payable(msg.sender).send(address(this).balance);
        require(result, "withdraw failed");
    }

    function withdraw3() external onlyOwner {
        (bool result,) = payable(msg.sender).call{value:address(this).balance}("");
        require(result, "withdraw failed");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}