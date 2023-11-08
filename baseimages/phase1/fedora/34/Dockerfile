# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM fedora:34
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# Install the minimum set of tools
RUN set -x \
 && dnf update -y \
 && dnf -y install \
    bash-completion \
    file \
    git \
    gcc-c++ \
    jq \
    make \
    openssh-server \
    redhat-lsb-core \
    subversion \
    sudo \
    vim-enhanced \
    wget \
# Install compilation tools
 && dnf -y install @development-tools \
 && dnf -y group install "C Development Tools and Libraries" \
 && echo ". /etc/bash_completion" >> /root/.bashrc \
# Install the latest git
 && dnf -y install \ 
    expat-devel \
    gnutls-devel \
    libcurl-devel \
    openssl-devel \
    zlib-devel \
 && export GIT_VER=2.39.3 \
 && cd /tmp && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all -j `nproc` \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
 && cd /tmp ; sudo rm -rf v${GIT_VER}.tar.gz git-${GIT_VER}* \
# Non root user
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -a -G wheel admin \
# Add to sudoers
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && mkdir -p /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config

USER admin
ENV HOME=/home/admin USER=admin
WORKDIR /home/admin
CMD /bin/bash

RUN sudo chown -R admin:admin /home/admin \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys \
 && sudo chmod 0600 /etc/ssh/*

EXPOSE 22
