# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN sudo apt-get update \
 && sudo apt-get install -y \
        build-essential \
        chrpath \
        cpio \
        debianutils \
        diffstat \
        gawk \
        gcc-multilib \
        git-core \
        iputils-ping \
        libegl1-mesa \
        libelf-dev \
        liblz4-tool \
        libsdl1.2-dev \
        locales \
        mesa-common-dev \
        pylint3 \
        python \
        python3 \
        python3-git \
        python3-jinja2 \
        python3-pexpect \
        python3-pip \
        python3-subunit \
        sed \
        socat \
        sysstat \
        texinfo \
        unzip \
        wget \
        xterm \
        xz-utils \
        zstd \
# Set up locale
 && sudo locale-gen en_US.UTF-8 \
 && echo "export LANG=en_US.UTF-8" > /tmp/add_locale \
 && echo "export LANGUAGE=en_US:en" >> /tmp/add_locale \
 && echo "export LC_ALL=en_US.UTF-8" >> /tmp/add_locale \
# Test setup using well known script
 && cd /tmp && wget https://raw.githubusercontent.com/crops/yocto-dockerfiles/master/build-install-dumb-init.sh && chmod +x build-install-dumb-init.sh \
 #&& sudo /tmp/build-install-dumb-init.sh \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
