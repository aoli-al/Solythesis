import boto3
import paramiko
import subprocess
import time
import sys
from multiprocessing import Pool
from scp import SCPClient
from utils import *


def create_new_instance(count, security_group='all-open', image_id="ami-0e65a0ccc7550e6f3"):
    ec2 = boto3.resource('ec2', region_name='us-west-1')
    instances = ec2.create_instances(
        ImageId=image_id,
        UserData='#cloud-config\nrepo_upgrade: none',
        MinCount=count,
        MaxCount=count,
        InstanceType='m5.xlarge',
        SecurityGroups=[
            security_group,
        ],
        KeyName='Leo-remote'
    )
    for instance in instances:
        instance.wait_until_running()
        instance.reload()
    return instances


def clean_up(instance):
    volumes = instance.volumes
    instance.terminate()
    #  for volume in volumes:
        #  volume.delete()


def execute_remote_command(ssh, command, block=True):
    print(command)
    stdin, stdout, stderr = ssh.exec_command(command, get_pty=True)
    if block:
        while True:
            print(stdout.readline())
            if stdout.channel.exit_status_ready():
                break
        # while not stdout.channel.exit_status_ready():
        #     line_buf += stdout.read(1).decode("utf-8")
        #     if line_buf.endswith('\n'):
        #         print(line_buf)
        #         line_buf = ''


def move_files(ssh, src, dst):
    scp = SCPClient(ssh.get_transport())
    scp.put(src, dst, recursive=True)


def fetch_files(ssh, src, dst):
    scp = SCPClient(ssh.get_transport())
    scp.get(src, dst, recursive=True)


def execute_local_command(command):
    out = subprocess.Popen(command.split(' '), stdout=subprocess.PIPE)
    stdout = out.communicate()
    print(stdout)


def install_bench_dependencies(ssh):
    execute_remote_command(ssh, "~/scripts/bash/setup_bench.sh")


def connect_until_successful(ssh, *args, **xargs):
    try:
        ssh.connect(*args, **xargs)
        return ssh
    except:
        time.sleep(10)
        connect_until_successful(ssh, *args, **xargs)


def setup_receiver(instance):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    privkey = paramiko.RSAKey.from_private_key_file('../keys/Leo-remote.pem')
    connect_until_successful(ssh, instance.public_dns_name,
                             username='leo', pkey=privkey, timeout=30000, banner_timeout=30000,
                             auth_timeout=30000)
    try:
        move_files(ssh, "../../scripts", "scripts")
        move_files(ssh, "../../tests", "tests")
        execute_remote_command(ssh, "bash ~/scripts/bash/setup_parity.sh metrics", block=False)
    except Exception as e:
        print(e)
        instance.terminate()
        exit(0)
    return [instance, ssh]


def create_receiver_singleton(image_id="ami-04a4f29a9644e4693"):
    instance = create_new_instance(1, security_group='Monitor', image_id=image_id)[0]
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    privkey = paramiko.RSAKey.from_private_key_file('../keys/Leo-remote.pem')
    connect_until_successful(ssh, instance.public_dns_name,
                             username='leo', pkey=privkey, timeout=30000, banner_timeout=30000,
                             auth_timeout=30000)
    try:
        move_files(ssh, "../../scripts", "scripts")
        move_files(ssh, "../../tests", "tests")
        execute_remote_command(ssh, "bash ~/scripts/bash/setup_parity.sh metrics")
    except Exception as e:
        print(e)
        instance.terminate()
        exit(0)
    return [instance, ssh]


def setup_sender(instance):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    privkey = paramiko.RSAKey.from_private_key_file('../keys/Leo-remote.pem')
    try:
        connect_until_successful(ssh, instance.public_dns_name,
                                 username='leo', pkey=privkey, timeout=30000, banner_timeout=30000,
                                 auth_timeout=30000)
        move_files(ssh, "../../scripts", "scripts")
        move_files(ssh, "../../tests", "tests")
        execute_remote_command(ssh, "bash ~/scripts/bash/setup_parity.sh metrics")
        # execute_remote_command(ssh, "bash ~/scripts/bash/setup_bench.sh")
    except Exception as e:
        print(e)
        instance.terminate()
        exit(0)
    return [instance, ssh]


def test(args):
    instances = create_new_instance(2, image_id="ami-07695e0338baae1ea")
    [contract, script_path, csv] = args
    [receiver, receiver_client] = setup_receiver(instances[0])
    [sender, sender_client] = setup_sender(instances[1])
    print(contract+csv + ": " + receiver.public_ip_address)
    print(contract+csv + ": " + sender.public_ip_address)
    result = True
    try:
        execute_remote_command(sender_client,
                               "bash ~/scripts/bash/test_sync.sh {} {} {} {}"
                               .format(contract, script_path, csv, receiver.public_ip_address), block=False)
        execute_remote_command(receiver_client,
                               "bash ~/scripts/bash/run_receiver.sh {} {} {} {}"
                               .format(contract, script_path, csv, sender.public_ip_address))
        execute_remote_command(sender_client,
                               "bash ~/scripts/bash/finish_sync.sh {} {} {} {}"
                               .format(contract, script_path, csv, receiver.public_ip_address))
        fetch_files(sender_client, "/home/leo/results", "/data/rep-{}-{}".format(contract, csv))
    except Exception as e:
        print(e)
        result = False
    sender_client.close()
    receiver_client.close()
    clean_up(sender)
    clean_up(receiver)
    if not result:
        test(args)


def test_2(args):
    [contract, script_path, csv] = args
    [receiver, receiver_client] = create_receiver_singleton()
    print(contract+csv + ": " + receiver.public_ip_address)
    try:
        execute_remote_command(receiver_client,
                               "bash ~/scripts/bash/run_receiver_singleton.sh {} {} {} {}"
                               .format(contract, script_path, csv, receiver.public_ip_address))
    except Exception as e:
        print(e)
    fetch_files(receiver_client, "/home/leo/results", "/data/mainnet-{}-{}".format(contract, csv))
    receiver_client.close()
    clean_up(receiver)


def test_3(args):
    [contract, script_path, csv] = args
    [receiver, receiver_client] = create_receiver_singleton("ami-0743bccc2aee3cf56")
    print(contract+csv + ": " + receiver.public_ip_address)
    try:
        move_files(receiver_client, "/data/mainnet-{0}-{1}/{0}-{1}-mainchain.bin".format(contract, csv), "/home/leo")
        execute_remote_command(receiver_client,
                               "bash ~/scripts/bash/import.sh {} {} {} {}"
                               .format(contract, script_path, csv, receiver.public_ip_address))
    except Exception as e:
        print(e)
    fetch_files(receiver_client, "/home/leo/parity.log", "/data/mainnet-{}-{}/parity-3000-m5-hashbrown.log".format(contract, csv))
    receiver_client.close()
    clean_up(receiver)

with Pool(18) as p:
    p.map(test_3, generate_tests(*[int(x) for x in sys.argv[1:]]))

# with Pool(2) as p:
#     print(p.map(test, generate_tests()))


