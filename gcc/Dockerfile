# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN sudo apt-get update && \
    sudo apt-get install -y \
    g++ make gawk wget

RUN mkdir tarballs && cd tarballs && \
    wget http://ftpmirror.gnu.org/binutils/binutils-2.24.tar.gz           && \
    wget http://ftpmirror.gnu.org/gcc/gcc-4.9.2/gcc-4.9.2.tar.gz          && \
    wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.17.2.tar.xz && \
    wget http://ftpmirror.gnu.org/glibc/glibc-2.20.tar.xz                 && \
    wget http://ftpmirror.gnu.org/mpfr/mpfr-3.1.2.tar.xz                  && \
    wget http://ftpmirror.gnu.org/gmp/gmp-6.0.0a.tar.xz                   && \
    wget http://ftpmirror.gnu.org/mpc/mpc-1.0.2.tar.gz                    && \
    wget ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-0.12.2.tar.bz2      && \
    wget ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz

RUN for f in `ls tarballs/*.tar*`; do tar xf $f; done && \
    cd gcc-4.9.2 && \
    ln -s ../mpfr-3.1.2 mpfr && \
    ln -s ../gmp-6.0.0 gmp && \
    ln -s ../mpc-1.0.2 mpc && \
    ln -s ../isl-0.12.2 isl && \
    ln -s ../cloog-0.18.1 cloog
