//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Bank {

    mapping(address => uint) private balances;
    uint limitBank = 20;
    event Deposit(address indexed owner, uint amount);
    event Withdraw(address indexed owner, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);

    function deposit(address _account, uint _number) public payable {
        limitBank -= _number;

        // Assert
        assert(limitBank <= 20 && limitBank >= 0);

        balances[_account] += _number;
        emit Deposit(_account, _number);
    }

    function withdraw(address _account, uint _number) public payable {
        
        // Require
        require(balances[_account] > _number, "You're broke!");

        balances[_account] -= _number;
        limitBank += _number;
        // Assert
        assert(limitBank <= 20 && limitBank >= 0);
        emit Withdraw(_account, _number);
    }

    function transfer(address _from, address _to, uint _number) public payable {
        // Revert
        if(balances[_from] < _number){
        revert("You do not have enough funds for this transaction");
        }

        balances[_from] -= _number;
        balances[_to] += _number;
        emit Transfer(_from, _to, _number);
    }

    function getBalance(address _address) public view returns(uint) {
        return balances[_address];
    } 
}