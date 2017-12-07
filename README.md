# Squid

## ビルド

    docker build --build-arg=http_proxy=$http_proxy --build-arg=https_proxy=$https_proxy --tag=squid .

## 起動

プロキシ無し:

    docker run --detach --restart=always --volume=$PWD/log:/var/log/squid --volume=$PWD/cache:/var/spool/squid --publish=33128:3128 --env=MAXIMUM_OBJECT_MB=1024 --env=DISK_CACHE_MB=10240 --name=squid squid && docker logs squid -f

プロキシあり:

    docker run --detach --restart=always --volume=$PWD/log:/var/log/squid --volume=$PWD/cache:/var/spool/squid --publish=33128:3128 --env=MAXIMUM_OBJECT_MB=1024 --env=DISK_CACHE_MB=10240 --env=http_proxy=$http_proxy --name=squid squid && docker logs squid -f

## 停止

    docker rm -f squid

## 確認

    http_proxy=http://localhost:33128 wget -O- http://www.google.co.jp | head -10

## 環境変数

    export http_proxy=http://localhost:33128
    export https_proxy=https://localhost:33128
