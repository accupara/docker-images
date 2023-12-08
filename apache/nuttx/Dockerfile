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
    kconfig-frontends \
    libgmp-dev \
    libgmp3-dev \
    libmpc-dev \
    libmpfr-dev \
    libncurses-dev \
# Install a whole bunch of cross compilers
 && apt-cache search linux-gnu | grep gcc- | grep -v 'gcc-[0-9]' | awk '{print $1}' | \
    xargs sudo apt-get install -y \
 && apt-cache search 'gcc-' | grep eabi | grep -v 'gcc-[0-9]' | grep -v source | awk '{print $1}' | \
    xargs sudo apt-get install -y \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
