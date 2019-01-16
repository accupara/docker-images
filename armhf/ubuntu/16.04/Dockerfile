# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM arm32v7/ubuntu:16.04
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
        subversion \
        sudo \
        vim \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

RUN echo ". /etc/bash_completion" >> /root/.bashrc

CMD /bin/bash

RUN useradd -ms /bin/bash admin && \
    echo "admin:admin" | chpasswd && \
    adduser admin sudo && \
    echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER admin
ENV HOME /home/admin
WORKDIR /home/admin

RUN sudo chown -R admin:admin /home/admin
RUN echo ". /etc/bash_completion" >> /home/admin/.bashrc && \
    echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc
