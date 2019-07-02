# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
    git \
    rsync \
    pigz

COPY bin/crave /usr/local/bin
