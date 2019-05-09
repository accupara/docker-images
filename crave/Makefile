# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
IMGTAG?=accupara/crave
IMGVER?=latest
GITROOT=$(shell git rev-parse --show-toplevel)
GITBR=$(shell git rev-parse --abbrev-ref HEAD)

# This code can not be part of Dockerfile as we need crave version to be used as docker image tag
CRAVE_LATEST_VERSION=$(shell curl -s https://api.github.com/repos/accupara/crave/releases/latest | jq -r '.tag_name'|awk '{print $$1}')
CRAVE_DOWNLOAD_URL=https://github.com/accupara/crave/releases/download/${CRAVE_LATEST_VERSION}/crave-${CRAVE_LATEST_VERSION}-Linux-amd64.bin

include ${GITROOT}/Makefile.build

# These targets are customized for crave as Image tag is mapped to crave version
crave-build:
	-rm -f bin/crave
	mkdir -p bin
	curl -L -s -k -4 -f -o 'bin/crave' '${CRAVE_DOWNLOAD_URL}'
	chmod +x bin/crave
	${MAKE} clean IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64
	${MAKE} build IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64

crave-push:
	${MAKE} push IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64

crave-tag-latest:
	${MAKE} tag-latest IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64
	${MAKE} push IMGVER=latest

doitall:
	${MAKE} crave-build
	${MAKE} crave-push
	${MAKE} crave-tag-latest

testruncmd:
	docker run --rm -it -e CRAVE_CONFIG="$$(cat /home/uv/code/crave.internal.crave.conf)" accupara/crave:latest ${CMD}

testitall:
	${MAKE} testruncmd CMD="ls"
	${MAKE} testruncmd CMD="list"
	${MAKE} testruncmd CMD="crave list"
