# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
# Download the FerretDB sources and compile the task tool
 && git clone https://github.com/FerretDB/FerretDB.git fdb \
 && cd fdb/tools \
 && go generate -x \
 && sudo mv ../bin/task /usr/bin
