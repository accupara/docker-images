# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM golang:1.22-bullseye
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

ENV GIT_VER=2.45.1 \
    GIT_LFS_VER=3.5.1 \
    lsb_release_env="bullseye"

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && set -x \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        bash-completion \
        binutils \
        build-essential \
        debhelper \
        dh-make \
        eatmydata \
        git \
        jq \
        lsb-release \
        openssh-server \
        rsync \
        subversion \
        sudo \
        vim-nox \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
# Install the latest git
 && eatmydata apt-get install -y \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
# Make sure to install git-lfs the direct way. no mucking around with apt
 && cd /tmp/dl \
 && arch="$(uname -m)"; \
       case "$arch" in \
              x86_64)  lfsArch='amd64' ;; \
              aarch64) lfsArch='arm64' ;; \
              ppc64le) lfsArch='ppc64le' ;; \
              s390x) lfsArch='s390x' ;; \
              *) echo >&2 "error: unsupported architecture ($arch)"; exit 1 ;;\
       esac \
 && wget -q https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VER}/git-lfs-linux-$arch-v${GIT_LFS_VER}.tar.gz \
 && tar -xf git-lfs-linux-$arch-v${GIT_LFS_VER}.tar.gz \
 && cd git-lfs-${GIT_LFS_VER} \
 && ./install.sh \
# Cleanup the image
 && cd /tmp \
 && find /tmp/dl -delete \
 && eatmydata apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_* \
# bash completion, non-root user and sshd config
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
# bash completion for non-root user and a skeleton ssh directory
 && sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
# Create some default directories:
 && sudo mkdir -p $GOPATH/src/github.com \
# change the ownership on the $GOPATH
 && sudo chown -R admin:admin $GOPATH

EXPOSE 22
