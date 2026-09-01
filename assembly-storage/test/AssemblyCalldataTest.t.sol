// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";

import {AssemblyCalldata} from "../src/AssemblyCalldata.sol";

contract AssemblyCalldataTest is Test {
    AssemblyCalldata assemblyCalldata;

    function setUp() external {
        assemblyCalldata = new AssemblyCalldata();
    }

    function test_calldata_useCase1() public view {
        // Chosen number therefore no overflow
        uint256 num1 = 10;
        uint256 num2 = 20;

        uint256 sum = assemblyCalldata.add(num1, num2);

        assertEq(sum, num1 + num2);
    }

    function test_calldata_useCase2() public view {
        uint256 num1 = 0;
        uint256 num2 = 0;

        uint256 sum = assemblyCalldata.add(num1, num2);

        assertEq(sum, num1 + num2);
    }

    function test_calldata_useCase3() public view {
        uint256 num1 = type(uint256).max;
        uint256 num2 = 1;
        uint256 expected;

        unchecked {
            expected = num1 + num2;
        }

        uint256 sum = assemblyCalldata.add(num1, num2);

        assertEq(sum, expected);
    }

    function test_calldata_useCase4() public view {
        uint256 num1 = type(uint256).max;
        uint256 num2 = type(uint256).max;
        uint256 expected;

        unchecked {
            expected = num1 + num2;
        }

        uint256 sum = assemblyCalldata.add(num1, num2);

        assertEq(sum, expected);
    }

    function test_calldataFuzz(uint256 num1, uint256 num2) public view {
        uint256 expected;

        unchecked {
            expected = num1 + num2;
        }

        uint256 sum = assemblyCalldata.add(num1, num2);

        assertEq(sum, expected);
    }
}

// Answers:

// 1. Because first 4 bytes in a calldata are reserved for function selector.

// 2. Because except function selector each data chunk in a calldata stored in 32-bytes word format, So after function selector bytes [0x00:0x03], first argument chunk comes [0x04:0x23] as a chunk of 32-bytes. Therefore, next 32-bytes word would be [0x24:0x43] and that's nothing but our second argument.

// 3. Option B: load 32 bytes (evm doesn't care about and doesn't know what those bytes are it simply load a standard 32-bytes word, solidity compiler gives semantics and meaning to those bytes).

// 4.
//     Top
//     bytes from: [0x24:0x43] b
//     bytes from: [0x04:0x23] a

// 5. on the stack

// 6. Returning data from the stack is impossible and mstore is missing.
// calldata | memory
//          |
//        stack
//          |
//     computation
//          |
//     still on stack
//          |
//    store into memory (mstore())
//          |
//    return from memory (return(,))

// My question: I'm just surprised that i peeked into calldata what i found is that there was no offset only selector -> arg1 -> arg2, how is that possible???? that should be: selector -> offset -> length -> args....
