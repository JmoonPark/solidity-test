// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Loop {
    /*
        solidity支持for、while、do while语句，
        但是不受限的循环可能会达到gas上限导致交易失败，
        所以很少使用while和do while
    */
    uint256 public j;

    function loop () public {
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            if (i == 5) {
                break;
            }
        }
        while (j < 10) {
            j++;
        }
    }
}