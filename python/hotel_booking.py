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
    hotelWallet = contract.functions.hotelWallet().call()
    print("Hotel wallet:", hotelWallet)
    print("Last guest wallet:", contract.functions.guestWallet().call())

    # Hotel information
    print("Rooms available:", contract.functions.roomsAvailable().call())
    print("Total bookings:", contract.functions.totalBookings().call())
    
    # Selecting account and price
    guestAccount = ganache.eth.accounts[1]
    roomPrice = contract.functions.roomPrice().call()
    print("\nGuest:", guestAccount)

    # Book and send payment
    transaction = contract.functions.bookRoom().transact({
        "from": guestAccount,
        "value": roomPrice
    })

    receipt = ganache.eth.wait_for_transaction_receipt(transaction)

    if receipt.status == 1:
        print("Booking successful!")
        print("Rooms available:", contract.functions.roomsAvailable().call())
        print("Total bookings:", contract.functions.totalBookings().call())
    else:
        print("Booking failed.")
else:
    print("Connection failed. Check Ganache.")