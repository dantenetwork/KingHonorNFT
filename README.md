# KingHonorNFT
This is an NFT project, launched on PlatON and showcased on Ethereum OpenSea. This function is implemented Dante Cross-Chain functionality.

## Prerequisite
1. Accounts on both PlatON Dev and Rinkeby  
2. Truffle  
3. Npm and node  

## Install
```
cd platon
npm install
```

```
cd ethereum
npm install
```

Create private key file `.secret`, and place the file to both ethereum and platon folders.

## Usage
### 1.Deploy NFT contracts
**platon**
```
cd platon
truffle migrate --network platonDev --reset
```

**ethereum**
```
cd ethereum
truffle migrate --network rinkeby --reset --skip-dry-run
```

### 2.Configure contract addresses
```
git clone git@github.com:virgil2019/near-hackathon-test.git
```

Change variables in `kinghonorEthereum.js` and `kinghonorPlatON.js`.

### 3.Start cross-chain nodes
Perhaps it will not work because program has been upgraded.

### 4.Initialize and run
**After minting, you can see the asset on OpenSea.**
For example: https://testnets.opensea.io/assets/0x155e86e6a43586372326d57585382526b84f063d/1