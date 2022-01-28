# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/centos:7 as remake
RUN set -x \
 && sudo yum update -y \
 && sudo yum install -y \
    flex \
    glibc-devel.i686 \
    gettext-devel \
    guile-devel \
    libgcc.i686 \
    perl \
    readline-devel \
    svn \
    texinfo \
    texinfo-tex \
    zip \
# Download and install the latest gcc
 && mkdir ~/GCC-source && cd ~/GCC-source \
 && svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_9_2_0_release/ >/dev/null \
 && cd gcc_9_2_0_release/ \
 && ./contrib/download_prerequisites \
 && mkdir ../gcc_9_2_0_release-build \
 && cd ../gcc_9_2_0_release-build \
 && ../gcc_9_2_0_release/configure --disable-multilib \
 && make -j `nproc` \
 && sudo make install \
# Download and install automake
 && cd /home/admin \
 && wget -q --no-check-certificate https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.gz \
 && tar -xf automake-1.16.5.tar.gz \
 && cd automake-1.16.5 \
 && ./configure --prefix=/usr \
 && make -j `nproc` \
 && sudo make install

RUN set -x \
# Get the remake sources for 4.3 and compile them
 && cd /home/admin \
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && ./autogen.sh \
 && make -j `nproc` \
 && mv ./make /tmp/
