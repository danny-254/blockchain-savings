// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Savings {
  address payable public owner;
  uint256 balance;
  uint256 public constant duration = 365 days;
  uint256 public immutable end;
  uint256 public immutable start;


  constructor () {
    owner = payable(msg.sender);
    end = block.timestamp + duration;
    start = block.timestamp;
  }

  receive() external payable {}

  function getBalance() public view returns (uint256){
    return address(this).balance;
  }

  function savingsPeriod() public view returns(uint256) {
    return block.timestamp - start;
  }

  function redeemSavings() public {
    require(msg.sender == owner, "Only owner can redeem");
    require(block.timestamp >= end, "too early");
    selfdestruct(owner);
  }
}

