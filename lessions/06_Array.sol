// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

contract Array
{
    /** Array
        1. a compile-time fixed size (Static in size)
        2. a dynamic size (Dynamic in size)
        
        * The type of an array of fixed size k and element type T is written as T[k], 
          and an array of dynamic size as T[].

        * Example, an array of 5 dynamic arrays of "uint" is written as uint[][5]. 
    
        * Creation of array in-side function : 
          (we can't create dynamic size array inside functions)
          https://docs.soliditylang.org/en/v0.8.12/types.html#allocating-memory-arrays
     */
    uint[] public arr;

    function pushElement(uint item) public
    {
    /*
        .push(value) can be used to append a new element at the end of the array, 
        where as .push() appends a zero-initialized element and returns a reference to it.
    */
        arr.push(item);
        arr.push();
    }

    function getLength() public view returns(uint)
    {
        return arr.length;
    }

    function popElement() public
    {
        arr.pop();
    }

    // creation of array inside function 
    function f(uint len) public pure {
        uint[] memory a = new uint[](7);
        bytes memory b = new bytes(len);
        assert(a.length == 7);
        assert(b.length == len);
        a[6] = 8;
    }
}