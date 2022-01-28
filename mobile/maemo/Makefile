# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
IMGTAG?=accupara/maemo
IMGVER?=latest
CONTAINER_NAME=maemo-build

include $(shell git rev-parse --show-toplevel)/Makefile.cleanpushpull

build:
	-docker rm $(CONTAINER_NAME)
	docker run \
		--privileged -it \
		--name $(CONTAINER_NAME) \
		-v $$(readlink -f ./setup.sh):/tmp/setup.sh \
		-v $$(readlink -f ./dh_make):/tmp/dh_make \
		-v $$(readlink -f ./usr_share_debhelper):/tmp/usr_share_debhelper \
		-v $$(readlink -f ./nokia.list):/tmp/nokia.list \
		-v $$(readlink -f ./extras.list):/tmp/extras.list \
		accupara/scratchbox \
		/tmp/setup.sh
	docker commit $(CONTAINER_NAME) $(IMGTAG):$(IMGVER)
	docker rm $(CONTAINER_NAME)

try:
	docker run \
		--privileged -it \
		--name $(CONTAINER_NAME) \
		-v $$(readlink -f ./setup.sh):/tmp/setup.sh \
		-v $$(readlink -f ./nokia.list):/tmp/nokia.list \
		-v $$(readlink -f ./extras.list):/tmp/extras.list \
		accupara/scratchbox
