# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Accupara Inc. "contact@accupara.com"

RUN sudo apt-get update && \
    sudo apt-get install -y \
        build-essential \
        chrpath \
        cpio \
        diffstat \
        gawk \
        gcc-multilib \
        git-core \
        libsdl1.2-dev \
        python3 \
        socat \
        texinfo \
        unzip \
        wget \
        xterm

RUN sudo locale-gen en_US.UTF-8 && \
    echo "export LANG=en_US.UTF-8" > /tmp/add_locale && \
    echo "export LANGUAGE=en_US:en" >> /tmp/add_locale && \
    echo "export LC_ALL=en_US.UTF-8" >> /tmp/add_locale
