#!/bin/bash
set -e

IPV4_ADDR=${IPV4_ADDR:-$1}

# Setup and copy swarm services' files
sed "s#{{PUBLIC_ADDR}}#$IPV4_ADDR#g" swarm-node.service > /etc/systemd/system/swarm-node.service
sed "s#{{PUBLIC_ADDR}}#$IPV4_ADDR#g" swarm-manager.service > /etc/systemd/system/swarm-manager.service
