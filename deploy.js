const COORDINATOR = "0xA0bA94a068F22727D26004e8D407b8fc1fac1Bd3";
const AIRLINES = [
  {
    name: "Sams Airline",
    wallet: "0x48d991cC8721E93D89556eB482c19411998889C0",
    iExecAddress: "0x8790ed88752255da1a08142d5ba31f0fc0b97fd4",
  },
];

async function main() {
  const contract = await ethers.getContractFactory("AirlineWalletListManager");
  const deployedContract = await contract.deploy(COORDINATOR, AIRLINES);
  console.log("Contract Deployed to Address:", deployedContract.address);
  console.log(
    "\nCheck on etherscan: https://sepolia.etherscan.io/address/" + deployedContract.address
  );
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
