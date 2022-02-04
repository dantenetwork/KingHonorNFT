// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC721Tradable.sol";

/**
 * @title Creature
 * Creature - a contract for my non-fungible creatures.
 */
contract KingHonorNFTView is ERC721Tradable {
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

    // forbiden
    function approve(address to, uint256 tokenId) public virtual override {
        revert("This contract is only for view");
    }

    // forbiden
    function setApprovalForAll(address operator, bool approved) public virtual override {
        revert("This contract is only for view");
    }

    // forbiden
    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        revert("This contract is only for view");
    }

    // forbiden
    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        revert("This contract is only for view");
    }

    // forbiden
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {
        revert("This contract is only for view");
    }

    // cross-chain transferFrom
    function crossChainTransferFrom(address from, address to, uint256 tokenId) public onlyOwner {
        _transfer(from, to, tokenId);
    }

    // cross-chain safeTransferFrom
    function crossChainSafeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public onlyOwner {
        _safeTransfer(from, to, tokenId, _data);
    }
}