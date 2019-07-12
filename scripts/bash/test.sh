rm -rf /tmp/leo
rm -rf test.bin
nohup cargo run --release -- --config ./build/config.dev-insecure.toml --unsafe-expose   --jsonrpc-cors=all\
  --base-path=/tmp/leo/eth-clean&
sleep 2
python3 /Users/leo/repos/playground/replay_batchTransfer.py "/tmp/leo/eth-clean//jsonrpc.ipc" \
"/Users/leo/repos/solythesis/tests/$1.sol" leo123leo987 leo987leo654
kill %1
sleep 2
./target/release/parity export blocks --config ./build/config.dev-insecure.toml --base-path=/tmp/leo/eth-clean ./test.bin
cargo run --release -- import --config ./build/config.dev-insecure.toml  --base-path=/tmp/leo/eth ./test.bin

