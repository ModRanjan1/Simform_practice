// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.21 <0.9.0;

contract SimpleAuction {
    event message(address sender, int amount); 
/** event
    * takes less gas to push data into blockchain

*/
    function bid(int _val) public payable {
        // ...
        emit message(msg.sender, _val); // Triggering event
    }
}