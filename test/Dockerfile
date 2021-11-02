# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
# Compile remake on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/centos:6

RUN set -x \
 && sudo yum update \
 && sudo yum install -y \
    flex \
    glibc-devel.i686 \
    gmp \
    libgcc.i686 \
    libunistring \
    perl \
    readline-devel \
    svn \
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
 && sudo make install

RUN set -x \
# Fetch gettext sources and compile them
 && cd /home/admin \
 && wget -q --no-check-certificate https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz \
 && tar -xf gettext-0.21.tar.gz \
 && cd gettext-0.21 \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
# Download and install autoconf
 && cd /home/admin \
 && wget -q --no-check-certificate https://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz \
 && tar -xf autoconf-2.71.tar.gz \
 && cd autoconf-2.71 \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
# Download and install automake
 && cd /home/admin \
 && wget -q --no-check-certificate https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.gz \
 && tar -xf automake-1.16.5.tar.gz \
 && cd automake-1.16.5 \
 && ./configure --prefix=/usr \
 && make -j `nproc` \
 && sudo make install \
# Download and install pkg-config
 && cd /home/admin \
 && wget -q --no-check-certificate https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz \
 && tar -xf pkg-config-0.29.2.tar.gz \
 && cd pkg-config-0.29.2 \
 && ./configure --with-internal-glib \
 && make -j `nproc` \
 && sudo make install

RUN set -x \
# Get the remake sources for 4.3 and compile them
 && cd /home/admin \
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && sed 's/AM_PROG_AR/m4_ifdef([AM_PROG_AR], [AM_PROG_AR])/g' configure.ac > configure.ac.new && mv configure.ac.new configure.ac \
 && grep -v AC_PREREQ configure.ac >configure.ac.new && mv configure.ac.new configure.ac \
 && ./autogen.sh --without-guile \
 && make -j `nproc` \
 && mv ./make /tmp/
