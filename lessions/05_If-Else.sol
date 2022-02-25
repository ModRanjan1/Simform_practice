// SPDX-License-Identifier:GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract ifElse {
    function check(int256 a) public pure returns (string memory) {
        string memory value;

        // it never works on contract level, always used inside a function
        if (a & 1 != 0) {
            value = "Value is Odd.";
        } else if (a == 0) {
            value = "Value is Zero.";
        } else {
            value = "Value is Even.";
        }

        // ternary operator
        value = (a & 1 != 0) ? "Value is Odd." : "Value is Either Zero or Even.";

        return value;
    }
}
