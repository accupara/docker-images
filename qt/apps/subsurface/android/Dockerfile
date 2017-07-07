# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/android
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update

# libgit2-dev has to be installed after the rest
RUN sudo apt-get install -y \
    autoconf \
    automake \
    cmake \
    g++ \
    git \
    make \
    pkg-config \
 && sudo apt-get install -y \
    libgit2-dev
