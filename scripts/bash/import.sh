#!/usr/bin/env bash

cd ~
mkdir results

perf record -F 1000 -g ~/parity-ethereum/target/release/parity import ~/$1-$3-mainchain.bin \
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
  --base-path=/home/leo/import --log-file=/home/leo/parity.log

perf script --header >  header.txt
