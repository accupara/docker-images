# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    build-essential \
    cmake \
    gfortran \
    libopenmpi2 \
    libopenmpi-dev \
    python \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
