// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentDetails {
    string firstName;
    string lastName;
    string dob;

    function setStudentDetails(
        string memory _fName,
        string memory _lName,
        string memory _dob
    ) public {
        firstName = _fName;
        lastName = _lName;
        dob = _dob;
    }

    function getStudentDetails()
        public
        view
        returns (string memory, string memory, string memory)
    {
        return (firstName, lastName, dob);
    }
}
