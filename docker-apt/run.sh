#!/bin/bash
set -eux

chown apt-cacher-ng:apt-cacher-ng /var/cache/apt-cacher-ng /var/log/apt-cacher-ng

/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng
