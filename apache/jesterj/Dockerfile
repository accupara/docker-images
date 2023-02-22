# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/openjdk:8

ENV CMAKE_VER=3.23.2 \
    PROTOBUF_VER=3.7.1 \
    BOOST_VER=1_80_0

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        automake \
        build-essential \
        bzip2 \
        cmake \
        fuse \
        libbz2-dev \
        libfuse-dev \
        libssl-dev \
        libsasl2-dev \
        libsnappy-dev \
        libtool \
        libzstd-dev \
        maven \
        pkg-config \
        software-properties-common \
        zlib1g-dev \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Download boost, but don't compile it
 && wget -q -O /tmp/boost_${BOOST_VER}.tar.gz https://downloads.sourceforge.net/project/boost/boost/$(echo ${BOOST_VER} | sed 's/_/./g')/boost_${BOOST_VER}.tar.gz >/dev/null \
 && sudo tar -C /opt -xf /tmp/boost_${BOOST_VER}.tar.gz \
 && rm /tmp/boost_${BOOST_VER}.tar.gz \
 && sudo chown -R admin:admin /opt/boost_${BOOST_VER} \
 && cd /opt/boost_${BOOST_VER} \
 && ./bootstrap.sh --prefix=/usr/ \
 && ./b2 --without-python \
 && sudo ./b2 --without-python install \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
