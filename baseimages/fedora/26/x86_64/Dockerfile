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
 && useradd -ms /bin/bash dcuser \
 && echo "dcuser:dcuser" | chpasswd \
 && usermod -a -G wheel dcuser \
 && echo "dcuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dcuser
ENV HOME=/home/dcuser USER=dcuser
WORKDIR /home/dcuser
CMD /bin/bash

RUN sudo chown -R dcuser:dcuser /home/dcuser \
 && echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/dcuser/.bashrc
