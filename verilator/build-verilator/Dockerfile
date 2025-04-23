# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
# Info from: https://verilator.org/guide/latest/install.html
       autoconf \
       bison \
       clang-format \
       cmake \
       flex \
       graphviz \
       help2man \
       lcov \
       libbit-vector-perl \
       libfl2 \
       libfl-dev \
       zlib1g \
       zlib1g-dev \
# Minimize image
 && sudo eatmydata apt-get autoremove -y \
 && sudo eatmydata apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
