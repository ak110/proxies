FROM ubuntu:xenial

ARG DEBIAN_FRONTEND=noninteractive
RUN set -x && \
    apt-get update && \
    apt-get install --yes squid cron && \
    rm -rf /var/lib/apt/lists/*

ENV http_proxy=$http_proxy https_proxy=$https_proxy

COPY cron.squid /etc/cron.d/
COPY squid.conf /etc/squid/
COPY run.sh /
CMD ["/run.sh"]
