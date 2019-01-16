# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

RUN sudo apt-get update \
 && sudo apt-get install -y \
    python3-pip \
    software-properties-common \
 && sudo add-apt-repository ppa:certbot/certbot \
 && sudo apt-get update \
 && sudo apt-get install -y certbot \
 && sudo pip3 install --upgrade pip \
 && sudo pip3 install --upgrade certbot_dns_route53
