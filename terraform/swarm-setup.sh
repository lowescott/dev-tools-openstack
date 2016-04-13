#!/bin/bash

# Set these IP addresses after running Terraform
NODE_01='172.16.5.149'
NODE_02='172.16.5.152'
NODE_03='172.16.5.150'
NODE_04='172.16.5.151'
NODE_05='172.16.5.153'

# Set API endpoints based on node IP addresses
N01_ETCD="$NODE_01:2379"
N01_DCKR="$NODE_01:2375"
N02_ETCD="$NODE_02:2379"
N02_DCKR="$NODE_02:2375"
N03_ETCD="$NODE_03:2379"
N03_DCKR="$NODE_03:2375"
N04_ETCD="$NODE_04:2379"
N04_DCKR="$NODE_04:2375"
N05_ETCD="$NODE_05:2379"
N05_DCKR="$NODE_05:2375"

# Set the correct path to the Docker binary
DOCKER_BIN='/usr/local/docker/bin/docker-1.9.1'

# Define the Swarm commands to be used to build the cluster
JOIN_CMD="run -d swarm join etcd://$N01_ETCD/swarm"

# Define the command for the Swarm manager
MGR_CMD="run -d -p 3375:3375 swarm manage -H :3375 --addr $NODE_01 etcd://$N01_ETCD/swarm"

# Set up the first node
$DOCKER_BIN -H tcp://$N01_DCKR $JOIN_CMD --addr $N01_DCKR

# Set up the second node
$DOCKER_BIN -H tcp://$N02_DCKR $JOIN_CMD --addr $N02_DCKR

# Set up the third node
$DOCKER_BIN -H tcp://$N03_DCKR $JOIN_CMD --addr $N03_DCKR

# Set up the fourth node
$DOCKER_BIN -H tcp://$N04_DCKR $JOIN_CMD --addr $N04_DCKR

# Set up the fifth node
$DOCKER_BIN -H tcp://$N05_DCKR $JOIN_CMD --addr $N05_DCKR

# Turn up primary Swarm manager
$DOCKER_BIN -H tcp://$N01_DCKR $MGR_CMD
