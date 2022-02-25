// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

struct Student {
    // Structs are custom defined types that can group several variables.
    uint256 roll;
    string name;
}

contract ClassA {
    Student public Ranjan;

    constructor(uint256 _roll, string memory _name) {
        Ranjan.roll = _roll;
        Ranjan.name = _name;
    }

    function change(uint256 _roll, string memory _name) public {
        Student memory new_student = Student({roll: _roll, name: _name});

        Ranjan = new_student;
    }
}
