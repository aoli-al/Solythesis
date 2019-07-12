rm -rf /data/parity
~/repos/parity-ethereum/target/release/parity import --config ./config.dev-insecure.toml  --base-path=/data/parity --logging=info $1
mv /data/parity/chains/DevelopmentChain/db/5121426b82ed1df6/overlayrecent/db/LOG ./$1.log
# blkparse $2-$4 -f "%5T.%9t, %p, %C, %a, %d, %N\n" -a read -a write -o $2-$4.blk
