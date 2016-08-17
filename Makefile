# Copyright (c) 2016 Accupara Inc. All rights reserved

# DO NOT COMPILE bb10 automatically. It requires a UI to build..
# SUBDIRS=ubuntu linuxkernel rsync qt bb10
SUBDIRS=ubuntu django-nginx linuxkernel rsync qt qemu lfs ffmpeg

include $(shell git rev-parse --show-toplevel)/Makefile.subdirs

recreate:
	$(MAKE) clean build push
