# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
IMGTAG?=accupara/centos
IMGVER?=7_$(shell /bin/bash -c 'if [ "$(uname -a | grep -c x86)" = "1" ] ; then echo x86 ; else echo arm ; fi')

manifest:
	docker manifest create \
		accupara/centos:7 \
		--amend accupara/centos:7_x86 \
		--amend accupara/centos:7_arm

include $(shell git rev-parse --show-toplevel)/Makefile.build
