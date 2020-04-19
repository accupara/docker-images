# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
    git \
    rsync \
    pigz \
    make \
    jq

COPY bin/crave /usr/local/bin
