# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

# Compile remake and rsync on the fly and keep it ready for the next stage
## Chicken or egg : Which came first?
FROM accupara/ubuntu:14.04 as remake
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        autopoint \
        guile-2.0-dev \
        texinfo \
# Fetch gettext sources and compile them
 && wget -q --no-check-certificate https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz \
 && tar -xf gettext-0.21.tar.gz \
 && cd gettext-0.21 \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
# Get the remake sources for 4.3 and compile them
 && git clone https://github.com/rocky/remake.git remake \
 && cd remake \
 && ./autogen.sh \
 && ./configure --enable-maintainer-mode \
 && make -j `nproc` \
 && mv ./make /tmp/

# The binary generated from this step works in centos 6 and 7, and ubuntu 14.04,16.04,18.04,20.04. It does not work in 22.04
FROM accupara/centos:6 as rsync
RUN set -x \
 && sudo yum update -y \
 && sudo yum install -y \
    glibc-static \
    popt-static \
    libzstd-devel \
    libzstd-static \
    lz4-devel \
    lz4-static \
    openssl-static \
 && export RSYNC_VER=3.2.5 \
 && curl https://download.samba.org/pub/rsync/src/rsync-3.2.5.tar.gz -o rsync-${RSYNC_VER}.tar.gz \
 && tar -xf rsync-${RSYNC_VER}.tar.gz \
 && cd rsync-${RSYNC_VER} \
 && ./configure --prefix=/tmp/rsync --disable-xxhash \
# This command fails because of the stupid way the linker needs the correct order, but the Makefile isn't written in a way to support that.
 && make -j `nproc` CFLAGS="-static" LDFLAGS="-L/usr/lib64 -ldl" \
# So this command fixes the order of the LDFLAGS
 ;  gcc -std=gnu99 -static -o rsync \
        flist.o rsync.o generator.o receiver.o cleanup.o sender.o exclude.o util1.o util2.o main.o checksum.o match.o syscall.o log.o \
        backup.o delete.o options.o io.o compat.o hlink.o token.o uidlist.o socket.o hashtable.o usage.o fileio.o batch.o clientname.o \
        chmod.o acls.o xattrs.o progress.o pipe.o params.o loadparm.o clientserver.o access.o connection.o authenticate.o lib/wildmatch.o \
        lib/compat.o lib/snprintf.o lib/mdfour.o lib/md5.o lib/permstring.o lib/pool_alloc.o lib/sysacls.o lib/sysxattrs.o  zlib/deflate.o \
        zlib/inffast.o zlib/inflate.o zlib/inftrees.o zlib/trees.o zlib/zutil.o zlib/adler32.o zlib/compress.o zlib/crc32.o  \
        -lpopt -llz4 -lzstd -lcrypto \
        -L/usr/lib64 -ldl \
 && make install \
 && strip /tmp/rsync/bin/rsync

################## The real container starts here ################## 
FROM ubuntu:14.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# Install the minimum tools
RUN set -x \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        bash-completion \
        binutils \
        build-essential \
        curl \
        debhelper \
        devscripts \
        dh-make \
        emacs \
        gettext \
        guile-2.0 \
        jq \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libpopt0 \
        libssl-dev \
        locales \
        lsb-release \
        multitail \
        ninja-build \
        openssh-server \
        psmisc \
        # install rsync because it allows the updated rsync to work correctly
        rsync \
        subversion \
        sudo \
        tmux \
        vim-nox \
        unzip \
# Make sure to install git-lfs
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
 && apt-get install -y git-lfs \
# Install the latest git
 && sudo apt-get install -y \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
 && export GIT_VER=2.38.2 \
 && cd /tmp && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
 && cd /tmp ; sudo rm -rf v${GIT_VER}.tar.gz git-${GIT_VER}* \
# Install the latest version of gradle
 && cd /tmp \
 && export GRADLE_VER=7.5.1 \
 && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip \
 && unzip gradle-${GRADLE_VER}-bin.zip \
 && sudo mv gradle-${GRADLE_VER} /usr/lib/ \
 && sudo ln -sf /usr/lib/gradle-${GRADLE_VER}/bin/gradle /usr/bin/gradle \
 && rm gradle-${GRADLE_VER}-bin.zip \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -O /etc/crave/create_build_tools_json.sh https://raw.githubusercontent.com/accupara/docker-images/master/baseimages/shared/create_build_tools_json.sh \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Clean up image
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_* \
# Bash completion and admin in sudoers
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir -p /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config

USER admin
ENV HOME=/home/admin USER=admin TERM=xterm
WORKDIR /home/admin
CMD /bin/bash

RUN set -x \
 && sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/*

# Copy these at the very end
COPY --from=remake /tmp/make /usr/bin/remake
COPY --from=rsync  /tmp/rsync/bin/rsync /tmp/rsync/bin/rsync-ssl /usr/bin/

EXPOSE 22
