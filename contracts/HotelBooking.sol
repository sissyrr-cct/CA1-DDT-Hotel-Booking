// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelBooking {
    address public hotelWallet;
    uint public roomPrice = 0.01 ether;

    mapping(uint => address) public bookings;

    constructor() {
        hotelWallet = msg.sender;
    }

    function bookRoom(uint date) public {
        require(bookings[date] == address(0), "Room already booked");

        bookings[date] = msg.sender;
    }
}
