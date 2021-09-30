// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;

    constructor(address _priceFeed) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeed);
        //we need the price of ether
        //and we're gonna get that from chainlin price feed
    }

    function enter() public payable {
        // $50 dollar minimum

        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData();

        // 1. we need to convert the price variable from int to uint
        // 2. the price from the oracle has 8 decimals so we need to add 10 decimals to it
        uint256 adjustedPrice = uint256(price) * ( 10**10) ;
        uint256 costToEnter = (usdEntryFee * (10**18) ) / adjustedPrice;
        return costToEnter;
    }

        function getEthPrice() public view returns (uint256) {
        (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData();

        // 1. we need to convert the price variable from int to uint
        // 2. the price from the oracle has 8 decimals so we need to add 10 decimals to it
        uint256 adjustedPrice = uint256(price) * ( 10**10) ;
        return adjustedPrice;
    }

    function startLottery() public {}

    function endLotter() public {}
}
