# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/openjdk:11

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
# Add a gradlew properties with some defaults
# && mkdir -p /home/admin/.gradle \
# && echo "org.gradle.jvmargs=-Xmx4096M" > /home/admin/.gradle/gradle.properties \
# Cleanup apt cache
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
