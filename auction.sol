// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract  EnglishAuction{
    address public highestBidder;
    uint public highestBid;
    mapping (address => uint)public bids;
        constructor(){
            highestBidder=msg.sender;
            highestBid=0;
        }
    function bid() public payable {
        require(msg.value > highestBid, "Bid must me greater than the current Bid");
        payable (highestBidder).transfer(highestBid);
        highestBidder = msg.sender;
        highestBid = msg.value;
        bids[msg.sender] += msg.value;
    }
    function withdraw() public {
         require(msg.sender != highestBidder, "Highest bidder cannot withdraw untill end of the auction");
         uint amount = bids[msg.sender];
         require(amount > 0,"No funds to withdraw");
         bids[msg.sender] = 0;
         payable (msg.sender).transfer(amount);
    }
    
    function endAuction() public view{
        require(msg.sender == highestBidder,"Only the highest bidder can end the Auction");
    }
}