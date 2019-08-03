import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import sys
import re
from utils import generate_tests

m = {}


def name_mapping(name):
    if "secured" in name:
        return "S"
    if "noopt" in name:
        return "S-N"
    return "O"


def generate_table(m, formatter):
    corder = ["erc20", "transfer", "batchTransfer", "v", "erc721", "tran"]
    rorder = ["S", "S-N", "O"]
    for r in rorder:
        s = " & \\textbf{%s}"% r
        for c in corder:
            s += formatter % m[r][c]
        s += "\\\\"
        print(s)
    print("\\cline{2-8}")

#  for i in range(6):
    #  for benchmark in generate_tests(i):
        #  name = benchmark[0] + "-" + benchmark[2]
        #  idx = name_mapping(name)
        #  if idx not in m:
            #  m[idx] = {}
        #  try:
            #  res = pd.read_csv("/data/rep-{}/{}.txt".format(name, name), sep="\s+", header=None, dtype=np.float64, skiprows=1)
            #  res = res[[1]]
            #  m[idx][benchmark[2]] = np.mean(res).values[0]
            #  print(name)
            #  print(m[idx][benchmark[2]])
        #  except:
            #  continue
#  generate_table(m, "& %.3f\\%%")
#
#
#  for benchmark in generate_tests():
    #  name = benchmark[0] + "-" + benchmark[2]
    #  idx = name_mapping(name)
    #  if idx not in m:
        #  m[idx] = {}
    #  try:
        #  f = open("/data/mainnet-{0}/metric-3000-m5.log".format(name))
        #  total = 0
        #  store = 0
        #  for line in f:
            #  result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            #  result = re.findall(r"TOTALTIME: (\d*)", line)
            #  if result:
                #  total += int(result[0])
            #  result = re.findall(r"STORETIME: (\d*)", line)
            #  if result:
                #  store += int(result[0])
        #  print(total)
        #  print(store)
        #  m[idx][benchmark[2]] =  "%.2f" % (store/10**6) + "/%.2f" % (total/10**6)
        #  print(name)
        #  print(m[idx][benchmark[2]])
    #  except:
        #  continue
#  generate_table(m, "& %s")


def store_inst(name):
    data = {
            "LOAD": 0,
            "STORE": 0,
            "SHA3": 0,
            "TOTAL": 0,
            "UNIQUE_SHA3": 0,
            "SHA3 64": 0,
            "SHA3 32": 0
            }
    count = 0
    with open("/data/mainnet10000-{}/storage.log".format(name)) as f:
        for line in f:
            for key in data.keys():
                result = re.findall(key + r": (\d*)", line)
                if result:
                    data[key] += int(result[0])
                    if key == 'STORE':
                        count += 1
    return str(int(data['LOAD']/count))
    return str(int(data['SHA3 32']/count) + int(data['SHA3 64']/count))


def generate(func):
    m = {}
    for benchmark in generate_tests():
        name = benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        m[idx][benchmark[2]] = func(name)
    generate_table(m, "& %s")

generate(store_inst)
exit(0)

#  for i in range(6):
    #  for benchmark in generate_tests(i):
        #  name = benchmark[0] + "-" + benchmark[2]
        #  idx = name_mapping(name)
        #  if idx not in m:
            #  m[idx] = {}
        #  f = open("/data/rep-{}/db.stat".format(name, name))
        #  for line in f:
            #  result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            #  result = re.findall(r"rocksdb\.bytes\.written COUNT : (\d*)", line)
            #  if result:
                #  m[idx][benchmark[2]] = int(result[0]) / 1024 / 1024 / 1024
#  generate_table(m, "& %.2f ")

for benchmark in generate_tests():
    name = "mainnet10000-" + benchmark[0] + "-" + benchmark[2]
    idx = name_mapping(name)
    if idx not in m:
        m[idx] = {}
    try:
        f = open("/data/{}/parity-opt-2-12500-m5.log".format(name, name))
        for line in f:
            #  result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            result = re.findall(r"Import completed in .+ (\d+) blocks", line)
            if result:
                #  print(result)
                m[idx][benchmark[2]] = int(result[0])
        #  print(m[idx][benchmark[2]])
    except:
        pass
generate_table(m, "& %d ")

for benchmark in generate_tests():
    name = "mainnet10000-" + benchmark[0] + "-" + benchmark[2]
    idx = name_mapping(name)
    if idx not in m:
        m[idx] = {}
    try:
        f = open("/data/{}/parity-noopt-12500-m5.log".format(name, name))
        for line in f:
            #  result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            result = re.findall(r"Import completed in .+ (\d+) tx/s", line)
            result = re.findall(r"Import completed in .+ (\d+) blocks", line)
            if result:
                #  print(result)
                m[idx][benchmark[2]] = int(result[0])
        #  print(m[idx][benchmark[2]])
    except:
        pass
generate_table(m, "& %d ")

for benchmark in generate_tests():
    name = "mainnet10000-" + benchmark[0] + "-" + benchmark[2]
    idx = name_mapping(name)
    if idx not in m:
        m[idx] = {}
    try:
        f = open("/data/{}/parity-inline-12500-m5.log".format(name, name))
        for line in f:
            #  result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            result = re.findall(r"Import completed in .+ (\d+) tx/s", line)
            result = re.findall(r"Import completed in .+ (\d+) blocks", line)
            if result:
                #  print(result)
                m[idx][benchmark[2]] = int(result[0])
        #  print(m[idx][benchmark[2]])
    except:
        pass
generate_table(m, "& %d ")
exit(0)

for i in range(6):
    for benchmark in generate_tests(i):
        name = "mainnet-" + benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        f = open("/data/{}/parity-100-m5.log".format(name, name))
        for line in f:
            # result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            result = re.findall(r"Import completed in .+ (\d+) blocks", line)
            if result:
                print(result)
                m[idx][benchmark[2]] = int(result[0])
        print(m[idx][benchmark[2]])
generate_table(m, "& %d ")


for i in range(6):
    for benchmark in generate_tests(i):
        name = benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        f = open("/data/{}/{}.stat".format(name, name))
        for line in f:
            # result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            result = re.findall(r"rocksdb\.bytes\.written COUNT : (\d*)", line)
            if result:
                m[idx][benchmark[2]] = int(result[0]) / 1024 / 1024 / 1024
generate_table(m, "& %.2f ")

for i in range(6):
    for benchmark in generate_tests(i):
        name = benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        res = pd.read_csv("/data/{}/{}.txt".format(name, name), sep="\s+", header=None, dtype=np.float64, skiprows=1)
        res = res[[1]]
        m[idx][benchmark[2]] = np.mean(res).values[0]
generate_table(m, "& %.3f\\%%")
