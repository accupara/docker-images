# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM bitriseio/docker-android:latest
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.0 | grep 'package installed'
