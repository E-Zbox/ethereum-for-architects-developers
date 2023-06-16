// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract MyFirstToken is ERC20 {
    string public constant symbol = "DMY";
    string public constant name = "My First Token";
    uint8 public constant decimals = 18;

    uint private constant __totalSupply = 1000;
    mapping(address => uint) private __balanceOf;
    mapping(address => mapping(address => uint)) private __allowances;

    constructor() {
        __balanceOf[msg.sender] = __totalSupply;
    }

    function totalSupply() public pure returns (uint _totalSupply) {
        _totalSupply = __totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return __balanceOf[_owner];
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        if (_value > 0 && __balanceOf[msg.sender] >= _value) {
            __balanceOf[msg.sender] -= _value;
            __balanceOf[_to] += _value;
            return true;
        }
        return false;
    }

    function transferFrom(
        address _from,
        address _to,
        uint _value
    ) public returns (bool success) {
        if (
            _value > 0 &&
            __allowances[_from][msg.sender] >= _value &&
            __balanceOf[_from] >= _value
        ) {
            __balanceOf[_from] -= _value;
            __balanceOf[_to] += _value;
            __allowances[_from][msg.sender] -= _value;
            return true;
        }
        return false;
    }

    function approve(
        address _spender,
        uint _value
    ) public returns (bool success) {
        __allowances[msg.sender][_spender] = _value;
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint remaining) {
        return __allowances[_owner][_spender];
    }
}
