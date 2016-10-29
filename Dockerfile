FROM openrovdocker/armhf-buildtools
MAINTAINER spiderkeys

RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        automake && \
    apt-get autoremove -y && \
    apt-get clean