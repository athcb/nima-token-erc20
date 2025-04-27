// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract NimaToken is ERC20 {

   uint256 public constant INITIAL_SUPPLY = 1000 * 10 ** 18;

    constructor() ERC20("NimaToken", "NIMA") {
        _mint(msg.sender, INITIAL_SUPPLY);
    } 


}