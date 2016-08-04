# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM accupara/qt4:latest
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        libqtwebkit-dev \
        libtelepathy-qt4-dev \
        perl \
        qt4-default
