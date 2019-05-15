# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        autoconf \
        automake \
        bc \
        bison \
        flex \
        libelf-dev \
        libncurses5-dev \
        libssl-dev \
        openssl \
        perl \
        cpio
