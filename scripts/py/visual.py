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

for i in range(6):
    for benchmark in generate_tests(i):
        name = benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        try:
            res = pd.read_csv("/data/rep-{}/{}.txt".format(name, name), sep="\s+", header=None, dtype=np.float64, skiprows=1)
            res = res[[1]]
            m[idx][benchmark[2]] = np.mean(res).values[0]
            print(name)
            print(m[idx][benchmark[2]])
        except:
            continue
generate_table(m, "& %.3f\\%%")

for i in range(6):
    for benchmark in generate_tests(i):
        name = benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        f = open("/data/rep-{}/db.stat".format(name, name))
        for line in f:
            # result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            result = re.findall(r"rocksdb\.bytes\.written COUNT : (\d*)", line)
            if result:
                m[idx][benchmark[2]] = int(result[0]) / 1024 / 1024 / 1024
generate_table(m, "& %.2f ")

#  for i in range(6):
    #  for benchmark in generate_tests(i):
        #  name = "mainnet-" + benchmark[0] + "-" + benchmark[2]
        #  print(name)
        #  idx = name_mapping(name)
        #  if idx not in m:
            #  m[idx] = {}
        #  f = open("/data/{}/parity.log".format(name, name))
        #  for line in f:
            #  result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            #  result = re.findall(r"Import completed in .+ (\d+) blocks", line)
            #  if result:
                #  print(result)
                #  m[idx][benchmark[2]] = int(result[0])
        #  print(m[idx][benchmark[2]])
#  generate_table(m, "& %d ")

for i in range(6):
    for benchmark in generate_tests(i):
        name = "mainnet-" + benchmark[0] + "-" + benchmark[2]
        print(name)
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        f = open("/data/{}/parity.log".format(name, name))
        for line in f:
            # result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            result = re.findall(r"Import completed in .+ (\d+) tx/s", line)
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
