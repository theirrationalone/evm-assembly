// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console2} from "forge-std/Test.sol";

import {AssemblyMath} from "../src/AssemblyMath.sol";

contract AssemblyMathTest is Test {
    AssemblyMath private assemblyMath;

    function setUp() external {
        assemblyMath = new AssemblyMath();
    }
}
