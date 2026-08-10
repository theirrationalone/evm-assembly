// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console2} from "forge-std/Test.sol";

import {StorageBox} from "../src/StorageBox.sol";

contract StorageBoxTest is Test {
    StorageBox storageBox;

    function setUp() external {
        storageBox = new StorageBox();
    }

    function testStoreFunctionWorksWell() public {
        uint256 valueToStore = 777;
        storageBox.store(valueToStore);

        uint256 storedValue = storageBox.load();

        console2.log("Expected value: ", valueToStore);
        console2.log("Actual Value  : ", storedValue);

        assertEq(storedValue, valueToStore);
    }
}
