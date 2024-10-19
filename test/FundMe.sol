// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    AggregatorV3Interface internal dataFeed;
    mapping (address => uint256) public fundersToAmount;
    uint256 MINIMUM_VALUE = 100 * 10 ** 18;// USD
    /**
     * NetWork:Sepolia testNet
     * Aggregator:ETH/USD
     * Address:0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

 
    function fund() external payable {
        require(convertEthToUsd(msg.value) >= MINIMUM_VALUE, "send more ETH");
        fundersToAmount[msg.sender] += msg.value;
    }

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

    function convertEthToUsd(uint ethAmount) internal view returns(uint256) {
        uint256 ethPrice = uint256(getChainLinkDataFeedLatestAnswer());
        return ethAmount * ethPrice / (10 ** 8);
    }
}