// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address private _owner;
    uint256 private _initialSupply;
    mapping(address => uint256) private _balances;

    constructor() ERC20("MyToken", "MTK") {
        _owner = msg.sender;
        _mint(msg.sender,1000000*(10**decimals()));
        _initialSupply+=1000000*(10**decimals());
    }


    modifier onlyOwner() {
        require(msg.sender == _owner, "Only owner can call this function");
        _;
    }


    function getOwner() public view returns (address) {
        return _owner;
    }

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
        _balances[account] += amount;
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        _balances[msg.sender] -= amount;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        return true;
    }
}
