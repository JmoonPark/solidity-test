// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Event {
    /*
      event：允许将日志输出到区块链上
        写法：event 事件名(变量类型 [indexed] 变量名, ...)
            indexed关键字：被修饰的变量可以作为过滤条件过滤日志，最多支持三个变量修饰
            emit关键字：调用事件时使用的一个关键字
    */
    event Log(address indexed sender, string message);
    event Log2();

    function test() public {
        emit Log(msg.sender, "Hello World");
        emit Log(msg.sender, "Hello asdf asdf adsfasd");
        emit Log2();
    }
}