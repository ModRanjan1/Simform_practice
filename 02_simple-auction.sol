// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract SimpleAuction {
  
    address payable public beneficiary;
    uint public auctionEndTime;

    address public highestBidderAddress;
    uint public highestBid;

    mapping(address => uint) pendingReturns;

    bool ended;

    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    // The triple-slash comments are so-called natspec comments. 
    // They will be shown when the user is asked to confirm a transaction or when an error is displayed.


    /// Create a simple auction with `biddingTime`(in second) and `beneficiaryAddress`(payable).
    constructor(uint _biddingTime, address payable _beneficiaryAddress) {
        beneficiary = _beneficiaryAddress;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The value will only be refunded if the
    /// auction is not won.
    function placeBid() external payable {

        // Revert the call if the bidding period is over.
        if (block.timestamp > auctionEndTime)
            revert("The Auction has already been ended");

        // If the bid is not higher, send the money back 
        // (the revert statement will revert all changes in 
        // this function execution including it having received the money).
        if (msg.value <= highestBid)
            revert ("Bid Not High Enough to place the transaction");

        if (highestBid != 0) {
            // Sending back the money by simply using
            // highestBidderAddress.send(highestBid) is a security risk
            // because it could execute an untrusted contract.
            // It is always safer to let the recipients
            // withdraw their money themselves.
            pendingReturns[highestBidderAddress] += highestBid;
        }
        highestBidderAddress = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }


    function withdraw() external returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            
            pendingReturns[msg.sender] = 0;

            if (!payable(msg.sender).send(amount)) {
                // No need to call throw here, just reset the amount owing
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() external {
        // It is a good guideline to structure functions that interact
        // with other contracts (i.e. they call functions or send Ether)
        // into three phases:
        // 1. checking conditions
        // 2. performing actions (potentially changing conditions)
        // 3. interacting with other contracts
        // If these phases are mixed up, the other contract could call
        // back into the current contract and modify the state or cause
        // effects (ether payout) to be performed multiple times.
        // If functions called internally include interaction with external
        // contracts, they also have to be considered interaction with
        // external contracts.

        // 1. Conditions
        if (block.timestamp < auctionEndTime)
            revert("AuctionhasNotYetEndedyet");
        if (ended)
            revert("The AuctionEnd function has Already been Called");

        // 2. Effects
        ended = true;
        emit AuctionEnded(highestBidderAddress, highestBid);

        // 3. Interaction
        beneficiary.transfer(highestBid);
    }
}