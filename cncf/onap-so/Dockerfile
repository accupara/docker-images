# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
# Install OpenJDK 8 and maven
 && sudo apt-get install -y \
        maven \
        openjdk-8-jdk \
# Uninstall 11 because only 8 has some plugins required for compilation
 && sudo apt-get purge -y openjdk-11-jre-headless \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
