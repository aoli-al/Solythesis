#!/usr/bin/env bash

killall psrecord
killall parity
sleep 10
killall -9 parity
#mv /tmp/parity/chains/DevelopmentChain/db/5121426b82ed1df6/overlayrecent/db/LOG ~/results/$1-$3.log
# sudo killall blktrace
sleep 5
#~/parity-ethereum/target/release/parity export blocks \
#  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
# --base-path=/home/leo/fullnode ~/results/$1-$3.bin
#
#~/parity-ethereum/target/release/parity import \
#  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json\
#  --base-path=/data/parity --logging=info /data/$1/$1.bin > /data/$1/$1.stat

~/parity-ethereum/target/release/parity export blocks \
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
 --base-path=/home/leo/fullnode ~/results/$1-$3-mainchain.bin  --from 5052259

~/parity-ethereum/target/release/parity import ~/results/$1-$3-mainchain.bin\
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json \
  --base-path=/home/leo/import --log-file=/home/leo/results/parity.log > ~/results/db.stat
#mv /data/parity/chains/DevelopmentChain/db/5121426b82ed1df6/overlayrecent/db/LOG /data/$1/$1.log
