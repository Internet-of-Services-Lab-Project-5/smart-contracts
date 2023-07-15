/** @type import('hardhat/config').HardhatUserConfig */
require("dotenv").config();
require("@nomiclabs/hardhat-ethers");

const { ALCHEMY_API_URL, WALLET_PRIVATE_KEY } = process.env;

module.exports = {
  solidity: "0.8.2",
  defaultNetwork: "sepolia",
  networks: {
    hardhat: {},
    sepolia: {
      url: ALCHEMY_API_URL,
      accounts: [`0x${WALLET_PRIVATE_KEY}`],
    },
  },
};
