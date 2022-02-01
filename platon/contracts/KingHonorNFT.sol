// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC721Tradable.sol";

/**
 * @title Creature
 * Creature - a contract for my non-fungible creatures.
 */
contract KinHonorNFT is ERC721Tradable {
    constructor(
        string memory _name,
        string memory _symbol,
        address _proxyRegistryAddress)
        ERC721Tradable(_name, _name, _proxyRegistryAddress)
    {}

    function baseTokenURI() override public pure returns (string memory) {
        return "https://king-honor-nft.oss-cn-beijing.aliyuncs.com/";
    }

    function contractURI() public pure returns (string memory) {
        return "https://king-honor-nft.oss-cn-beijing.aliyuncs.com/contract.json";
    }
}