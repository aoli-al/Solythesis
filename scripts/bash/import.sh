#!/usr/bin/env bash

cd ~
mkdir results

# perf record -F 1000 -g
# perf record -F 100 --call-graph dwarf
~/parity-ethereum/target/release/parity import ~/$1-$3-mainchain.bin \
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/config.json \
  --base-path=/home/leo/empty --log-file=/home/leo/parity.log --logging=info

# ~/parity-ethereum/target/release/parity export blocks ~/$1-$3-prep.bin \
  # --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
  # --base-path=/home/leo/import --from 5052259 --to $5
#
# ~/parity-ethereum/target/release/parity export blocks ~/$1-$3-main.bin \
  # --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
  # --base-path=/home/leo/import --from $5
# perf script --header >  header.txt
#
# ~/parity-ethereum/target/release/parity import ~/$1-$3-prep.bin \
  # --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
  # --base-path=/home/leo/fullnode --log-file=/home/leo/parity-1.log --logging=error
#
# ~/parity-ethereum/target/release/parity import ~/$1-$3-main.bin \
  # --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
  # --base-path=/home/leo/fullnode --log-file=/home/leo/parity-2.log --logging=info
