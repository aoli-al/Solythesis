#!/usr/bin/env bash

nohup ~/parity-ethereum/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --config \
   /home/leo/scripts/parity/config.dev-insecure.toml \
   --chain=/home/leo/scripts/parity/foundation.json  \
   --base-path=/tmp/leo --db-path=/home/leo/fullnode/chains --logging=info  \
   --no-discovery  \
   --bootnodes=enode://293d68d490e3d758564db5d0988507ba7c692e364bb2780bd280c6226629f7d83e23bc483c0f7e293f6620177008d1e4af0ca0cc4cee8db90f07f862d5be0cf9@$4:30303  &


sleep 30
python3 $2 /tmp/leo/jsonrpc.ipc ~/scripts/data/$3.csv\
 ~/tests/$1.sol ~/scripts/keys/leo123leo987 ~/scripts/keys/leo123leo456 &
replay=$!
sleep 1
# sudo blktrace -d /dev/xvdf -o $2-$4 &
python3 ~/scripts/py/miner.py /tmp/leo/jsonrpc.ipc &
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
