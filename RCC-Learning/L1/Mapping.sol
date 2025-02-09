// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Mapping {
    /*
        mapping(keyType => valueType)
        keyType可以是任何内置值类型、bytes、string、contract
        valueType可以是任何类型，包括另一个mapping或array
        keyType和valueType后面可以接变量名，更明显的表明mapping的作用
    */
    mapping(address user => uint256 a) private map;
    
    function get(address user) public view returns (uint256) {
        return map[user];
    }

    function set(address user, uint256 a) public {
        map[user] = a;
    }

    /*
        delete：删除关键字，对基本数据类型进行delete则会使其变成其默认值, string则变为空字符串，bytes则会变为0x0
    */
    uint256 public num = 123;
    bool public flag = true;
    bytes public array = "123";
    string public str = "adsf";
    function remove(address user) public {
        delete map[user];
        delete num;
        delete flag;
        delete array;
        delete str;
    }
}

contract NestedMapping {
    mapping(address => mapping(uint256 => bool)) private map;

    function get(address user, uint256 num) public view returns (bool) {
        return map[user][num];
    }

    function set(address user, uint256 num, bool flag) public {
        map[user][num] = flag;
    }

    function remove(address user, uint256 num) public {
        delete map[user][num];
    }
}