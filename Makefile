# Copyright (c) 2016 Accupara Inc. All rights reserved

SUBDIRS=ubuntu centos django-nginx linuxkernel rsync qt qemu lfs ffmpeg duperemove mobile

include $(shell git rev-parse --show-toplevel)/Makefile.subdirs

recreate:
	for i in ${SUBDIRS} ; do ${MAKE} -C $$i clean build push clean ; done
