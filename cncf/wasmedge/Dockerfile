# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get install -y \
      clang-12 \
      cmake \
      gcc g++ \
      libboost-all-dev \
	liblld-12-dev \
      llvm-12-dev \
      ninja-build \
      software-properties-common \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
