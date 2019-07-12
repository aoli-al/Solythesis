import web3
import csv
import sys
import multiprocessing
import math
from multiprocessing import Manager, Pool
from web3 import Web3

fields = ['from', 'gas', 'to', 'value', 'input', 'status', 'gasPrice', 'gasUsed']

eth = web3.eth.Eth(Web3(Web3.HTTPProvider('https://mainnet.infura.io/v3/f1fba10f310546659bbf8ea3eb18fbaf')))
receipt = eth.getTransactionReceipt(sys.argv[1])

START = receipt.blockNumber
HEIGHT = START + 200000
cpuc = int(sys.argv[2])
count = HEIGHT - START
group = math.ceil((HEIGHT - START) / cpuc)
ADDR = receipt.contractAddress.lower()

# for i in range(START, HEIGHT * 3):
#     # bar.update(idx - START)
#     block = eth.getBlock(i, True)
#     print(block.number)
#     for transaction in block.transactions:
#         if transaction['to'] and transaction['to'].lower() == ADDR:
#             print(transaction)


def download(idx):
    with open('out' + str(idx) + '.csv', 'w') as f:
        # bar = progressbar.ProgressBar(maxval=count,
        #                               widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        # bar.start()
        for i in range((idx * group) + START, ((idx + 1) * group) + START):
            # bar.update(idx - START)
            print(i)
            block = eth.getBlock(i, True)
            for transaction in block.transactions:
                if transaction['to'] and transaction['to'].lower() == ADDR:
                    receipt = eth.getTransactionReceipt(transaction['hash'])
                    writer.writerow({'from': transaction['from'], 'gas': transaction['gas'], 'to': transaction['to'],
                                     'input': transaction['input'], 'value': transaction['value'],
                                     'status': receipt['status'], 'gasPrice': transaction['gasPrice'],
                                     'gasUsed': receipt['gasUsed']})


manager = Manager()
pool = Pool(cpuc)
pool.map(download, range(cpuc))