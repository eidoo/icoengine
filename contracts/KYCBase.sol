pragma solidity ^0.4.19;

import "./SafeMath.sol";

// Abstract base contract
contract KYCBase is SafeMath {
    using SafeMath for uint256;
    address public kycSignerAddress;

    mapping (uint64 => uint256) public alreadyPayed;

    function KYCBase(address _kycSigner) {
        kycSignerAddress = _kycSigner;
    }

    // Must be implemented in descending contract to assign tokens to the buyers. Called after the KYC verification is passed
    function releaseTokensTo(address buyer) internal returns(bool);

    function buyTokensFor(address buyerAddress, uint64 buyerId, uint maxAmount, uint8 v, bytes32 r, bytes32 s)
        public payable returns (bool)
    {
        // check the signature
        bytes32 hash = sha256("Eidoo icoengine authorization", this, buyerAddress, buyerId, maxAmount);
        if (ecrecover(hash, v, r, s) != kycSignerAddress) {
            revert();
        } else {
            uint256 totalPayed = alreadyPayed[buyerId].add(msg.value);
            require(totalPayed <= maxAmount);
            alreadyPayed[buyerId] = totalPayed;
            return releaseTokensTo(buyerAddress);
        }
    }

    function buyTokens(uint64 buyerId, uint maxAmount, uint8 v, bytes32 r, bytes32 s)
        public payable returns (bool)
    {
        return buyTokensFor(msg.sender, buyerId, maxAmount, v, r, s);
    }

    // No payable fallback function, must be used buyTokens functions
    function () public {
        revert();
    }
}
