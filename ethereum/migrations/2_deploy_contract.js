const ProxyRegistry = artifacts.require("ProxyRegistry");
const KingHonorNFTView = artifacts.require("KingHonorNFTView");

module.exports = async function (deployer) {
  await deployer.deploy(ProxyRegistry);
  let proxy = await ProxyRegistry.deployed();
  await deployer.deploy(KingHonorNFTView, "DanteFlow", "KH", proxy.address);
};
