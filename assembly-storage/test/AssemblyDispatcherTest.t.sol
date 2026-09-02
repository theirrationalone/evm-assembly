// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";

import {AssemblyDispatcher} from "../src/AssemblyDispatcher.sol";

contract AssemblyDispatcherTest is Test {
    AssemblyDispatcher assemblyDispatcher;

    function setUp() external {
        assemblyDispatcher = new AssemblyDispatcher();
    }

    function test_dispatcher_useCase1() public {
        bytes memory data = abi.encodeWithSignature("add(uint256,uint256)", 10, 20);
        address(assemblyDispatcher).call(data);
    }
}
