benchmarks = [
    #("kc", "~/scripts/py/replay.py", "erc721", 100),
    #("kc", "~/scripts/py/replay_dd.py", "tran", 33),
    #("test", "~/scripts/py/replay.py", "erc20", 100),
    #("test", "~/scripts/py/replay_bec.py", "transfer", 155),
    #("test", "~/scripts/py/replay_bec.py", "batchTransfer", 115),
    # ("vote", "~/scripts/py/replay_vote.py", "v", 151)
    #("tether", "~/scripts/py/replay_tether.py", "transfer", 155),
    #("maker", "~/scripts/py/replay_maker.py", "transfer", 155),
    #("inb", "~/scripts/py/replay_inb.py", "transfer", 155),
    #("hedg", "~/scripts/py/replay_hedg.py", "transfer", 155),
    #("zrx", "~/scripts/py/replay_zrx.py", "transfer", 155),

    # ERC 721
    # ("mchh", "~/scripts/py/replay_mchh.py", "transfer", 155),
    # ("cc", "~/scripts/py/replay_cc.py", "transfer", 155),
    # ("clv", "~/scripts/py/replay_clv.py", "transfer", 155),
    ("land", "~/scripts/py/replay_land.py", "transfer", 155),
    ("cards", "~/scripts/py/replay_cards.py", "transfer", 155),
    ("kb", "~/scripts/py/replay_kb.py", "transfer", 155),
    # ("trinket", "~/scripts/py/replay_trinket.py", "transfer", 155),
    # ("packs", "~/scripts/py/replay_packs.py", "transfer", 155),
    # ("bkc", "~/scripts/py/replay_bkc.py", "transfer", 155),
    # ("egg", "~/scripts/py/replay_egg.py", "transfer", 155)
    ]
tests = ["_base"]


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
                yield [benchmark[0]+test, *benchmark[1:]]

