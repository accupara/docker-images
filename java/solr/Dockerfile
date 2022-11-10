# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/openjdk:18

# Install the minimum tools
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
# Prep ant with ivy
 && cd /home/admin/.ant/lib \
 && wget -q https://repo1.maven.org/maven2/org/apache/ivy/ivy/2.4.0/ivy-2.4.0.jar \
# Add a gradlew properties with some defaults
 && mkdir -p /home/admin/.gradle \
 && echo "org.gradle.jvmargs=-Xmx4096M" > /home/admin/.gradle/gradle.properties \
# Cleanup apt cache
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
