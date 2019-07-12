#!/usr/bin/env bash

cd ~
sudo apt update
sudo apt install -y build-essential cmake libudev-dev
git clone https://github.com/Leeleo3x/parity-ethereum
curl https://sh.rustup.rs -sSf | sh -s -- -y
cd parity-ethereum
~/.cargo/bin/cargo build --release


#~/parity-ethereum/target/release/parity --accounts \
#    -refresh=0 --fast-unlock --no-warp --config \
#    /home/ubuntu/scripts/parity/config.dev-insecure.toml
#    --chain=/home/ubuntu/scripts/parity/config.json  \
#    --base-path=/tmp/leo --logging=info  \
#    --unsafe-expose --jsonrpc-cors=all
