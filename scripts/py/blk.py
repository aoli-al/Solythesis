import sys

p = ['parity', 'rocksdb', 'file']
m = {}

for x in p:
    m[x] = [0, 0]
with open(sys.argv[1]) as f:
    for l in f:
        v = l.split(',')
        if len(v) != 6:
            continue
        if 'I' not in v[3] and 'C' not in v[3]:
            continue
        for x in p:
            if x in v[2]:
                m[x][0] += 1
                m[x][1] += int(v[5])

for x in p:
    print(x)
    print(m[x])

