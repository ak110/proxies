#!/bin/bash
set -eux

chown apt-cacher-ng:apt-cacher-ng /var/cache/apt-cacher-ng /var/log/apt-cacher-ng

/etc/init.d/apt-cacher-ng start

tail -f /var/log/apt-cacher-ng/*
