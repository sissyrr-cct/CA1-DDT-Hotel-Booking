from web3 import Web3

# Connect to Ganache
ganache = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))

if ganache.is_connected():
    print("Connected to Ganache")

    account = ganache.eth.accounts[0]
    print("Wallet address:", account)

    balance = ganache.eth.get_balance(account)
    print("Balance:", ganache.from_wei(balance, "ether"), "ETH")

else:
    print("Connection failed. Check Ganache.")
