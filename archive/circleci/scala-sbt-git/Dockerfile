# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM codestar/circleci-scala-sbt-git:latest
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.email="contact@crave.io"

# Just add the libc6 compat
RUN apk add --update libc6-compat
