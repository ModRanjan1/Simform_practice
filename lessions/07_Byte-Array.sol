// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

contract Array
{
    bytes3 public arr3;  // 3 bytes array (static sized byte array)
    bytes2 public arr2;  // 2 bytes array

    bytes public arrD = "abc";  // (dynamic sized byte array)

    function setter() public
    {        
        arr3 = "abc";
        arr2 = "de";
        // arr3[0]="a";   we can not do this!
        // 1. Byte arrays cannot be modified.
        // 2. Padding of 0 is addied at the end if the value (by which the array is
        // initialized) does not occupy the entire space. 
    }

    function pushElement() public
    {
        arrD.push('f');
    }

function getElementu(uint i) public view returns(bytes1)
    {
        return arrD[i];
    }

    function getLength() public view returns(uint)
    {
        return arrD.length;
    }

}