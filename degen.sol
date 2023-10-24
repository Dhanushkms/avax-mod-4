// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.0/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract CustomToken is ERC20, Ownable, ERC20Burnable {
    event LogMessage(string message);

    mapping(address => uint256) public redeemed;

    constructor() ERC20("DEGEN", "DGN") {}

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }

    function Burn(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "INSUFFICIENT FUNDS!!");
        _burn(msg.sender, amount);
        emit LogMessage("burned tokens");
    }

    function transferTokens(address recipient, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "INSUFFICIENT FUNDS!!");
        approve(msg.sender, amount);
        transferFrom(msg.sender, recipient, amount);
    }

    function redeem(uint256 itemNumber) external payable {
        uint256 tokens;

        if (itemNumber == 1) {
            tokens = 1000; // Redeem iPhone for 1000 tokens
        } else if (itemNumber == 2) {
            tokens = 800; // Redeem Samsung for 800 tokens
        } else if (itemNumber == 3) {
            tokens = 1200; // Redeem Bike for 1200 tokens
        } else if (itemNumber == 4) {
            tokens = 2000; // Redeem Car for 2000 tokens
        } else {
            revert("Invalid item");
        }

        require(balanceOf(msg.sender) >= tokens, "INSUFFICIENT FUNDS!!");
        _burn(msg.sender, tokens);
        redeemed[msg.sender]++;
        emit LogMessage("Redeemed item");
    }

    function balance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function redeemedItemsCount(address account) public view returns (uint256) {
        return redeemed[account];
    }
}
