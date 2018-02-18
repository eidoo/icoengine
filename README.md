# Eidoo ICO Engine

Base smart contracts for ICOs that use [ICO Engine](https://icoengine.net/) througt the [Eidoo app](https://eidoo.io/).

## Smart contracts

See _SampleTokenSale_ contract for an example of how to use the ICO Engine smart contracts.

### ICOEngineInterface

This is an abstract contract that defines the functions that must be implemented to provide required informations to the Eidoo wallets.

### KYCBase

This is the base contract for all smart contracts that use the ICO Engine KYC.

The KYCBase constructor requires an array of the signers addresses, these addresses are provided by Eidoo Sagl.
 
The descending contracts must implement the function _releaseTokensTo()_ to assign the tokens to a buyer, it is called when the kyc verification is passed:

    function releaseTokensTo(address buyer) internal returns(bool);

The KYC enabled contracts does not have the fallback payable function, users must buy tokens calling the _buyTokens()_ function implemented in the _KYCBase_ contract. The Eidoo wallet takes care of calling the _buyTokens()_ function with the appropriate parameters obtained from the ICO Engine KYC servers.

See _tests/kycbase.js_ for details about calling _buyTokens()_ function.

