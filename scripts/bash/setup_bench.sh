#!/usr/bin/env bash

sudo apt install -y python3-pip
pip3 install progressbar
pip3 install py-solc
pip3 install web3==v5.0.0-beta.2
pip3 install psrecord
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update
sudo apt install -y solc
