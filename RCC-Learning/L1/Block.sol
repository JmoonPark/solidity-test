// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Block {
    /*
        全局变量block的方法：
            1.block.coinbase (address): 返回当前区块的矿工的地址
            2.block.difficulty (uint): 返回当前区块的难度系数
            3.block.gaslimit (uint): 返回当前区块的gas上限
            4.block.number (uint): 返回当前区块的块编号
            5.block.blockhash(uint) returns (bytes32): 返回指定区块的哈希值, 已经被内建函数blockhash所代替
            6.block.timestamp (uint): 返回当前区块的时间戳
    */
    address public coinBaseAddress;
    uint256 public difficulty;
    uint256 public gaslimit;
    uint256 public number;
    bytes32 public blockHash;
    uint256 public timestamp;
    function test() public {
        coinBaseAddress = block.coinbase;
        difficulty = block.difficulty;
        gaslimit = block.gaslimit;
        number = block.number;
        blockHash = blockhash(number);
        timestamp = block.timestamp;
    }
}