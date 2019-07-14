#!/usr/bin/env bash

cd ~
export DEBIAN_FRONTEND=noninteractive
#sudo apt update
#sudo apt install -y build-essential cmake libudev-dev
git clone https://github.com/Leeleo3x/parity-ethereum
#curl https://sh.rustup.rs -sSf | sh -s -- -y
cd parity-ethereum
git checkout batch_packing
#git pull origin batch_packing
~/.cargo/bin/cargo build --release


#~/parity-ethereum/target/release/parity --accounts \
#    -refresh=0 --fast-unlock --no-warp --config \
#    /home/ubuntu/scripts/parity/config.dev-insecure.toml
#    --chain=/home/ubuntu/scripts/parity/config.json  \
#    --base-path=/tmp/leo --logging=info  \
#    --unsafe-expose --jsonrpc-cors=all
