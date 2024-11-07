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
    uint256 constant MINIMUM_VALUE = 100 * 10 ** 18;// USD
    /**
     * 目标金额
     */
    uint256 constant TARGET = 300 * 10 ** 18;
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
     * 收款函数
     * require：最小收款金额应 >= MINIMUM_VALUE
     */
    function fund() external payable {
        require(convertEthToUsd(msg.value) >= MINIMUM_VALUE, "send more ETH");
        fundersToAmount[msg.sender] += msg.value;
    }

    /**
     * 获取当前的货币定价
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
     * 货币金额转换 ETH to USD
     */
    function convertEthToUsd(uint ethAmount) internal view returns(uint256) {
        uint256 ethPrice = uint256(getChainLinkDataFeedLatestAnswer());
        return ethAmount * ethPrice / (10 ** 8);
    }

    function getFund() external {
        require(msg.sender == owner, "this function can only be called by owner");
        require(convertEthToUsd(address(this).balance) >= TARGET, "Target is not reached");
        payable(msg.sender).transfer(address(this).balance);
    }
}