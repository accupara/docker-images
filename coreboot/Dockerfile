# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        acpica-tools \
        autoconf \
        automake \
        bison \
        build-essential \
        binutils \
        flex \
        gnat-7 \
        libncurses5-dev \
        zlib1g-dev \
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
