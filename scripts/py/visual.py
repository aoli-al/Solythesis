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


def generate_table(m):
    corder = ["erc20", "tran", "batchTransfer", "v", "erc721", "tran"]
    rorder = ["S", "S-N", "O"]
    for r in rorder:
        s = " & \\textbf{%s}"% r
        for c in corder:
            s += "& %.3f\\%%" % m[r][c]
        s += "\\\\"
        print(s)


for i in range(6):
    for benchmark in generate_tests(i):
        name = benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        f = open("/data/{}/{}.log".format(name, name))
        for line in f:
            result = re.match(r"Cumulative writes:.+ingest: (\d*\.?\d*) GB", line)
            m[idx][benchmark[2]] = float(result.group(1))
generate_table(m)

for i in range(6):
    for benchmark in generate_tests(i):
        name = benchmark[0] + "-" + benchmark[2]
        idx = name_mapping(name)
        if idx not in m:
            m[idx] = {}
        res = pd.read_csv("/data/{}/{}.txt".format(name, name), sep="\s+", header=None, dtype=np.float64, skiprows=1)
        res = res[[1]]
        print(np.mean(res).values[0])
        m[idx][benchmark[2]] = np.mean(res).values[0]
generate_table(m)



