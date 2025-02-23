// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/*
    WETH 是包装 ETH 主币，作为 ERC20 的合约。 标准的 ERC20 合约包括如下几个

    3 个查询
    balanceOf: 查询指定地址的 Token 数量
    allowance: 查询指定地址对另外一个地址的剩余授权额度
    totalSupply: 查询当前合约的 Token 总量
    2 个交易
    transfer: 从当前调用者地址发送指定数量的 Token 到指定地址。
    这是一个写入方法，所以还会抛出一个 Transfer 事件。
    transferFrom: 当向另外一个合约地址存款时，对方合约必须调用 transferFrom 才可以把 Token 拿到它自己的合约中。
    2 个事件
    Transfer
    Approval
    1 个授权
    approve: 授权指定地址可以操作调用者的最大 Token 数量。
*/
contract WETH {
    // 转账事件
    event Transfer(address indexed fromAddr, address indexed toAddr, uint256 amount);
    // 提现事件
    event Withdraw(address indexed fromAddr, uint256 amount);
    // 授权事件
    event Approve(address indexed toAddr, uint256 amount);
    // 接收事件
    event Deposit(address indexed toAddr, uint256 amount);
    
    // 查询指定地址的token数量
    mapping(address addr => uint256 balance) public balanceOf;
    // 查询指定地址对另外一个地址的剩余授权额度
    mapping(address sourceAddr => mapping(address targetAddr => uint256)) public allowance;

    // 查询当前合约的 Token 总量
    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    // 转账
    function transfer(address toAddr, uint256 amount) public returns (bool) {
        return transferFrom(msg.sender, toAddr, amount);
    }
    // 指定发送方地址转账
    function transferFrom(address fromAddr, address toAddr, uint256 amount) public returns (bool) {
        require(balanceOf[fromAddr] >= amount);
        // 当发送方地址不是调用方地址时，需要判断发送方有没有给予调用方足够的授权额度
        if (fromAddr != msg.sender) {
            require(allowance[fromAddr][msg.sender] >= amount, unicode"授权额度不够");
            allowance[fromAddr][msg.sender] -= amount;
        }
        balanceOf[fromAddr] -= amount;
        balanceOf[toAddr] += amount;
        emit Transfer(fromAddr, toAddr, amount);
        return true;
    }

    // 提现
    function withdraw(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, unicode"当前账户金额不够");
        balanceOf[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // 授权
    function approve(address toAddr, uint256 amount) public returns (bool) {
        allowance[msg.sender][toAddr] += amount;
        emit Approve(toAddr, amount);
        return true;
    }

    // 接收
    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    receive() external payable {
        deposit();
    }

    fallback() external payable {
        deposit();
    }
}