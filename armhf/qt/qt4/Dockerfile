# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.04_arm32v7
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get -y install \
        libphonon-dev \
        libqt4-dev \
        libssl-dev

