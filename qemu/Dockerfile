# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# Picked up these instructions from https://wiki.qemu.org/Hosts/Linux and trial and error
RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    bison \
    flex \
    libaio-dev \
    libbluetooth-dev \
    libbrlapi-dev \
    libbz2-dev \
    libcapstone-dev \
    libcap-ng-dev \
    libcurl4-gnutls-dev \
    libfdt-dev \
    libglib2.0-dev \
    libgtk-3-dev \
    libibverbs-dev \
    libjpeg8-dev \
    libncurses5-dev \
    libnuma-dev \
    libpixman-1-dev \
    librbd-dev \
    librdmacm-dev \
    libsasl2-dev \
    libsdl2-dev \
    libseccomp-dev \
    libsnappy-dev \
    libssh-dev \
    libvde-dev \
    libvdeplug-dev \
    libvte-2.91-dev \
    libxen-dev \
    liblzo2-dev \
    ninja-build \
    python3 \
    python3-sphinx \
    python3-venv \
    python-is-python3 \
    valgrind \
    xfslibs-dev \
    zlib1g-dev \
# Cleanup
 && sudo eatmydata apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
