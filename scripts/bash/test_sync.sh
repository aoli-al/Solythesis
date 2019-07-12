#!/usr/bin/env bash

rm nohup.out
rm -rf /data/parity
# sudo rm $2-$4.blktrace.*
~/repos/parity-ethereum/target/release/parity --accounts-refresh=0 --fast-unlock --no-warp \
  --config ./config.dev-insecure.toml  \
  --base-path=/data/parity --bootnodes=enode://5a3bf48fcb9dd123b50232b360e73c31bdc0992a6dd3bff1ed8efc7766856cc90f5127dd8102d4ca07b168a97a3c976c7be5a4d2a677b0c27da85733d21ee46a@us2.aoli.al:30303  &
parity_pid=$!
# sleep 4
python3 $2 ws://us2.aoli.al:8546 "/home/leo/repos/solythesis/scripts/data/$3.csv"\
 "/home/leo/repos/solythesis/tests/$1.sol" "/home/leo/repos/solythesis/scripts/keys/leo123leo456" "/home/leo/repos/solythesis/scripts/keys/leo123leo789" &
replay=$!
# sudo blktrace -d /dev/xvdf -o $2-$4 &
nohup /home/ubuntu/.local/bin/psrecord $parity_pid --interval 0.1 --log $1-$3.txt  &
psrecord=$!
nohup python3 ~/repos/playground/miner.py ws://us2.aoli.al:8546&
miner=$!

wait $replay
kill $psrecord
kill $miner
kill $parity_pid
sleep 5
kill -9 $parity_pid
mv /data/parity/chains/DevelopmentChain/db/5121426b82ed1df6/overlayrecent/db/LOG ./$1-$3.log
# sudo killall blktrace
# sleep 5
# ~/repos/parity-ethereum/target/release/parity export blocks --config ./config.dev-insecure.toml --base-path=/data/parity ./$2-$4.bin
# rm -rf /data/parity
# ~/repos/parity-ethereum/target/release/parity import --config ./config.dev-insecure.toml  --base-path=/data/parity --logging=info ./$2-$4.bin
# blkparse $2-$4 -f "%5T.%9t, %p, %C, %a, %d, %N\n" -a read -a write -o $2-$4.blk
