const debug = require('debug')('ck');
const BN = require('bn.js');
const utils = require('./utils');

const ProxyRegistry = artifacts.require('ProxyRegistry');
const KingHonorNFT = artifacts.require('KingHonorNFT');
const CrossChain = artifacts.require('CrossChain');

const eq = assert.equal.bind(assert);

contract('KingHonorNFT', function(accounts) {
    let owner = accounts[0];
    let user1 = accounts[1];
    let user2 = accounts[2];
    let user3 = accounts[3];
    let crossChain;

    before(async function() {
        crossChain = await CrossChain.new();
        let nft = await KingHonorNFT.deployed();
        nft.setCrossChainContract(crossChain.address);        
    });

    describe('Initial state', function() {
        it('should own contract', async () => {
            let nft = await KingHonorNFT.deployed();
            let o = await nft.owner();
            eq(o, owner);
        });
    });

    describe('Available functions', function() {    
        before(async function() {
            let nft = await KingHonorNFT.deployed();
            nft.registerDestinationMethod("ETHEREUM", "ethereum", "mintTo");
            nft.registerDestinationMethod("ETHEREUM", "ethereum", "transferFrom");
            nft.registerDestinationMethod("ETHEREUM", "ethereum", "safeTransferFrom");
        });

        describe('Mint to', function() {
            it('should execute successfully', async () => {
                let nft = await KingHonorNFT.deployed();
                await nft.mintTo(user1, {from: owner});
                let tokenOwner = await nft.ownerOf(1);
                eq(tokenOwner, user1);
            });
        });
          
        describe('Transfer from', function() {
            it('should execute successfully', async () => {
                let nft = await KingHonorNFT.deployed();
                await nft.transferFrom(user1, user2, 1, {from: user1});
                let tokenOwner = await nft.ownerOf(1);
                eq(tokenOwner, user2);
            });
        });
          
        describe('Safe Transfer from', function() {
            it('should execute successfully', async () => {
                let nft = await KingHonorNFT.deployed();
                await nft.safeTransferFrom(user2, user3, 1, {from: user2});
                let tokenOwner = await nft.ownerOf(1);
                eq(tokenOwner, user3);
            });
        });
    });
});