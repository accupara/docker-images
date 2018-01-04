# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/qt4:linux
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        libcurl4-openssl-dev \
        libboost-dev \
        libhunspell-dev \
        libopencv-dev \
        libpoppler-qt4-dev

