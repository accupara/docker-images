# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
MAINTAINER Crave.io Inc. "contact@crave.io"

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get install -y \
    wget \
 && cd /tmp \
 && url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init" \
 && wget "$url" \
 && chmod +x rustup-init \
 && sudo mkdir -p /usr/local/rustup /usr/local/cargo \
 && sudo chown admin:admin /usr/local/rustup /usr/local/cargo \
 && ./rustup-init -y --no-modify-path --default-toolchain nightly \
 && rm rustup-init \
 && sudo chmod -R a+w $RUSTUP_HOME $CARGO_HOME \
 && rustup --version \
 && cargo --version \
 && rustc --version
