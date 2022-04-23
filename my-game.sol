// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract MyGame {
    uint256 public playerCount = 0;

    uint256 public pot;
    address public Owner;

    Player[] public playersInGame;

    mapping(address => Player) public players;

    enum Level {
        Novice,
        Intermediate,
        Advanced
    }

    struct Player {
        address playerAddress;
        Level playerLevel;
        string firestName;
        string lastName;
        uint256 createdTime;
    }

    constructor() {
        Owner = msg.sender;
    }

    function addPlayer(string memory firstName, string memory lastName)
        private
    {
        Player memory newPlayer = Player(
            msg.sender,
            Level.Novice,
            firstName,
            lastName,
            block.timestamp
        );
        players[msg.sender] = newPlayer;
        playersInGame.push(newPlayer);
    }

    function getPlayerLevel(address playerAddress)
        private
        view
        returns (Level)
    {
        Player storage player = players[playerAddress];
        return player.playerLevel;
    }

    function changePlayerLevel(address playerAddress) private {
        Player storage player = players[playerAddress];
        if (block.timestamp >= player.createdTime + 20) {
            player.playerLevel = Level.Intermediate;
        }
    }

    function joinGame(string memory _firstName, string memory _lastName)
        public
        payable
    {
        require(msg.value == 10 ether, "The joining fee is 10 ether");
        if (payable(Owner).send(msg.value)) {
            addPlayer(_firstName, _lastName);
            playerCount += 1;
            pot += 10;
        }
    }

    function payOutWinners(address loserAddress) public payable {
        require(
            msg.sender == Owner,
            "Only the dwaler can pay out the winner."
        );
        require(msg.value == pot * (1 ether));

        uint256 payoutPerWinner = msg.value / (playerCount - 1);

        for (uint256 i = 0; i < playersInGame.length; i++) {
            address currentPlayerAddress = playersInGame[i].playerAddress;
            if (currentPlayerAddress != loserAddress) {
                payable(currentPlayerAddress).transfer(payoutPerWinner);
            }
        }
    }
}


