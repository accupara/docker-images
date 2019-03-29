# Copyright (c) 2019 Crave.io Inc. All rights reserved

# Take base of postgres
FROM postgres:alpine

# Apply accupara docker image standards base
FROM accupara/alpine:3.9
MAINTAINER Crave.io Inc. "contact@crave.io"

# Install dependancies for timescaledb
RUN sudo apk update \
    && sudo apk add --no-cache --virtual .build-deps \
       coreutils \
       dpkg-dev \
       findutils \
       gcc \
       libc-dev \
       make \
       util-linux-dev \
       diffutils \
       cmake \
       bison \
       flex \
       curl \
       git \
       openssl-dev \
       postgresql-dev \
       # below clang installs version 5, but we need 7. To be fixed in future
       clang \
    && sudo mkdir -p /build/debug /build/debug-nossl

# Install lcov from alpine edge repo
RUN sudo apk add --no-cache --virtual --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    --allow-untrusted \
       lcov
