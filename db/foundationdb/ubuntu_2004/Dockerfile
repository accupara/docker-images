# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

ENV BOOST_VER=1_82_0 \
    BOOST_ROOT=/opt/boost_1_80_0 \
    CMAKE_VER=3.26.4 \
    SWIFT_VER=5.8.1

RUN set -x \
 && sudo apt-get update \
# Prep for Mono installation
 && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
 && sudo apt-get install -y apt-transport-https ca-certificates \
 && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Now for the rest of the deps
 && sudo apt update \
 && sudo apt-get install -y \
    binutils \
    gnupg2 \
    libc++-dev \
    libc6-dev \
    libcurl4-openssl-dev \
    libedit2 \
    libgcc-11-dev \
    libjemalloc-dev \
    liblz4-dev \
    libpython3-dev \
    libsqlite3-0 \
    libssl-dev \
    libstdc++-11-dev \
    libxml2-dev \
    libz3-dev \
    mono-devel \
    ninja-build \
    openjdk-11-jdk \
    pkg-config \
    python3-lldb-13 \
    python3-pip \
    python3-venv \
    software-properties-common \
    tzdata \
    unzip \
    zlib1g-dev \
# Download boost, but don't compile it
 && wget -q -O /tmp/boost_${BOOST_VER}.tar.gz https://downloads.sourceforge.net/project/boost/boost/$(echo ${BOOST_VER} | sed 's/_/./g')/boost_${BOOST_VER}.tar.gz >/dev/null \
 && sudo tar -C /opt -xf /tmp/boost_${BOOST_VER}.tar.gz \
 && rm /tmp/boost_${BOOST_VER}.tar.gz \
 && sudo chown -R admin:admin ${BOOST_ROOT}} \
# Install Swift
 && sudo apt install -y \
    clang \
    libpython2.7 \
    libpython2.7-dev \
 && wget -q -O /tmp/swift.tar.gz https://download.swift.org/swift-${SWIFT_VER}-release/ubuntu2004/swift-${SWIFT_VER}-RELEASE/swift-${SWIFT_VER}-RELEASE-ubuntu20.04.tar.gz \
 && sudo tar -C /tmp/ -xf /tmp/swift.tar.gz \
 && sudo rsync -a /tmp/swift-${SWIFT_VER}-RELEASE-ubuntu20.04/usr/ /usr/ \
# Cleanup apt cache
 && sudo apt-get clean
