# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:14.04
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY build-install-dumb-init.sh /tmp/

RUN sudo apt-get update \
 && sudo apt-get install -y \
        build-essential \
        chrpath \
        cpio \
        diffstat \
        gawk \
        gcc-multilib \
        git-core \
        libsdl1.2-dev \
        locales \
        python \
        python3 \
        socat \
        sysstat \
        texinfo \
        unzip \
        wget \
        xterm \
        xz-utils \
 && sudo locale-gen en_US.UTF-8 \
 && echo "export LANG=en_US.UTF-8" > /tmp/add_locale \
 && echo "export LANGUAGE=en_US:en" >> /tmp/add_locale \
 && echo "export LC_ALL=en_US.UTF-8" >> /tmp/add_locale \
 && sudo /bin/bash /tmp/build-install-dumb-init.sh \
 && sudo apt-get clean
