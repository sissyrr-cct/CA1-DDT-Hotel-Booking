// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract HotelBooking {
    address payable public hotelWallet;
    address public guestWallet;

    uint public roomPrice = 0.01 ether;
    uint public totalRooms = 10;
    uint public totalBookings = 0;
    uint public lastPayment;

    mapping(uint => uint) public bookingsPerDate;

    //recording successful bookings
    event RoomBooked(address guest, uint date, uint amount);

    constructor() {
        hotelWallet = payable(msg.sender);
    }

    function bookRoom(uint date) public payable {
        require(date > 0, "Enter a booking date");
        require(msg.value == roomPrice, "Incorrect payment");
        require(bookingsPerDate[date] < totalRooms, "No rooms available");

        bookingsPerDate[date] += 1;
        totalBookings += 1;
        guestWallet = msg.sender;
        lastPayment = msg.value;

        (bool success, ) = hotelWallet.call{value: msg.value}("");
        require(success, "Payment failed");

        emit RoomBooked(msg.sender, date, msg.value);
    }

    function getAvailableRooms(uint date) public view returns (uint) {
        return totalRooms - bookingsPerDate[date];
    }

    function getBookings() public view returns (uint) {
        return totalBookings;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
