import web3
import sys
import csv
from solc import compile_files
import time
from web3 import Web3
import json
import os
import time
import progressbar

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

nonceMap = {}

def getNonce(sender):
    if sender in nonceMap:
        nonceMap[sender] += 1
    else:
        nonce = w3.eth.getTransactionCount(sender)
        nonceMap[sender] = nonce
    return nonceMap[sender]

parity = web3.Web3.WebsocketProvider(sys.argv[1])
# parity = web3.Web3.HTTPProvider(sys.argv[1], timeout=120)
w3 = web3.Web3(parity)
accounts = w3.eth.accounts
i = 0

def waitForResult(result):
    work = w3.eth.getWork()
    w3.eth.submitWork("0x0000000000000002",
                      work[0],
                      "0xD1FE5700000000000000000000000000D1FE5700000000000000000000000001")
    return w3.eth.waitForTransactionReceipt(result)

def transfer(receiver, amount):
    nonce = getNonce(main_account[0])
    signed_transaction = w3.eth.account.signTransaction(dict(
        nonce=nonce,
        gas=1000000,
        gasPrice=1,
        to=receiver,
        value=amount
    ), main_account[1])
    return w3.eth.sendRawTransaction(signed_transaction.rawTransaction)


def create_account(secrete):
    with (open(secrete)) as kf:
        key = kf.read()
        jf = json.loads(key)
        private = w3.eth.account.decrypt(key, os.path.basename(secrete))
    from_address = Web3.toChecksumAddress(jf['address'])
    return [from_address, private]


main_account = create_account(sys.argv[4])

address_map = dict()

# accounts = []
# for i in range(50):
#     new = w3.personal.newAccount('x')
#     w3.personal.unlockAccount(new, 'x', 0)
#     transfer(new, 10000000000000)
#     i += 1
#     print(i)

def new_addr(addr):
    addr = addr.lower()
    if addr in address_map:
        return address_map[addr]
    if len(accounts):
        new = accounts.pop()
        # w3.personal.unlockAccount(new, 'x', 2147483647)
    else:
        # exit(0)
        new = w3.parity.personal.newAccount('x')
        w3.parity.personal.unlockAccount(new, 'x')
    address_map[addr] = new
    return new


with open(sys.argv[2]) as f:
    reader = csv.DictReader(f)
    transactions = list(reader)

if 'erc20' in sys.argv[2]:
    contract_name = 'BecToken'
    contract_creator = "0x36642d20f2E288f18A9a21b544AA853C594DD312"
    CSIZE = 100
    args = []
else:
    contract_name = 'DozerDoll'
    contract_creator = "0x6f53E6F92E85C084E10AAf35D4A44DEE6a27892d"
    args = ["a", "b"]
    CSIZE = 100

compiled_output = compile_files([sys.argv[3]], output_values=ALL_OUTPUT_VALUES, optimize=True)
contract_interface = compiled_output[sys.argv[3]+':' + contract_name]
contract = w3.eth.contract(abi=contract_interface['abi'],
                           bytecode=contract_interface['bin'])




creator = main_account[0]
address_map[Web3.toChecksumAddress(contract_creator).lower()] = main_account[0]
print('creator: ' + creator)

def construct():
    nonce = getNonce(creator)
    raw_transaction = w3.eth.account.signTransaction(contract.constructor(*args).buildTransaction({
        'from': creator,
        'gas': 8000000,
        'gasPrice': 1,
        'nonce': nonce
    }), main_account[1])

    result = w3.eth.sendRawTransaction(raw_transaction.rawTransaction)
    return waitForResult(result).contractAddress
contract_address = [construct() for i in range(CSIZE)]
# contract_address = main_account[0]
# print('contract address: ' + contract_address)

def replace_addresses_recursive(argv):
    if isinstance(argv, list):
        return [replace_addresses_recursive(x) for x in argv]
    else:
        return new_addr(argv)


def replace_addresses(abi, input):
    output = []
    for elem in abi:
        if 'address' in elem['type']:
            output.append(replace_addresses_recursive(input[elem['name']]))
        else:
            output.append(input[elem['name']])
    return output


# bar = progressbar.ProgressBar(maxval=len(transactions),
#                               widgets=[progressbar.Bar('=', '[', ']'), ' ', progressbar.Percentage()])
# bar.start()
idx = 0

current_time = time.time()

count = 0

pendingTransactions = []
gasUsed = 0
created = set()

COUNT = 1000
lastTransaction = ""

for transaction in transactions:
    sender = new_addr(transaction['from'])
    if int(transaction['status']) == 0:
        continue
    idx += 1
    if sender not in created:
        created.add(sender)
        lastTransaction = transfer(sender,  1000000000000000000)
        gasUsed = 0
    if idx == COUNT:
        waitForResult(lastTransaction)
        break


idx = 0
max = 0
gas = 0
for transaction in transactions:
    # bar.update(idx)
    print(idx)
    if idx == COUNT:
        exit(0)
    if int(transaction['status']) == 0:
        continue
    idx += 1
    for k in range(CSIZE):
        sender = new_addr(transaction['from'])
        value = transaction['value']
        transaction_info = {
            'from': sender,
            'to': contract_address[k],
            'gas': 8000000,
            'gasPrice': Web3.toWei(1, 'wei'),
            'value': int(value)
        }
        try:
            input = contract.decode_function_input(transaction['input'])
            func = getattr(contract.functions, input[0].fn_name)
            raw_transaction = func(*replace_addresses(input[0].abi['inputs'], input[1])).buildTransaction(transaction_info)
        except:
            transaction_info['data'] = transaction['input']
            raw_transaction = transaction_info
        nonce = getNonce(sender)
        raw_transaction['nonce'] = nonce
        if 'chainId' in raw_transaction:
            del raw_transaction['chainId']
        if sender == main_account[0]:
            signed_transaction = w3.eth.account.signTransaction(raw_transaction, main_account[1])
            result = w3.eth.sendRawTransaction(signed_transaction.rawTransaction)
        else:
            # w3.personal.unlockAccount(sender, 'x', 0)
            try:
                result = w3.parity.personal.sendTransaction(raw_transaction, "x")
            except:
                print(transaction)
                print(raw_transaction)
                raise
        gas += int(transaction['gasUsed'])
        if gas >= 8000000:
            waitForResult(result)
            gas = 0
    count += 1
    if count == 100:
        t = time.time()
        tps = count / (t - current_time)
        current_time = t
        print("tps: %.2f" % tps)
        count = 0
waitForResult(result)
