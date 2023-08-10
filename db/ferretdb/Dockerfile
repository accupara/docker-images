# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/golang:1.21-bullseye

RUN set -x \
# Download the FerretDB sources and compile the task tool
 && git clone https://github.com/FerretDB/FerretDB.git fdb \
 && cd fdb/tools \
 && go generate -x \
 && sudo mv ../bin/task /usr/bin
