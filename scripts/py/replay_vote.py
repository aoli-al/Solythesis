import web3
import sys
from bench import Bench
import time
import random
import progressbar


GAS_CREATE_ISSUE = 281909
GAS_VOTE = 49840


bench = Bench(sys.argv[1], sys.argv[3], 'AdvancedTokenVote1202')
contract_creator = bench.import_account(sys.argv[4])

NUM_OF_CONTRACT = 150
OPTIONS = 5
USERS = 5
ITER = 100

vote_addr = [bench.call_contract_function(contract_creator[0], 'constructor', [], private_key=contract_creator[1])
             for i in range(NUM_OF_CONTRACT)]
vote_addr = [bench.wait_for_result(x).contractAddress for x in vote_addr]
print(vote_addr)

users = []
for i in range(USERS):
    [addr, result] = bench.new_address(*contract_creator)
    users.append(addr)
print(users)
bench.wait_for_result(result)

count = 0
current_time = time.time()
bar = progressbar.ProgressBar(maxval=ITER,
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()

for i in range(ITER):
    bar.update(i)
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

