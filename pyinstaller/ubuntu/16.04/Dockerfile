# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN sudo apt-get update \
 && sudo apt-get install -y \
    python3-dev \
    python3-pip \
    python3-setuptools \
 && sudo pip3 install --upgrade pip==18.0.0 \
 && sudo pip3 install --upgrade setuptools wheel \
 && sudo pip3 install --upgrade \
        autopep8 \
        boto3 \
        configparser \
        giturlparse.py \
        google-api-python-client \
        grpcio   \
        grpcio-tools \
        paramiko \
        pick \
        protobuf \
        pyinstaller \
        python-dateutil \
        requests \
        scp \
        tabulate \
        termcolor \
        tzdata \
        tzlocal \
        websocket-client
