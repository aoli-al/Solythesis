import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import sys



# ax = plt.figure()
def show(path, color, label, fig=None):
    data = pd.read_csv(path, sep="\s+", header=None, dtype=np.float64, skiprows=0)
    data = data[[1]]
    dd = data[data < 10]
    return data.rolling(window=1).mean().plot(kind='line', ax=fig, x=0, y=1, color=color, label=label)
# print(data)
# f = show(sys.argv[1], 'green', "secured")
# show(sys.argv[2], 'red', 'normal', f)
# plt.legend()
# plt.show()

res = pd.read_csv(sys.argv[1], sep="\s+", header=None, dtype=np.float64, skiprows=1)
res = res[[1]]
print(np.mean(res))
print(np.max(res))
# plt.plot(data[0], data[1])
