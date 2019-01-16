# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM ubuntu:17.10
MAINTAINER Crave.io Inc. "contact@crave.io"

# Install the minimum tools
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get install -y \
        bash-completion \
        binutils \
        build-essential \
        debhelper \
        dh-make \
        git \
        lsb-release \
        subversion \
        sudo \
        vim-nox \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_* \
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && adduser admin sudo \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER admin
ENV HOME=/home/admin USER=admin
WORKDIR /home/admin
CMD /bin/bash

RUN sudo chown -R admin:admin /home/admin \
 && echo ". /etc/bash_completion" >> /home/admin/.bashrc \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc
