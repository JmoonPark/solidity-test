// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
/**
     * 外部合约接口,用于获取货币定价
     */
    AggregatorV3Interface internal dataFeed;
/**
     * 维护收款账户与金额的map
     */
    mapping (address => uint256) public fundersToAmount;
    /**
     * 最小收款金额，单位USD
     * constant代表常量
     */
    uint256 MINIMUM_VALUE = 1 * 10 ** 18;// USD
    /**
     * 目标金额
     */
    uint256 constant TARGET = 10 * 10 ** 18;// USD
    /**
     * 合约拥有者(在合约部署时赋值)
     */
    address public owner;
    /**
     * NetWork:Sepolia testNet
     * Aggregator:ETH/USD
     * Address:0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        owner = msg.sender;
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    /**
     * 筹集资金，将资金捐赠人的地址和金额以key value的形式存入map中
     * require：最小收款金额应 >= MINIMUM_VALUE
     */
    function fund() external payable {
        require(convertEthToUsd(msg.value) >= MINIMUM_VALUE, "send more ETH");
        fundersToAmount[msg.sender] += msg.value;
    }

    /**
     * 获得ETH/USD的汇率
     */
    function getChainLinkDataFeedLatestAnswer() public view returns(int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int256 answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    /**
     * 转换资金，ETH/USD 精度10 ** 8
     *
     * param uint ethAmount 资金捐赠人捐赠的具体资金金额(单位wei)
     * return uint256 美元
     */
    function convertEthToUsd(uint ethAmount) internal view returns(uint256) {
        uint256 ethPrice = uint256(getChainLinkDataFeedLatestAnswer());
        return ethAmount * ethPrice / (10 ** 8);
    }

    /**
     * 转换合约拥有者,需要当前合约拥有者本人调用
     */
    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "this function can only be called by owner");
        owner = newOwner;
    }

    /**
     * 获取资金，将筹得的资金取出来
     */
    function getFund() external {
        // this，指当前合约，当当前合约中的balance资金 < 目标值时， 提示信息
        require(convertEthToUsd(address(this).balance) >= TARGET, "Target is not reached");
        require(msg.sender == owner, "this function can only be called by owner");
        // transfer: a.transfer(b) a:接受transfer的人的地址，b：发送transfer的地址所拥有的金额， transfer ETH and revert if tx failed 当交易失败时，balance没有变化，只会损失一些fee
        // payable(): msg.sender地址本身不具备交易性质，需要用payable()将地址转换成可交易的类型，
        // payable(msg.sender).transfer(address(this).balance);
        // send：用法用transfer，区别会有个返回值，代表此交易是否成功，一般用require()确认是否成功，transfer ETH and return false if failed
        // bool success = payable(msg.sender).send(address(this).balance);
        // require(success, "transation failed!");
        // call：除了可以transfer以外，还可以调用payable函数，还可以返回低腰用的函数的返回值，transfer ETH with data return value of function and bool
        // (bool, return) = addr.call{value: balance}("data");  balance:transfer的金额，data：需要调用的函数 , bool:transfer的结果， return：如果调用函数，那么return就是该函数的返回值，没有就不写return
        bool success;
        (success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "transaction failed!");
        fundersToAmount[msg.sender] = 0;
    }

    /**
     * 如果在指定期间内未达到筹集目标的金额，则进行退款
     */
    function refund() external {
        // 当当前合约中的balance资金 >= 目标值时，提示信息
        require(convertEthToUsd(address(this).balance) < TARGET, "Target is reached");
        // 检测当前账户有没有实际做过fund
        uint256 amount = fundersToAmount[msg.sender];
        require(amount != 0, "there is no fund for you");
        bool success;
        (success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "transaction failed!");
        fundersToAmount[msg.sender] = 0;
    }
}