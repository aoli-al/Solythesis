#!/usr/bin/env bash

nohup ~/parity-ethereum/target/release/parity --accounts-refresh=0 \
   --fast-unlock --no-warp --config \
   /home/leo/scripts/parity/config.dev-insecure.toml \
   --chain=/home/leo/scripts/parity/foundation.json  \
   --base-path=/tmp/leo --db-path=/home/leo/fullnode_bak/chains --logging=info  \
    --unsafe-expose   \
   --bootnodes=enode://20c9dba148de1201f80798f7fa178a795709bc43dcfcb22a79615c11a3f38886d0ba41c59420e15fb17c0098fba9c8b6c21315bcd43e38e0c32a77bc77dcb3b7@$4:30303  &


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
