// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.0 <0.9.0;

contract _string {
/**
    * Solidity does not have string manipulation functions.

    * But there are third-party string libraries. 
      we can also compare two strings by their keccak256-hash using 
      keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2)) 
      and concatenate two strings using string.concat(s1, s2).

    * If you want to access the byte-representation of a string s, 
      use bytes(s).length / bytes(s)[7] = 'x';. 
      Keep in mind that you are accessing the low-level bytes of the UTF-8 representation, 
      and not the individual characters.
*/

    string public str = "Mod";

    function makeString() public pure returns (string memory) {
        // string str;
        string memory str1 = "Raju";

        return str1;
    }

    function saveName(string memory _name) public pure returns (string memory) {
        string memory name = _name;

        return name;
    }

// 
/**  The functions bytes.concat and string.concat

    * You can concatenate an arbitrary number of string values using string.concat.

    * The bytes.concat function can concatenate an arbitrary number of bytes values.

    * If you call string.concat or bytes.concat without arguments they return an empty array.
*/

    string public str2 = "Ranjan";

    function fConcatinate() public view returns(string memory) {

        string memory concat_string = string.concat(str, str2, "Literal");
        return concat_string;
        
    }
}
