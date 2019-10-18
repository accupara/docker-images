# Copyright (c) 2019 Crave.io Inc. All rights reserved

# Take base of postgres
FROM postgres:alpine

# Apply accupara docker image standards base
FROM accupara/alpine:3.9
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY sshd_config /etc/ssh/sshd_config

# Install dependancies for timescaledb
RUN sudo apk update \
 && sudo apk add --no-cache --virtual .build-deps \
       bison \
       cmake \
       coreutils \
       curl \
       diffutils \
       dpkg-dev \
       findutils \
       flex \
       gcc \
       git \
       libc-dev \
       openssl-dev \
       postgresql-dev \
       make \
       util-linux-dev \
       # below clang installs version 5, but we need 7. To be fixed in future
       clang \
 && sudo mkdir -p /build/debug /build/debug-nossl \
# Install lcov from alpine edge repo
 && sudo apk add --no-cache --virtual --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    --allow-untrusted \
       lcov \
# Fix for not having sshd host keys.
 && sudo /usr/bin/ssh-keygen -A
