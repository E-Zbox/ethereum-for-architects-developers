// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Lesson {
	string public firstName;
	uint16 public highestAge;
	uint8[] public colors;
	address public owner;

	constructor() {
		owner = msg.sender;
	}

	modifier onlyOwner {
		require(msg.sender == owner, "Only owner can perform operation!");
		_;
	}

	modifier withinRange(uint8 _index) {
		require(_index < colors.length, "Provided parameter exceeds length of array!");
		_;
	}

	function addColor(uint8 _color) public onlyOwner {
		colors.push(_color);
	}

	function getColor(uint8 _index) public withinRange(_index) view returns(uint8) {
		return colors[_index];
	}

	function setFirstname(string memory _name) public {
		firstName = _name;
	}
}
