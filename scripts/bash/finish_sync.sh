#!/usr/bin/env bash

killall psrecord
killall parity
sleep 10
killall -9 parity
mv /tmp/parity/chains/DevelopmentChain/db/5121426b82ed1df6/overlayrecent/db/LOG ~/results/$1-$3.log
# sudo killall blktrace
sleep 5
~/parity-ethereum/target/release/parity export blocks \
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
 --base-path=/tmp/parity ~/results/$1-$3.bin
# rm -rf /data/parity
# ~/repos/parity-ethereum/target/release/parity import --config ./config.dev-insecure.toml  --base-path=/data/parity --logging=info ./$2-$4.bin
# blkparse $2-$4 -f "%5T.%9t, %p, %C, %a, %d, %N\n" -a read -a write -o $2-$4.blk
