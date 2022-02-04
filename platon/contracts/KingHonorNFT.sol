// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC721Tradable.sol";
import "./ConsumerBase.sol";

string constant TO_CHAIN = "ETHEREUM";

/**
 * @title Creature
 * Creature - a contract for my non-fungible creatures.
 */
contract KingHonorNFT is ERC721Tradable, ConsumerBase {
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

    /**
     * This is used instead of msg.sender as transactions won't be sent by the original token owner, but by OpenSea.
     */
    function _msgSender()
        internal
        override
        view
        returns (address sender)
    {
        return ContextMixin.msgSender();
    }

    function crossChainCall(string memory _toChain, string memory _methodName, bytes memory _data) internal {
        mapping(string => DestinationMethod) storage map = methodMap[_toChain];
        DestinationMethod storage method = map[_methodName];
        require(method.used, "method not registered");

        crossChainContract.sendMessage(_toChain, method.contractAddress, method.methodName, _data);
    }

    function mintTo(address _to) public override onlyOwner {
        ERC721Tradable.mintTo(_to);

        bytes memory data = abi.encode(_to);
        crossChainCall(TO_CHAIN, "mintTo", data);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        ERC721.transferFrom(from, to, tokenId);

        bytes memory data = abi.encode(from, to, tokenId);
        crossChainCall(TO_CHAIN, "transferFrom", data);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public override {
        ERC721.safeTransferFrom(from, to, tokenId);

        bytes memory data = abi.encode(from, to, tokenId);
        crossChainCall(TO_CHAIN, "safeTransferFrom", data);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata _data) public override {
        ERC721.safeTransferFrom(from, to, tokenId, _data);

        bytes memory data = abi.encode(from, to, tokenId, _data);
        crossChainCall(TO_CHAIN, "safeTransferFrom", data);
    }
}