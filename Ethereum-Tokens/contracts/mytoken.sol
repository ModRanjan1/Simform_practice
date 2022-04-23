// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// Source Link: https://eips.ethereum.org/EIPS/eip-20
interface ERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address tokenOwner) external view returns (uint256);

    function transfer(address _to, uint256 value) external returns (bool);

    function allowence(address _owner, address _spender)
        external
        view
        returns (uint256);

    function approve(address _spender, uint256 value) external returns (bool);

    function TransferFrom(
        address _from,
        address _to,
        uint256 value
    ) external returns (bool);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _from, address indexed _to, uint256 _value);
}

contract MyToken is ERC20 {
    uint256 totalTokenSupply = 1000;
    string public Name;
    string public Symbol;
    address public owner;
    mapping(address => uint256) balance;
    mapping(address => mapping(address => uint256)) allowed;

    constructor(string memory _name, string memory _symbol) {
        Name = _name;
        Symbol = _symbol;
        owner = msg.sender;
        balance[msg.sender] = totalTokenSupply;
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

    /// Transfer _value ampunt of tokens _to, and MUST fire the Transfer event.
    /// The funcction SHOULD throw if the message caller's account balance does not have enough tokens to spend.
    /// NOTE: Transfer of 0 values MUST be treated as transfers and fire the Transfer event.
    function transfer(address _to, uint256 _value)
        public
        override
        returns (bool)
    {
        require(balance[msg.sender] >= _value, "Not enough balance");
        balance[msg.sender] -= _value;
        balance[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /// Transfers _value amount of token from address _from to address _to, and MUST fire the Transfer event.
    /// The transferFrom method is used for a withraw workflow, alloewing contracts to transfer tokens on your behalf.
    // This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies.
    // The function SHOULD throw unless the _from account has deliberately authorized the sender of the message via some mechanism.
    /// NOTE: Transfer of 0 values MUST be treated as transfers and fire the Transfer event.
    function TransferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override returns (bool) {
        require(_value <= allowed[_from][msg.sender], "Not enough balance");
        allowed[_from][msg.sender] -= _value;
        balance[_from] -= _value;
        balance[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    /// Allow _spender to withraw from your account multiple times, up to the _value amount.
    // If this function is called again it overwrites the current allowance with _value.
    function approve(address _spender, uint256 value)
        public
        override
        returns (bool)
    {
        allowed[msg.sender][_spender] = value;
        emit Approval(msg.sender, _spender, value);
        return true;
    }

    /// Returns the amount which _spender is still allowed to withdraw from _owner.
    function allowence(address _owner, address _spender)
        public
        view
        override
        returns (uint256)
    {
        return allowed[_owner][_spender];
    }
}
