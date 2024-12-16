# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
IMGTAG?=accupara/ubuntu
IMGVER_BASE?=24.04

include $(shell git rev-parse --show-toplevel)/Makefile.build

pre_build:
	# Copy the users public key into the docker context
	cp $$(readlink -f ~/.ssh/id_rsa) .
	cp $$(readlink -f ~/.ssh/id_rsa.pub) .
