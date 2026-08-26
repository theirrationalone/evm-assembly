// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console2} from "forge-std/Test.sol";

import {AssemblyMath} from "../src/AssemblyMath.sol";

contract AssemblyMathTest is Test {
    AssemblyMath private assemblyMath;

    function setUp() external {
        assemblyMath = new AssemblyMath();
    }

    function test_divideFunction_normalCase() public view {
        uint256 a = 10;
        uint256 b = 2;

        uint256 result = assemblyMath.divide(a, b);

        console2.log("result: ", result);
        assertEq(result, 5);
    }

    function test_divideFunction_truncationCase() public view {
        uint256 a = 10;
        uint256 b = 11;

        uint256 result = assemblyMath.divide(a, b);

        console2.log("result: ", result);
        assertEq(result, 0);
    }

    function test_divideFunction_edgeCase() public view {
        uint256 a = 0;
        uint256 b = 10;

        uint256 result = assemblyMath.divide(a, b);

        console2.log("result: ", result);
        assertEq(result, 0);
    }

    function test_divideByZero() public view {
        uint256 a = 10;
        uint256 b;

        uint256 result = assemblyMath.divide(a, b);

        console2.log("result: ", result);

        // @note: It's so weird, dividing any value by zero should throw error
        assertEq(result, b);
    }

    function test_modFunction_normalCase() public view {
        uint256 a = 10;
        uint256 b = 3;

        uint256 result = assemblyMath.modulus(a, b);

        console2.log("result: ", result);
        assertEq(result, 1);
    }

    function test_modFunction_edgeCase() public view {
        uint256 a = 10;
        uint256 b = 10;

        uint256 result = assemblyMath.modulus(a, b);

        console2.log("result: ", result);
        assertEq(result, 0);
    }

    function test_modFunction_edgeCase2() public view {
        uint256 a = 0;
        uint256 b = 10;

        uint256 result = assemblyMath.modulus(a, b);

        console2.log("result: ", result);
        assertEq(result, 0);
    }

    function test_modByZero() public view {
        uint256 a = 10;
        uint256 b;

        uint256 result = assemblyMath.modulus(a, b);

        console2.log("result: ", result);

        // @note: It's now really gone out-of-mind, mod any value with zero should throw exception
        assertEq(result, b);
    }

    function test_addFunction_normalCase() public view {
        uint256 a = 9;
        uint256 b = 3;

        uint256 result = assemblyMath.add(a, b);

        console2.log("result: ", result);
        assertEq(result, 12);
    }

    function test_addFunction_overflowCase() public view {
        uint256 a = type(uint256).max;
        uint256 b = 1;

        uint256 result = assemblyMath.add(a, b);

        console2.log("result: ", result);
        assertEq(result, 0);
    }

    function test_subtractFunction_normalCase() public view {
        uint256 a = 12;
        uint256 b = 3;

        uint256 result = assemblyMath.subtract(a, b);

        console2.log("result: ", result);
        assertEq(result, 9);
    }

    function test_subtractFunction_underflowCase() public view {
        uint256 a = 0;
        uint256 b = 1;

        uint256 result = assemblyMath.subtract(a, b);

        console2.log("result: ", result);
        assertEq(result, type(uint256).max);
    }

    function test_multiplyFunction_normalCase() public view {
        uint256 a = 3;
        uint256 b = 3;

        uint256 result = assemblyMath.multiply(a, b);

        console2.log("result: ", result);
        assertEq(result, 9);
    }

    function test_multiplyFunction_overflowCase() public view {
        uint256 a = type(uint256).max;
        uint256 b = 3;
        uint256 expectedOutput;
        unchecked {
            expectedOutput = a * b;
        }

        uint256 result = assemblyMath.multiply(a, b);

        console2.log("result: ", result);
        assertEq(result, expectedOutput);
    }
}
