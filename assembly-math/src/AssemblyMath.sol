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
}
