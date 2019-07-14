#!/usr/bin/env bash

nohup ~/parity-ethereum/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --config \
   /home/ubuntu/scripts/parity/config.dev-insecure.toml \
   --chain=/home/ubuntu/scripts/parity/config.json  \
   --base-path=/tmp/leo --logging=info  \
   --unsafe-expose --jsonrpc-cors=all &

python3 $2 ws://127.0.0.1:8546 ~/scripts/data/$3.csv\
 ~/tests/$1.sol ~/scripts/keys/leo123leo456 ~/scripts/keys/leo123leo987&
replay=$!
sleep 1
# sudo blktrace -d /dev/xvdf -o $2-$4 &
python3 ~/scripts/py/miner.py ws://127.0.0.1:8546 &
miner=$!
wait $replay
killall parity
killall -9 parity
