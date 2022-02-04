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

    function registerInterface(string calldata _funcName, string calldata _interface) onlyOwner virtual external {
        crossChainContract.registerInterface(_funcName, _interface);
    }

    function registerDestinationMethod(string calldata _toChain, string calldata _contractAddress, string calldata _methodName) onlyOwner external {
        mapping(string => DestinationMethod) storage map = methodMap[_toChain];
        DestinationMethod storage method = map[_methodName];
        method.contractAddress = _contractAddress;
        method.used = true;
    }

    function registerTarget(string calldata _funcName, string calldata _abiString, string calldata _paramName, string calldata _paramType) onlyOwner external {
        crossChainContract.registerTarget(_funcName, _abiString, _paramName, _paramType);
    }

    function setCrossChainContract(address _address) onlyOwner public {
        crossChainContract = ICrossChain(_address);
    }
}