// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.0 < 0.9.0;

contract Demo{

    function globalVar() public view returns(uint blockNo, uint timestamp, address msgSender)
    {
        return (block.number, block.timestamp, msg.sender);
    }
}