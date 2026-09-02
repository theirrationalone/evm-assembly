// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyCalldataDynamic {
    function firstElement(
        uint256[] calldata /**
                            */
    )
        external
        pure
        returns (uint256)
    {
        assembly {
            let offset := calldataload(0x04)
            // 0x04 + offset + 0x20 -> data
            mstore(0x00, calldataload(add(0x024, offset)))
            return(0x00, 0x20)
        }
    }
}
