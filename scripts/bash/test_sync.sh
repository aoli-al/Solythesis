#!/usr/bin/env bash

cd ~
rm nohup.out
rm -rf /tmp/parity
mkdir ~/results
# sudo rm $2-$4.blktrace.*
nohup ~/parity-ethereum/target/release/parity --accounts-refresh=0 --fast-unlock --no-warp \
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json\
  --base-path=/home/leo/fullnode_bak --unsafe-expose  \
  --bootnodes=enode://c94c9be82dab81508b881f9a7f8c0fd250785119f6c4b7b1ebff4125c7bbec82443a228fa5bf69d9e2147243910f7b87a26a8315b8782b203623a41f4ab2c217@$4:30303  &
parity_pid=$!
~/.local/bin/psrecord $parity_pid --interval 0.1 --log ~/results/$1-$3.txt
psecord=$!
# sleep 4
#python3 $2 ws://$4:8546 ~/scripts/data/$3.csv\
# ~/tests/$1.sol ~/scripts/keys/leo123leo456 ~/scripts/keys/leo123leo987&
#replay=$!
## sudo blktrace -d /dev/xvdf -o $2-$4 &
#python3 ~/scripts/py/miner.py ws://$4:8546 &
#miner=$!
#
#wait $replay
#kill $psrecord
#kill $miner
#sleep 10
#kill $parity_pid
#kill -9 $parity_pid
#mv /tmp/parity/chains/DevelopmentChain/db/5121426b82ed1df6/overlayrecent/db/LOG ~/results/$1-$3.log
## sudo killall blktrace
#sleep 5
#~/parity-ethereum/target/release/parity export blocks \
#  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/config.json \
# --base-path=/tmp/parity ~/results/$2-$4.bin
# rm -rf /data/parity
# ~/repos/parity-ethereum/target/release/parity import --config ./config.dev-insecure.toml  --base-path=/data/parity --logging=info ./$2-$4.bin
# blkparse $2-$4 -f "%5T.%9t, %p, %C, %a, %d, %N\n" -a read -a write -o $2-$4.blk
