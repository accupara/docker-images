# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/golang:1.16-buster
MAINTAINER Crave.io Inc. "contact@crave.io"

ENV lsb_release_env="stretch"
# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && set -x \
 && apt-get update \
 && apt-get install -y \
    go-md2man \
    libassuan-dev \
    libbtrfs-dev \
    libdevmapper-dev \
    libgpgme-dev \
# Cleanup the apt cache
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*
