# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04

RUN sudo apt-get update \
 && sudo apt-get dist-upgrade -y \
 && sudo apt-get install -y \
    libbz2-dev \
    libdb5.3++-dev \
    libdb5.3-dev \
    libffi-dev \
    libgdbm-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssh-dev \
    lzma-dev \
    tk-dev \
    uuid-dev \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
