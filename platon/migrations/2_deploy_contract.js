const ProxyRegistry = artifacts.require("ProxyRegistry");
const KingHonorNFT = artifacts.require("KingHonorNFT");

module.exports = async function (deployer) {
  await deployer.deploy(ProxyRegistry);
  let proxy = await ProxyRegistry.deployed();
  await deployer.deploy(KingHonorNFT, "KingHonor", "KH", proxy.address);
};
