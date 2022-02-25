// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Identity {
    //* State variables are variables whose values are permanently stored in contract storage.
    string name; // State variable
    uint256 age; // State variable

    constructor() {
        name = "ModRanjan";
        age = 20;
    }

    // Functions are the executable units of code. Functions are usually defined inside a contract, but they can also be defined outside of contracts.
    function getName() public view returns (string memory) {
        return name;
    }

    function getAge() public view returns (uint256) {
        return age;
    }
}

contract defaultValue {
    uint public num;
    bool public check;
    address public wallet;
    bytes32 public a;
    string str; 
}