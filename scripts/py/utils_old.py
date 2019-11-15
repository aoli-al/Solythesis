benchmarks = [
    #("kc", "~/scripts/py/replay.py", "erc721", 100),
    #("kc", "~/scripts/py/replay_dd.py", "tran", 33),
    #("test", "~/scripts/py/replay.py", "erc20", 100),
    #("test", "~/scripts/py/replay_bec.py", "transfer", 155),
    #("test", "~/scripts/py/replay_bec.py", "batchTransfer", 115),
    #("vote", "~/scripts/py/replay_vote.py", "v", 151)
    #("tether", "~/scripts/py/replay_tether.py", "transfer", 155),
    #("zrx", "~/scripts/py/replay_zrx.py", "transfer", 155),
    #("swipe", "~/scripts/py/replay_swipe.py", "transfer", 155),
    #("theta", "~/scripts/py/replay_theta.py", "transfer", 155),
    #("inb", "~/scripts/py/replay_inb.py", "transfer", 155),
    #("hedg", "~/scripts/py/replay_hedg.py", "transfer", 155),
    #("ekt", "~/scripts/py/replay_ekt.py", "transfer", 155),
    #("dai", "~/scripts/py/replay_dai.py", "transfer", 155),
    #("xin", "~/scripts/py/replay_xin.py", "transfer", 155),
    #("hot", "~/scripts/py/replay_hot.py", "transfer", 155),
    #("swipe", "~/scripts/py/replay_swipe.py", "transfer", 155),
    ("mchh", "~/scripts/py/replay_mchh.py", "tran", 33),
    #("cc", "~/scripts/py/replay_cc.py", "tran", 33),
    #("clv", "~/scripts/py/replay_clv.py", "tran", 33),
    #("land", "~/scripts/py/replay_land.py", "tran", 33),
    #("emond", "~/scripts/py/replay_emond.py", "tran", 33),
    #("cards", "~/scripts/py/replay_cards.py", "tran", 33),
    #("kb", "~/scripts/py/replay_kb.py", "tran", 33),
    #("mumo", "~/scripts/py/replay_mumo.py", "tran", 33),
    #("trinket", "~/scripts/py/replay_trinket.py", "tran", 33),
    #("bkc", "~/scripts/py/replay_bkc.py", "tran", 33),
    #("packs", "~/scripts/py/replay_packs.py", "tran", 33),
    # ("egg", "~/scripts/py/replay_egg.py", "tran", 33),
    ]
    
tests = [""]
# tests = ["", "_secured", "_noopt"]
#tests = ["_base_new"]


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

