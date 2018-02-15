pragma solidity ^0.4.19;

library SafeMath {
  function add(uint a, uint b) internal pure returns (uint) {
    uint c = a + b;
    assert(c>=a && c>=b);
    return c;
  }
}
