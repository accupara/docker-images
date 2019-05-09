# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM centos:6
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY bin/crave /usr/local/bin
COPY docker-entrypoint /

ENTRYPOINT [ "/docker-entrypoint" ]
CMD [ "/bin/sh" ]
