// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * @title Structs contract
 * @author Famus
 * @notice Storing and viewing user KYC information in a dedicated struct and emitting events accordingly
 */

contract userBalance {
    event FundsDeposited(address user, uint256 amount); //register the deposit of funds by user
    event ProfileUpdated(address user); //register / update a profile

    //struct storing users' information
    struct userKyc {
        string name;
        uint age;
    }

    //mapping storing address, KYC struct pairs
    mapping(address => userKyc) public userData;

    mapping(address => uint) public userbal; // mapping storing user's balance

    function setUserDetails(string calldata _name, uint _age) external {
        userKyc memory userkyc = userKyc(_name, _age);
        userData[msg.sender] = userkyc;
        emit ProfileUpdated(msg.sender);
    }

    function getUserDetails()
        external
        view
        returns (string memory name, uint age)
    {
        userKyc memory userkyc = userData[msg.sender];
        return (userkyc.name, userkyc.age);
    }

    function deposit(uint _amount) external {
        userbal[msg.sender] += _amount;
        emit FundsDeposited(msg.sender, _amount);
    }

    function checkBalance() external view returns (uint) {
        //returning whoever is calling the function balance;
        return userbal[msg.sender];
    }
}
