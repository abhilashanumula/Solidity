// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    mapping (string => uint) shop;

    constructor() ERC20("Degen", "DGN") {
              addItems();
    }
    function addItems()  private {
         shop["gameNFT"] = 150;
        shop["merch1"] = 100;
        shop["merch2"] = 75;
        shop["gamePremium"] = 100;        
    }

    mapping (address => mapping (string => int)) items;
   
        // overide deci to 0
        function decimals() public pure override returns (uint8) {
                return 0;
        }


        function mintTokens(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }

        function transferTokens( address to, uint256 amount) public {
            transferFrom(msg.sender,to,amount);
        }

        function checkBalance() public view returns(uint256){
            return balanceOf(msg.sender);
        }

        function redeemTokens(string memory name) public {
            address owner_ = owner();
            transferFrom(msg.sender,owner_,shop[name]);
            items[msg.sender][name]+=1;
        }

        function showItems(address account, string memory name) public view returns (int) {
            return items[account][name];
        }

        function burnTokens(uint256 amount) public {
            _burn(msg.sender, amount);
        }
}
