#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
sudo apt install -y python3-pip
pip3 install progressbar
pip3 install py-solc
pip3 install web3==v5.0.0-beta.2
pip3 install psrecord
sudo snap install solc
