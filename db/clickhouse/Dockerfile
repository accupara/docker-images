# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

ENV CMAKE_VER=3.27.9 \
    LLVM_VER=18 \
    CC=clang \
    CXX=clang++

SHELL ["/bin/bash", "-c"]
RUN set -x \
# Latest version of cmake required for compilation
 && export ARCH=$(uname -m) \
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-$ARCH.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh --skip-license --prefix=/usr \
# Use clang, add the tools required for test data, according to https://clickhouse.com/docs/en/development/developer-instruction
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    clang \
    clang-tidy \
    gnupg \
    lsb-release \
    nasm \
    python3-pip \
    software-properties-common \
    wget \
    xz-utils \
    yasm \
# Make sure we have the latest version of pip and then install jinja
 && sudo python3 -m pip install --upgrade pip \
 && sudo python3 -m pip install --upgrade jinja2 \
# Now actually install a newer version of clang over this
 && wget https://apt.llvm.org/llvm.sh \
 && chmod +x llvm.sh \
 && sudo ./llvm.sh ${LLVM_VER} \
# and update the links
 && cd /usr/bin \
 && find ../lib/llvm-${LLVM_VER}/bin/ -name 'clang*' | \
    while read line ; do \
        sudo ln -sf $line $(basename $line) ; \
    done \
# Cleanup
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
