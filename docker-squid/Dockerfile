FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
RUN set -x && \
    apt-get update && \
    apt-get install --yes squid psmisc sudo && \
    rm -rf /var/lib/apt/lists/*

ENV http_proxy=$http_proxy https_proxy=$https_proxy

RUN set -x && \
    echo "Defaults:proxy !requiretty" > /etc/sudoers.d/squid && \
    echo "proxy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/squid && \
    chmod 0440 /etc/sudoers.d/squid && \
    visudo --check

COPY squid.conf /etc/squid/
COPY run.sh /
USER proxy
CMD ["/usr/bin/sudo", "-E", "/run.sh"]
