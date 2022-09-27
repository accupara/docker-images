# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
IMGTAG?=accupara/devspace
IMGVER?=latest

include $(shell git rev-parse --show-toplevel)/Makefile.build

it_vnc:
	docker run \
		--rm -it \
		-v ~/:/tmp/home \
		--security-opt seccomp=./seccomp-allow-all.json \
		accupara/devspace:latest \
		bash -c "sudo service supervisor start ; bash"

# --security-opt seccomp=./newdefault.json \
#		--security-opt seccomp=unconfined \
