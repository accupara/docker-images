# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    build-essential \
    autoconf \
    automake \
    autotools-dev \
    cython \
    debhelper \
    libaio-dev \
    libatomic-ops-dev \
    libblkid-dev \
    libboost-dev \
    libboost-random-dev \
    libboost-regex-dev \
    libboost-program-options-dev \
    libboost-thread-dev \
    libbz2-dev \
    libcrypto++-dev \
    libcurl4-gnutls-dev \
    libedit-dev \
    libexpat1-dev \
    libfcgi-dev \
    libfuse-dev \
    libgoogle-perftools-dev \
    libgtkmm-2.4-dev \
    libkeyutils-dev \
    libleveldb-dev \
    liblttng-ust-dev \
    libnss3-dev \
    libsnappy-dev \
    libtool \
    libudev-dev \
    pkg-config \
    python3-dev \
    python3-pip \
    python3-virtualenv \
    uuid-dev \
    xfslibs-dev \
# Clone the ceph repo and run the install-deps.sh script. This does all the heavy lifting
 && mkdir -p /tmp/src/ && cd /tmp/src \
 && git clone https://github.com/ceph/ceph.git \
 && cd ceph && sudo ./install-deps.sh \
## Clean up after ourselves
 && cd .. && rm -rf src \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
