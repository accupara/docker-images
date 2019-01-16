# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:14.04

COPY startcmd.sh /tmp/

RUN sudo apt-get update \
 && sudo apt-get install -y \
        binutils \
        openssh-server \
        python-pip \
        xpra \
 && mkdir -p ~/.ssh/ \
 && echo "alias xpra_start='xpra control :100 start'" >> ~/.bashrc \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

CMD /tmp/startcmd.sh
EXPOSE 22
