const COORDINATOR = "0xA0bA94a068F22727D26004e8D407b8fc1fac1Bd3";
const AIRLINES = [
  {
    name: "Airline1",
    wallet: "0x0cD8BddfCf3F724f28389831d61D2cA93706f2a0",
    iExecAddress: "0xe4466997238b45484c51e91fcbb184734e568822",
  },
  // {
  //   name: "Airline2",
  //   wallet: "0xf97D50f0df01921Af2e37EdaC9c6eA00d8723e10",
  //   iExecAddress: "0xb50d3d190190ac05f2e9887845900799e09be3a6"
  // },
  // {
  //   name: "Airline3",
  //   wallet: "0x9f81A7F939A44359864F9c9e3151c1A26B7Ca973",
  //   iExecAddress: "0xec24f02e4e52e29def086a81b487fdb169d50439"
  // },
  // {
  //   name: "Airline4",
  //   wallet: "0x3a7f8cE4E39b8E6Bb5ca26Cfe43430F1E65AC0e4",
  //   iExecAddress: "0x650111aae897fa755f66bc39fbab5b167ad8902a"
  // },
  // {
  //   name: "Airline5",
  //   wallet: "0x3966D1d6dFB65Cd6A2dC3B5cE36669572dd5E6DD",
  //   iExecAddress: "0x5d51b0093b2fcb52045e690e29d23a5c9dc81f3a"
  // },
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
