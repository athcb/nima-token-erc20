#!/bin/bash

source .env

forge script script/DeployNimaToken.s.sol \
    --rpc-url http://127.0.0.1:8545 \
    --broadcast