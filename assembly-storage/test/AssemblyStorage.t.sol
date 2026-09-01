// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {AssemblyStorage} from "../src/AssemblyStorage.sol";

contract AssemblyStorageTest is Test {
    AssemblyStorage public assemblyStorage;

    function setUp() external {
        assemblyStorage = new AssemblyStorage();
    }

    function test_storage_useCase1() public {
        uint256 number = 42;
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }

    function test_storage_useCase2() public {
        uint256 number = 0;
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }

    function test_storage_useCase3() public {
        uint256 number = type(uint256).max;
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }

    function test_storage_useCase4() public {
        uint256 number = type(uint256).max;
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        bytes32 rawData = vm.load(address(assemblyStorage), bytes32(uint256(0)));
        uint256 directAccessNumber = uint256(rawData);

        assertEq(storedNumber, number);
        assertEq(directAccessNumber, number);
        assertEq(directAccessNumber, storedNumber);
    }

    function test_storageFuzz(uint256 number) public {
        assemblyStorage.setValue(number);
        uint256 storedNumber = assemblyStorage.getValue();

        assertEq(storedNumber, number);
    }
}

// Answers:

// 1. what is the difference between MSTORE and SSTORE?
// Answer: MSTORE: MSTORE means store data into memory within the current execution context, data resides till execution ends, Whereas, SSTORE means store data permanently into the storage space, data remains forever until modified or deleted.

// 2. After sstore(0, 123), where does 123 exist?
// Answer: It is now stored in storage space with slot 0 permanently i.e., storage[0]: 123

// 3. After let x := sload(0), where is 123 immediately after SLOAD?
// Answer: 123 is on the top of the stack just immediately after SLOAD.

// 4. Why can't we simply do assembly {return(0x00, 0x20)}, after sload(0)?
// Answer: After sload(0) data pushed on to the stack and return(offset, size) grabs and returns data from the memory so doing return(0x00, 0x20) immediately after sload(0) could return gibberish data.

// 5. Suppose we have uint256 public value; uint256 public number; What storage slots do you expect?
// value -> ?
// number -> ?

// Answer:
// value -> 0
// number -> 1

// 6. Suppose someone writes: assembly{sstore(1, 999)}, inside this contract. What solidity state variable would that overwrite?
// Answer: `uint256 public number` at slot 1
