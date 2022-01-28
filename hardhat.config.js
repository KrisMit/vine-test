require("@nomiclabs/hardhat-waffle");


const ALCHEMY_API_KEY = "https://eth-rinkeby.alchemyapi.io/v2/4OEDbIkOZJGHQPliVkddOR8XpSyGaf7X";

const ROPSTEN_PRIVATE_KEY = "952706202140426eee2e702ea024324623aae6719ac05c3f05409485939c50f5";


task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  defaultNetwork: "rinkeby",
  networks: {
    rinkeby: {
      url: ALCHEMY_API_KEY,
      accounts: [`${ROPSTEN_PRIVATE_KEY}`]
    }
  }
};
