// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";

import {AssemblyArray} from "../src/AssemblyArray.sol";

contract AssemblyArrayTest is Test {
    AssemblyArray private asmArray;

    address owner = makeAddr("owner");

    function setUp() external {
        vm.startPrank(owner);
        asmArray = new AssemblyArray();
        vm.stopPrank();
    }

    function test_arraySumCase1() public view {
        uint256[] memory array = new uint256[](4);
        array[0] = 10;
        array[1] = 20;
        array[2] = 30;
        array[3] = 40;

        uint256 total = asmArray.sum(array);
        assertEq(total, 100);
    }

    function test_arraySumCase2() public view {
        uint256[] memory array = new uint256[](0);

        uint256 total = asmArray.sum(array);
        assertEq(total, 0);
    }

    function test_arraySumCase3() public view {
        uint256[] memory array = new uint256[](4);
        array[0] = type(uint256).max - type(uint128).max;
        array[1] = type(uint128).max;
        array[2] = 10;
        array[3] = 40;

        uint256 total = asmArray.sum(array);
        assertEq(total, 49);
    }

    function test_arraySumCase4() public view {
        uint256[] memory array = new uint256[](1);
        array[0] = type(uint256).max;

        uint256 total = asmArray.sum(array);
        assertEq(total, type(uint256).max);
    }

    function test_arraySumCase5() public view {
        uint256[] memory array = new uint256[](3);
        array[0] = 0;
        array[1] = 0;
        array[2] = 0;

        uint256 total = asmArray.sum(array);
        assertEq(total, 0);
    }

    function testFuzz_arraySum(uint256[] calldata array) public view {
        uint256 expectedTotal;
        unchecked {
            for (uint256 i; i < array.length; i++) {
                expectedTotal += array[i];
            }
        }

        uint256 total = asmArray.sum(array);
        assertEq(total, expectedTotal);
    }
}
