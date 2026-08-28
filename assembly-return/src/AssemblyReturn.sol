// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract AssemblyReturn {
    function double(uint256 x) external pure returns (uint256) {
        assembly {
            x := mul(x, 2)
            // Answer1: mstore: It picks up the x (not the identifer itself but the value contained into it) stores it to the memory with the offset(the distance is 0 to reach data) 0
            // Padding comes a makes the fit into 32-byte word. Data x captures the 32 bytes and resides into memory with offset 0x00 (0)
            // i.e. memory: [0x00:0x20] -> 0x00000000000000000000000000000000000000000000000000000000000000xx (for data with value under 255)
            mstore(0x00, x)

            // Answer2: As it is known that the memory holds 32-bytes words and [0x00:0x1f] contains our data and that's actually 32-bytes
            // That's why we choose 0x20 to return 32 bytes starting with offset 0x00
            return(0x00, 0x20)
        }

        // Answer3: mstore(0x00, 42), return(0x00, 0x40) -> In that case function would return 64 bytes of data and our test would get failed
        // Because 64bytes would contain: 0x000000000000000000000000000000000000000000000000000000000000002a0000000000000000000000000000000000000000000000000000000000000000 and is way more than type(uint256).max
        // So wrap around value would be spitted out (could be accidently correct though)

        // Answer4: mstore(0x20, 42), return(0x00, 0x20) -> data would get into obscurity and return value would be 0x0000000000000000000000000000000000000000000000000000000000000000 (it could be something else already stored at 0x00-0x1f)
    }
}
