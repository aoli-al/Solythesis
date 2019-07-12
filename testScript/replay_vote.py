import web3
import sys
from solc import compile_files
from web3 import Web3
import time
import os
import json
import random
import progressbar

# createIssue gas = 1053040
# voteGas

GAS_CREATEISSUE = 281909
GAS_VOTE = 49840

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

def waitForResult(result):
    # work = w3.eth.getWork()
    # w3.eth.submitWork("0x0000000000000002",
    #                   work[0],
    #                   "0xD1FE5700000000000000000000000000D1FE5700000000000000000000000001")
    return w3.eth.waitForTransactionReceipt(result)

nonce_map = {}
def get_nonce(sender):
    if sender in nonce_map:
        nonce_map[sender] += 1
    else:
        nonce_map[sender] = w3.eth.getTransactionCount(sender)
    return nonce_map[sender]

def create_account(secrete):
    with (open(secrete)) as kf: 
        key = kf.read()
        jf = json.loads(key)
        private = w3.eth.account.decrypt(key, os.path.basename(secrete))

    from_address = Web3.toChecksumAddress(jf['address'])
    return [from_address, private]


a = [create_account(sys.argv[5]), create_account(sys.argv[4])]

basename = os.path.basename(sys.argv[3])


compiled_sol = compile_files([sys.argv[3]], output_values=ALL_OUTPUT_VALUES, optimize=True, optimize_runs=200)
# erc_20_interface = compiled_sol[sys.argv[2]+':BasicErc20Token']
vote_interface = compiled_sol[sys.argv[3]+':AdvancedTokenVote1202']

# erc_20 = w3.eth.contract(abi=erc_20_interface['abi'], bytecode=erc_20_interface['bin'])
vote = w3.eth.contract(abi=vote_interface['abi'], bytecode=vote_interface['bin'])

from_address = Web3.toChecksumAddress(a[0][0])


def call_contract_function(sender, contract, name, args, contract_addr=None, private_key=None):
    nonce = get_nonce(sender)
    if contract_addr:
        func = getattr(contract.functions, name)
    else:
        func = getattr(contract, name)
    attributes = {
        'from': sender,
        'gas': 800000,
        'nonce': nonce,
        'gasPrice': 1,
    }
    if contract_addr:
        attributes['to'] = contract_addr
    tx_data = func(*args).buildTransaction(attributes)
    if 'chainId' in tx_data:
        del tx_data['chainId']
    if private_key:
        signed_txn = w3.eth.account.signTransaction(tx_data, private_key=private_key)
        result = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    else:
        result = w3.parity.personal.sendTransaction(tx_data, "x")
    return result
    # return w3.eth.waitForTransactionReceipt(result)

def construct(contract):
    # tx_receipt = call_contract_function(a[0][0], contract, 'constructor', [], private_key=a[0][1])
    nonce = get_nonce(a[0][0])
    raw_transaction = contract.constructor().buildTransaction({
        'from': a[0][0],
        'gas': 8000000,
        'nonce': nonce
    })
    signed_txn = w3.eth.account.signTransaction(raw_transaction, private_key=a[0][1])
    result = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    return result
    # tx_receipt = waitForResult(result)
    # tx_receipt = w3.eth.waitForTransactionReceipt(result)
    # return tx_receipt.contractAddress


NUM_OF_CONTRACT = 150

# erc_20_addr = construct(erc_20)
# print(erc_20_addr)
vote_addr = [construct(vote) for i in range(NUM_OF_CONTRACT)]
vote_addr = [waitForResult(x).contractAddress for x in vote_addr]
print(vote_addr)


def transfer(receiver, amount):
    nonce = get_nonce(a[0][0])
    signed_transaction = w3.eth.account.signTransaction(dict(
        nonce=nonce,
        gas=100000,
        gasPrice=w3.eth.gasPrice,
        to=receiver,
        value=amount
    ), a[0][1])
    return w3.eth.sendRawTransaction(signed_transaction.rawTransaction)


iii = 0
def new_addr():
    global iii
    new = w3.parity.personal.newAccount('x')
    result = transfer(new, 100000000000000000)
    iii += 1
    if iii == 5:
        waitForResult(result)
        # w3.eth.waitForTransactionReceipt(result)
    return new


count = 0
current_time = time.time()
OPTIONS = 5
USERS = 5

users = [new_addr() for i in range(USERS)]
print(users)

SIZE = 100


bar = progressbar.ProgressBar(maxval=SIZE,
                              widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
bar.start()
# for user in users:
#     call_contract_function(a[0][0], erc_20, 'transfer', [user, 1], erc_20_addr, a[0][1])
gas = 0


for i in range(SIZE):
    bar.update(i)
    for k in range(5):
        for j in range(28):
            result = call_contract_function(a[0][0], vote, 'createIssue',
                                   [i, from_address, [j for j in range(OPTIONS)], [user for user in users], ""],
                                   vote_addr[k * 28 + j], a[0][1])
        waitForResult(result)
    for k in range(5):
        for j in range(28 * 5):
        # generate_dumb_transactions()
        # gas += GAS_CREATEISSUE
        # generate_dumb_transactions()

        # if gas > 8000000:
        #     w3.eth.waitForTransactionReceipt(result)
        #     gas = 0

        # if receipt.status != 1:
        #    print(i)
        # assert(receipt.status == 1)
            user = users[k]
            result = call_contract_function(user, vote, 'vote', [i, random.randint(0, OPTIONS-1)], vote_addr[j])
            gas += GAS_VOTE
        waitForResult(result)
        # if gas > 8000000:
        #     w3.eth.waitForTransactionReceipt(result)
        #     gas = 0
        # if receipt.status != 1:
        #    print(i)
        # assert(receipt.status == 1)
