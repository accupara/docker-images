# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/rustlang:debian_10
LABEL maintainer="Crave.io Inc. 'contact@crave.io'"

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
# Required to have a working rust toolchain
 && rustup toolchain remove nightly \
 && rustup toolchain install nightly \
# From the libra circleci yaml
 && rustup component add clippy rustfmt \
 && cargo install --force grcov \
# This is what the current libra code does at the very beginning
 && rustup install 1.43.1-x86_64-unknown-linux-gnu \
# Cleanup
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
