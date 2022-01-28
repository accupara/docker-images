# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

RUN sudo apt-get update \
 && sudo apt-get install -y \
    python3-certbot-dns-route53 \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
