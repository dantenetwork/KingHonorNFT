const debug = require('debug')('ck');
const BN = require('bn.js');
const utils = require('./utils');

const ProxyRegistry = artifacts.require('ProxyRegistry');
const KingHonorNFTView = artifacts.require('KingHonorNFTView');

const eq = assert.equal.bind(assert);

contract('KingHonorNFTView', function(accounts) {
    let owner = accounts[0];
    let user1 = accounts[1];
    let user2 = accounts[2];
    let user3 = accounts[3];

    describe('Initial state', function() {
        it('should own contract', async () => {
            let nft = await KingHonorNFTView.deployed();
            let o = await nft.owner();
            eq(o, owner);
        });
    });

    describe('Forbiden functions', function() {
        describe('Approve', function() {
            it('should failed', async () => {
                let nft = await KingHonorNFTView.deployed();
                await utils.expectThrow(nft.approve(user1, 0, {from: owner}), 'only for view');
            });
        });

        describe('Set approval for all', function() {
            it('should failed', async () => {
                let nft = await KingHonorNFTView.deployed();
                await utils.expectThrow(nft.setApprovalForAll(user1, true, {from: owner}), 'only for view');
            });
        });
        
        describe('Transfer from', function() {
            it('should failed', async () => {
                let nft = await KingHonorNFTView.deployed();
                await utils.expectThrow(nft.transferFrom(user1, user2, 0, {from: owner}), 'only for view');
            });
        });
        
        describe('Safe transfer from', function() {
            it('should failed', async () => {
                let nft = await KingHonorNFTView.deployed();
                await utils.expectThrow(nft.safeTransferFrom(user1, user2, 0, {from: owner}), 'only for view');
            });
        });
        
        describe('Safe transfer from with data', function() {
            it('should failed', async () => {
                let nft = await KingHonorNFTView.deployed();
                await utils.expectThrow(nft.methods["safeTransferFrom(address,address,uint256,bytes)"](user1, user2, 0, web3.utils.asciiToHex(''), {from: owner}), 'only for view');
            });
        });
    });

    describe('Available functions', function() {          
        describe('Mint to', function() {
            it('should execute successfully', async () => {
                let nft = await KingHonorNFTView.deployed();
                await nft.mintTo(user1, {from: owner});
                let tokenOwner = await nft.ownerOf(1);
                eq(tokenOwner, user1);
            });
        });
          
        describe('Cross chain transfer from', function() {
            it('should execute successfully', async () => {
                let nft = await KingHonorNFTView.deployed();
                await nft.crossChainTransferFrom(user1, user2, 1, {from: owner});
                let tokenOwner = await nft.ownerOf(1);
                eq(tokenOwner, user2);
            });
        });
          
        describe('Cross chain safe transfer from', function() {
            it('should execute successfully', async () => {
                let nft = await KingHonorNFTView.deployed();
                await nft.crossChainSafeTransferFrom(user2, user3, 1, web3.utils.asciiToHex(''), {from: owner});
                let tokenOwner = await nft.ownerOf(1);
                eq(tokenOwner, user3);
            });
        });
    });
});