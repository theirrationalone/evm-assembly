// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyMapping {
    mapping(address => uint256) public balances;

    function setBalance(address user, uint256 amount) external {
        assembly {
            mstore(0x00, user)
            mstore(0x20, 0x00)
            let slot := keccak256(0x00, 0x40)
            sstore(slot, amount)
        }
    }

    function getBalance(address user) external view returns (uint256) {
        assembly {
            mstore(0x00, user)
            mstore(0x20, 0x00)
            let slot := keccak256(0x00, 0x40)
            let userBal := sload(slot)
            mstore(0x40, userBal)
            return(0x40, 0x20)
        }
    }
}
