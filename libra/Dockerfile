# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/rustlang:debian_10

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
      clang \
      cmake \
      curl \
      gcc-powerpc-linux-gnu \
      lcov \
      libssl-dev \
      llvm \
      pkg-config \
## Libra code needs this toolchain
 && rustup toolchain install 1.44.0 \
 && rustup toolchain install 1.44.1 \
# Cleanup
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
