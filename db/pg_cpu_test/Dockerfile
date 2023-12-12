# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
# Derive from postgress base container
FROM accupara/centos:7

RUN set -x \
 && sudo eatmydata yum update -y \
 && sudo eatmydata yum upgrade -y \
# Make a place for downloading things
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
# Clone the repo, copy the context files into the places specified in https://github.com/sebasmannem/pg_cpu_test/blob/master/pg_cpu_load_tester/Dockerfile
 && git clone https://github.com/sebasmannem/pg_cpu_test.git pg_cpu_test \
 && cd pg_cpu_test/pg_cpu_load_tester \
 && sudo cp sar.sh builder.sh run.sh pg_cpu_load_c7 loaddisplay.py / \
 && sudo chmod +x /builder.sh \
 && sudo /builder.sh \
# Clean up
 && cd /tmp \
 && sudo find /tmp/dl -delete