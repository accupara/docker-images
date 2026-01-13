# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
        clang \
        cmake \
        gcc g++ \
        libboost-all-dev \
        liblld-dev \
        llvm-dev \
        ninja-build \
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
