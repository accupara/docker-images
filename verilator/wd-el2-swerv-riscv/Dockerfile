# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# Stage 1
FROM accupara/verilator_build:ubuntu_2004 AS stage1
# Get Crave, clone verilator stable branch, compile verilator using crave, download output
RUN set -x \
### Get and compile verilator
 && cd /tmp \
# clone verilator stable branch
 && git clone https://github.com/verilator/verilator.git verilator \
# Get Crave
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
# compile verilator
 && cd verilator \
 && ../crave run --clean 'set -x ; autoconf && ./configure --prefix=/usr && make -j && make DESTDIR=`readlink -f pack` install' \
 && ../crave pull pack -d /tmp/ \
 && ls -lrt /tmp/

FROM accupara/ubuntu:20.04
COPY --from=stage1 /tmp/pack /tmp/

RUN set -x \
 && ls -lrt /tmp/ \
 && sudo apt-get update \
 && sudo apt-get install -y \
    libbit-vector-perl \
### Copy the contents of the pack from stage 1 into this container
 && sudo rsync -av /tmp/usr / \
 && sudo rm -rf /tmp/usr \
### Download and install the Freedon Tools riscv tools
 && cd /tmp && wget -q https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
 && tar -xf riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
 && cd riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14 \
 && sudo rsync -a bin include lib libexec python riscv64-unknown-elf share /usr/ \
 && cd /tmp && ls -l ; find riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14 -delete \
 && rm riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
# Minimize image
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
