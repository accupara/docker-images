# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM ubuntu:18.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get -y dist-upgrade \
 && apt-get install -y \
    git \
    rsync \
    pigz \
    make \
    jq \
    curl \
    wget \
    gnupg2 \
    software-properties-common

# Install awscli and gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get -y update \
    && apt-get -y install google-cloud-sdk awscli

# install docker cli
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-19.03.7.tgz -o /tmp/docker-cli.tgz \
    && tar -zxf /tmp/docker-cli.tgz --strip 1 -C /usr/local/bin/ docker/docker \
    && rm -rf /tmp/*.tgz \
    && chmod +x /usr/local/bin/docker

COPY bin/crave /usr/local/bin
