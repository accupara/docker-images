# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM bitriseio/docker-android:latest
MAINTAINER Abhijit Paithankar "ap@accupara.com"

RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.0 | grep 'package installed'
