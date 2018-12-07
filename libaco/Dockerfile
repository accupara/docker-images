# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install --no-install-recommends -y  \
    build-essential     \
    gcc-multilib        \
    libpcap-dev         \
    linux-headers-generic \
    valgrind \
    && sudo rm -rf /var/lib/apt/lists/*
