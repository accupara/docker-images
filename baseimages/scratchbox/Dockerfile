# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:14.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN sudo bash -c 'echo "deb http://scratchbox.org/debian/ hathor main" >> /etc/apt/sources.list' && \
    sudo apt-get update && \
    sudo apt-get install -y --allow-unauthenticated \
     scratchbox-core \
     scratchbox-devkit-apt-https \
     scratchbox-devkit-autotools-legacy \
     scratchbox-devkit-debian-squeeze \
     scratchbox-devkit-doctools \
     scratchbox-devkit-git \
     scratchbox-devkit-perl \
     scratchbox-devkit-python-legacy \
     scratchbox-devkit-qemu \
     scratchbox-devkit-svn \
     scratchbox-libs \
     scratchbox-toolchain-cs2007q3-glibc2.5-arm7 \
     scratchbox-toolchain-cs2007q3-glibc2.5-i486 \
     scratchbox-toolchain-host-gcc \
     wget \
     xserver-xephyr

ENV USER=admin

RUN sudo /scratchbox/sbin/sbox_adduser admin && \
    sudo newgrp sbox && sudo newgrp && \
    sudo mkdir -p /scratchbox/users/admin/home/admin && \
    sudo chown -R admin.admin /scratchbox/users/admin/home/admin && \
    sudo mkdir -p /scratchbox/users/admin/targets && \
    sudo chown -R admin.admin /scratchbox/users/admin/targets
