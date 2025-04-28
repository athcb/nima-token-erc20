#!/bin/bash

source .env

forge script script/TransferToSmartContract.s.sol \
    --rpc-url $ALCHEMY_SEPOLIA_URL \
    --broadcast \
    --private-key $TEST_PRIVATE_KEY