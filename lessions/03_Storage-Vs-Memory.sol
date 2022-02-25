// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.0 <0.9.0;

contract Demo {
/*     Storage                         Memorey
  * Holds state variables.      * Holds local variables defined inside  
                                  functions if they are refrence types.
  * Persistent                  * Not persistent
  * Cost gas                    * No gas
  * Like a Computer HDD         * Like a Computer RAM
*/

    string[] public student = ["Raj", "Mohan", "Aditya", "Mod Ranjan"];

    function meM() public view {
        string[] memory s1 = student;
        s1[0] = "Rajmohan";
    }

    function sto() public {
        string[] storage s1 = student;
        s1[0] = "Rajmohan";
    }
}
