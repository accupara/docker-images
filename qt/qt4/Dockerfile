# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
        libphonon-dev \
        libqt4-dev \
        libqtwebkit-dev \
        libssl-dev

