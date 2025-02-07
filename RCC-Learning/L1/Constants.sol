// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Constant {
    /*
        常量是不可修改的变量，值是硬编码的，通常可以节省gas成本
    */
    address public constant MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint public constant MY_UINT = 123;
}