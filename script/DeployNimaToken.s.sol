// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "../src/NimaToken.sol";


contract DeployNimaToken is Script {

    function run() external {

        vm.startBroadcast();
        NimaToken token = new NimaToken();
        console.log("NimaToken deployed to address: ", address(token));
        console.log("NimaToken deployed by address: ", address(msg.sender));
        vm.stopBroadcast();
    }

}