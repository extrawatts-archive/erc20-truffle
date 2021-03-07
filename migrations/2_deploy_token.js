const Token = artifacts.require('ERC20');

module.exports = function (deployer) {
  const name = 'ERC20 Token';
  const symbol = 'ERC20';
  const token = deployer.deploy(Token,name, symbol);
}