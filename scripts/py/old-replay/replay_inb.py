import sys
from web3 import Web3
import progressbar
import time
from bench import Bench
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

if 'transfer' in args.csv:
    NUM_OF_CONTRACT = 155
else:
    NUM_OF_CONTRACT = 115

bench = Bench(args.endpoint, args.path, 'InsightChainToken', args.pow)
a = [bench.import_account(args.key1), bench.import_account(args.key2)]

bec_addr = [bench.call_contract_function(a[0][0], 'constructor', [], private_key=a[0][1], wait=True)
            for i in range(NUM_OF_CONTRACT)]
bec_addr = [bench.wait_for_result(x, gen_pow=False).contractAddress for x in bec_addr]

count = 0
ITER = 10000

addr = 0
def next_address():
    global addr
    addr += 1
    yield Web3.toChecksumAddress("0x%040x" % addr)


def generate(idx, k):
    if 'transfer' in sys.argv[2]:
        return bench.call_contract_function(a[0][0], 'transfer',
                                            [next(next_address()), 1],
                                            bec_addr[k], a[0][1])
    else:
        return bench.call_contract_function(a[0][0], 'batchTransfer',
                                            [[next(next_address()) for i in range(5)], 1],
                                            bec_addr[k], a[0][1])


bar = progressbar.ProgressBar(maxval=ITER,
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()

idx = 0
for i in range(ITER):
    if args.progress_bar:
        bar.update(i)
    else:
        print(i)
    for k in range(NUM_OF_CONTRACT):
        result = generate(idx, k)
    tx_receipt = bench.wait_for_result(result)
    idx ^= 1
