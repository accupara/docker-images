# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        autoconf \
        automake \
        bc \
        libelf-dev \
        libncurses5-dev \
        libssl-dev \
        openssl \
        perl \
        wget

RUN wget ftp://ftp.denx.de/pub/eldk/5.6/install.sh && chmod +x install.sh \
 && mkdir -p targets/armv4t && cd targets/armv4t && wget -nv ftp://ftp.denx.de/pub/eldk/5.6/targets/armv4t/* && cd ../../ \
 && sudo ./install.sh -s toolchain -r - armv4t \
 && rm -rf targets
