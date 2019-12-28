# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    build-essential \
# Clone the ceph repo and run the install-deps.sh script. This does all the heavy lifting
 && cd /tmp/ && git clone https://github.com/ceph/ceph.git \
 && cd ceph && sudo ./install-deps.sh \
## Clean up after ourselves
 && cd .. && rm -rf ceph \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
