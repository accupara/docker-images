# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/centos:7
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo yum -y update \
 && sudo yum install -y \
    yum-utils \
 && sudo yum-builddep \
    python3
