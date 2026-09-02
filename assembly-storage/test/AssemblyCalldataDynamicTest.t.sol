// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";

import {AssemblyCalldataDynamic} from "../src/AssemblyCalldataDynamic.sol";

contract AssemblyCalldataDynamicTest is Test {
    AssemblyCalldataDynamic assemblyCalldataDynamic;

    function setUp() external {
        assemblyCalldataDynamic = new AssemblyCalldataDynamic();
    }

    function test_calldataDynamic_usecase1() public view {
        uint256[] memory numbers = new uint256[](3);
        numbers[0] = 123;
        numbers[1] = 456;
        numbers[2] = 789;
        uint256 firstElement = assemblyCalldataDynamic.firstElement(numbers);
        assertEq(firstElement, 123);
    }

    function test_calldataDynamic_usecase2() public view {
        uint256[] memory numbers = new uint256[](0);
        uint256 firstElement = assemblyCalldataDynamic.firstElement(numbers);
        assertEq(firstElement, 0);
    }

    function test_calldataDynamic_usecase3() public view {
        uint256[] memory numbers = new uint256[](1);
        numbers[0] = type(uint256).max;
        uint256 firstElement = assemblyCalldataDynamic.firstElement(numbers);
        assertEq(firstElement, type(uint256).max);
    }

    function test_calldataDynamicFuzz(uint256 firstElement) public view {
        vm.assume(firstElement < type(uint256).max - 20);
        uint256[] memory numbers = new uint256[](3);
        numbers[0] = firstElement;
        numbers[1] = firstElement + 10;
        numbers[2] = firstElement + 20;
        uint256 firstElementStored = assemblyCalldataDynamic.firstElement(numbers);
        assertEq(firstElementStored, firstElement);
    }
}
