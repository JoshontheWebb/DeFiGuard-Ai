pragma solidity ^0.8.0;

contract VulnerableToken {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool sent, ) = msg.sender.call{value: amount}("");
        if (sent) {
            balances[msg.sender] -= amount; // Vulnerable to reentrancy
        }
    }
}