// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";

import {AssemblyMathV2} from "../src/AssemblyMathV2.sol";

contract AssemblyMathV2Test is Test {
    AssemblyMathV2 assemblyMathV2;

    function setUp() external {
        assemblyMathV2 = new AssemblyMathV2();
    }

    function test_mathV2_usecase1() public view {
        uint256 num1 = 10;
        uint256 num2 = 20;
        uint256 expected;

        unchecked {
            expected = (num1 + num2) * (num1 * num2);
        }

        uint256 total = assemblyMathV2.calculate(num1, num2);

        assertEq(total, expected);
    }

    function test_mathV2_usecase2() public view {
        uint256 num1 = type(uint256).max;
        uint256 num2 = type(uint256).max;
        uint256 expected;

        unchecked {
            expected = (num1 + num2) * (num1 * num2);
        }

        uint256 total = assemblyMathV2.calculate(num1, num2);

        assertEq(total, expected);
    }

    function test_mathV2Fuzz(uint256 num1, uint256 num2) public view {
        uint256 expected;

        unchecked {
            expected = (num1 + num2) * (num1 * num2);
        }

        uint256 total = assemblyMathV2.calculate(num1, num2);

        assertEq(total, expected);
    }
}
