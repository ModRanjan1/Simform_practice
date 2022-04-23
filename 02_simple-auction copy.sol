// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract SimpleAuction {
  
    address payable beneficiary;
    uint auctionEndTime;

    address public highestBidderAddress;
    uint public highestBid;
    uint public increaseBid;

    enum State { Active, Inactive }
    State state;

    mapping(address => uint) pendingReturns;

    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    modifier notOwner(){
        require(msg.sender != beneficiary, "Owner cannot Bid");
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == beneficiary, "Only Owner can call this");
        _;
    }

    modifier Running(){
        require(state == State.Active, "Auction has ended");
        _;
    }


    constructor(uint _biddingTime, uint _incBid) {
        beneficiary = payable(msg.sender);
        auctionEndTime = block.timestamp + _biddingTime;
        state = State.Active;
        increaseBid = _incBid;
    }

    function placeBid() public notOwner Running payable {

        // Revert the call if the bidding period is over.
        if (block.timestamp > auctionEndTime)
            revert("The Auction Time has been Over");

        // If the bid is not higher, send the money back 
        if ((pendingReturns[msg.sender] + msg.value) <= (highestBid + increaseBid))
            revert ("Bid Not High Enough to place the transaction");

        if (highestBid != 0) {
            pendingReturns[highestBidderAddress] += highestBid;
        }
        highestBidderAddress = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }


    function withdraw() external notOwner returns (bool) {
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

    function cancelAuction() public onlyOwner Running {
        require(block.timestamp < auctionEndTime, "Auction Time has Already Over");

        state = State.Inactive;
    }

    function anounceWinner() public onlyOwner {

        require(block.timestamp > auctionEndTime, "Auction Time has Not Over Yet");

        state = State.Inactive;
        emit AuctionEnded(highestBidderAddress, highestBid);

        beneficiary.transfer(highestBid);
    }
}