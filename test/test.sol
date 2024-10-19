// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// comment: this is my first contract
contract MyContract {
    // contract code here
    // 不能用01代替false true
    bool bVar_1 = true;
    bool bVar_2 = false;
    // u代表usigned无符号,int代表integer, 8代表该变量可以赋值0 - 2^8-1的数值
    uint8 a = 255;
    uint256 b = 44444444444444444444444444444444444444444444444444444444444444444444444444444;
    // uint不能有符号，int可以有
    int256 intVar_1 = -1;
    // 字符串，数字代表存储字节上限，同string,string为动态分配的bytes，占用的空间比定长类型要多，执行效率低
    bytes8 bytesVar = "aaaaaaaa";
    string strVar = "Hello World";
    // 地址数据类型，存储地址，不需要双引号
    address addrVar = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // 作用域标识符 internal(protected) external(protected取反) private(私有) public(公有)
    // view 如果此函数为纯读取的函数，建议将此关键字写上
    // pure 如果此函数为纯计算的函数，简意将此关键字协商
    /*
    数据的存储模式
    简单数据类型不需要写下面的存储模式关键字，比如 uint int bytes bool默认
    1. storage 永久性存储
    2. memory 暂时性存储
    3. calldata 暂时性存储 与memory的区别，calldata类似于final，不可以在函数中修改
    4. stack
    5. codes
    6. logs
    */
    function testFunction() private view returns(string memory) {
        return addInfo(strVar);
    }

    function setHello(string memory newString) public {
        strVar = newString;
    }

    function addInfo(string memory helloWorldStr) internal pure returns(string memory) {
        return string.concat(helloWorldStr, " from pzw's contract");
    }
    /*
    数据的数据结构
    struct：结构体(对象)
    array：数组(list)
    mapping：映射(map)
    */
    struct Info {
        string phrase;
        uint8 id;
        address addr;
    }
    Info[] infos;
    function setInfo(string memory str, uint8 _id) external {
        Info memory info = Info(str, _id, msg.sender);
        infos.push(info);
        infoMapping[_id] = info;
    }

    function sayHellow(uint8 _id) external view returns(string memory, uint8 count) {
        count = 0;
        for (uint8 i = 0; i < infos.length; i++) {
            if (infos[i].id == _id) {
                count++;
                if (count == 10) {
                    return (addInfo(infos[i].phrase), count);
                }
            }
        }
        return (testFunction(), count);
    }

    mapping(uint8 id => Info info) infoMapping;

    function sayHellowFromMapping(uint8 _id) external view returns(string memory) {
        if (infoMapping[_id].addr != address(0x0)) {
            return addInfo(infoMapping[_id].phrase);
        } else {
            return testFunction();
        }
    }
}