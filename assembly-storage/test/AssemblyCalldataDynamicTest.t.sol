// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";

import {AssemblyCalldataDynamic} from "../src/AssemblyCalldataDynamic.sol";

contract AssemblyCalldataDynamicTest is Test {
    AssemblyCalldataDynamic assemblyCalldataDynamic;

    function setUp() external {
        assemblyCalldataDynamic = new AssemblyCalldataDynamic();
    }

    function test_calldataDynamic_usecase1() public {
        // @TODO: Test calldata dynamic contract...
    }
}
