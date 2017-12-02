#!/bin/bash
set -eux

sed -ie "s#STORE_AVG_OBJECT_SIZE#${STORE_AVG_OBJECT_SIZE}#g" /etc/squid/squid.conf
sed -ie "s#STORE_AVG_OBJECT_UNIT#${STORE_AVG_OBJECT_UNIT}#g" /etc/squid/squid.conf
sed -ie "s#DISK_CACHE_MB#${DISK_CACHE_MB}#g" /etc/squid/squid.conf

if [ -v http_proxy ] ; then
    proxy_data=$(echo "$http_proxy" | sed -r 's#^https?://(([^@:]+?)(:([^@]+?))?@)?([^@:/]+?)(:([0-9]+))?/?#\2,\4,\5,\7#')
    IFS=','
    set -- $proxy_data
    unset IFS
    proxy_user=$1
    proxy_pass=$2
    proxy_host=$3
    proxy_port=$4
    if [ "$proxy_user" == "" ] ; then
        echo "cache_peer $proxy_host parent $proxy_port 0 no-query no-netdb-exchange" >> /etc/squid/squid.conf
    elif [ "$proxy_pass" == "" ] ; then
        echo "cache_peer $proxy_host parent $proxy_port 0 no-query no-netdb-exchange login=$proxy_user" >> /etc/squid/squid.conf
    elif [ "$proxy_pass" == "" ] ; then
        echo "cache_peer $proxy_host parent $proxy_port 0 no-query no-netdb-exchange login=$proxy_user:$proxy_pass" >> /etc/squid/squid.conf
    fi
fi

# volume
chown proxy:proxy /var/log/squid /var/spool/squid

# キャッシュ作成
squid -z -F

# 実行
squid -N -X
