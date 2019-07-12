from solc import compile_files
from web3 import Web3
import os
import json
import web3

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


class Bench:
    REQUEST = {
        'gas': 8000000,
        'gasPrice': 1
    }

    def __init__(self, endpoint, contract_path, contract_name):
        client = web3.Web3.WebsocketProvider(endpoint)
        self.w3 = web3.Web3(client)
        self.pow = True
        self.nonce_map = {}
        self.contract = self.compile_contract(contract_path, contract_name)

    def get_nonce(self, sender):
        if sender in self.nonce_map:
            self.nonce_map[sender] += 1
        else:
            self.nonce_map[sender] = self.w3.eth.getTransactionCount(sender)
        return self.nonce_map[sender]

    def call_contract_function(self, sender, name, args, contract_addr=None, private_key=None):
        nonce = self.get_nonce(sender)
        if contract_addr:
            func = getattr(self.contract.functions, name)
        else:
            func = getattr(self.contract, name)
        attributes = {
            'from': sender,
            'nonce': nonce,
            ** Bench.REQUEST
        }
        if contract_addr:
            attributes['to'] = contract_addr
        tx_data = func(*args).buildTransaction(attributes)
        if private_key:
            signed_txn = self.w3.eth.account.signTransaction(tx_data, private_key=private_key)
            result = self.w3.eth.sendRawTransaction(signed_txn.rawTransaction)
        else:
            self.w3.parity.personal.unlockAccount(sender, 'x')
            result = self.w3.eth.sendTransaction(tx_data)
        return result

    def compile_contract(self, path, contract_name):
        compiled_sol = compile_files([path], output_values=ALL_OUTPUT_VALUES, optimize=True, optimize_runs=200)
        contract = compiled_sol[path + ':' + contract_name]
        return self.w3.eth.contract(abi=contract['abi'], bytecode=contract['bin'])

    def import_account(self, path):
        with (open(path)) as f:
            key = f.read()
            jf = json.loads(key)
            private = self.w3.eth.account.decrypt(key, os.path.basename(path))
            address = Web3.toChecksumAddress(jf['address'])
            return [address, private]

    def transfer(self, sender, receiver, amount, private_key):
        nonce = self.get_nonce(sender)
        signed_transaction = self.w3.eth.account.signTransaction({
            "nonce": nonce,
            "to": receiver,
            "value": amount,
            ** Bench.REQUEST
        }, private_key)
        return self.w3.eth.sendRawTransaction(signed_transaction.rawTransaction)

    def new_address(self, sender, private_key):
        new = self.w3.parity.personal.newAccount('x')
        result = self.transfer(sender, new, 10000000000, private_key)
        return [new, result]

    def wait_for_result(self, result, gen_pow=True, check_successful=False):
        if gen_pow:
            work = self.w3.eth.getWork()
            self.w3.eth.submitWork("0x0000000000000002",
                                   work[0],
                                   "0xD1FE5700000000000000000000000000D1FE5700000000000000000000000001")
        receipt = self.w3.eth.waitForTransactionReceipt(result)
        if check_successful:
            assert(receipt.status == 1)
        return receipt
