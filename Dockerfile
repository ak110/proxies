FROM ubuntu:xenial

RUN set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes squid && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3128

COPY squid.conf /etc/squid/
COPY run-squid.sh ./
CMD ["/bin/bash", "run-squid.sh"]
