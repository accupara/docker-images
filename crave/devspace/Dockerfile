# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && mkdir -p /tmp/grpcurl_download \
 && LOCATION=$(curl -s https://api.github.com/repos/fullstorydev/grpcurl/releases/latest \
       | grep "tag_name" \
       | awk '{print "https://github.com/fullstorydev/grpcurl/releases/download/v" substr($2, 3, length($2)-4) "/grpcurl_" substr($2, 3, length($2)-4) "_linux_x86_64.tar.gz"}') \
 && curl -L $LOCATION | tar xvz -C /tmp/grpcurl_download \
 && sudo cp /tmp/grpcurl_download/grpcurl /usr/bin \
 && rm -rf /tmp/grpcurl_download \
 # Get the latest version of repo
 && curl https://storage.googleapis.com/git-repo-downloads/repo >/tmp/repo \
 && sudo mkdir /opt/aosp \
 && sudo chown admin:admin /opt/aosp \
 && sudo mv /tmp/repo /usr/bin/repo \
 && sudo chmod +x /usr/bin/repo \
 # Remove python 2 completely
 && sudo apt-get purge -y python python2.7 \
 && sudo apt-get -y autoremove \
 # Use python3 as the default python
 && sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
 # Make sure that the default version of python is 3
 && if [ $(python --version | grep -c 'Python 3') -eq "0" ] ; then exit 1 ; fi
