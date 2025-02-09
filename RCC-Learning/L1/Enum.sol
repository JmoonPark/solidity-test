// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Enum {
    /*
        枚举: enum 枚举名 {元素名, ...}
        枚举的元素也有下标，从0开始，默认当前枚举为下标0对应的值
        delete枚举会将当前枚举重置为下标0对应的值
    */
    enum Light {
        RED,
        YELLOW,
        GREEN
    }
    Light public light;
    function get() public view returns (Light) {
        return light;
    }
    function set(Light _light) public {
        light = _light;
    }
    function Green() public {
        light = Light.GREEN;
    }
    function reset() public {
        delete light;
    }
}