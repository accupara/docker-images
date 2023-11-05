# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM openjdk:18-jdk-bullseye
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        ant \
        bash-completion \
        binutils \
        build-essential \
        curl \
        debhelper \
        dh-make \
        git \
        jq \
        maven \
        openssh-server \
        rsync \
        subversion \
        sudo \
        vim-nox \
        wget \
# ANT needs these directories
 && mkdir -p /home/admin/.ant/lib \
# Install the latest git
 && sudo apt-get install -y \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
 && export GIT_VER=2.39.3 \
 && cd /tmp && wget -q --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VER}.tar.gz \
 && tar -xf git-${GIT_VER}.tar.gz \
 && cd git-${GIT_VER} \
 && make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true all \
 && sudo make prefix=/usr CFLAGS="-std=gnu99" NO_UNCOMPRESS2=true install \
 && cd /tmp ; sudo rm -rf v${GIT_VER}.tar.gz git-${GIT_VER}* \
# Add the crave binary into the base image
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
 && sudo mv crave /usr/local/bin/ \
# Cleanup apt cache
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_* \
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

RUN sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc \
 && mkdir /home/admin/.ssh \
 && chmod 700 /home/admin/.ssh \
 && touch /home/admin/.ssh/authorized_keys

EXPOSE 22
