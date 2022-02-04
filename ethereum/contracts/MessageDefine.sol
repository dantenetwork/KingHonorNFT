// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

struct Data {
    bytes arguments;
}

struct Content {
    string contractAddress;
    string action;
    Data data;
}

struct SentMessage {
    uint256 id;         // message id
    string fromChain;   // source chain name
    string toChain;     // destination chain name
    address sender;     // message sender
    Content content;      // message content
}

struct ReceivedMessage {
    uint256 id;         // message id
    string fromChain;   // source chain name
    string sender;      // message sender
    address contractAddress;      // message content
    string action;
    bytes data;
    bool executed;      // if message has been executed
    uint256 errorCode;  // it will be 0 if no error occurs
}

struct cachedReceivedMessage {
    ReceivedMessage message;
    address porter;
}