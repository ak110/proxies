#!/bin/bash
set -eux

sed -ie "s#MAXIMUM_OBJECT_MB#${MAXIMUM_OBJECT_MB}#g" /etc/squid/squid.conf
sed -ie "s#DISK_CACHE_MB#${DISK_CACHE_MB}#g" /etc/squid/squid.conf

if [ -v http_proxy ] ; then
    if [ "$http_proxy" != "" ] ; then
        proxy_data=$(echo "$http_proxy" | sed -r 's#^https?://(([^@:]+?)(:([^@]+?))?@)?([^@:/]+?)(:([0-9]+))?/?#\2,\4,\5,\7#')
        IFS=','
        set -- $proxy_data
        unset IFS
        proxy_user=$1
        proxy_pass=$2
        proxy_host=$3
        proxy_port=$4
        sed -ie '/^cache_peer /d' /etc/squid/squid.conf
        if [ "$proxy_user" == "" ] ; then
            echo "cache_peer $proxy_host parent $proxy_port 0 no-query no-netdb-exchange" >> /etc/squid/squid.conf
        elif [ "$proxy_pass" == "" ] ; then
            echo "cache_peer $proxy_host parent $proxy_port 0 no-query no-netdb-exchange login=$proxy_user" >> /etc/squid/squid.conf
        else
            echo "cache_peer $proxy_host parent $proxy_port 0 no-query no-netdb-exchange login=$proxy_user:$proxy_pass" >> /etc/squid/squid.conf
        fi
        sed -ie '/^never_direct allow/d' /etc/squid/squid.conf
        echo "never_direct allow all" >> /etc/squid/squid.conf
        echo "never_direct allow CONNECT" >> /etc/squid/squid.conf
    fi
fi

chown proxy:proxy /var/log/squid /var/spool/squid

killall squid || true

# キャッシュ作成
squid -z -F
# pidが残っていれば削除
if [ -f /var/run/squid.pid ] ; then
    rm -f /var/run/squid.pid
fi
# 起動ごとにログローテート (手抜き)
squid -k rotate || true
# 実行
squid -N
