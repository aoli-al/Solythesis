import sys
import csv
import progressbar
import argparse
from bench import Bench

ITER = 500

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('endpoint')
parser.add_argument('csv')
parser.add_argument('path')
parser.add_argument('key1')
parser.add_argument('key2')
parser.add_argument("--pow", dest="pow", action="store_true")
parser.add_argument("--progress-bar", dest="progress_bar", action="store_true")
args = parser.parse_args()

if 'erc20' in args.csv:
    contract_name = 'BecToken'
    origin_creator = "0x36642d20f2E288f18A9a21b544AA853C594DD312"
    NUM_OF_CONTRACT = 100
    constructor_args = []
else:
    contract_name = 'DozerDoll'
    origin_creator = "0x6f53E6F92E85C084E10AAf35D4A44DEE6a27892d"
    constructor_args = ["a", "b"]
    NUM_OF_CONTRACT = 100


bench = Bench(args.endpoint, args.path, contract_name, args.pow)
contract_creator = bench.import_account(args.key1)

with open(args.csv) as f:
    reader = csv.DictReader(f)
    transactions = list(reader)

bench.address_mapping(origin_creator, contract_creator[0])
print('creator: ' + contract_creator[0])

idx = 0
for idx in range(ITER):
    transaction = transactions[idx]
    if int(transaction['status']) == 0:
        continue
    new = bench.address_mapping(transaction['from'])
    bench.transfer(contract_creator[0], new, 10000000000, contract_creator[1])
    idx += 1

contract_address = [bench.call_contract_function(contract_creator[0], 'constructor', constructor_args,
                                                 private_key=contract_creator[1], wait=True)
                    for i in range(NUM_OF_CONTRACT)]
contract_address = [bench.wait_for_result(x, gen_pow=False).contractAddress for x in contract_address]


bar = progressbar.ProgressBar(maxval=len(transactions),
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()

idx = 0
gas = 0
num_of_blocks = 0
for idx in range(ITER):
    if args.progress_bar:
        bar.update(idx)
    else:
        print(idx)
    transaction = transactions[idx]
    if int(transaction['status']) == 0:
        continue
    for k in range(NUM_OF_CONTRACT):
        sender = bench.address_mapping(transaction['from'])
        value = int(transaction['value'])

        private_key = None
        if sender.lower() == contract_creator[0].lower():
            private_key = contract_creator[1]
        result = bench.replay_contract_function(transaction['input'], sender, contract_address[k], value, private_key)
        gas += int(transaction['gasUsed'])
        if gas >= 8000000:
            bench.wait_for_result(result)
            num_of_blocks += 1
            if num_of_blocks == ITER:
                exit(0)
            gas = 0
bench.wait_for_result(result)
