// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelBooking {
    address public hotelWallet;
    uint public roomPrice = 0.01 ether;

    constructor() {
        hotelWallet = msg.sender;
    }
}
