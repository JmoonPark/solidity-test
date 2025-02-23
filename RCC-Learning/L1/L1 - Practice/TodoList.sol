// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
/*
    TodoList: 是类似便签一样功能的东西，记录我们需要做的事情，以及完成状态。 1.需要完成的功能

    创建任务
    修改任务名称
    任务名写错的时候
    修改完成状态：
    手动指定完成或者未完成
    自动切换
    如果未完成状态下，改为完成
    如果完成状态，改为未完成
*/
contract TodoList {
    struct Todo {
        string name;
        bool isCompleted;
    }
    Todo[] public list;

    // 创建任务
    function createTodo(string memory name) external {
        list.push(Todo(name, false));
    }

    // 修改名称
    function changeName(uint256 index, string memory _name) external {
        list[index].name = _name;
    }

    // 修改任务状态
    function changeStatus(uint256 index, bool status) external {
        list[index].isCompleted = status;
    }

    // 切换任务状态
    function switchStatus(uint256 index) external {
        list[index].isCompleted = !list[index].isCompleted;
    }

    // 获取任务1:  gas = 8141, memory会将list[index]数据拷贝到内存中，增加操作数量，所以gas会多
    function getTodo(uint256 index) external view returns (string memory, bool) {
        Todo memory todo = list[index];
        return (todo.name, todo.isCompleted);
    }
    // 获取任务2:  gas = 8060，storage本质是生成指针指向list中对应下标的数据，没有多余拷贝操作
    function getTodo2(uint256 index) external view returns (string memory, bool) {
        Todo storage todo = list[index];
        return (todo.name, todo.isCompleted);
    }
    // 获取任务3:  gas = 8258，直接引用会造成两次寻址，导致多余开销
    function getTodo3(uint256 index) external view returns (string memory, bool) {
        return (list[index].name, list[index].isCompleted);
    }
}