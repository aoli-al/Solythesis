import sys
import time
from bench import Bench
import progressbar

MINT_GAS = 180286
TRANSFER = 70618

bench = Bench(sys.argv[1], sys.argv[3], 'DozerDoll')
contract_creator = bench.import_account(sys.argv[4])

NUM_OF_CONTRACT = 31
dd_addr = [bench.call_contract_function(contract_creator[0], 'constructor', ["Dozer", "DD"],
                                        private_key=contract_creator[1]) for i in range(NUM_OF_CONTRACT)]
dd_addr = [bench.wait_for_result(x).contractAddress for x in dd_addr]
print(dd_addr)


count = 0
current_time = time.time()
OPTIONS = 5
USERS = 5

users = [bench.new_address(*contract_creator) for i in range(USERS)]
print(users)

ITER = 1000

bar = progressbar.ProgressBar(maxval=ITER,
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()
for i in range(ITER):
    bar.update(i)
    for k in range(NUM_OF_CONTRACT):
        bench.call_contract_function(contract_creator[0], 'mintUniqueTokenTo',
                                     [users[0], i, "Token!!!"],
                                     dd_addr[k], contract_creator[1])
        result = bench.call_contract_function(users[0], 'transfer', [users[1], i], dd_addr[k])
    bench.wait_for_result(result, check_successful=True)

