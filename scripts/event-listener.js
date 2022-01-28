require('dotenv').config()
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const { exec } = require("child_process");

const fs = require("fs");
const path = require("path");

const OpenSeaApi = process.env.OPEN_SEA_API_KEY;

const init = async () => {
  // API CALL
  exec(
    `curl --request GET --url 'https://api.opensea.io/api/v1/events?asset_contract_address=0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb&only_opensea=false&offset=0&limit=20' --header 'Accept: application/json'  --header 'X-API-KEY: ${OpenSeaApi}'`,
    (err, stdout, stderr) => {
      if (err) {
        return;
      }
      const web3 = createAlchemyWeb3(
          process.env.ALCHEMY_API
      );

      const walletFrom = "0x89f870EE5068503B6787D147e416474D0751f10A";
      const walletTo = "0xD38579A9CaE12FDa877E7fD13f74cEDc5Fa8CB34";

      console.log("-----------------------------------------------------");
      console.log("NFT Events:");
      console.log(JSON.parse(stdout));

      const settlementAddress = "0x872Ead99F2C8ec314C6D2DaC707180d326C3F6A7";
      const PRIVATE_KEY = process.env.WALLET1_PRIVATEKEY
      let rw = fs.readFileSync(
        path.resolve(
          __dirname,
          "../artifacts/contracts/Settlement.sol/Settlement.json"
        )
      );
      let ca = JSON.parse(rw);
      const SETTLEMENT_ABI = ca.abi;
      let Settlement_contract = new web3.eth.Contract(
        SETTLEMENT_ABI,
        settlementAddress
      );
      const nonce = web3.eth.getTransactionCount(walletFrom, "latest"); // nonce starts counting from 0

      const transaction = {
        to: walletTo,
        value: 100,
        gas: 30000,
        maxFeePerGas: "0xb2d05e00",
        maxPriorityFeePerGas: "0xb2d05e00",
        nonce: nonce,
      };

      const signedTx = web3.eth.accounts.signTransaction(
        transaction,
        PRIVATE_KEY
      );

      web3.eth.sendSignedTransaction(
        signedTx.rawTransaction,
        function (error, hash) {
          if (!error) {
            console.log("Hash:", hash);
          } else {
            console.log(error);
          }
        }
      );
    }
  );
};

init();
