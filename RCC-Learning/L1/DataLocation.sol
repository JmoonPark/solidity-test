// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract DataLocation {
    /*
        变量可以被声明为三种位置
        storage：会在区块链上永久存储，即使交易被挖矿并添加到区块链后，数据也会一直保留，storage是昂贵的，因为它需要使用区块链上的磁盘空间，所有状态变量都存储在storage中。
        memory：数据在临时内存中存储，当前函数执行完毕后，这部分数据会被清除，不会被永久写入区块链，function中的局部变量默认在memory中。
        calldata：用于函数参数，特别是external函数，这类数据只读且只在函数调用期间存在
    */
    uint256 storageData;// 状态变量默认存储在storage，即链上

    function f(uint256 x) external {
        uint256 y = x;// 默认存储在memory，函数执行结束后就被清除
        storageData = y + x;
    }

    function g(uint256[] calldata x) external pure returns (uint256) {
        assembly {

        }
        return x[1];// calldata 一般用于external函数参数，只读属性
    }

    /*
        assembly{}代码块：允许开发者直接编写EVM的底层汇编代码，来实现更高效的gas优化和更精细的控制，
        指令集：
            栈操作：push(), pop()
            内存操作：mstore(), mload()
            存储：sstore(), sload()
            调用数据：calldataload(), calldatasize()
            算数运算：add(), sub(), mul(), div(), mod()(取模)
            逻辑运算：and按位与, or按位或, xor按位异或, not按位取反
            比较运算：eq, lt, gt
    */
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            result := add(a, b)
        }
        return result;
    }

    /*
        modifier：修饰符，用于更改函数行为的关键字，可以用于控制函数的执行条件，添加前置检查，简化重复逻辑，在函数执行之前执行一段代码，只有修饰符的条件满足时，函数才会继续执行。
            “_;”代表函数主体将在修饰符逻辑执行后继续执行。
            一个函数也可有多个修饰符，在函数后面追加即可
    */
    address owner = msg.sender;

    /*
        权限控制
    */
    modifier onlyAdmin() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }
    function updateSetting() public onlyAdmin {

    }

    /*
        参数校验
    */
    uint256 public num = 2;
    function setNum(uint256 _num) public {
        num = _num;
    }
    modifier validNum() {
        require(num > 1, "Number need larger than 1");
        _;
    }
    function nextStep() public validNum {

    }

}