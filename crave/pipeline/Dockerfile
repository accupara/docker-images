# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM ubuntu:22.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

RUN set -x \
# Defaults to run crave
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y eatmydata \
 && eatmydata apt-get -y dist-upgrade \
 && eatmydata apt-get install -y \
    git \
    rsync \
    pigz \
    make \
    jq \
    curl \
    wget \
    gnupg2 \
    software-properties-common \
# Install awscli and gcloud
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
 && eatmydata apt-get -y update \
 && eatmydata apt-get -y install google-cloud-sdk awscli \
# install docker cli
 && curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-19.03.7.tgz -o /tmp/docker-cli.tgz \
 && tar -zxf /tmp/docker-cli.tgz --strip 1 -C /usr/local/bin/ docker/docker \
 && rm -rf /tmp/*.tgz \
 && chmod +x /usr/local/bin/docker \
# Clean up image
 && eatmydata apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

COPY bin/crave /usr/local/bin
