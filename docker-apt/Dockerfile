FROM ubuntu:xenial

RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN set -x && \
    echo "Proxy: $http_proxy" >> /etc/apt-cacher-ng/local.conf

COPY run.sh /
CMD ["/bin/bash", "/run.sh"]

