## Degen Token Contract

This Solidity contract is a custom implementation that extends the ERC20 token standard from OpenZeppelin. It provides functionalities such as minting, burning, transferring tokens, and redeeming specific items based on predefined token values. The contract also maintains a log of redeemed items for each user.

## Functionality Overview

1. `mint`: Only the contract owner can mint new tokens to a specified account.
2. `Burn`: Allows users to burn a specified amount of tokens from their own balance, with an accompanying event emission. It checks for sufficient funds before burning.
3. `transferTokens`: Enables users to transfer tokens to a specified recipient after proper approval and validation of available funds.
4. `redeem`: Allows users to redeem specific items based on predefined token values. It deducts the appropriate token amount from the user's balance and increments the count of redeemed items.
5. `balance`: Returns the balance of tokens for the caller.
6. `redeemedItemsCount`: Returns the count of redeemed items for a specified account.

## Prerequisites

The contract utilizes OpenZeppelin libraries, particularly version 4.9.0. Ensure that these libraries are properly installed.

## Usage

Deploy the contract using Avalanche Fuji Testnet Network, ensuring the Solidity version is 0.8.18 or higher. The contract supports functionalities for minting, burning, and transferring tokens, as well as the redemption of specific items based on predefined token values.

```javascript
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
        emit LogMessage("Destroyed tokens");
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

```

## Author

Dhanush K M

dhamushkm@gmail.com

## License

This contract is licensed under the MIT License. See the `LICENSE` file for more details.
