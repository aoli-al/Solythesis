import sys
from utils import generate_tests
import matplotlib.pyplot as plt
import numpy as np

def read(path):
    signature = {
        "verifier": [["Verifier"], 0],
        # "keccakf": [["keccakf", "tiny_keccak"], 0],
        # "rocksdb:low": [["rocksdb:low"], 0],
        # "rocksdb:high": [["rocksdb:high"], 0],
        "evm": [["CallCreateExecutive::exec", "exec_instruction", "Gasometer"], 0],

        # "parity_rocksdb": [["parity_rocksdb"], 0],
        # "trie_db": [["parity_rocksdb", "trie_db"], 0],
        # "hash_db": [["parity_rocksdb", "trie_db", "hash_db"], 0],
        # "kvdb_rocksdb": [["parity_rocksdb", "trie_db", "hash_db", "kvdb_rocksdb"], 0],
        # "memory": [["__memmove_avx_unaligned_erms", "_int_malloc", "malloc", "cfree"], 0],
        # "db": [["parity_rocksdb", "trie_db", "hash_db", "kvdb_rocksdb"], 0],
        "storage": [["parity_rocksdb", "rocksdb", "rocksdb:low", "rocksdb:high",
                     "trie_db", "journaldb",
                     "hash_db", "kvdb_rocksdb",
                     "snappy::RawUncompress"], 0],
        # "uint": [["ethereum_types::uint"], 0]
    }
    def eat_rest_lines(f):
        l = f.readline()
        while l and l != "\n":
            l = f.readline()
    other = 0
    found = True
    n = ""
    result = {}

    pending = ""
    with open(path) as f:
        line = f.readline()
        print(line)
        while line:
            if line[0] == "#":
                line = f.readline()
                continue
            if not pending and line[0] == '\t':
                pending = line.strip()
            found = False
            n = ""
            for key, value in signature.items():
                for name in value[0]:
                    if name in line:
                        # value[1] += 1
                        n = key
                        found = True
                        break
                if found and n != "memory" and n != 'keccakf':
                    break
            if found:
                eat_rest_lines(f)
                pending = ""
                if n != "memory" and n != "keccakf":
                    signature[n][1] += 1
                elif n == "memory":
                    other += 1
                    # signature["evm"][1] += 1
                else:
                    signature["storage"][1] += 1
                    # other += 1
                    # signature["other"][1] += 1
            elif line == "\n":
                other += 1
                if pending not in result:
                    result[pending] = 0
                result[pending] += 1
                pending = ""
            line = f.readline()


    # for (key, value) in sorted(result.items(), reverse=True, key=lambda x: x[1]):
    #     print(key + ": " + str(value))
    # print(sum(result.values()))
    # for key, value in signature.items():
    #     print(key + ": " + str(value[1]))

    keys = [x for x in signature.keys()]
    keys.append('other')
    # keys.remove("memory")
    # keys.remove("keccakf")
    values = [signature[x][1] for x in keys[:-1]]
    values.append(other)
    plt.pie(values, labels=keys, autopct='%1.1f%%', shadow=True, startangle=140)
    plt.axis('equal')
    plt.tight_layout()
    plt.title(path)
    plt.show()
    return keys, values
# plt.hold(False)

w = 0.1

for i in range(0, 6):
    ax1 = plt.subplot(1, 1, 1)
    keys = []

    values = []

    def rr(path):
        global test
        for test in generate_tests(i):
            name = path.format(test[0], test[2])
            # read(name)
            k, v = read(name)
            keys.append(k)
            values.append(v)

    rr("/Users/leo/tests/vis2/mainnet10000-dwarf-{}-{}-12500-m5.txt")
    # rr("/Users/leo/tests/vis2/mainnet10000-{}-{}-12500-m5.txt")
    # rr("/Users/leo/tests/vis2/mainnet10000-inline-{}-{}-12500-m5.txt")
    # rr("/Users/leo/tests/vis2/mainnet10000-opt-{}-{}-12500-m5.txt")
    x = np.arange(len(keys[0]))

    plt.xticks(x + w * len(values) / 2, keys[0], rotation='vertical')
    plt.ylabel('Counts')
    plt.title('opt-'+test[2])
    t = 0
    for vv in values:
        ax1.bar(x+t, vv, width=w, align='center')
        t += w
    # s0 = ax1.bar(x, values[0], width=0.2, align='center')
    # s1 = ax1.bar(x+0.2, values[1], width=0.2, align='center')
    # s3 = ax1.bar(x+0.4, values[2], width=0.2, align='center')
    plt.show()
    plt.clf()
    # print(values)
    # s1 = ax1.bar(x+w, keys[0], width=w, color='b', align='center')

    # print(other)

# x = np.arange(10)
# #plt.xticks(), will label the bars on x axis with the respective country names.
# pop =ax1.bar(x, datasort['population']/ 10 ** 6, width=w, color='b', align='center')
# #The trick is to use two different axes that share the same x axis, we have used ax1.twinx() method.
# ax2 = ax1.twinx()
# #We have calculated GDP by dividing gdpPerCapita to population.
# gdp =ax2.bar(x + w, datasort['gdpPerCapita'] * datasort.population / 10**9, width=w,color='g',align='center')
# #Set the Y axis label as GDP.
# plt.ylabel('GDP')
# #To set the legend on the plot we have used plt.legend()
# plt.legend([pop, gdp],['Population in Millions', 'GDP in Billions'])
# #To show the plot finally we have used plt.show().
# plt.show()
