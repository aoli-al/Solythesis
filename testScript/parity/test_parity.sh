rm -rf /data/leo
rm -rf ./$1.bin
nohup $2 --config ./config.dev-insecure.toml --unsafe-expose   --jsonrpc-cors=all\
  --base-path=/data --no-periodic-snapshot&
sleep 2
# python3 /Users/leo/repos/playground/replay.py "/tmp/leo/eth-clean/jsonrpc.ipc" \
python3 $3 "ws://127.0.0.1:8546" "${HOME}/repos/playground/erc20.csv" "${HOME}/repos/solythesis/tests/$1.sol" leo123leo987 leo987leo654
kill %1
sleep 2
kill -9 %1
$2 export blocks --config ./config.dev-insecure.toml --base-path=/data ./$1.bin
$2 import --config ./config.dev-insecure.toml  --base-path=/data ./$1.bin
