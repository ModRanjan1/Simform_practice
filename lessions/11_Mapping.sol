// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

contract Mapping{
    mapping(uint=>string) public rollNo;

    function setter(uint keys, string memory value) public{
        rollNo[keys] = value;
    }

}