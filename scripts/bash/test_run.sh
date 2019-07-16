#!/usr/bin/env bash
rm -rf /data/parity
~/repos/parity-ethereum/target/release/parity import \
  --config ~/Solythesis/scripts/parity/config.dev-insecure.toml  --chain ~/Solythesis/scripts/parity/config.json\
  --base-path=/data/parity --logging=info /data/$1/$1.bin > /data/$1/$1.stat
# python3 ~/scripts/py/visual.py /data/$1/$1.txt
mv /data/parity/chains/DevelopmentChain/db/5121426b82ed1df6/overlayrecent/db/LOG /data/$1/$1.log
# blkparse $2-$4 -f "%5T.%9t, %p, %C, %a, %d, %N\n" -a read -a write -o $2-$4.blk
