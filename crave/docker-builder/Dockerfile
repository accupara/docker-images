# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu-dind:latest

COPY docker-build-helper.sh /usr/bin/

RUN set -x \
 # Add the yq tool from the releases at https://github.com/mikefarah/yq
 && wget -q -O yq https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_amd64 \
 && chmod +x yq \
 && sudo mv yq /usr/bin/ \
# Install the jfrog tool: https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/install
 && wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog\_public\_gpg.key | sudo apt-key add - \
 && echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list \
 && sudo apt-get update \
 && sudo apt-get install -y jfrog-cli-v2 \
# Then install htop and bmon
 && sudo apt-get install -y \
 	bmon \
 	htop \
 && sudo python3 -m pip install \
  	pick \
 	python-dateutil \
	ratelimiter \
	tzlocal \
# Cleanup
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
