# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && mkdir -p /tmp/grpcurl_download \
 && LOCATION=$(curl -s https://api.github.com/repos/fullstorydev/grpcurl/releases/latest \
       | grep "tag_name" \
       | awk '{print "https://github.com/fullstorydev/grpcurl/releases/download/v" substr($2, 3, length($2)-4) "/grpcurl_" substr($2, 3, length($2)-4) "_linux_x86_64.tar.gz"}') \
 && curl -L $LOCATION | tar xvz -C /tmp/grpcurl_download \
 && sudo cp /tmp/grpcurl_download/grpcurl /usr/bin \
 && rm -rf /tmp/grpcurl_download
