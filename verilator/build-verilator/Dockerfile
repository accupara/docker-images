# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

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
# Download and install the Freedon Tools riscv tools
# && cd /tmp && wget -q https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
# && tar -xf riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
# && cd riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14 \
# && sudo rsync -a bin include lib libexec python riscv64-unknown-elf share /usr/ \
# && cd /tmp && ls -l ; find riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14 -delete \
# && rm riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
# Minimize image
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
