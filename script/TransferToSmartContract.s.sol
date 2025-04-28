// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "forge-std/Vm.sol"; 


interface IBucket {
    function drop(address erc20, uint amount) external;
}

contract Transfer is Script {

    uint256 private allowanceAmount = 2 * 10**18; 
    address private smartContractAddr = 0xa978c3BcaFA79058e408a65Ea5dfb7F3B800d0F8;
    address private tokenOwner = vm.envAddress("TEST_ADDRESS");
    address private tokenAddr = vm.envAddress("NIMA_TOKEN_ADDRESS_SEPOLIA");

    function run() public {

        IERC20 token = IERC20(tokenAddr);
        IBucket bucketContract = IBucket(smartContractAddr);

        vm.startBroadcast();

        token.approve(smartContractAddr, allowanceAmount);
        console.log("Approval done for address %s and amount %s", smartContractAddr, allowanceAmount/10**18, " NIMA tokens.");
        console.log("Allowance: ", token.allowance(tokenOwner, smartContractAddr));
        console.log("NIMA token balance of owner account: ", token.balanceOf(tokenOwner));
        
        bucketContract.drop(tokenAddr, allowanceAmount);
        console.log("The NIMA tokens were successfully transferred to ", smartContractAddr);

        vm.stopBroadcast();
        
    }
}