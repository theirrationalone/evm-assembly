// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyArray {
    function sum(
        uint256[] calldata /**
                            */
    )
        external
        pure
        returns (uint256 total)
    {
        assembly {
            let offset := calldataload(0x04)
            let lengthPosition := add(0x04, offset)
            let length := calldataload(lengthPosition)
            let dataStartPosition := add(0x20, lengthPosition)
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                total := add(total, calldataload(add(mul(i, 0x20), dataStartPosition)))
            }
        }
    }
}
