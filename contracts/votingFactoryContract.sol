// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "./votingContract.sol";


contract PollFactory {

    VotingPoll[] public polls;

    event PollCreated(address pollAddress, string question);

    function createPoll(string memory _question, string[] memory _options) public {

        VotingPoll newPoll = new VotingPoll(msg.sender, _question, _options);

        polls.push(newPoll);

        emit PollCreated(address(newPoll), _question);
    }

    function getPolls() public view returns(VotingPoll[] memory) {
        return polls;
    }
}
