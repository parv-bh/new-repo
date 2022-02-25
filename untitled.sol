// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/math/SafeMath.sol";

/// @title untitled
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract messageBoard {
    using SafeMath for uint;
    event msgCreated(uint256 msgId);
    
    uint public noOfLols = 0;

    struct message {
        string content;
        address owner;
        uint timeCreated;
    }

    function getLols() external view returns (uint) {
        return noOfLols;
    }

    function newLol() external {
        noOfLols.add(1);
    }
}
