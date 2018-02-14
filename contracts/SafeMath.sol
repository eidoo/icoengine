pragma solidity ^0.4.8;

library SafeMath {
  function add(uint a, uint b) internal returns (uint) {
    uint c = a + b;
    assert(c>=a && c>=b);
    return c;
  }
}
