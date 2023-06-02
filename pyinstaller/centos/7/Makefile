# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
IMGTAG?=accupara/pyinstaller
IMGVER_BASE?=centos_7

manifest:
	docker manifest create \
		accupara/pyinstaller:centos_7 \
		--amend accupara/pyinstaller:centos_7_x86 \
		--amend accupara/pyinstaller:centos_7_arm

include $(shell git rev-parse --show-toplevel)/Makefile.build
