import web3
import sys
from solc import compile_files
from web3 import Web3
import os
import json


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

w3 = web3.Web3()

def create_account(secrete):
    with (open(secrete)) as kf:
        key = kf.read()
        jf = json.loads(key)
    from_address = Web3.toChecksumAddress(jf['address'])
    return [from_address]


a = [create_account(sys.argv[3]), create_account(sys.argv[4])]

basename = os.path.basename(sys.argv[2])


# compiled_sol = compile_files([sys.argv[2]], output_values=ALL_OUTPUT_VALUES, optimize=True, optimize_runs=200)
compiled_sol = compile_files([sys.argv[2]], output_values=ALL_OUTPUT_VALUES, optimize=True, optimize_runs=200)
contract_interface = compiled_sol[sys.argv[2]+':BecToken']

open(basename + '.bin', 'w').write(contract_interface['bin-runtime'])
bnb = w3.eth.contract(abi=contract_interface['abi'], bytecode=contract_interface['bin'])

from_address = Web3.toChecksumAddress(a[0][0])


tx_hash = bnb.constructor().buildTransaction({
    'from': from_address,
    'gas': 8000000,
    'gasPrice': w3.toWei('1', 'wei'),
})
open(basename + '.cons.bin', 'w').write(tx_hash['data'][2:])



idx = 0
tx_hash = bnb.functions.batchTransfer([a[idx ^ 1][0]] * 5, 1).buildTransaction({
    # tx_hash = bnb.functions.transfer(a[idx ^ 1][0], 1).buildTransaction({
    'from': a[idx][0],
    'to': a[idx][0],
    'gas': 8000000,
    'gasPrice': 0,
})
open(basename + '.batchTransfer.input.bin', 'w+').write(tx_hash['data'][2:])

tx_hash = bnb.functions.transfer(a[idx ^ 1][0], 1).buildTransaction({
    'from': a[idx][0],
    'to': a[idx][0],
    'gas': 8000000,
    'gasPrice': 0,
})
open(basename + '.transfer.input.bin', 'w+').write(tx_hash['data'][2:])

