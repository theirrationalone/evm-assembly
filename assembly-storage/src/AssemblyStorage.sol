// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyStorage {
    uint256 public value;

    function setValue(uint256 newValue) external {
        assembly {
            sstore(0x00, newValue)
        }
    }

    function getValue() external view returns (uint256) {
        assembly {
            let storedValue := sload(0x00)
            mstore(0x80, storedValue)
            return(0x80, 0x20)
        }
    }
}
