#!/usr/bin/env bash

nohup ~/parity-ethereum/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --config \
   /home/ubuntu/scripts/parity/config.dev-insecure.toml \
   --chain=/home/ubuntu/scripts/parity/foundation.json  \
   --base-path=/home/leo/fullnode --logging=info  \
   --unsafe-expose --jsonrpc-cors=all --no-discovery  &

sleep 30
python3 $2 ws://127.0.0.1:8546 ~/scripts/data/$3.csv\
 ~/tests/$1.sol ~/scripts/keys/leo123leo987 ~/scripts/keys/leo123leo456 &
replay=$!
sleep 1
# sudo blktrace -d /dev/xvdf -o $2-$4 &
python3 ~/scripts/py/miner.py ws://127.0.0.1:8546 &
miner=$!
wait $replay
sleep 5
killall parity
sleep 2
kill $miner
killall -9 parity

#~/parity-ethereum/target/release/parity export blocks \
#  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/config.json \
# --base-path=/tmp/parity ~/results/$1-$3-mainchain.bin
