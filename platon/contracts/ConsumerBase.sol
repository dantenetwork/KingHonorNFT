// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ICrossChain.sol";

contract ConsumerBase is Ownable {
    struct DestinationMethod {
        string contractAddress;
        string methodName;
        bool used;
    }

    // Dante cross chain contract
    ICrossChain public crossChainContract;
    // Cross-chain method map
    mapping(string => mapping(string => DestinationMethod)) public methodMap;
    // Cross-chain source sender map
    mapping(string => mapping(string => string)) public senderMap;

    function registerInterface(string calldata _funcName, string calldata _interface) onlyOwner virtual external {
        crossChainContract.registerInterface(_funcName, _interface);
    }

    function registerDestinationMethod(string calldata _toChain, string calldata _contractAddress, string calldata _methodName) onlyOwner external {
        mapping(string => DestinationMethod) storage map = methodMap[_toChain];
        DestinationMethod storage method = map[_methodName];
        method.contractAddress = _contractAddress;
        method.methodName = _methodName;
        method.used = true;
    }

    function registerTarget(string calldata _funcName, string calldata _abiString, string calldata _paramName, string calldata _paramType) onlyOwner external {
        crossChainContract.registerTarget(_funcName, _abiString, _paramName, _paramType);
    }

    function setCrossChainContract(address _address) onlyOwner public {
        crossChainContract = ICrossChain(_address);
    }

    function registerSourceSender(string calldata _chainName, string calldata _sender, string calldata _methodName) onlyOwner external {
        mapping(string => string) storage map = senderMap[_chainName];
        map[_methodName] = _sender;
    }

    function verify(string calldata _chainName, string calldata _methodName, string calldata _sender) public virtual view returns (bool) {
        mapping(string => string) storage map = senderMap[_chainName];
        string storage sender = map[_methodName];
        require(keccak256(bytes(sender)) == keccak256(bytes(_sender)), "Sender does not match");
        return true;
    }
}