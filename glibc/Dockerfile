# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
        bison \
        gawk \
        gettext \
        openssl \
        python3 \
        texinfo \
        wget \
# Cleanup apt cache
 && sudo eatmydata apt-get clean
