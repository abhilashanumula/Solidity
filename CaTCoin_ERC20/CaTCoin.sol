// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CaTCoin {
    string public _name;
    string public _symbol;
    address public _owner;
    uint256 public _totalSupply = 0;
    mapping(address=>uint256) _balances;

    event Transfer(address from, address to, uint256 amount);

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _owner = msg.sender;
        _mint(msg.sender,1000*( 10 ** decimals()));

    }

    function decimals() public pure returns (uint) {
        return 18;      // least amount you can transact is 0.000.....01 of a token, as we can only transcact token in the form of uint... we use this func
    }

    modifier onlyOwner {
        require(msg.sender == _owner, "ONly owner can mint!");
        _;
    }

    function _mint(address to, uint256 amount) public onlyOwner {
        _balances[to] += amount;
        _totalSupply += amount;
        emit Transfer(msg.sender, to, amount);
    }

    function _burn(uint256 amount)  public {
        require(_balances[msg.sender] >= amount,"Insufficient Funds");
        _balances[msg.sender] -= amount;
        _totalSupply -= amount;
        
    }

    function transfer(address to, uint256 amount) public {
        require(_balances[msg.sender] >= amount,"Insufficient Funds");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender,to,amount);
    }

    function transferFrom(address from, address to, uint256 amount) public {
        require(_balances[from] >= amount,"Insufficient Funds");
        _balances[from] -= amount;
        _balances[to] += amount;
        emit Transfer(from,to,amount);
    }

    function balanceOf(address _add) public view returns(uint256) {
        return _balances[_add];
    }

    
    function getOwner() public view returns(address) {
        return _owner;
    }

}