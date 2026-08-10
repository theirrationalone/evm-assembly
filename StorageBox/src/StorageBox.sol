// SPDX-License-identifier: MIT

pragma solidity ^0.8.30;

contract StorageBox {
    function store(uint256 value) external {
        assembly {
            sstore(0, value)
        }
    }

    function load() external view returns (uint256 result) {
        assembly {
            result := sload(0)
        }
    }
}
