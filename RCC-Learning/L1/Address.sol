// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Address {
    /*
        address有两种类型：
            address：普通地址，存储一个20字节的地址值
            address payable: 可转账地址，可以存储和接收任意的Ether，但是必须要通过转账方法才能存储Ether
        payable关键字：定义这个address变量是个可转账地址
        payable()函数：显示转换普通地址为可转账地址
    */
    address addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address payable addr_payable = payable(0x8306300ffd616049FD7e4b0354a64Da835c1A81C);
    /*
        地址类型有三个成员变量：
            balance：该地址的余额，单位是wei
            code：该地址的合约代码，EOA账户(外部账户)为空，CA账户(合约账户)为非空
            codehash：该地址的合约代码的hash值
    */
    function getBalance() public view returns (uint256) {
        return addr.balance;
    }
    function getBalance2() public view returns (uint256) {
        return address(this).balance;
    }

    function getCode() public view returns (bytes memory) {
        return addr.code;
    }
    function getCode2() public view returns (bytes memory) {
        return address(this).code;
    } 

    function getCodeHash() public view returns (bytes32) {
        return addr.codehash;
    }
    function getCodeHash2() public view returns (bytes32) {
        return address(this).codehash;
    }

    /*
        地址类型有三个成员函数：
            transfer(uint256 amount)：向指定地址转账，失败时抛出异常(仅address payable 可以使用)，此操作固定gas fee = 2300
            send(uint256 amount)：与transfer()类似，但是失败时不会抛出异常，而是返回布尔值，此操作固定gas fee = 2300
            call(...)：调用其他合约中的函数
            delegatecall(...)：与call()类似，但使用当前合约的上下文来调用其他合约中的函数，修改的是当前合约的数据存储
    */
}