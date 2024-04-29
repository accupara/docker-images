# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

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
    software-properties-common \
    wget \
    xz-utils \
# Now actually install a newer version of clang over this
 && wget https://apt.llvm.org/llvm.sh \
 && chmod +x llvm.sh \
 && sudo ./llvm.sh ${LLVM_VER} \
# Cleanup
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
