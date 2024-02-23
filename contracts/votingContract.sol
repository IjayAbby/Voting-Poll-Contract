// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;


contract VotingPoll {

    struct Option {
        string optionName;
        uint voteCount;
    }

    address public pollCreator;

    string public question;

    bool public pollClosed = false;

    mapping(address => bool) public voters;

    Option[] public options;

    event VoteCast(address voter, uint optionId);

    event PollClosed();

    constructor(address _creator, string memory _question, string[] memory _options) {

        require(_creator != address(0), "Zero Address");

        pollCreator = _creator;
        question = _question;

        for(uint i = 0; i < _options.length; i++) {
            options.push(Option(_options[i], 0));
        }
    }

    function vote(uint _optionId) public {

        require(!pollClosed, "Poll is closed.");

        require(!voters[msg.sender], "You have already voted.");

        voters[msg.sender] = true;
        options[_optionId].voteCount += 1;

        emit VoteCast(msg.sender, _optionId);
    }

    function closePoll() public {
        require(msg.sender == pollCreator, "Only the poll creator can close the poll.");

        pollClosed = true;

        emit PollClosed();
    }

    function getOptions() public view returns(Option[] memory) {

        return options;
    }
}

