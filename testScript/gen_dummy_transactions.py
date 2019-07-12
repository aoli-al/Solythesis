import web3
import sys
import os
import random
from web3 import Web3
import json
import time

parity = web3.Web3.IPCProvider("/tmp/leo/eth-clean/jsonrpc.ipc")
w3 = web3.Web3(parity)

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
    return [from_address, private]


a = [create_account(sys.argv[1])]

nonce_map = {}
def get_nonce(sender):
    if sender in nonce_map:
        nonce_map[sender] += 1
    else:
        nonce_map[sender] = 0

    return nonce_map[sender]

def transfer(receiver, amount):
    nonce = get_nonce(a[0][0])
    signed_transaction = w3.eth.account.signTransaction(dict(
        nonce=nonce,
        gas=100000,
        gasPrice=w3.eth.gasPrice,
        to=receiver,
        value=amount
    ), a[0][1])
    return signed_transaction
    # return w3.eth.sendRawTransaction(signed_transaction.rawTransaction)


# f = open('transactions.txt', 'w+')
k = 0
t = time.time()
for i in range(1000000):
    print(i)
    receiver = Web3.toChecksumAddress('0x'+hex(random.getrandbits(160))[2:].zfill(40))
    transaction = transfer(receiver, 10).rawTransaction
    t1 = time.time()
    result = w3.eth.sendRawTransaction(transaction)
    t2 = time.time()
    print(t2-t1)
    k += 1
    if k == 333:
        waitForResult(result)
        tt = time.time()
        print(tt - t)
        t = tt
        k = 0

    # f.write(transaction)
    # f.write('\n')
    # print(i)
