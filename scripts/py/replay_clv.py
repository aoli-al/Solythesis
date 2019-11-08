import sys
import time
from bench import Bench
import progressbar
import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('endpoint')
parser.add_argument('csv')
parser.add_argument('path')
parser.add_argument('key1')
parser.add_argument('key2')
parser.add_argument("--pow", dest="pow", action="store_true")
parser.add_argument("--progress-bar", dest="progress_bar", action="store_true")
args = parser.parse_args()
bench = Bench(args.endpoint, args.path, 'Clovers', args.pow)
contract_creator = bench.import_account(args.key1)

MINT_GAS = 180286
TRANSFER = 70618
[addr, result] = bench.new_address_and_transfer(*contract_creator)
bench.wait_for_result(result)

NUM_OF_CONTRACT = 132
dd_addr = [bench.call_contract_function(contract_creator[0], 'constructor', ["Clover", "CLV"],
                                        private_key=contract_creator[1], wait=True) for i in range(NUM_OF_CONTRACT)]
dd_addr = [bench.wait_for_result(x, gen_pow=False).contractAddress for x in dd_addr]
print(dd_addr)


count = 0
current_time = time.time()
OPTIONS = 5
USERS = 5

users = []
for i in range(USERS):
    [addr, result] = bench.new_address_and_transfer(*contract_creator)
    users.append(addr)
print(users)
bench.wait_for_result(result)

ITER = 1000

bar = progressbar.ProgressBar(maxval=ITER,
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()

gas = 0 
num_of_blocks = 0
for i in range(ITER):
    if args.progress_bar:
        bar.update(i)
    else:
        print(i)
    for k in range(NUM_OF_CONTRACT):
        result = bench.call_contract_function(contract_creator[0], 'mint',
                                     [users[0], i],
                                     dd_addr[k], contract_creator[1])
        gas += MINT_GAS
        if gas >= 8000000:
            bench.wait_for_result(result, check_successful=True)
            num_of_blocks += 1
            if num_of_blocks == ITER:
                exit(0)
            gas = 0
    for k in range(NUM_OF_CONTRACT):
        result = bench.call_contract_function(users[0], 'transfer', [users[1], i], dd_addr[k])
        gas += TRANSFER
        if gas >= 8000000:
            bench.wait_for_result(result, check_successful=True)
            num_of_blocks += 1
            if num_of_blocks == ITER:
                exit(0)
            gas = 0
