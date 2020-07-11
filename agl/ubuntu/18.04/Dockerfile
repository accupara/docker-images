# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/yocto:ubuntu_1804
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get -y install \
    curl \
    autoconf \
    automake \
    gettext \
    libboost-dev \
    libz-dev \
    g++ \
    gawk \
    wget \
    git-core \
    diffstat \
    unzip \
    texinfo \
    gcc-multilib \
    build-essential \
    chrpath \
    socat \
    cpio \ 
    python \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \ 
    libegl1-mesa \
    libsdl1.2-dev \
    pylint3 \
    xterm \
    locales \
    g++-multilib \
    subversion \
    screen \
    tmux \
    iputils-ping \
    iproute2 \
    fluxbox \
    tightvncserver \
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

RUN set -x \
 && sudo apt-get install -y strace
