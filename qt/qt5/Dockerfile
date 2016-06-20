# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get -y install \
        binutils \
        libphonon-dev \
        libqt5webkit5-dev \
        libqt5xmlpatterns5-dev \
        libssl-dev \
        qt5-default \
        qtmultimedia5-dev
