# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM golang:1.12-stretch
MAINTAINER Crave.io Inc. "contact@crave.io"

ENV lsb_release_env="stretch"
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
        git \
        lsb-release \
        openssh-server \
        rsync \
        subversion \
        sudo \
        vim-nox \
# Cleanup the apt cache
 && apt-get clean \
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
