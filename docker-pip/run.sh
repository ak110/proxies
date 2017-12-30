#!/bin/bash
set -eux

if [ ! -e /cache/.serverversion ] ; then
    devpi-server --serverdir=/cache --init
fi

exec devpi-server --serverdir=/cache --host=0.0.0.0

