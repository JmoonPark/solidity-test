// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Receive {
    /*
        receive()是一种特殊函数，主要用于接收以太币的转账
            格式固定，不需要写function关键字，可见性必须为external，状态可变性必须为payable
    */
    receive() external payable {

    }
    /*
        如果一个合约中既没有receive()也没有fallback()，则该合约无法接收以太币转账，
        在这种情况下，所有向该合约转账的操作都会被revert
    */
}
// 既没有receive()也没有fallback()
contract TestReceive {}

contract TestReceiver {
    address payable testReceive;
    constructor() payable {
        testReceive = payable(address(new TestReceive()));
    }
    // 失败 因为testReceive没有receive也没有fallback
    function tryTransfer() external {
        testReceive.transfer(1);
    }
    // 失败 因为testReceive没有receive也没有fallback
    function trySend() external {
        bool success = testReceive.send(1);
        require(success, "Failed to send ether");
    }
    // 失败 因为testReceive没有receive也没有fallback
    function tryCall() external {
        (bool success,) = testReceive.call{value: 1}("");
        require(success, "Failed to send ether");
    }
}