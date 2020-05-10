# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/openjdk:11
MAINTAINER Crave.io Inc. "contact@crave.io"

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
# Prep ant with ivy
 && cd /home/admin/.ant/lib \
 && wget https://repo1.maven.org/maven2/org/apache/ivy/ivy/2.4.0/ivy-2.4.0.jar \
# Cleanup apt cache
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
