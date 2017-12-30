FROM python:3.6

RUN pip install --no-cache-dir devpi-server

ENV http_proxy=$http_proxy https_proxy=$https_proxy

COPY run.sh /
CMD ["/bin/bash", "/run.sh"]

