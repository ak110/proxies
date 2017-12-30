# proxies

squidと、aptとpipのキャッシュサーバ。

## ビルド

    docker-compose build --build-arg=http_proxy=$http_proxy --build-arg=https_proxy=$https_proxy proxy proxy-apt proxy-pip

## 起動

    docker-compose up -d
    docker-compose logs -f

## 停止

    docker-compose down

## 確認

    http_proxy=http://localhost:33128 wget -O- http://www.yahoo.co.jp | head -10
    http_proxy=http://localhost:33142 wget -O- http://www.yahoo.co.jp
    http_proxy=http://localhost:33141 wget -O- http://www.yahoo.co.jp

## 使い方

### squid

    export http_proxy=http://xxxx:33128
    export https_proxy=https://xxxx:33128

### apt

以下のどれかをやる。(他にもあるけどとりあえず)

- `export http_proxy=http://xxxx:33142/`
- `/etc/apt/apt.conf.d/` 配下に `Acquire::http::Proxy "http://xxxx:33142/";` のようなファイルを作る

### pip

以下のどれかをやる。(他にもあるけどとりあえず)

- `export PIP_TRUSTED_HOST=xxxx`, `export PIP_INDEX_URL=http://xxxx:33141/root/pypi/`
- pipの引数に `--trusted-host xxxx --index-url http://xxxx:33141/root/pypi/`
