#!/usr/bin/env bash

cd ~
rm nohup.out
rm -rf /tmp/parity
mkdir ~/results
# sudo rm $2-$4.blktrace.*
nohup ~/parity-ethereum/target/release/parity --accounts-refresh=0 --fast-unlock --no-warp \
  --config ~/scripts/parity/config.dev-insecure.toml  --chain ~/scripts/parity/foundation.json\
  --base-path=/home/leo/fullnode_bak --unsafe-expose --logging=info \
  --bootnodes=enode://9198e9a929c82722a00db6259e3601b6a17d5a62dd4d4b3dfd5388657cbefade31cde4ae2e9ef12cad672de063ca9756b7bca0d9196b6eb6aff33fab367baae4@$4:30303  &
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
