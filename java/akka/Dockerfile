# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/openjdk:8
MAINTAINER Crave.io Inc. "contact@crave.io"

# Install the minimum tools
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get install -y apt-transport-https \
 && echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list \
 && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get install -y \
        sbt \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
