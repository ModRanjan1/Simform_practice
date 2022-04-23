// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract Ballot {
    address contractOwner;

    struct Voter {
        bool vote;
        uint256 weight;
        address votedTo;
    }
    struct Proposal {
        address proposalId;
        string symbool;
        uint256 voteCount;
    }

    Proposal[] public proposals;
    // 1 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    // 2 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    mapping(address => Voter) public voters;

    constructor() {
        contractOwner = msg.sender;
    }

    // modifier
    modifier onlyContractOwner() {
        require(
            msg.sender == contractOwner,
            "Only Contract owner can call this."
        );
        _;
    }

    modifier checkVote() {
        require(voters[msg.sender].vote == false, "Already Voted");
        _;
    }

    // functions
    function addProposal(address _proposalAddress, string memory _symbool)
        public
        onlyContractOwner
    {
        // proposals.push(Proposal({
        //         proposalId: _proposalAddress,
        //         symbool: _symbool,
        //         voteCount: 0
        //     }));

        proposals.push(Proposal(_proposalAddress, _symbool, 0));
    }

    function giveRightToVote(address _voterAddress)
        public
        onlyContractOwner
        checkVote
    {
        voters[_voterAddress].weight = 1;
    }

    function giveVoteTo(uint256 _proposal) public checkVote {
        proposals[_proposal].voteCount += voters[msg.sender].weight;
    }

    function voteCount(string memory _symbool)
        public
        view
        onlyContractOwner
        returns (uint256 count)
    {
        for (uint256 i = 0; i < proposals.length; i++)
            if (
                keccak256(abi.encodePacked((proposals[i].symbool))) ==
                keccak256(abi.encodePacked((_symbool)))
            ) count = proposals[i].voteCount;

        return count;
    }

    function decleareWinner() public view returns (string memory winner) {
        uint256 winnerVoteCount = 0;
        for (uint256 p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winnerVoteCount) {
                winnerVoteCount = proposals[p].voteCount;
                winner = proposals[p].symbool;
            }
        }
        return winner;
    }
}