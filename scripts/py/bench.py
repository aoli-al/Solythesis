from solc import compile_files
from web3 import Web3
import os
import json
import web3
import os

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
        'gas': 79415920,
        'gasPrice': 1
    }

    def __init__(self, endpoint, contract_path, contract_name, pow=True):
        client = web3.Web3.IPCProvider(endpoint, timeout=30)
        self.w3 = web3.Web3(client)
        self.pow = pow
        self.nonce_map = {}
        self.address_map = {}
        self.contract = self.compile_contract(contract_path, contract_name)

    def get_nonce(self, sender):
        if sender in self.nonce_map:
            self.nonce_map[sender] += 1
        else:
            self.nonce_map[sender] = self.w3.eth.getTransactionCount(sender)
        return self.nonce_map[sender]

    def call_contract_function(self, sender, name, args, contract_addr=None, private_key=None, wait=False):
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
        else:
            attributes['gasPrice'] = 2
        tx_data = func(*args).buildTransaction(attributes)
        if private_key:
            signed_txn = self.w3.eth.account.signTransaction(tx_data, private_key=private_key)
            result = self.w3.eth.sendRawTransaction(signed_txn.rawTransaction)
        else:
            self.w3.parity.personal.unlockAccount(sender, 'x')
            result = self.w3.eth.sendTransaction(tx_data)
        if wait and self.pow:
            self.wait_for_result(result)
        return result

    def replace_addresses_recursive(self, argv):
        if isinstance(argv, list):
            return [self.replace_addresses_recursive(x) for x in argv]
        else:
            return self.address_mapping(argv)

    def replace_addresses(self, abi, args):
        output = []
        for elem in abi:
            if 'address' in elem['type']:
                output.append(self.replace_addresses_recursive(args[elem['name']]))
            else:
                output.append(args[elem['name']])
        return output

    def address_mapping(self, origin_addr, new_addr=None):
        origin_addr = origin_addr.lower()
        if origin_addr not in self.address_map:
            if new_addr:
                self.address_map[origin_addr] = new_addr
            else:
                self.address_map[origin_addr] = self.w3.parity.personal.newAccount('x')
        return self.address_map[origin_addr]

    def replay_contract_function(self, data, sender, contract_address, value, private_key=None):
        args = self.contract.decode_function_input(data)
        func = getattr(self.contract.functions, args[0].fn_name)
        raw_transaction = func(*self.replace_addresses(args[0].abi['inputs'], args[1])) \
            .buildTransaction({
                'from': sender,
                'nonce': self.get_nonce(sender),
                'to': contract_address,
                'value': value,
                ** Bench.REQUEST
            })
        if 'chainId' in raw_transaction:
            del raw_transaction['chainId']
        if private_key:
            signed_transaction = self.w3.eth.account.signTransaction(raw_transaction, private_key)
            return self.w3.eth.sendRawTransaction(signed_transaction.rawTransaction)
        else:
            result = self.w3.parity.personal.sendTransaction(raw_transaction, "x")
        return result

    def compile_contract(self, path, contract_name):
        compiled_sol = compile_files([path], output_values=ALL_OUTPUT_VALUES, optimize=True, optimize_runs=200,
                                     solc_binary=os.path.expanduser("~/solidity/build/solc/solc"))
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

    def new_address(self):
        return self.w3.parity.personal.newAccount('x')

    def new_address_and_transfer(self, sender, private_key):
        new = self.w3.parity.personal.newAccount('x')
        result = self.transfer(sender, new, 100000000000000, private_key)
        return [new, result]

    def wait_for_result(self, result, gen_pow=True, check_successful=True):
        if gen_pow and self.pow:
            work = self.w3.eth.getWork()
            self.w3.eth.submitWork("0x0000000000000002",
                                   work[0],
                                   "0xD1FE5700000000000000000000000000D1FE5700000000000000000000000001")
        receipt = self.w3.eth.waitForTransactionReceipt(result)
        if check_successful:
            if receipt.status != 1:
                print(receipt)
            assert(receipt.status == 1)
        return receipt
