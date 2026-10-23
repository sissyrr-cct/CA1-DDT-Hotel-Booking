// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelBooking {
    address payable public hotelWallet;
    address public guestWallet;

    uint public roomPrice = 0.01 ether;
    uint public roomsAvailable = 10;
    uint public totalBookings = 0;
    uint public lastPayment;

    constructor() {
        hotelWallet = payable(msg.sender);
    }

    function bookRoom() public payable {
        require(msg.value == roomPrice, "Payment incorrect");
        require(roomsAvailable > 0, "No rooms available");

        roomsAvailable -= 1;
        totalBookings += 1;
        guestWallet = msg.sender;
        lastPayment = msg.value;

        (bool success, ) = hotelWallet.call{value: msg.value}("");
        require(success, "Payment failed");
    }

    function getBookings() public view returns (uint) {
        return totalBookings;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
