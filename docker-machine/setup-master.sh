#!/bin/bash
# This script relies upon the following environment variables:
# OS_AUTH_URL = Specifies the URL for authentication
# OS_USERNAME = Specifies the username for authentication
# OS_PASSWORD = Specifies the password for authentication
# OS_TENANT_NAME = Specifies the name of the tenant Docker Machine will use

# Define the Swarm token (must be re-generated every time this is re-run)
SWARM_TOKEN="2cc829e6dc46e3217e53b4b4ee721b46"

# Define some values used later
OS_IMAGE_ID="83854473-9603-44d4-a632-396871999c9b"
OS_NETWORK_NAME="demo-net"
OS_SSH_USER="ubuntu"
OS_FLOATINGIP_POOL="EXTNET"

# Create the Swarm master instance
docker-machine create -d openstack \
--openstack-flavor-id 3 \
--openstack-image-id $OS_IMAGE_ID \
--openstack-net-name $OS_NETWORK_NAME \
--openstack-floatingip-pool $OS_FLOATINGIP_POOL \
--openstack-ssh-user $OS_SSH_USER \
--openstack-sec-groups docker,basic-services \
--swarm \
--swarm-master \
--swarm-discovery token://$SWARM_TOKEN \
master
