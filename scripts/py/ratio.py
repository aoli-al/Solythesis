import web3
import csv
import sys
import multiprocessing
import math
from multiprocessing import Manager, Pool
from web3 import Web3

fields = ['from', 'gas', 'to', 'value', 'input', 'status', 'gasPrice', 'gasUsed']

eth = web3.eth.Eth(Web3(Web3.HTTPProvider('https://mainnet.infura.io/v3/f1fba10f310546659bbf8ea3eb18fbaf')))

# for i in range(START, HEIGHT * 3):
#     # bar.update(idx - START)
#     block = eth.getBlock(i, True)
#     print(block.number)
#     for transaction in block.transactions:
#         if transaction['to'] and transaction['to'].lower() == ADDR:
#             print(transaction)

transfer = 0
contract = 0

for i in range(7000000, 8000000):
    # bar.update(idx - START)
    print(i)
    block = eth.getBlock(i, True)
    for transaction in block.transactions:
        if not transaction['to']:
            contract += 1
        elif eth.getCode(transaction['to']):
            contract += 1
        else:
            transfer += 1
print(contract)
print(transfer)
