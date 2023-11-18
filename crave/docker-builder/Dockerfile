# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu-dind:latest

COPY docker-build-helper.sh /usr/bin/

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
 	htop \
 && sudo python3 -m pip install \
  	pick \
 	python-dateutil \
	ratelimiter \
	tzlocal \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
