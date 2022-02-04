const ProxyRegistry = artifacts.require("ProxyRegistry");

module.exports = function (deployer) {
  deployer.deploy(ProxyRegistry);
};
