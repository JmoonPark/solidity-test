// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Struct {
    /*
        struct 类似于java中的实体类
    */
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    /*
        calldata:和memory一样，但是calldata修饰的变量被赋值之后无法修改，类似于final
        创建struct方法：
            1.struct名(变量值, ...)
            2.struct名({变量名: 变量值, ...})
            3.先创建空对象，再给变量赋值
    */
    function create(string calldata _text) public {
        // 1.
        todos.push(Todo(_text, false));
        // 2.
        todos.push(Todo({text: _text, completed: false}));
        // 3.
        Todo memory todo;
        todo.text = _text;
        todos.push(todo);
    }

    /*
        solidity会自动创建struct对象的get方法，所以其实不用再创建get方法
    */
    function get(uint256 _index) public view returns(Todo memory) {
        return todos[_index];
    }

    /*
        更新数组对应下标下的对象的变量值
    */
    function updateText(uint256 _index, string calldata _text) public {
        todos[_index].text = _text;
    }

    /*
        改变状态
    */
    function toggleCompleted(uint256 _index) public {
        todos[_index].completed = !todos[_index].completed;
    }
}