# Smart contract

This is the repository to deploy the smart contract we use to manage our list of airlines.

## Installation

Run `npm i`. We use hardhat and alchemy to deploy the smart contract.

## Deployment

### Environment

To deploy this contract, you need to insert a `.env` file in the root directory. It should have the following keys:

- `ALECHEMY_API_URL`: The Alchemy URL used for deployment (e.g.: `https://eth-sepolia.g.alchemy.com/v2/6msOk8gqto8m3OZtn5nhjeNSnN-HCPk9`).
- `WALLET_PRIVATE_KEY`: The private key of your wallet.

### Initial params

in `deploy.js` adjust the variable `COORDINATOR` and `AIRLINES` to set the initial data of the smart contract.

- `COORDINATOR`: is the address of the wallet used by the Gramine app.
- `AIRLINES`: is an array of airline objects, where each item contains the name of the airline, an Ethereum wallet address, and an iExec wallet address. The type of the object is as follows:
```
{
  name: string;
  wallet: string | Addressish;
  iExecAddress: string | Addressish;
}
```

### Actual deployment

1. Run `npm i compile` to compile the contract.
2. Run `npm i deploy` to deploy it.

## The ABI

Once deployed, you will find a json file that contains the ABI in `artifacts/contracts/AirlineWalletListManager.sol/AirlineWalletListManager.json`. If you have changed the smart contract you need to do some updates to the server and gramine app repo.

1. Copy that file
2. In the server repository replace the file `src/AirlineLWalletListManager.json` with the one you just have copied.
3. Copy the value of `"abi"` in that file.
4. Replace the return value of the `getABI()` function of the Gramine app with the copied array.
