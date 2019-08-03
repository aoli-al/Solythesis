#!/usr/bin/env bash

cd ~
mkdir results
~/parity-ethereum/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --no-consensus --config \
   ~/scripts/parity/config.dev-insecure.toml \
   --chain ~/scripts/parity/config.json  \
   --base-path=/home/leo/empty --logging=error \
   --unsafe-expose --jsonrpc-cors=all --no-discovery &

sleep 30
python3 $2 /home/leo/empty/jsonrpc.ipc ~/scripts/data/$3.csv\
  ~/tests/$1.sol ~/scripts/keys/leo123leo987 ~/scripts/keys/leo123leo456 --pow
replay=$!
sleep 1
# sudo blktrace -d /dev/xvdf -o $2-$4 &
#python3 ~/scripts/py/miner.py ws://127.0.0.1:8546 &
#miner=$!
# wait $replay
killall parity
sleep 120
#kill $miner
killall -9 parity

~/parity-ethereum/target/release/parity export blocks \
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/config.json \
 --base-path=/home/leo/empty ~/results/$1-$3-mainchain.bin

~/parity-ethereum/target/release/parity import ~/results/$1-$3-mainchain.bin\
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/config.json \
  --base-path=/home/leo/empty2 --log-file=/home/leo/results/parity.log --logging=info
