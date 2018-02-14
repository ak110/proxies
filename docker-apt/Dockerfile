FROM ubuntu:xenial

RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV http_proxy=$http_proxy https_proxy=$https_proxy
RUN set -x && \
    echo "Proxy: $http_proxy" >> /etc/apt-cacher-ng/acng.conf

COPY run.sh /
CMD ["/bin/bash", "/run.sh"]

