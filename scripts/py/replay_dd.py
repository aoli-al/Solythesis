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
parser.add_argument("--pow", type=bool, dest="pow", action="store_true")
parser.add_argument("--progress-bar", type=bool, dest="progress_bar", action="store_true")
args = parser.parse_args()
bench = Bench(args.endpoint, args.path, 'DozerDoll', args.pow)
contract_creator = bench.import_account(args.key1)

MINT_GAS = 180286
TRANSFER = 70618

NUM_OF_CONTRACT = 31
dd_addr = [bench.call_contract_function(contract_creator[0], 'constructor', ["Dozer", "DD"],
                                        private_key=contract_creator[1]) for i in range(NUM_OF_CONTRACT)]
dd_addr = [bench.wait_for_result(x).contractAddress for x in dd_addr]
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

ITER = 500

bar = progressbar.ProgressBar(maxval=ITER,
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()
for i in range(ITER):
    if args.progress_bar:
        bar.update(i)
    else:
        print(i)
    for k in range(NUM_OF_CONTRACT):
        bench.call_contract_function(contract_creator[0], 'mintUniqueTokenTo',
                                     [users[0], i, "Token!!!"],
                                     dd_addr[k], contract_creator[1])
        result = bench.call_contract_function(users[0], 'transfer', [users[1], i], dd_addr[k])
    bench.wait_for_result(result, check_successful=True)

