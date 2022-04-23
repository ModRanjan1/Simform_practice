// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.0 <0.9.0;

contract checkSend {
    address payable public getter = payable(0xdD870fA1b7C4700F2BD7f44238821C26f7392148);

    receive() external payable {}

    /* send()
      * returns boolvalue: true for success / false for failure
      * has gas limit: 2300 gas, 
      * if operation reaches the gas limit, it will give an error "out Of Gas" and return false. 
      * if transaction is failed, it doesn't revert gas-fee.
      * if you perform any operation on state variable bafore send() statement then it couldn't revert to original value.

      ** conclusion : always use send() with require() (why-?).
         because of 2-reasons:
          1. in require() condition - false - revert gas-fee  
          2. in require() condition - false - revert state variable to original value  
*/

    function SEND() public {
        bool sent = getter.send(1 ether);
        require(sent, "transaction failed");
    }

    /* transfer()
        * does not returns anything
        * has gas limit: 2300 gas, 
        * if operation reaches the gas limit, it will give an error "out Of Gas" 
        * if transaction is failed, it will auto-revert the gas-fee.
        * if you perform any operation on state variable bafore send() statement then it will revert to original value.
*/
    function TRANSFER() public {
        getter.transfer(1 ether);
    }

    /* call()
        * returns 2-value:
           1. boolvalue: true for success / false for failure 
           2. somedata (in byte)
        * we have the right to set gas limit 
        * if operation reaches the gas limit, it will give an error "out Of Gas" 
        * if transaction is failed, it doesn't revert gas-fee.
        * if you perform any operation on state variable bafore call() statement then it couldn't revert to original value.

        ** conclusion: same as send() but it gave us the way to set the gas-fee.
*/

    function CALL() public {
        /* Syntax:
            .call{key: value, gas: value}("")
        */

        // (bool sent, bytes memory data) = getter.call{value: 1 ether}("");
        (bool sent, ) = getter.call{value: 1 ether}("");
        require(sent, "transaction failed");
    }

    function checkBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
