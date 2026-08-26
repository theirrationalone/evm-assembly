// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyMath {
    function add(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := add(a, b)
        }
    }

    function subtract(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := sub(a, b)
        }
    }

    function multiply(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := mul(a, b)
        }
    }

    function divide(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := div(a, b)
        }
    }

    function modulus(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := mod(a, b)
        }
    }

    function min(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            mstore(0x00, a)
            mstore(0x20, b)

            result := mload(mul(0x20, lt(b, a)))
        }
    }

    function max(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            mstore(0x00, a)
            mstore(0x20, b)

            result := mload(mul(0x20, gt(b, a)))
        }
    }

    function average(uint256 a, uint256 b) external pure returns (uint256 result) {
        assembly {
            result := add(div(xor(a, b), 2), and(a, b))
        }
    }
}
