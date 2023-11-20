# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM eclipse-temurin:11-jdk-centos7 as jdk
FROM accupara/debian:10

ENV JAVA_HOME=/opt/java/openjdk \
    PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# See https://hub.docker.com/_/eclipse-temurin
COPY --from=jdk /opt/java/openjdk /opt/java/openjdk

RUN set -x \
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
 && wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VER}/binaries/apache-maven-${MAVEN_VER}-bin.tar.gz -O maven.tar.gz \
 && tar -xf maven.tar.gz \
 && sudo mv apache-maven-${MAVEN_VER} /opt/java/maven \
# Now lets confirm that it actually works
 && mvn -v \
# Add some fonts
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    libfreetype6 \
# And then do the final bit of cleanup
 && cd /tmp \
 && sudo find dl -delete
