const hre = require("hardhat");

async function main() {
  let Callee = await hre.ethers.getContractFactory("contracts/Calliee.sol:Callee");
  let Caller = await hre.ethers.getContractFactory("contracts/Caller.sol:Caller");
  let callee = await Callee.deploy();
  let caller = await Caller.deploy();

  await callee.deployed();
  await caller.deployed();

  console.log("Callee deployed to:", callee.address);
  console.log("Caller deployed to:", caller.address);

  //
  

  let val = await callee.callStatic.getValues()
  console.log("Callee Values", val);

  console.log("Testing account chaining", caller.address);
  // caller.callAdr(callee.adr)
  val = await callee.callStatic.storeValue(1)

  console.log("Callee Values", val);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
