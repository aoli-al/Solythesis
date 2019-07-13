import web3
import threading
import sys

# parity = web3.Web3.IPCProvider(sys.argv[1], timeout=12000000)
parity = web3.Web3.WebsocketProvider(sys.argv[1], websocket_timeout=65535)
w3 = web3.Web3(parity)

idx = 0

def printit():
  global idx
  idx += 1
  if idx == 100000:
    return
  work = w3.eth.getWork()
  w3.eth.submitWork("0x0000000000000002",
                    work[0],
                    "0xD1FE5700000000000000000000000000D1FE5700000000000000000000000001")
  threading.Timer(10.0, printit).start()
  # printit()

printit()
