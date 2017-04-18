#!/bin/bash
set -e

sed -i "s#ExecStart=/usr/bin/dockerd#ExecStart=/usr/bin/dockerd \$DOCKER_OPTS#" /lib/systemd/system/docker.service

DOCKER_CONF_PATH=/etc/systemd/system/docker.service.d
mkdir -p ${DOCKER_CONF_PATH}
cp 20-docker.conf ${DOCKER_CONF_PATH}/20-docker.conf
