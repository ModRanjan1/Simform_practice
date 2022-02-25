// SPDX-License-Identifier:GPL-3.0

pragma solidity > 0.5.0 < 0.9.0;



contract Demo{
    struct Student{
        string name;
        uint age;
        uint marks;
    }

    mapping(uint=>Student) public data;
    // about maping
    // The key cannot be types mapping, dynamic array, enum, and struct.
    // The value can be of any type.
    // Mapping are always stored in the storage irrespective of whether they are declared in contract storage or not.
    

    function setter(uint _roll, uint _age, uint _marks, string memory _name) public{
        data[_roll] = Student(_name, _age, _marks);
    }
}