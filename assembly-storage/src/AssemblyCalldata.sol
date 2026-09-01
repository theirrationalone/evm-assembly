// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyCalldata {
    function add(uint256, uint256) external pure returns (uint256) {
        assembly {
            mstore(0x00, add(calldataload(0x04), calldataload(0x24)))
            return(0x00, 0x20)
        }
    }
}
