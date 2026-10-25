
from web3 import Web3
import json

# Ganache connection
ganache = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))

if ganache.is_connected():
    print("Connected to Ganache!")

    # Load the ABI from the JSON file
    with open("hotel_booking_abi.json", "r") as file:
        abi = json.load(file)

    # Connecting to the smart contract
    contractAddress = input("Enter contract address from Remix: ")
    contract = ganache.eth.contract(
        address=Web3.to_checksum_address(contractAddress),
        abi=abi
    )

    # Wallet addresses
    print("Hotel wallet:", contract.functions.hotelWallet().call())
    print("Guest wallet:", contract.functions.guestWallet().call())

    # Hotel information
    print("Rooms available:", contract.functions.roomsAvailable().call())
    print("Total bookings:", contract.functions.totalBookings().call())

else:
    print("Connection failed. Check Ganache.")