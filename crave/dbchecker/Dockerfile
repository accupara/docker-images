# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/golang:1.22-bullseye

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo apt-get update \
 && sudo apt-get install -y \
	vim-nox \
	postgresql-client \
	jq

COPY startup.sh /startup.sh
RUN sudo chmod a+x /startup.sh
ENTRYPOINT [ "/startup.sh" ]
