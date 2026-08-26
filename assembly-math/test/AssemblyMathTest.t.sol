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

        assertEq(result, 5);
    }

    function test_divideFunction_truncationCase() public view {
        uint256 a = 10;
        uint256 b = 11;

        uint256 result = assemblyMath.divide(a, b);

        assertEq(result, 0);
    }

    function test_divideFunction_edgeCase() public view {
        uint256 a = 0;
        uint256 b = 10;

        uint256 result = assemblyMath.divide(a, b);

        assertEq(result, 0);
    }

    function test_divideByZero() public view {
        uint256 a = 10;
        uint256 b;

        uint256 result = assemblyMath.divide(a, b);

        // @note: It's so weird, dividing any value by zero should throw error
        assertEq(result, b);
    }

    function test_modFunction_normalCase() public view {
        uint256 a = 10;
        uint256 b = 3;

        uint256 result = assemblyMath.modulus(a, b);

        assertEq(result, 1);
    }

    function test_modFunction_edgeCase() public view {
        uint256 a = 10;
        uint256 b = 10;

        uint256 result = assemblyMath.modulus(a, b);

        assertEq(result, 0);
    }

    function test_modFunction_edgeCase2() public view {
        uint256 a = 0;
        uint256 b = 10;

        uint256 result = assemblyMath.modulus(a, b);

        assertEq(result, 0);
    }

    function test_modByZero() public view {
        uint256 a = 10;
        uint256 b;

        uint256 result = assemblyMath.modulus(a, b);

        // @note: It's now really gone out-of-mind, mod any value with zero should throw exception
        assertEq(result, b);
    }

    function test_addFunction_normalCase() public view {
        uint256 a = 9;
        uint256 b = 3;

        uint256 result = assemblyMath.add(a, b);

        assertEq(result, 12);
    }

    function test_addFunction_overflowCase() public view {
        uint256 a = type(uint256).max;
        uint256 b = 1;

        uint256 result = assemblyMath.add(a, b);

        assertEq(result, 0);
    }

    function test_subtractFunction_normalCase() public view {
        uint256 a = 12;
        uint256 b = 3;

        uint256 result = assemblyMath.subtract(a, b);

        assertEq(result, 9);
    }

    function test_subtractFunction_underflowCase() public view {
        uint256 a = 0;
        uint256 b = 1;

        uint256 result = assemblyMath.subtract(a, b);

        assertEq(result, type(uint256).max);
    }

    function test_multiplyFunction_normalCase() public view {
        uint256 a = 3;
        uint256 b = 3;

        uint256 result = assemblyMath.multiply(a, b);

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

        assertEq(result, expectedOutput);
    }

    function test_minFunction_useCase1() public view {
        uint256 a = 3;
        uint256 b = 7;

        uint256 result = assemblyMath.min(a, b);

        assertEq(result, a);
    }

    function test_minFunction_useCase2() public view {
        uint256 a = 7;
        uint256 b = 3;

        uint256 result = assemblyMath.min(a, b);

        assertEq(result, b);
    }

    function test_minFunction_useCase3() public view {
        uint256 a = 7;
        uint256 b = 7;

        uint256 result = assemblyMath.min(a, b);

        assertEq(result, b);
    }

    function test_maxFunction_useCase1() public view {
        uint256 a = 3;
        uint256 b = 7;

        uint256 result = assemblyMath.max(a, b);

        assertEq(result, b);
    }

    function test_maxFunction_useCase2() public view {
        uint256 a = 7;
        uint256 b = 3;

        uint256 result = assemblyMath.max(a, b);

        assertEq(result, a);
    }

    function test_maxFunction_useCase3() public view {
        uint256 a = 7;
        uint256 b = 7;

        uint256 result = assemblyMath.max(a, b);

        assertEq(result, a);
    }

    function test_averageFunction_useCase1() public view {
        uint256 a = 4;
        uint256 b = 6;

        uint256 result = assemblyMath.average(a, b);

        assertEq(result, (a + b) / 2);
    }

    function test_averageFunction_useCase2() public view {
        uint256 a = 5;
        uint256 b = 6;

        uint256 result = assemblyMath.average(a, b);

        assertEq(result, (a + b) / 2);
    }

    function test_averageFunction_useCase3() public view {
        uint256 a = 0;
        uint256 b = type(uint256).max;

        uint256 result = assemblyMath.average(a, b);

        assertEq(result, (a + b) / 2);
    }

    function test_averageFunction_useCase4() public view {
        uint256 a = type(uint256).max;
        uint256 b = type(uint256).max;

        uint256 result = assemblyMath.average(a, b);

        assertEq(result, type(uint256).max);
    }
}
