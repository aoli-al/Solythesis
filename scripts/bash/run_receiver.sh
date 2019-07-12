#!/usr/bin/env bash

~/parity-ethereum/target/release/parity --accounts \
   -refresh=0 --fast-unlock --no-warp --config \
   /home/ubuntu/scripts/parity/config.dev-insecure.toml
   --chain=/home/ubuntu/scripts/parity/config.json  \
   --base-path=/tmp/leo --logging=info  \
   --unsafe-expose --jsonrpc-cors=all
