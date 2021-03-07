// SPDX-License-Identifier: MIT
// Latest stable version of solidity
pragma solidity ^0.7.4;
// It is being needed to use struct  arrays
pragma experimental ABIEncoderV2;

// Main contract to implement. Our coin is also an ERC20 coin.
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";
// SafeMath allows us to make maths without thinking overflows
import "@openzeppelin/contracts/math/SafeMath.sol";
// It is needed for make one address to owner of contract and use that address
// to alter contract
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20Pausable, Ownable {
    using SafeMath for uint256;
    // Official release time of token
    uint256 public releaseTime;
    // Total max supply of token
    uint256 public totalMaxSupply;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) ERC20(_name, _symbol) {
        _mint(msg.sender, _initialSupply);
    }

    //Overriden ERC20 mint function. Mint new token to address
    function _mint(address account, uint256 amount) internal override {
        uint256 totalSupply = super.totalSupply();
        require(
            totalMaxSupply > totalSupply.add(amount),
            "Max total supply over"
        );

        super._mint(account, amount);
    }

    // Owner changes contract variables
    function alter(uint256 _releaseTime, uint256 _totalMaxSupply)
        external
        onlyOwner
    {
        releaseTime = _releaseTime;
        totalMaxSupply = _totalMaxSupply;
    }

    function getTimestamp() external view returns (uint256) {
        return block.timestamp;
    }
}
