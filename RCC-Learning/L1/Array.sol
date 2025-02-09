// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Array {
    /*
        array可以初始化长度，也可以指定数组内元素值
    */
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    uint256[5] public arr3;

    function get(uint256 index) public view returns (uint256) {
        return arr2[index];
    }

    /*
        solidity可以直接返回数组，但是应该避免在未定义长度的数组上使用此方法
    */
    function getArray() public view returns (uint256[] memory) {
        return arr2;
    }

    /*
        array.push(value)方法会直接在array的后面加一个值value，同时长度会+1
    */
    function push(uint256 i) public {
        arr2.push(i);
    }

    /*
        array.pop()方法会直接弹出array的最后一个元素，同时长度会-1
    */
    function pop() public {
        arr2.pop();
    }

    /*
        array.length方法返回array的长度
    */
    function getLength() public view returns (uint256) {
        return arr2.length;
    }

    /*
        delete会重置对应下标的元素为默认值，不会改变array的长度
    */
    function remove(uint256 index) public {
        delete arr2[index];
    }

    /*
        可以创建只定义长度来创建数组
    */
    function examples() external pure returns (uint256[] memory) {
        uint256[] memory a = new uint256[](5);
        return a;
    }

    /*
        删除数组中的某一个元素:将后面的元素赋值给前面的元素，然后pop最后一个元素
    */
    function removeElement(uint256 index) public {
        require(index < arr2.length, "index out of bound");
        for (uint256 i = index; i < arr2.length - 1; i++) {
            arr2[i] = arr2[i + 1];
        }
        arr2.pop();
    }
}