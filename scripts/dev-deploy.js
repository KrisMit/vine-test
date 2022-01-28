require('dotenv').config()
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const NFT = require("../artifacts/contracts/NFT.sol/NFT.json");
const fs = require("fs");
const path = require("path");

function subscribeToEvents() {
  let options = {
    fromBlock: 0,
    address: [],
    topics: [],
  };

  let subscription = web3.eth.subscribe("logs", options, (err, event) => {
    if (!err) console.log(event);
  });

  subscription.on("data", (event) => console.log(event));
  subscription.on("changed", (changed) => console.log(changed));
  subscription.on("error", (err) => {
    throw err;
  });
  subscription.on("connected", (nr) => console.log(nr));
}

const OpenSeaApi = process.env.OPEN_SEA_API_KEY;

async function main() {
  const [deployer] = await ethers.getSigners();
  const web3 = createAlchemyWeb3(
    process.env.ALCHEMY_API
  );
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  const NFT_address = "0x88B48F654c30e99bc2e4A1559b4Dcf1aD93FA656";
  const settlementAddress = "0x872Ead99F2C8ec314C6D2DaC707180d326C3F6A7";

  const wallet1 = "0x89f870EE5068503B6787D147e416474D0751f10A";
  const wallet2 = "0x44F655ECE5D6f84E0EdaB37757961E8734EF3129";

  console.log("Wallet 1: ", wallet1);
  console.log("Wallet 2: ", wallet2);
  console.log("-----------------------------------------------------");

  // const Settlement = await ethers.getContractFactory("Settlement");
  // const settlement = await Settlement.deploy();

  let rawdata = fs.readFileSync(
    path.resolve(__dirname, "../artifacts/contracts/NFT.sol/NFT.json")
  );
  let contractAbi = JSON.parse(rawdata);
  const NFT_ABI = contractAbi.abi;
  let NFT_contract = new web3.eth.Contract(NFT_ABI, NFT_address);

  let rw = fs.readFileSync(
    path.resolve(
      __dirname,
      "../artifacts/contracts/Settlement.sol/Settlement.json"
    )
  );
  let ca = JSON.parse(rawdata);
  const SETTLEMENT_ABI = ca.abi;
  let Settlement_contract = new web3.eth.Contract(
    SETTLEMENT_ABI,
    settlementAddress
  );

  console.log("NFT address:", NFT_address);
  console.log("Settlement address:", settlementAddress);

  let owner = await NFT_contract.methods.owner().call();
  console.log("Owner:", owner);

  console.log("-----------------------------------------------------");
  let events = await NFT_contract.events;
  console.log("Events:", events);
  console.log("-----------------------------------------------------");

  // let methods = await NFT_contract.methods
  // console.log("Methods:", methods)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
