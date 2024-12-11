# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM ubuntu:22.04 AS crave
RUN set -x \
# Install curl and wget: so that we can get crave
 && apt-get update \
 && apt-get install -y curl wget \
# call the get_crave.sh script to get the crave binary
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
 && mv crave /tmp/

FROM ubuntu:22.04
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

RUN set -x \
# Defaults to run crave
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y eatmydata \
 && eatmydata apt-get install -y \
    git \
    openssh-client \
    rsync \
# Clean up image
 && eatmydata apt-get clean \
 && rm -f /var/lib/apt/lists/*_dists_*

COPY --from=crave /tmp/crave /usr/local/bin
ENTRYPOINT ["/usr/local/bin/crave"]
