# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
       gnucobol4 \
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
