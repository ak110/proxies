FROM python:latest

RUN pip install --no-cache-dir devpi-server

ARG ENV_HTTP_PROXY=$http_proxy
ENV http_proxy="$ENV_HTTP_PROXY" \
    https_proxy="$ENV_HTTP_PROXY"

COPY run.sh /
CMD ["/run.sh"]

