# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/openjdk:11

ENV CASSANDRA_VER=4.1.2

# Instructions copied from https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
# Install emacs and nano... because "someone" hates vim with a passion :D
 && sudo apt-get update \
 && sudo apt-get install -y \
    emacs \
    nano \
# Download the correct version of cassandra tools
 && wget -q https://dlcdn.apache.org/cassandra/${CASSANDRA_VER}/apache-cassandra-${CASSANDRA_VER}-bin.tar.gz \
 && tar -xvf apache-cassandra-${CASSANDRA_VER}-bin.tar.gz \
 && rm apache-cassandra-${CASSANDRA_VER}-bin.tar.gz \
 && sudo mv apache-cassandra-${CASSANDRA_VER} /usr/local \
 && cd /usr/local/apache-cassandra-${CASSANDRA_VER}/bin \
# Symlink it into /usr/bin so that cassandra tools are accessible without $PATH changes
 && cd /usr/bin \
 && find ../local/apache-cassandra-4.1.0/bin/ -mindepth 1 -maxdepth 1 | \
       while read line ; do \
              sudo ln -sf $line ./$(basename $line) ; \
       done
