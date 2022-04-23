// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.0 <0.9.0;

contract checkRequire {

    address public owner = msg.sender;
    uint age = 25;  

    function Require(uint256 _amount) public {
    /** Use require()to:
        Validate user inputs ie. require(input<20);
        Validate the response from an external contract ie. require(external.send(amount));
        Validate state conditions prior to execution, ie. require(block.number > SOME_BLOCK_NUMBER) or require(balance[msg.sender]>=amount)
        
        1. in require() condition - false - revert gas-fee  
        2. in require() condition - false - revert state variable to original value  
    */
        
        age = 17;
        require(_amount < 100, "Amount is greater than 100 :(");
    }

    function getAge() view public returns(uint){
        return age;
    }
    

}