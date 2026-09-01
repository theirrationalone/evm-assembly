// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {AssemblyStorage} from "../src/AssemblyStorage.sol";

contract AssemblyStorageTest is Test {
    AssemblyStorage public assemblyStorage;

    function setUp() external {
        assemblyStorage = new AssemblyStorage();
    }

    function test_storage_useCase1() public {
        uint256 number = 42;
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }

    function test_storage_useCase2() public {
        uint256 number = 0;
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }

    function test_storage_useCase3() public {
        uint256 number = type(uint256).max;
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }

    function test_storageFuzz(uint256 number) public {
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }
}
