// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "contracts/math/SafeMath.sol";

/// @title untitled
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract messageBoard {
    using SafeMath for uint;

    address payable public owner = payable(msg.sender);

    uint msgCost;

    event msgCreated(uint256 msgId);
    
    Message[] messages;

    struct Message {
        string content;
        address owner;
        uint timeCreated;
    }

    function postMessage(string memory _content) external payable {
        messages.push(Message({content: _content, owner: msg.sender, timeCreated: block.timestamp}));
        emit msgCreated(messages.length.sub(1));
        depositBy(msg.value, msgCost, payable(msg.sender));
    }

    function depositBy(uint givenEther, uint reqdEther, address payable sender) public payable {
        require(givenEther >= reqdEther, "insufficient funds");
        uint excess = givenEther - reqdEther;
        (bool success,) = owner.call{value: reqdEther}("");
        require(success, "Failed to send money");
        sender.call{value: excess}("");
    }

    function getMessages() external view returns(Message[] memory) {
        return messages;
    }

    function setMsgPrice(uint _price) public onlyOwner {
        msgCost = _price;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    
}
