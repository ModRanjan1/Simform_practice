// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.0 <0.9.0;

contract Bank {
    address public minter;

    struct User {
        uint256 balance;
        bool check;
    }

    mapping(address => User) public userWallet;

    event Sent(address from, address to, uint256 amount);

    // event openNewWallet(address wallet, uint balance);

    constructor() {
        minter = msg.sender;
    }

    function depositToWallet() public payable {
        if (userWallet[msg.sender].check != true) {
            userWallet[msg.sender].check = true;
        }
        userWallet[msg.sender].balance += msg.value;
        // emit openNewWallet(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        uint256 amount = _amount * (10**18);

        require(
            userWallet[msg.sender].check == true,
            "Sorry, You don't have any wallet in this Bank."
        );
        require(
            amount <= userWallet[msg.sender].balance,
            "Insufficient Balance. :("
        );

        userWallet[msg.sender].balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function myWalletBalance() public view returns (uint256) {
        return userWallet[msg.sender].balance;
    }

    // user-1: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // user-2: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    // user-3: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    function transfer(address _receiverAddress, uint256 _amount) public {
        uint256 amount = _amount * (10**18);
        require(
            userWallet[_receiverAddress].check == true,
            "Sorry, Unknown Wallet Address."
        );
        require(
            amount <= userWallet[msg.sender].balance,
            "Insufficient balance. :("
        );

        userWallet[msg.sender].balance -= amount;
        userWallet[_receiverAddress].balance += amount;

        emit Sent(msg.sender, _receiverAddress, amount);
    }
}
