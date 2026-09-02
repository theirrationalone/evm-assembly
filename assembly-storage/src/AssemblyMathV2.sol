// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyMathV2 {
    function calculate(uint256, uint256) external pure returns (uint256) {
        assembly {
            function addTwo(a, b) -> result {
                result := add(a, b)
            }

            function mulTwo(a, b) -> result {
                result := mul(a, b)
            }

            mstore(
                0x00,
                mulTwo(addTwo(calldataload(0x04), calldataload(0x24)), mulTwo(calldataload(0x04), calldataload(0x24)))
            )
            return(0x00, 0x20)
        }
    }
}
