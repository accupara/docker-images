# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
IMGTAG?=accupara/pyinstaller
IMGVER?=centos_7_$(shell if [ "$(uname -a | grep -c x86)" == "1" ] ; then echo x86 ; else echo arm ; fi)

manifest:
	docker manifest create \
		accupara/pyinstaller:centos_7 \
		--amend accupara/pyinstaller:centos_7_x86 \
		--amend accupara/pyinstaller:centos_7_arm

include $(shell git rev-parse --show-toplevel)/Makefile.build
