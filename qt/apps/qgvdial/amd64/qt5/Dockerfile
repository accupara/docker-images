# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM accupara/qt5:latest
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        libtelepathy-qt5-dev \
        perl \
        qt5-default
