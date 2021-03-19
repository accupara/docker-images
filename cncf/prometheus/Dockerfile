# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/golang:1.15-buster
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
 && curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
 && sudo apt-get install -y nodejs \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
 && sudo apt-get update \
 && sudo apt-get install -y \
    yarn
