# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

ENV RUSTUP_HOME=/opt/rustup \
    CARGO_HOME=/opt/cargo \
    PATH=/opt/cargo/bin:$PATH

# Install the minimum tools
SHELL ["/bin/bash", "-c"]
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update \
 && sudo mkdir -p $RUSTUP_HOME $CARGO_HOME \
 && sudo chown admin:admin $RUSTUP_HOME $CARGO_HOME \
 && cd /tmp \
 && wget -q "https://static.rust-lang.org/rustup/dist/$(if [ "$(uname -m)" == "ppc64le" ]; then echo "powerpc64le" ; else echo "$(uname -m)"; fi )-unknown-linux-gnu/rustup-init" \
 && chmod +x rustup-init \
 && eatmydata ./rustup-init -y --no-modify-path --default-toolchain nightly \
 && sudo chmod -R a+w $RUSTUP_HOME $CARGO_HOME \
 && eatmydata rustup --version \
 && eatmydata cargo --version \
 && eatmydata rustc --version \
# Add the rustc compiler into the build tools list
 && /etc/crave/create_build_tools_json.sh /opt/cargo/bin \
# Cleanup
 && sudo eatmydata apt-get clean \
 && sudo eatmydata rm -f /var/lib/apt/lists/*_dists_* \
 && rm /tmp/rustup-init
