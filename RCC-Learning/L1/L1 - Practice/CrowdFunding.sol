// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/*
    众筹
    两种角色:
        受益人   beneficiary => address         => address 类型
        资助者   funders     => address:amount  => mapping 类型 或者 struct 类型
    状态变量按照众筹的业务：
        状态变量
            筹资目标数量    fundingGoal
            当前募集数量    fundingAmount
            资助者列表      funders
            资助者人数      fundersKey
    需要部署时候传入的数据:
        受益人
        筹资目标数量
*/
contract CrowdFunding {
    address public immutable beneficiary;// 受益人
    uint256 public immutable fundingGoal;// 筹资目标数量
    uint256 public fundingAmount;// 当前金额
    mapping(address => uint256) public funders;// 资助者
    mapping(address=>bool) private fundersInserted;// 用于记录资助者是否资助过，和下面的list一起方便统计人数
    address[] public fundersKey;// 资助者人数
    bool public AVAILABLED = true;// 众筹状态

    // 部署的时候，写入受益人+筹资目标数量
    constructor(address addr, uint256 amount) {
        beneficiary = addr;
        fundingGoal = amount;
    }

    modifier open() {
        require(AVAILABLED, unicode"众筹已关闭");
        _;
    }

    function contribute() external payable open {
        // 如果捐赠的钱+当前金额大于目标金额，则只接收到等于的金额，剩下的退还
        uint256 potentialFundingAmount = fundingAmount + msg.value;
        uint256 refundAmount = 0;
        if (potentialFundingAmount > fundingGoal) {
            refundAmount = potentialFundingAmount - fundingGoal;
            funders[msg.sender] += (msg.value - refundAmount);
            fundingAmount += (msg.value - refundAmount);
        } else {
            funders[msg.sender] += msg.value;
            fundingAmount += msg.value;
        }

        // 更新捐赠者信息
        if (!fundersInserted[msg.sender]) {
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }

        // 退还多余的金额
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }

    // 关闭众筹
    function close() external open returns (bool) {
        if (fundingAmount < fundingGoal) {
            return false;
        }
        uint256 amount = fundingAmount;
        fundingAmount = 0;
        AVAILABLED = false;
        payable(beneficiary).transfer(amount);
        return true;
    }

    // 资助者的数量
    function fundersLength() public view returns (uint256) {
        return fundersKey.length;
    }
}