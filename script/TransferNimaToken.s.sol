// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract TransferNimaToken is Script {

    address private recipient = vm.envAddress("RECIPIENT_ADDRESS");
    //address private deployer = vm.envAddress("ANVIL_DEPLOYER_ADDRESS");
    uint256 private amount = 1 * 10**18;
    //address private sender = vm.addr(vm.envUint("TEST_PRIVATE_KEY")); 

    function run() public {

        IERC20 token = IERC20(vm.envAddress("NIMA_TOKEN_ADDRESS_SEPOLIA"));

        console.log("Sender balance before transfer:", token.balanceOf(msg.sender));
        console.log("Recipient balance before transfer:", token.balanceOf(recipient));

        vm.startBroadcast();
        token.transfer(recipient, amount);
        vm.stopBroadcast();

        console.log("Sender balance after transfer:", token.balanceOf(msg.sender));
        console.log("Recipient balance after transfer:", token.balanceOf(recipient));

        console.log("Transfered %s Nima tokens from %s to %s", amount / 10**18, recipient);

    }

}