# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/golang:1.24-bullseye

RUN set -x \
# Download the FerretDB sources and compile the task tool
 && export GIT_CLONE_PROTECTION_ACTIVE=false \
 && git clone https://github.com/FerretDB/FerretDB.git fdb \
 && cd fdb/tools \
 && go generate -x \
 && sudo mv ../bin/task /usr/bin
