# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/golang:1.16-buster

ENV lsb_release_env="stretch"
# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    go-md2man \
    libassuan-dev \
    libbtrfs-dev \
    libdevmapper-dev \
    libgpgme-dev \
# Cleanup the apt cache
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
