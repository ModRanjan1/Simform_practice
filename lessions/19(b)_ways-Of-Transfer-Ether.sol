// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.0 <0.9.0;

contract checkSend {
    
    receive() external payable {}

    event log(uint value);
    
    function SEND(address payable getter) public payable {

        emit log(msg.value);

        bool sent = getter.send(msg.value);
        require(sent, "transaction failed");
    }

    function TRANSFER(address payable getter) public payable {
        getter.transfer(msg.value);
    }

    function CALL(address payable getter) public payable {
       
        (bool sent, ) = getter.call{value: msg.value}("");
        require(sent, "transaction failed");
    }

    function checkBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
