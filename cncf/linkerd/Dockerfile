# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Accupara Inc. "contact@accupara.com"

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
        openjdk-8-jdk \
 && apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*
