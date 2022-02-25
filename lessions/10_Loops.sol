// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Loops {
    uint256[3] public arr;
    uint256 public count;

    // while(count < arr.length){   // we cannot do this(we have to write a function) because it doesn't work on contract level
    //     arr[count] = count;
    //     count++;
    // }

    function whileLoop() public {
        while (count < arr.length) {
            arr[count] = count;
            count++;
        }
    }

    function doWhileLoop() public {
        do {
            arr[count] = count;
            count++;
        } while (count < arr.length);
    }

    function forLoop() public {
        for (uint256 i = count; i < arr.length; i++) {
            arr[count] = count;
            count++;
        }
    }
}
