// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import "../src/NimaToken.sol";


contract NimaTokenTest is Test {

    NimaToken public nimaToken;
    address public deployer;
    address public recipient;
    address public delegate;
    uint256 public initialSupply = 1000 * 10 ** 18;
    uint256 public allowanceAmount = 10 * 10 ** 18;
    uint256 public gasUsed;

    function setUp() public {
        deployer = makeAddr("deployer");
        recipient = makeAddr("recipient");
        delegate = makeAddr("delegate");

        hoax(deployer, 1 ether);
        uint256 gasBefore = gasleft();
        nimaToken = new NimaToken();
        uint256 gasAfter = gasleft();

        gasUsed = gasBefore - gasAfter;
    }

    function test_ShowGasUsed() public view {
        console.log("gasUsed: ", gasUsed);

        uint256 gasPrice = 0.371 * 1e9; // change accordingly
        uint256 deploymentGasCostWei = gasPrice * gasUsed;
        console.log("Deployment Gas Cost: ",deploymentGasCostWei , " wei");
        
    }

    function test_CorrectlyDeploysToken() public view {

        assertEq(nimaToken.name(), "NimaToken", "Incorrect token name");
        assertEq(nimaToken.symbol(), "NIMA", "Incorrect token symbol");
        assertEq(nimaToken.totalSupply(), initialSupply, "Incorrect total supply");
        assertEq(nimaToken.decimals(), 18, "Incorrect decimals");
        assertEq(nimaToken.balanceOf(deployer), initialSupply, "Token balance of deployer does not match initial supply");

    }

    function test_Transfer() public {

        uint256 transferAmount = 1 * 10 ** 18;
        vm.prank(deployer);
        nimaToken.transfer(recipient, transferAmount);
        
        assertEq(nimaToken.balanceOf(recipient), transferAmount, "Incorrect recipient balance");
    }

    function test_Allowance() public {

        vm.prank(deployer);
        nimaToken.approve(delegate, allowanceAmount);

        vm.prank(delegate);
        nimaToken.transferFrom(deployer, recipient, allowanceAmount);

        assertEq(nimaToken.balanceOf(recipient), allowanceAmount, "Incorrect recipient token balance");

    }

    function test_Allowance_FailsOverAllowedAmount() public {
        
        vm.prank(deployer);
        nimaToken.approve(delegate, allowanceAmount);

        vm.prank(delegate);
        vm.expectRevert();
        nimaToken.transferFrom(deployer, recipient, 2 * allowanceAmount);

    }
}