import boto3
import paramiko
import subprocess
import time
from multiprocessing import Pool
from scp import SCPClient


def create_new_instance(count):
    ec2 = boto3.resource('ec2', region_name='us-west-1')
    instances = ec2.create_instances(
        ImageId='ami-09fe6edeedec4bf7a',
        UserData='Leo-bench',
        MinCount=count,
        MaxCount=count,
        InstanceType='t2.xlarge',
        SecurityGroups=[
            'all-open',
        ],
        KeyName='Leo-remote'
    )
    for instance in instances:
        instance.wait_until_running()
        instance.reload()
    return instances


def execute_remote_command(ssh, command, cwd="~", block=True):
    print(command)
    stdin, stdout, stderr = ssh.exec_command(command, get_pty=block)
    # if block:
    #     line_buf = ''
    #     while not stdout.channel.exit_status_ready():
    #         line_buf += stdout.read(1).decode("utf-8")
    #         if line_buf.endswith('\n'):
    #             print(line_buf)
    #             line_buf = ''


def move_files(ssh, src, dst):
    ssh.exec_command("cd ~", get_pty=True)
    scp = SCPClient(ssh.get_transport())
    scp.put(src, dst, recursive=True)


def execute_local_command(command):
    out = subprocess.Popen(command.split(' '), stdout=subprocess.PIPE)
    stdout = out.communicate()
    print(stdout)


def install_cargo(ssh):
    execute_remote_command(ssh, "~/scripts/bash/setup_parity.sh")


def install_bench_dependencies(ssh):
    execute_remote_command(ssh, "~/scripts/bash/setup_bench.sh")


def connect_until_successful(ssh, *args, **xargs):
    try:
        ssh.connect(*args, **xargs)
        return ssh
    except:
        time.sleep(10)
        connect_until_successful(ssh, *args, **xargs)


def create_receiver():
    instance = create_new_instance(1)[0]
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    privkey = paramiko.RSAKey.from_private_key_file('../keys/Leo-remote.pem')
    connect_until_successful(ssh, instance.public_dns_name,
                             username='ubuntu', pkey=privkey, timeout=30000, banner_timeout=30000,
                             auth_timeout=30000)
    try:
        move_files(ssh, "../../scripts", "scripts")
        execute_remote_command(ssh, "bash ~/scripts/bash/setup_parity.sh", block=False)
    except Exception as e:
        print(e)
        instance.terminate()
        exit(0)
    return [instance, ssh]


def create_sender():
    instance = create_new_instance(1)[0]
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    privkey = paramiko.RSAKey.from_private_key_file('../keys/Leo-remote.pem')
    try:
        connect_until_successful(ssh, instance.public_dns_name,
                                 username='ubuntu', pkey=privkey, timeout=30000, banner_timeout=30000,
                                 auth_timeout=30000)
        move_files(ssh, "../../scripts", "scripts")
        move_files(ssh, "../../tests", "tests")
        execute_remote_command(ssh, "bash ~/scripts/bash/setup_parity.sh")
        # execute_remote_command(ssh, "bash ~/scripts/bash/setup_bench.sh")
    except Exception as e:
        print(e)
        instance.terminate()
        exit(0)
    return [instance, ssh]


def test(args):
    [contract, script_path, csv] = args
    [receiver, receiver_client] = create_receiver()
    [sender, sender_client] = create_sender()
    print(contract+csv + ": " + receiver.public_ip_address)
    print(contract+csv + ": " + sender.public_ip_address)
    try:
        execute_remote_command(receiver_client, "bash ~/scripts/bash/run_receiver.sh", block=False)
        execute_remote_command(sender_client,
                               "bash ~/scripts/bash/test_sync.sh {} {} {} {}"
                               .format(contract, script_path, csv, receiver.public_ip_address))
    except:
        pass
    move_files(sender_client, "/home/ubuntu/results", "/data/{}-{}".format(contract, csv))
    sender_client.close()
    receiver_client.close()
    sender.terminate()
    receiver.terminate()


benchmarks = [("kc", "~/scripts/py/replay.py", "erc721"),
              ("kc", "~/scripts/py/replay_dd.py", "tran"),
              ("test", "~/scripts/py/replay.py", "erc20"),
              ("test", "~/scripts/py/replay_bec.py", "transfer"),
              ("test", "~/scripts/py/replay_bec.py", "batchTransfer"),
              ("vote", "~/scripts/py/replay_vote.py", "v")]
tests = ["", "_secured", "_noopt"]


def generate_tests():
    for benchmark in benchmarks:
        for t in tests:
            yield [benchmark[0]+t, *benchmark[1:]]


with Pool(1) as p:
    p.map(test, generate_tests())


