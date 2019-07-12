import web3
import sys
from solc import compile_files
from web3 import Web3
import time
import os
import json
import cProfile
import threading


TOTAL_SUPPLY = 2 ** 256 - 1

ALL_OUTPUT_VALUES = (
    "abi",
    "asm",
    "ast",
    "bin",
    "bin-runtime",
    "devdoc",
    "interface",
    "opcodes",
    "userdoc",
)

parity = web3.Web3.WebsocketProvider(sys.argv[1])
w3 = web3.Web3(parity)

if 'transfer' in sys.argv[2]:
    CSIZE = 155
else:
    CSIZE = 115

def waitForResult(result):
    work = w3.eth.getWork()
    w3.eth.submitWork("0x0000000000000002",
                      work[0],
                      "0xD1FE5700000000000000000000000000D1FE5700000000000000000000000001")
    return w3.eth.waitForTransactionReceipt(result)


def create_account(secrete):
    with (open(secrete)) as kf: 
        key = kf.read()
        jf = json.loads(key)
        private = w3.eth.account.decrypt(key, os.path.basename(secrete))

    from_address = Web3.toChecksumAddress(jf['address'])
    return [from_address, private, w3.eth.getTransactionCount(from_address)]


a = [create_account(sys.argv[5]), create_account(sys.argv[4])]

basename = os.path.basename(sys.argv[3])


compiled_sol = compile_files([sys.argv[3]], output_values=ALL_OUTPUT_VALUES, optimize=True, optimize_runs=200)
contract_interface = compiled_sol[sys.argv[3]+':BecToken']

bnb = w3.eth.contract(abi=contract_interface['abi'], bytecode=contract_interface['bin'])

from_address = Web3.toChecksumAddress(a[0][0])


def construct():
    tx_hash = bnb.constructor().buildTransaction({
        'from': from_address,
        'gas': 8000000,
        'gasPrice': w3.toWei('1', 'wei'),
        'nonce': a[0][2]
    })
    a[0][2] += 1
    signed_txn = w3.eth.account.signTransaction(tx_hash, private_key=a[0][1])
    result = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    tx_receipt = waitForResult(result)
    return tx_receipt.contractAddress

contract_address = [construct() for i in range(CSIZE)]
print(contract_address)

count = 0
current_time = time.time()
wei = w3.toWei('1', 'wei')


SIZE = 2000

VALUE = (TOTAL_SUPPLY // SIZE)


def generate(idx, k):
    if 'transfer' in sys.argv[2]:
        tx_hash = bnb.functions.transfer(a[idx ^ 1][0], 1).buildTransaction({
            'from': a[idx][0],
            'to': contract_address[k],
            'gas': 8000000,
            'gasPrice': wei,
            'nonce': a[idx][2]
        })
    else:
        tx_hash = bnb.functions.batchTransfer([a[idx ^ 1][0]] * 5, 1).buildTransaction({
            'from': a[idx][0],
            'to': contract_address[k],
            'gas': 8000000,
            'gasPrice': wei,
            'nonce': a[idx][2]
        })
    a[idx][2] += 1
    return w3.eth.account.signTransaction(tx_hash, private_key=a[idx][1])


idx = 0
cc = 0

for i in range(SIZE):
    for k in range(CSIZE):
        signed_txn = generate(idx, k)
        result = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    tx_receipt = waitForResult(result)
    if tx_receipt.status == 0:
        print("Transaction Failed!")
        print(tx_receipt)
    # idx ^= 1
    count += 1
    if count == 100:
        t = time.time()
        tps = count / (t - current_time)
        print("tps: %.2f" % tps)
        count = 0
        current_time = time.time()

