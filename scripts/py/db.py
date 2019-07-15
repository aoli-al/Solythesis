from utils import generate_tests
import subprocess

for i in range(6):
    for benchmark in generate_tests(i):
        name = benchmark[0] + "-" + benchmark[2]
        subprocess.call("bash ~/Solythesis/scripts/bash/test_run.sh " + name, shell=True)

