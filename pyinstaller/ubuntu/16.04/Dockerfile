# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
   libffi-dev \
   python3-dev \
   python3-pip \
   python3-setuptools \
 && sudo python3 -m pip install --upgrade pip==18.0.0 \
 && sudo python3 -m pip install --upgrade setuptools wheel \
 && sudo python3 -m pip install --upgrade \
      autopep8 \
      boto3 \
      configparser \
      giturlparse.py \
      google-api-python-client \
      grpcio   \
      grpcio-tools \
      paramiko \
      pick \
      pyinstaller \
      python-dateutil \
      requests \
      scp \
      tabulate \
      termcolor \
      tzdata \
      tzlocal \
      websocket-client
