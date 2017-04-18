#!/bin/bash
set -e

IPV4_ADDR=${IPV4_ADDR:-$1}
ETCD_DISCOVERY=${ETCD_DISCOVERY:-$2}

# Setup and copy etcd environment file
sed "s#{{PUBLIC_ADDR}}#$IPV4_ADDR#g" etcd2.env > /etc/etcd2.env
sed -i "s#{{ETCD_DISCOVERY_URL}}#$ETCD_DISCOVERY#g" /etc/etcd2.env
# Copy etcd service file
cp etcd2.service /etc/systemd/system/etcd2.service

# Add DOCKER_OPTS into docker.service file
sed -i "s#ExecStart=/usr/bin/dockerd -H fd://#ExecStart=/usr/bin/dockerd \$DOCKER_OPTS -H fd://#" /lib/systemd/system/docker.service

# Copy docker service dropin file
DOCKER_CONF_PATH=/etc/systemd/system/docker.service.d
mkdir -p ${DOCKER_CONF_PATH}
cp 20-docker.conf ${DOCKER_CONF_PATH}/20-docker.conf
cp 10-wait-docker.conf ${DOCKER_CONF_PATH}/10-wait-docker.conf
