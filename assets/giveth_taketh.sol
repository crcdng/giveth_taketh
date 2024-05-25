// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract GivethTaketh {

  address payable public owner;

  constructor() payable {
    owner = payable(msg.sender);
  }

  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }

  function deposit() public payable {}

  function transfer(address payable _to, uint256 _amount) public {
    (bool success,) = _to.call{value: _amount}("");
      require(success, "Failed to send Ether");
  }
}