# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
# Install OpenJDK 8 and maven
 && sudo apt-get install -y \
        maven \
        openjdk-8-jdk \
# Uninstall 11 because only 8 has some plugins required for compilation
 && sudo apt-get purge -y openjdk-11-jre-headless \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
