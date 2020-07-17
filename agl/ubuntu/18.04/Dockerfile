# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/yocto:ubuntu_1804
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get -y install \
    autoconf \
    automake \
    build-essential \
    chrpath \
    cpio \ 
    curl \
    debianutils \
    diffstat \
    fluxbox \
    g++ \
    gawk \
    g++-multilib \
    gcc-multilib \
    gettext \
    git-core \
    iproute2 \
    iputils-ping \
    libboost-dev \
    libegl1-mesa \
    libsdl1.2-dev \
    libz-dev \
    locales \
    pylint3 \
    python \
    python3 \
    python3-git \
    python3-jinja2 \ 
    python3-pip \
    python3-pexpect \
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
 && sudo locale-gen en_US.UTF-8 \
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mkdir /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
# This is required for agl compilations
 && git config --global user.name Crave \
 && git config --global user.email aosp@crave.io \
 && git config --global color.ui false

ENV LANG=en_US.UTF-8
