// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyDispatcher {
    fallback() external {
        assembly {
            let selector := shr(mul(8, 28), calldataload(0))

            switch selector

            case 0xAAAAAAAA {
                mstore(0x00, add(calldataload(0x04), calldataload(0x24)))
                return(0x00, 0x20)
            }
            case 0xBBBBBBBB {
                mstore(0x00, mul(calldataload(0x04), calldataload(0x24)))
                return(0x00, 0x20)
            }
            default {
                mstore(0x00, "failed")
                revert(0x00, 0x20)
            }
        }
    }
}
