// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// Source Link: https://ethereum.org/en/developers/docs/standards/tokens/erc-721/
interface ERC721 {
    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes data
    ) external payable;

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable;

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable;

    function approve(address _approved, uint256 _tokenId) external payable;

    function setApprovalForAll(address _operator, bool _approved) external;

    function getApproved(uint256 _tokenId) external view returns (address);

    function isApprovedForAll(address _owner, address _operator)
        external
        view
        returns (bool);

    // EVENTS
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );
}

/* is ERC721 */
interface ERC721Metadata {
    /// @notice A descriptive name for a collection of NFTs in this contract
    function name() external view returns (string memory _name);

    /// @notice An abbreviated name for NFTs in this contract
    function symbol() external view returns (string memory _symbol);

    /// @notice A distinct Uniform Resource Identifier (URI) for a given asset.
    /// @dev Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
    ///  3986. The URI may point to a JSON file that conforms to the "ERC721
    ///  Metadata JSON Schema".
    function tokenURI(uint256 _tokenId) external view returns (string memory);
}

contract MyToken is ERC721 {
    uint256 totalTokenSupply;
    string public Name;
    string public Symbol;
    address public owner;
    mapping(address => uint256) balance;
    mapping(address => mapping(address => uint256)) allowed;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) {
        Name = _name;
        Symbol = _symbol;
        owner = msg.sender;
        totalTokenSupply = _totalSupply;
        balance[msg.sender] = _totalSupply;
    }

    /// Returns the token Name.
    function name() public view returns (string memory) {
        return Name;
    }

    /// Returns the token Symbol.
    function symbol() public view returns (string memory) {
        return Symbol;
    }

    /// Returns the total token supply.
    function totalSupply() public view override returns (uint256) {
        return totalTokenSupply;
    }

    /// Returns the accunt balance of another account with address _owner.
    function balanceOf(address _owner) public view override returns (uint256) {
        return balance[_owner];
    }
}
