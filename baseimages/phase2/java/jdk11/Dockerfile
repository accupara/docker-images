# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM eclipse-temurin:11-jdk-centos7 as jdk
FROM accupara/debian:10

ENV JAVA_HOME=/opt/java/openjdk \
    PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY --from=jdk /opt/java/openjdk /opt/java/openjdk