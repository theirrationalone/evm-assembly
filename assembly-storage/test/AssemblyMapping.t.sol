// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console2} from "forge-std/Test.sol";

import {AssemblyMapping} from "../src/AssemblyMapping.sol";

contract AssemblyMappingTest is Test {
    AssemblyMapping assemblyMapping;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address charlie = makeAddr("charlie");

    function setUp() external {
        assemblyMapping = new AssemblyMapping();
    }

    function test_storageMapping_useCase1() public {
        uint256 amount = 10;
        assemblyMapping.setBalance(alice, amount);
        assemblyMapping.setBalance(bob, amount);
        assemblyMapping.setBalance(charlie, amount);

        uint256 aliceStoredBalance = assemblyMapping.balances(alice);
        uint256 bobStoredBalance = assemblyMapping.balances(bob);
        uint256 charlieStoredBalance = assemblyMapping.balances(charlie);
        uint256 unknownStoredBalance = assemblyMapping.balances(address(123));
        uint256 aliceBalanceAsm = assemblyMapping.getBalance(alice);
        uint256 bobBalanceAsm = assemblyMapping.getBalance(bob);
        uint256 charlieBalanceAsm = assemblyMapping.getBalance(charlie);
        uint256 unknownBalanceAsm = assemblyMapping.getBalance(address(123));

        console2.log("aliceStoredBalance  : ", aliceStoredBalance);
        console2.log("bobStoredBalance    : ", bobStoredBalance);
        console2.log("charlieStoredBalance: ", charlieStoredBalance);
        console2.log("unknownStoredBalance: ", unknownStoredBalance);
        console2.log("---");
        console2.log("aliceBalanceAsm   : ", aliceBalanceAsm);
        console2.log("bobBalanceAsm     : ", bobBalanceAsm);
        console2.log("charlieBalanceAsm : ", charlieBalanceAsm);
        console2.log("unknownBalanceAsm : ", unknownBalanceAsm);

        assertEq(aliceStoredBalance, amount);
        assertEq(bobStoredBalance, amount);
        assertEq(charlieStoredBalance, amount);
        assertEq(unknownStoredBalance, 0);
        assertEq(aliceBalanceAsm, amount);
        assertEq(bobBalanceAsm, amount);
        assertEq(charlieBalanceAsm, amount);
        assertEq(unknownBalanceAsm, 0);
        assertEq(aliceBalanceAsm, aliceStoredBalance);
        assertEq(bobBalanceAsm, bobStoredBalance);
        assertEq(charlieBalanceAsm, charlieStoredBalance);
        assertEq(unknownBalanceAsm, unknownStoredBalance);
    }

    function test_storageMapping_useCase2() public {
        uint256 amount = 100;
        assemblyMapping.setBalance(alice, amount);
        assemblyMapping.setBalance(bob, amount * 2);
        assemblyMapping.setBalance(charlie, amount * 3);

        uint256 aliceStoredBalance = uint256(vm.load(address(assemblyMapping), keccak256(abi.encode(alice, 0))));
        uint256 bobStoredBalance = uint256(vm.load(address(assemblyMapping), keccak256(abi.encode(bob, 0))));
        uint256 charlieStoredBalance = uint256(vm.load(address(assemblyMapping), keccak256(abi.encode(charlie, 0))));
        uint256 unknownStoredBalance =
            uint256(vm.load(address(assemblyMapping), keccak256(abi.encode(address(123), 0))));

        uint256 aliceBalanceAsm = assemblyMapping.getBalance(alice);
        uint256 bobBalanceAsm = assemblyMapping.getBalance(bob);
        uint256 charlieBalanceAsm = assemblyMapping.getBalance(charlie);
        uint256 unknownBalanceAsm = assemblyMapping.getBalance(address(123));

        console2.log("aliceStoredBalance  : ", aliceStoredBalance);
        console2.log("bobStoredBalance    : ", bobStoredBalance);
        console2.log("charlieStoredBalance: ", charlieStoredBalance);
        console2.log("unknownStoredBalance: ", unknownStoredBalance);
        console2.log("---");
        console2.log("aliceBalanceAsm   : ", aliceBalanceAsm);
        console2.log("bobBalanceAsm     : ", bobBalanceAsm);
        console2.log("charlieBalanceAsm : ", charlieBalanceAsm);
        console2.log("unknownBalanceAsm : ", unknownBalanceAsm);

        assertEq(aliceStoredBalance, amount);
        assertEq(bobStoredBalance, amount * 2);
        assertEq(charlieStoredBalance, amount * 3);
        assertEq(unknownStoredBalance, 0);
        assertEq(aliceBalanceAsm, amount);
        assertEq(bobBalanceAsm, amount * 2);
        assertEq(charlieBalanceAsm, amount * 3);
        assertEq(unknownBalanceAsm, 0);
        assertEq(aliceBalanceAsm, aliceStoredBalance);
        assertEq(bobBalanceAsm, bobStoredBalance);
        assertEq(charlieBalanceAsm, charlieStoredBalance);
        assertEq(unknownBalanceAsm, unknownStoredBalance);
    }

    function test_storageMappingFuzz(address user, uint256 amount) public {
        assemblyMapping.setBalance(user, amount);

        uint256 userStoredBalanceLoad = uint256(vm.load(address(assemblyMapping), keccak256(abi.encode(user, 0))));
        uint256 userBalanceAsm = assemblyMapping.getBalance(user);
        uint256 userStoredBalance = assemblyMapping.balances(user);

        console2.log("userStoredBalanceLoad: ", userStoredBalanceLoad);
        console2.log("userBalanceAsm       : ", userBalanceAsm);
        console2.log("userStoredBalance    : ", userStoredBalance);

        assertEq(userStoredBalanceLoad, amount);
        assertEq(userBalanceAsm, amount);
        assertEq(userStoredBalance, amount);
        assertEq(userStoredBalanceLoad, userBalanceAsm);
        assertEq(userBalanceAsm, userStoredBalance);
    }
}
