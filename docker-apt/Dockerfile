FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
RUN set -x && \
    apt-get update && \
    apt-get install --yes apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG ENV_HTTP_PROXY=$http_proxy
ENV http_proxy="$ENV_HTTP_PROXY" \
    https_proxy="$ENV_HTTP_PROXY"

RUN set -x && \
    echo "ForeGround: 1" >> /etc/apt-cacher-ng/acng.conf && \
    echo "Proxy: $ENV_HTTP_PROXY" >> /etc/apt-cacher-ng/acng.conf && \
    echo "PassThroughPattern: .*" >> /etc/apt-cacher-ng/acng.conf

COPY run.sh /
CMD ["/run.sh"]

