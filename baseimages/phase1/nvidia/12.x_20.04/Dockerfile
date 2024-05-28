# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM nvidia/cuda:12.2.2-devel-ubuntu20.04

COPY sshd_config /tmp/

# For Git: https://mirrors.edge.kernel.org/pub/software/scm/git/
ENV GIT_VER=2.45.1 \
    GIT_LFS_VER=3.5.1 \
    GRADLE_VER=8.4

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        bash-completion \
        binutils \
        build-essential \
        curl \
        debhelper \
        dh-make \
        git \
        jq \
        locales \
        lsb-release \
        openssh-server \
        rsync \
        subversion \
        sudo \
        vim-nox \
        wget \
# Create a directory for all the compiled things
 && mkdir -p /tmp/dl \
# Install the latest git
 && sudo apt-get install -y \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
 && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all -j `nproc` \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
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
 && wget -q https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VER}/git-lfs-linux-$lfsArch-v${GIT_LFS_VER}.tar.gz \
 && tar -xf git-lfs-linux-$lfsArch-v${GIT_LFS_VER}.tar.gz \
 && cd git-lfs-${GIT_LFS_VER} \
 && ./install.sh \
# Store the build tools script into a well known directory
 && mkdir -p /etc/crave \
 && wget -q -O /etc/crave/create_build_tools_json.sh https://github.com/accupara/docker-images/blob/master/baseimages/shared/create_build_tools_json.sh?raw=true \
 && chmod +x /etc/crave/create_build_tools_json.sh \
# Add admin user and add it to sudoers
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
# Configure sshd
 && mkdir -p /var/run/sshd \
 && mv /tmp/sshd_config /etc/ssh/sshd_config \
# Clean up image
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && cd /tmp && sudo find dl -delete \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

USER admin
ENV HOME=/home/admin \
    USER=admin \
    TERM=xterm \
    LANG=en_US.utf8
WORKDIR /home/admin
CMD /bin/bash

RUN set -x \
# bashrc, ssh directory, completions, etc.
 && sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/* \
# locale setup
 && sudo locale-gen en_US.UTF-8 \
 && sudo update-locale LANG=en_US.UTF-8 \
# Export env vars
 && echo "export LC_ALL=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANG=en_US.UTF-8" >> /home/admin/.bashrc \
 && echo "export LANGUAGE=en_US.UTF-8" >> /home/admin/.bashrc \
# Initialize LFS
 && git lfs install

EXPOSE 22
