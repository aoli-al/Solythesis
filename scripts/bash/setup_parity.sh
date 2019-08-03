#!/usr/bin/env bash

cd ~
export DEBIAN_FRONTEND=noninteractive
#sudo apt update
# sudo apt install -y linux-tools-aws
sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
sudo sh -c 'echo 0 >/proc/sys/kernel/kptr_restrict'
#git clone https://github.com/Leeleo3x/parity-ethereum
#curl https://sh.rustup.rs -sSf | sh -s -- -y
cd parity-ethereum
# git checkout $1
# git pull origin $1
# ~/.cargo/bin/cargo build --release
RUSTFLAGS=-g ~/.cargo/bin/cargo build --release
# pip3 install psrecord

#~/parity-ethereum/target/release/parity --accounts \
#    -refresh=0 --fast-unlock --no-warp --config \
#    /home/ubuntu/scripts/parity/config.dev-insecure.toml
#    --chain=/home/ubuntu/scripts/parity/config.json  \
#    --base-path=/tmp/leo --logging=info  \
#    --unsafe-expose --jsonrpc-cors=all
