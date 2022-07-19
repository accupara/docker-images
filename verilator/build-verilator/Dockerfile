# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get install -y \
# Info from: https://verilator.org/guide/latest/install.html
       autoconf \
       bison \
       clang-format-11 \
       cmake \
       flex \
       graphviz \
       lcov \
       libbit-vector-perl \
       libfl2 \
       libfl-dev \
       zlibc \
       zlib1g \
       zlib1g-dev \
# Minimize image
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
