const hre = require("hardhat");

async function main() {

  const Supplychain = await hre.ethers.getContractFactory("Supplychain");
  const supplychain = await Supplychain.deploy();

  await supplychain.deployed();

  console.log( `Tracking deployed to ${supplychain.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
