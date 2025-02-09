// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Parent {
    string public name;
    constructor(string memory _name) {
        name = _name;
    }
    /*
        子合约可以继承父合约中定义的事件
    */
    event Log(string message);
    function logMessage() public {
        emit Log("Message from Parent");
    }
    /*
        子合约可以继承父合约中定义的修饰符
    */
    modifier onlyOwner() {
        require(msg.sender == address(this), "Not the owner");
        _;
    }
    /*
        继承，类似于java中的extends，solidity用is来表示
    */
    function test() public pure virtual returns (string memory) {
        return "Hello Parent";
    }
    function test2() public {
        
    }
}   

contract Child is Parent {
    /*
        如果继承的父合约有构造函数，则构造函数必须显式的调用他
    */
    constructor(string memory _name) Parent(_name) {
        // 这里可以田间子合约的初始化逻辑
    }
    function childLogMessage() public {
        emit Log("Message from Child");
    }
    /*
        继承的合约必须重写被virtual修饰的方法
        重写父合约方法有两个条件：
            1.父合约的方法需要被virtual关键字修饰
            2.子合约同名方法需要被override关键词修饰
    */
    function test() public pure override returns (string memory) {
        return "Hello Child";
    }
    function testModifier() public view onlyOwner {
    }
}



contract Child1 {
    string public name1;
    constructor(string memory _name) {
        name1 = _name;
    }

    function test() public pure virtual returns (string memory) {
        return "Hello Child1";
    }
}
/*
    solidity支持多继承，多继承时如果两个父合约都有同名的方法并且需要被重写时，需要在override后面显式写明继承顺序，
    如果父合约都有构造方法，则需要显式的写明构造函数的调用顺序，顺序为声明从右到左
    这里的调用顺序为 Child1 -> Parent -> Child2
    
*/
contract Child2 is Parent, Child1 {
    string public child2Name;
    constructor(string memory _name, string memory _name2) Parent(_name) Child1(_name2) {
        // 这里写子合约的初始化逻辑
    }
    function test() public pure override(Parent, Child1) returns (string memory) {
        return "Hello Child2";
    }
}