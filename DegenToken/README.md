# DegenToken

DegenToken is an ERC20 token contract that implements a custom token called "Degen" (DGN). It includes additional functionalities such as a shop, token minting, transferring, redeeming, and burning.

## Prerequisites

- Solidity ^0.8.18
- OpenZeppelin Contracts library

## Getting Started

1. Clone the repository or copy the contract code into a new Solidity file.
2. Install the required dependencies, including the OpenZeppelin Contracts library.
3. Compile the contract using a Solidity compiler of your choice.
4. Deploy the contract to the desired Ethereum network or use it within your existing project.

## Contract Details

The DegenToken contract extends the ERC20 and Ownable contracts from the OpenZeppelin Contracts library. It includes the following functionalities:

### Shop

- The contract initializes a shop with predefined items and their prices.
- Users can redeem tokens by transferring the required amount from their account to the contract owner's account.
- The redeemed items are tracked using a mapping called `items`, which stores the number of items owned by each account.

### Minting and Burning

- The contract includes functions to mint and burn tokens.
- Only the contract owner, specified by the `Ownable` contract, can perform these actions.

### Transferring Tokens

- Users can transfer tokens to other addresses using the `transferTokens` function.

### Checking Balance

- Users can check their token balance using the `checkBalance` function.

## Deployment

To deploy the DegenToken contract to the Fuji Testnet (Avalanche Testnet), follow these steps:

1. Make sure you have the Hardhat development environment installed. 
2. Set up the necessary configuration details in the `hardhat.config.js` file, including network settings and accounts.
3. Or you can create a `.env` file containing all your wallet private keys and api keys.
   ```js
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [process.env.WALLET_PRIVATE_KEY], // we use a .env file to hide our wallets private key
    },
   ```
    
4. After successful deployment, the contract address will be displayed in the console, for example:
   ```bash
    $ npx hardhat --network fuji run scripts/deploy.js
    Compiled 1 Solidity file successfully
    Degen token deployed to 0x71Fbd124304E1e095d55e65a5b0fCF88af8fbF00
   ```
5. One additional step is to verify the deployed smart contract, [to do this we need an API Key from Snowtrace, you need to provide an email address to complete this step, but is straightforward](https://snowtrace.io/register).

```js
module.exports = {
  // ...rest of the config...
  etherscan: {
    apiKey: process.env.SNOWTRACE_API_KEY,
  },
};
```
   6. Now we have access to the *verify* task, which allows us to verify smart contracts on specific networks.
   ```bash
    $ npx hardhat verify 0x71Fbd124304E1e095d55e65a5b0fCF88af8fbF00 --network fuji
    Nothing to compile
    Successfully submitted source code for contract
    contracts/DegenToken.sol:DegenToken at 0x71Fbd124304E1e095d55e65a5b0fCF88af8fbF00
    for verification on the block explorer. Waiting for verification result...

    Successfully verified contract DegenToken on Etherscan.
    https://testnet.snowtrace.io/address/0x71Fbd124304E1e095d55e65a5b0fCF88af8fbF00#code

   ```



