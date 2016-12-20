# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM accupara/ubuntu:14.04
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

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
     xserver-xephyr && \
    sudo /scratchbox/sbin/sbox_adduser admin && \
    sudo newgrp sbox && sudo newgrp

#RUN sudo /scratchbox/sbin/sbox_ctl start && \
#    wget http://repository.maemo.org/stable/5.0/maemo-sdk-install_5.0.sh && \
#    sed -i -e 's/etch/squeeze/g' maemo-sdk-install_5.0.sh && \
#    sh ./maemo-sdk-install_5.0.sh
