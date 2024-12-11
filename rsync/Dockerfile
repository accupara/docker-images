# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
        autoconf \
        automake \
        clang \
        liblz4-dev \
        libssh-dev \
        libxxhash-dev \
        libzstd-dev \
        perl \
        python3-pip \
 && sudo python3 -m pip install commonmark \
# Clean up image
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
