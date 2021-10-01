from brownie import Lottery, accounts, config, network


def test_get_entrance_fee():
    account = accounts[0]
    lottery = Lottery.deploy(
        config["networks"][network.show_active()]["eth_usd_price_feed"],
        {"from": account},
    )
    entranceFee = lottery.getEntranceFee()
    ethPrice = lottery.getEthPrice()
    print("Eth price = ")
    print((ethPrice / (10 ** 18)))  # in ether
    print("Fee price = ")
    print((entranceFee / (10 ** 18)))  # in ether
