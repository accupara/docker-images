# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/openjdk:8

# Instructions copied from https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get install -y apt-transport-https \
 && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list \
 && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list \
 && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import \
 && sudo chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get install -y \
        sbt \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
