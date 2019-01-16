# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get install -y \
        openjdk-8-jdk \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
