# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

# This was created after cloning verilator and then:
# autoconf && ./configure --prefix=/usr && make -j && make DESTDIR=`readlink -f verilator` install
ADD verilator/usr/ /usr/

RUN set -x \
# Get Crave, clone verilator stable branch, compile verilator using crave, download output
# && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
# && git clone -b stable https://github.com/verilator/verilator.git verilator \
# && cd verilator && ../crave run --clean 'set -x ; autoconf && ./configure --prefix=/usr && make -j && make DESTDIR=`readlink -f pack` install' 2>&1 >/tmp/op.txt \
# && cat /tmp/op.txt \
# && ../crave pull pack \
# Move contents of output into the container
# && sudo rsync -a pack/ / \
# Cleanup verilator clone
# && cd .. & rm -rf verilator crave \
# Download and install the Freedon Tools riscv tools
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
