// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract Coin{
    // the keyword *public* makes variables accessible from other contracts
    address public minter;

    mapping ( address => uint) public balances;

    // events allows clients to react to specific contract changes you declare
    event Sent(address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }

    // sends an amount of newly created coin to an address
    // can only be called by the contract creator
    function mint(address receiver, uint _amount) public {
        require(msg.sender == minter);
        require(_amount < 1e60);
        balances[receiver] += _amount;
    }

    // sends an amount of existing coins from any caller to an address
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance. :(");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}