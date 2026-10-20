// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelBooking {
    address public hotelWallet;
    address public guestWallet;

    uint public roomPrice = 0.01 ether;
    uint public roomsAvailable = 10;
    uint public totalBookings = 0;
    uint public lastPayment;

    constructor() {
        hotelWallet = msg.sender;
    }

    function bookRoom() public payable {
        roomsAvailable -= 1;
        totalBookings += 1;
        guestWallet = msg.sender;
        lastPayment = msg.value;
    }

    function getBookings() public view returns (uint) {
        return totalBookings;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
