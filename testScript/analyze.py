import web3
import sys
import csv
from solc import compile_files
from web3 import Web3
import json
import os
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


parity = web3.Web3.IPCProvider(sys.argv[1], timeout=120)
w3 = web3.Web3(parity)


def create_account(secrete):
    with (open(secrete)) as kf:
        key = kf.read()
        jf = json.loads(key)
        private = w3.eth.account.decrypt(key, os.path.basename(secrete))
    from_address = Web3.toChecksumAddress(jf['address'])
    return [from_address, private]


main_account = create_account(sys.argv[4])

address_map = dict()


with open(sys.argv[2]) as f:
    reader = csv.DictReader(f)
    transactions = list(reader)

compiled_output = compile_files([sys.argv[3]], output_values=ALL_OUTPUT_VALUES, optimize=True)
contract_interface = compiled_output[sys.argv[3]+':DozerDoll']
contract = w3.eth.contract(abi=contract_interface['abi'],
                           bytecode=contract_interface['bin'])

data = {}

idx = 0
for transaction in transactions:
    idx += 1
    print(idx)
    if idx == 2000:
        break
    if transaction['status'] == '0':
        continue
    try:
        input = contract.decode_function_input(transaction['input'])
        if input[0].fn_name in data:
            data[input[0].fn_name] += 1
        else:
            data[input[0].fn_name] = 1
    except ValueError:
        pass
print(data)
