# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

IMGTAG?=accupara/harmattan
IMGVER?=latest
CONTAINER_NAME=harmattan-build

include $(shell git rev-parse --show-toplevel)/Makefile.cleanpushpull

build:
	docker run \
		--privileged -it \
		--name $(CONTAINER_NAME) \
		-v $$(readlink -f ./setup.sh):/tmp/setup.sh \
		accupara/scratchbox \
		/tmp/setup.sh
	docker commit $(CONTAINER_NAME) $(IMGTAG):$(IMGVER)
	docker rm $(CONTAINER_NAME)

try:
	docker run \
		--privileged -it \
		--name $(CONTAINER_NAME) \
		-v $$(readlink -f ./setup.sh):/tmp/setup.sh \
		accupara/scratchbox
