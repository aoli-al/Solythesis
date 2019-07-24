benchmarks = [("kc", "~/scripts/py/replay.py", "erc721"),
              ("kc", "~/scripts/py/replay_dd.py", "tran"),
              ("test", "~/scripts/py/replay.py", "erc20"),
              ("test", "~/scripts/py/replay_bec.py", "transfer"),
              ("test", "~/scripts/py/replay_bec.py", "batchTransfer"),
              ("vote", "~/scripts/py/replay_vote.py", "v")]
tests = ["", "_secured", "_noopt"]


def generate_tests(i=None, j=None):
    if i is not None:
        if j is not None:
            t = tests[j]
            yield [benchmarks[i][0]+t, *benchmarks[i][1:]]
        else:
            for t in tests:
                yield [benchmarks[i][0]+t, *benchmarks[i][1:]]
    else:
        for benchmark in benchmarks:
            for test in tests:
                yield [benchmark[0]+t, *benchmark[1:]]

