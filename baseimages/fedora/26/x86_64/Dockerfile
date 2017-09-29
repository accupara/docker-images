# Copyright (c) 2017 Accupara Inc. All rights reserved
FROM fedora:26
MAINTAINER Accupara Inc. "contact@accupara.com"

# Install the minimum set of tools
RUN dnf -y install \
    git \
    gcc-c++ \
    make \
    sudo \
    file \
    subversion \
    bash-completion \
    vim-enhanced \
 && dnf -y install @development-tools \
 && dnf -y group install "C Development Tools and Libraries" \
 && echo ". /etc/bash_completion" >> /root/.bashrc \
 && useradd -ms /bin/bash admin \
 && echo "admin:admin" | chpasswd \
 && usermod -a -G wheel admin \
 && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER admin
ENV HOME=/home/admin USER=admin
WORKDIR /home/admin
CMD /bin/bash

RUN sudo chown -R admin:admin /home/admin \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc
