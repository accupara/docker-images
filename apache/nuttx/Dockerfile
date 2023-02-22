# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    automake \
    bison \
    byacc \
    curl \
    flex \
    gdb \
    gperf \
    libgmp-dev \
    libgmp3-dev \
    libmpc-dev \
    libmpfr-dev \
    libncurses-dev \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
