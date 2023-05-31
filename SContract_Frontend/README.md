Deploying the Smart Contract and Connecting it to the Frontend(Next.js).

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Smart Contract Overview](#smart-contract-overview)
- [Frontend](#frontend)
- [Run this Locally](#run-this-locally)


## Smart Contract Overview

The Math smart contract allows users to perform addition and multiplication operations while managing a balance of credits. It provides the following features:

- Addition: The `add` function takes two input values `_a` and `_b` and adds them together. The function requires a specified `_amount` of credits to be available in the account balance.

- Multiplication: The `multiply` function takes two input values `_a` and `_b` and multiplies them together. Similar to the `add` function, it also requires a specified `_amount` of credits to be available in the account balance.

- Account Balance Management: The contract keeps track of the account balance and ensures that the requested operation can be performed only if the account balance has sufficient credits. The `addCred` function allows the owner of the contract to add credits to the account balance.

## Frontend
- Connect your MetaMask wallet when prompted.
- Perform mathematical operations and manage credits.
- Add Credits: Enter the amount and click "Add Credits".
- Perform Operation: Enter two numbers and select the operation.
- Click "Result" to calculate the result.
- View the result and remaining credits.
- The smart contract functions include:
  - addCred(uint256 _amount): Adds credits to the account.
  - add(uint256 _a, uint256 _b, uint256 _amount): Performs addition operation and deducts the specified amount of credits.
  - multiply(uint256 _a, uint256 _b, uint256 _amount): Performs multiplication operation and deducts the specified amount of credits.
  - getBalance(): Retrieves the account balance (remaining credits).
  - getResult(): Retrieves the result of the last operation.

## Run this Locally
1. Install packages: `npm install`
2. Create a local Eth node: `npx hardhat node`
3. Deploy the contract to the local Eth network: `npx hardhat run --network local scripts/deploy.js`
4. Start the Frontend: `npm run dev`


