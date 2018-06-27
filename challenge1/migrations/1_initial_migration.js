var Migrations = artifacts.require("./Migrations.sol");
var SmartFoodDelivery = artifacts.require("./smartFoodDelivery.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
