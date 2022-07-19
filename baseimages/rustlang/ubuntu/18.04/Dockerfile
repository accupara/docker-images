# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

ENV RUSTUP_HOME=/opt/rustup \
    CARGO_HOME=/opt/cargo \
    PATH=/opt/cargo/bin:$PATH

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get install -y \
    wget \
 && sudo mkdir -p $RUSTUP_HOME $CARGO_HOME \
 && sudo chown admin:admin $RUSTUP_HOME $CARGO_HOME \
 && cd /tmp \
 && wget -q "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init" \
 && chmod +x rustup-init \
 && ./rustup-init -y --no-modify-path --default-toolchain nightly \
 && sudo chmod -R a+w $RUSTUP_HOME $CARGO_HOME \
 && rustup --version \
 && cargo --version \
 && rustc --version \
# Add the rustc compiler into the build tools list
 && /etc/crave/create_build_tools_json.sh /opt/cargo/bin \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_* \
 && rm /tmp/rustup-init
