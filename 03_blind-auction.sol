// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BlindAuction{

    struct Bid {
        bytes32 blindedBid;
        uint deposit; 
    }

    address payable public Owner;
    uint public biddingEnd;
    uint public revealEnd;
    bool public ended;

    mapping(address => Bid[]) public bids;

    address public highestBidder;
    uint public highestBid;

    mapping(address => uint) pendingReturns;

    event AuctionEnded(address winner, uint heighestBid);

    modifier onlyBefore(uint _time) { require(block.timestamp < _time ); _;}
    modifier onlyAfter(uint _time) { require(block.timestamp > _time); _; }

    constructor(
        uint _biddingTime,
        uint _revealTime,
        address payable _owner
    ){
        Owner = _owner;
        biddingEnd = block.timestamp + _biddingTime;
        revealEnd = biddingEnd + _revealTime;
    }

    function generateBlindBidBytes32(uint _value, bool _fake) public pure returns(bytes32)
    {
        return keccak256(abi.encodePacked(_value, _fake));
    }

    function bid(bytes32 _blindBid) public payable onlyBefore(biddingEnd) {
        bids[msg.sender].push(Bid ({
            blindedBid: _blindBid,
            deposit: msg.value
        }));
    }

    function reveal(
        uint[] memory _values,
        bool[] memory _fake
    ) 
        public
        onlyAfter(biddingEnd)
        onlyBefore(revealEnd)
    {
       uint length = bids[msg.sender].length;
       require(_values.length == length);
       require(_fake.length == length);

    //    uint refund;
       for(uint i=0; i<length; i++) {
           Bid storage bidToCheck = bids[msg.sender][i];
           (uint value, bool fake) = (_values[i], _fake[i]);
           if(bidToCheck.blindedBid != keccak256(abi.encodePacked(value, fake))) {
               continue;
           }
        //    refund += bidToCheck.deposite;
           if(!fake && bidToCheck.deposit >= value) {
               if(!placeBid(msg.sender, value)) {
                //    refund -= value;
                payable(msg.sender).transfer(bidToCheck.deposit *(1 ether));
               }
           }
           bidToCheck.blindedBid = bytes32(0);
       } 
    //    payable(msg.sender).transfer(refund);
    }

    function auctionEnd() public payable onlyAfter(revealEnd){
        require(!ended);
        emit AuctionEnded(highestBidder, highestBid);
        ended = true;
        Owner.transfer(highestBid);
    }

    function withdraw() public {
        uint amount = pendingReturns[msg.sender];
        if( amount > 0){
            pendingReturns[msg.sender] = 0;

            payable(msg.sender).transfer(amount);
        }
    }

    function placeBid(address _bidder , uint _value) internal returns(bool success) {
        if(_value <= highestBid) {
            return false;
        }
        if(highestBidder != address(0)) {
            pendingReturns[highestBidder] += highestBid;
        }
        highestBid = _value;
        highestBidder = _bidder;
        return true;
    }
}
