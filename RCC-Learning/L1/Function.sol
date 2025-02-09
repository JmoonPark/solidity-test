// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Function {
    /*
        function可以返回多个参数，返回参数可以加上变量名，添加变量名时，可以省略对应变量的声明和return

    */
    function test1() public pure returns (uint256 a, uint256 b) {
        a = 1;
        b = 2;
    }

    /*
        多个返回值可以省略接收不需要的返回
    */
    function test2() public pure returns (string memory, uint256, bool, uint256) {
        (uint256 a, ) = test1();
        return ("asdf", a, false, 1);
    }
}

contract XYZ {
    function someFuncWithManyInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address a,
        bool b,
        string memory c
    ) public pure returns (uint256) {}
    /*
        默认返回值顺序为调用函数定义的顺序
    */
    function callFunc() external pure returns (uint256) {
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
    }
    /*
        也可以用{key:value, ...}的形式返回对应变量
    */
    function callFuncWithKeyValue() external pure returns (uint256) {
        return someFuncWithManyInputs({
            a: address(0),
            b: true,
            c: "c",
            x: 1,
            y: 2,
            z: 3
        });
    }
}