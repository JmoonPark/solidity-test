// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ErrorTest {
    /*
        require: 用来校验输入或作为执行函数主体逻辑的条件
        revert: 和require类似，用在比较复杂的地方
        assert: 断言，通常用来检查不应该出错的地方，断言失败通常意味着这边出现了预期以外的问题。
    */
    function test(uint256 _i) public pure {
        // require
        require(_i > 10, "Input must be greater than 10");
        // revert 校验逻辑与上面相同
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    /*
        assert只能用于测试内部错误
    */
    uint256 public num;
    function testAssert() public view {
        assert(num == 0);
    }

    /*
        创建一个error
    */
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);
    /*
        如果当前余额小于传入的金额，则报错
    */
    function testError(uint256 _withdrawAmount) public view {
        uint256 bal = msg.sender.balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}