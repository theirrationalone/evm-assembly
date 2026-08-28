// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {AssemblyReturn} from "../src/AssemblyReturn.sol";

contract AssemblyReturnTest is Test {
    AssemblyReturn private asmReturn;

    address OWNER = makeAddr("OWNER");

    function setUp() external {
        vm.startPrank(OWNER);
        asmReturn = new AssemblyReturn();
        vm.stopPrank();
    }

    function test_doubleCase1() public view {
        uint256 x = 0;

        uint256 double = asmReturn.double(x);
        assertEq(double, 0);
    }

    function test_doubleCase2() public view {
        uint256 x = 1;
        uint256 expected;

        unchecked {
            expected = x * 2;
        }

        uint256 double = asmReturn.double(x);
        assertEq(double, expected);
    }

    function test_doubleCase3() public view {
        uint256 x = 21;
        uint256 expected;

        unchecked {
            expected = x * 2;
        }

        uint256 double = asmReturn.double(x);
        assertEq(double, expected);
    }

    function test_doubleCase4() public view {
        uint256 x = 100;
        uint256 expected;

        unchecked {
            expected = x * 2;
        }

        uint256 double = asmReturn.double(x);
        assertEq(double, expected);
    }

    function test_doubleCase5() public view {
        uint256 x = type(uint256).max;
        uint256 expected;

        unchecked {
            expected = x * 2;
        }

        uint256 double = asmReturn.double(x);
        assertEq(double, expected);
    }
}

