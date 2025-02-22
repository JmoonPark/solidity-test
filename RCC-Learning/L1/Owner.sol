// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/*
    合约的七大组成部分：状态变量、函数、函数修饰器、事件、Error、枚举、结构体
*/
contract Owner {
    // 状态变量
    Identity private owner;
    State private state;

    // 结构体
    struct Identity {
        address addr;
        string name;
    }

    // 枚举
    enum State {
        HasOwner,
        NoOwner
    }

    // 事件
    event OwnerSet(address indexed oldOwnerAddr, address indexed newOwnerAddr);
    event OwnerRemove(address indexed oldOwnerAddr);

    // 函数修饰器
    modifier isOwner() {
        require(msg.sender == owner.addr, "Caller is not owner");
        _;
    }

    // 构造函数
    constructor(string memory name) {
        owner.addr = msg.sender;
        owner.name = name;
        emit OwnerSet(address(0), owner.addr);
    }

    function getOwner() external view returns (address, string memory name) {
        return (owner.addr, owner.name);
    }

    function getState() external view returns (State) {
        return state;
    }

    function changeOwner(address addr, string calldata name) public isOwner {
        owner.name = name;
        owner.addr = addr;
        emit OwnerSet(msg.sender, addr);
    }

    function removeOwner() public isOwner {
        emit OwnerRemove(owner.addr);
        delete owner;
        state = State.NoOwner;
    }
}