# Copyright (c) 2016 Accupara Inc. All rights reserved
IMGTAG?=accupara/maemo
IMGVER?=latest
CONTAINER_NAME=maemo-build
#IMGVER?=$(shell /bin/date "+%Y%m%d.%H%M%S")

include $(shell git rev-parse --show-toplevel)/Makefile.cleanpushpull

build:
	docker run \
		--privileged -it \
		--name $(CONTAINER_NAME) \
		-v $$(readlink -f ./setup.sh):/tmp/setup.sh \
		-v $$(readlink -f ./nokia.list):/tmp/nokia.list \
		-v $$(readlink -f ./extras.list):/tmp/extras.list \
		accupara/scratchbox \
		/tmp/setup.sh
	docker commit $(CONTAINER_NAME) accupara/maemo
	docker rm $(CONTAINER_NAME)

try:
	docker run \
		--privileged -it \
		--name $(CONTAINER_NAME) \
		-v $$(readlink -f ./setup.sh):/tmp/setup.sh \
		-v $$(readlink -f ./nokia.list):/tmp/nokia.list \
		-v $$(readlink -f ./extras.list):/tmp/extras.list \
		accupara/scratchbox
