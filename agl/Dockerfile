# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/yocto:ubuntu_2404

SHELL ["/bin/bash", "-c"]
RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
    autoconf \
    automake \
    chrpath \
    curl \
    debianutils \
    diffstat \
    fluxbox \
    g++ \
    gawk \
    gettext \
    git-core \
    iproute2 \
    iputils-ping \
    libboost-dev \
    libegl1-mesa \
    libsdl1.2-dev \
    libz-dev \
    pylint \
    screen \
    socat \
    strace \
    subversion \
    texinfo \
    tightvncserver \
    tmux \
    wget \
    unzip \
    xterm \
    xz-utils \
 && if [ $(uname -a | grep -c x86) == "1" ] ; then \
        sudo eatmydata apt-get -y install \
            g++-multilib \
            gcc-multilib ; \
    fi \
# This is required for agl compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
 && git config --global color.ui false \
# Cleanup
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
