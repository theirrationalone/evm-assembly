// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console2} from "forge-std/Test.sol";

import {AssemblyMath} from "../src/AssemblyMath.sol";

contract AssemblyMathTest is Test {
    AssemblyMath private assemblyMath;

    function setUp() external {
        assemblyMath = new AssemblyMath();
    }

    function testDivideByZero() public view {
        uint256 a = 10;
        uint256 b;

        uint256 result = assemblyMath.divide(a, b);

        console2.log("result: ", result);

        // @note: It's so weird, dividing any value by zero should throw error
        assertEq(result, b);
    }

    function testModByZero() public view {
        uint256 a = 10;
        uint256 b;

        uint256 result = assemblyMath.modulus(a, b);

        console2.log("result: ", result);

        // @note: It's now really gone out-of-mind, mod any value with zero should throw exception
        assertEq(result, b);
    }
}
