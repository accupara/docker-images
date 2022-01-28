# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
IMGTAG?=accupara/crave
IMGVER?=latest
GITROOT=$(shell git rev-parse --show-toplevel)
GITBR=$(shell git rev-parse --abbrev-ref HEAD)

CRAVE_CONFIG?=/home/uv/code/crave.internal.crave.conf

ifndef CRAVE_BIN
	# This code can not be part of Dockerfile as we need crave version to be used as docker image tag
	CRAVE_LATEST_VERSION=$(shell curl -s https://api.github.com/repos/accupara/crave/releases/latest | jq -r '.tag_name'|awk '{print $$1}')
	CRAVE_DOWNLOAD_URL=https://github.com/accupara/crave/releases/download/${CRAVE_LATEST_VERSION}/crave-${CRAVE_LATEST_VERSION}-Linux-amd64.bin
endif

include ${GITROOT}/Makefile.build

# These targets are customized for crave as Image tag is mapped to crave version
crave-build: ensure_crave_version
	-rm -f bin/crave
	mkdir -p bin
ifndef CRAVE_BIN
	curl -L -s -k -4 -f -o 'bin/crave' '${CRAVE_DOWNLOAD_URL}'
else
	cp -f ${CRAVE_BIN} bin/crave
endif
	chmod +x bin/crave
	${MAKE} clean IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64
	${MAKE} build IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64

crave-push-tag: ensure_crave_version
	# This target is needed if we need to just push the tag and not latest 
	${MAKE} push IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64

doitall: ensure_crave_version
	${MAKE} crave-build
	${MAKE} testitall
	# Execute below targets only if tests are passed
	${MAKE} crave-push-tag
	${MAKE} tag-latest IMGVER=${CRAVE_LATEST_VERSION}-Linux-amd64
	${MAKE} push IMGVER=latest

test_template:
	docker run --rm -it -e CRAVE_CONFIG="$$(cat ${CRAVE_CONFIG})" accupara/crave:${CRAVE_LATEST_VERSION}-Linux-amd64 ${CMD}

testitall:
	${MAKE} test_template CMD="ls"
	${MAKE} test_template CMD="crave list"

ensure_crave_version:
ifndef CRAVE_LATEST_VERSION
ifdef CRAVE_BIN
	@echo "CRAVE_LATEST_VERSION variable is needed when CRAVE_BIN variable is specified."
	exit 1
else
	@echo "Failed to get latest crave version from github.com"
endif
endif
