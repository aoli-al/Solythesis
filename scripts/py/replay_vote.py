import web3
import sys
from bench import Bench
import time
import random
import progressbar
import argparse


GAS_CREATE_ISSUE = 281909
GAS_VOTE = 49840

parser = argparse.ArgumentParser()
parser.add_argument('endpoint')
parser.add_argument('csv')
parser.add_argument('path')
parser.add_argument('key1')
parser.add_argument('key2')
parser.add_argument("--pow", dest="pow", action="store_true")
parser.add_argument("--progress-bar", dest="progress_bar", action="store_true")
args = parser.parse_args()
bench = Bench(args.endpoint, args.path, 'AdvancedTokenVote1202', args.pow)
contract_creator = bench.import_account(args.key1)

NUM_OF_CONTRACT = 150
OPTIONS = 5
USERS = 5
ITER = 200

vote_addr = [bench.call_contract_function(contract_creator[0], 'constructor', [], private_key=contract_creator[1])
             for i in range(NUM_OF_CONTRACT)]
vote_addr = [bench.wait_for_result(x).contractAddress for x in vote_addr]
print(vote_addr)

users = []
for i in range(USERS):
    [addr, result] = bench.new_address_and_transfer(*contract_creator)
    users.append(addr)
print(users)
bench.wait_for_result(result)

count = 0
current_time = time.time()
bar = progressbar.ProgressBar(maxval=ITER,
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()

for i in range(ITER):
    if args.progress_bar:
        bar.update(i)
    else:
        print(i)
    for k in range(5):
        for j in range(28):
            result = bench.call_contract_function(contract_creator[0], 'createIssue',
                                                  [i, contract_creator[0], [j for j in range(OPTIONS)],
                                                   [user for user in users], ""],
                                                  vote_addr[k * 28 + j], contract_creator[1])
        bench.wait_for_result(result)
    for k in range(5):
        for j in range(28 * 5):
            user = users[k]
            result = bench.call_contract_function(user, 'vote', [i, random.randint(0, OPTIONS-1)], vote_addr[j])
        bench.wait_for_result(result)

