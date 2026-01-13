# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

# Information collected from https://docs.ubports.com/en/latest/porting/introduction/Setting_up.html

RUN set -x \
# Enable i386 architecture
 && sudo dpkg --add-architecture i386 \
# Then do all the installing
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get update \
 && sudo DEBIAN_FRONTEND=noninteractive eatmydata apt-get -y install \
        bc \
        bison \
        build-essential \
        bzr \
        curl \
        flex \
        g++-multilib \
        git \
        gnupg \
        gperf \
        imagemagick \
        libc6-dev \
        libncurses5 \
        libgl1-mesa-glx:i386 \
        libgl1-mesa-dev \
        liblz4-tool \
        libncurses5-dev:i386 \
        libreadline6-dev:i386 \
        libx11-dev:i386 \
        libxml2-utils \
        lzop \
        mingw-w64-i686-dev \
        python2 \
        python-is-python3 \
        python3-markdown \
        rsync \
        schedtool \
        tofrodos \
        x11proto-core-dev \
        xsltproc \
        zip \
        zlib1g-dev:i386 \
# Final cleanups
 && cd /tmp \
 && sudo find dl -delete \
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
