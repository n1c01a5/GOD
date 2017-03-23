var Go = artifacts.require("./Go.sol");

module.exports = function(deployer) {
  // init goban 10x10
  deployer.deploy(Go, 10);
};
