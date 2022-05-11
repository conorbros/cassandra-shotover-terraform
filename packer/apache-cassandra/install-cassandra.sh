#!/bin/bash

###
### INSTALL CASSANDRA
###
sudo yum install java-1.8.0-openjdk -y

cat <<EOF | sudo tee -a /etc/yum.repos.d/cassandra311x.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
EOF


#!/bin/bash


set -e

sudo yum update -y

sudo yum install cassandra -y
sudo systemctl daemon-reload
sudo service cassandra stop

# clear out data
sudo rm -rf /var/lib/cassandra/data/system/*

###
###
###

###
### INSTALL SHOTOVER
###

sudo yum install git openssl-devel openssl perf -y
sudo yum groupinstall "Development Tools" -y

curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env

git clone https://github.com/shotover/shotover-proxy
cd shotover-proxy
cargo build --release

cd ..
sudo mv shotover-proxy/target/release/shotover-proxy /usr/bin/shotover-proxy
sudo rm -r shotover-proxy

wget https://raw.githubusercontent.com/shotover/shotover-proxy/main/shotover-proxy/config/config.yaml

sudo mkdir -p /etc/shotover/config
sudo mv config.yaml /etc/shotover/config/

wget https://raw.githubusercontent.com/conorbros/cassandra-shotover-benchmarks/master/shotover.service

sudo mv shotover.service /etc/systemd/system/shotover.service

sudo chmod 640 /etc/systemd/system/shotover.service

sudo systemctl enable shotover
